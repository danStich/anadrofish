# . Package load ----
  library(snowfall)

# . Parallel settings ----
# Get number of cores
  args <- commandArgs(trailingOnly = TRUE);
  ncpus <- args[1];
  ncpus <- 7 # Uncomment to run on local workstation

# Initialize snowfall
  sfInit(parallel = TRUE, cpus=ncpus, type="SOCK")

# Wrapper function ----
  sim <- function(x){
  
# . Get cpu ids ----  
  workerId <- paste(Sys.info()[['nodename']],
                    Sys.getpid(),
                    sep='-'
                    )
  
# . Call simulation ----
  res <- sim_pop(
    nyears = 50,
    river = 'Susquehanna',
    max_age = NULL,
    nM = NULL,
    fM = 0,
    n_init = MASS::rnegbin(1, 10e3, 100),
    spawnRecruit = NULL,
    eggs = NULL,
    sr = rbeta(1, 100, 100),
    s_prespawn = rbeta(1, 90, 10),  
    s_hatch = runif(1, 0.005, 0.0086),
    type='total'
    )

# . Define the output lists ----
    retlist <- list(
      worker=workerId,
      res=res)      
    
    return(retlist)    
}  
  

# Parallel execution ----

# . Load libraries on workers -----
sfLibrary(anadrofish)

# . Distribute to workers -----
# Number of simulations to run
niterations <- 1000

# Run the simulation ----
start <- Sys.time()

result <- sfLapply(1:niterations, sim) 

Sys.time()-start

# . Stop snowfall ----
sfStop()

# Results ----
# 'result' is a list of lists. Save this:
#save(result, file = "sim_result.rda")

# Extract results dataframes by string and rbind them
res <- lapply(result, function(x) x[[c('res')]])
library(data.table)
resdf <- rbindlist(res)

# Summarize and plot results
library(plyr)

# Summarize spawner and overall population abundance
# across age classes
resdf$pop <- apply(resdf[ , .SD, .SDcols=c(names(resdf)[grep(pattern='pop_', names(resdf))])], 1, sum)
resdf$spawners <- apply(resdf[ , .SD, .SDcols=c(names(resdf)[grep(pattern='spawners_', names(resdf))])], 1, sum)

# Summarize spawner abundance by year
sums <- ddply(resdf, .(out_year), summarize, means=mean(spawners),
              lci=quantile(spawners, probs=c(0.025)),
              uci=quantile(spawners, probs=c(0.975))              
              ) 

# Plot juvenile abundance by year
# Open file connection
  # png(
  #   filename = paste0('notcommit/spawners_no_passage.png'),
  #   height = 600,
  #   width = 1500,
  #   res = 400,
  #   pointsize = 6
  # )

par(mar=c(5,5,1,1))
plot(x=sums$out_year,
     y = sums$means,
     type='l', col=NA,
     ylim=c(0, max(sums$uci+1e5)),
     xlab = 'Year',
     ylab = 'Spawner abundance (millions)',
     yaxt='n'
     ) 
axis(2, at=seq(0,10e6,.5e6), labels=sprintf(seq(0,10,.5), fmt = '%#.1f'), las=2)
polygon(x=c(sums$out_year, rev(sums$out_year)),
        y=c(sums$lci, rev(sums$uci)),
        col='gray87', border = NA
        )
lines(x=sums$out_year, y=sums$means, lty=1, lwd=1, col='black')
lines(sums$out_year, sums$lci, lty=2)
lines(sums$out_year, sums$uci, lty=2)
#text('Dams', x=0, y=.9e6, adj=0)
# dev.off()


