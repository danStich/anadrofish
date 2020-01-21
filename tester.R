# Testing code ---- 
# rm(list = ls())
# if(!is.null(dev.list())) dev.off()

# nyears = 50
# river = 'Delaware'
# max_age = NULL
# nM = NULL
# fM = 0
# n_init = MASS::rnegbin(1, 4e4, 10)
# spawnRecruit = NULL
# eggs = NULL
# sr = rbeta(1, 100, 100)
# s_prespawn = rbeta(1, 90, 10)
# s_hatch = runif(1, 0.005, 0.0086)
# type = 'functional'
# output='last'

# Package load ----
  library(snowfall)
  library(anadrofish)

# Parallel settings ----
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
    river = 'Penobscot',
    max_age = NULL,
    nM = NULL,
    fM = 0.05,
    n_init = MASS::rnegbin(1, 4e4, 10),
    spawnRecruit = NULL,
    eggs = NULL,
    sr = rbeta(1, 100, 100),
    s_prespawn = rbeta(1, 90, 10),  
    s_hatch = runif(1, 0.005, 0.0086),
    type = 'passage',
    upstream = 1,
    downstream = 1,
    downstream_j = 1,
    output='last'
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
niterations <- 100

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
resdf <- data.frame(rbindlist(res))

mean(resdf$spawners)



# . Default output plots ----

hist(resdf$spawners)

resdf$type = as.character(resdf$type)

boxplot(spawners~type, data=resdf,
        #names = c('No passage', 'No dams'),
        xlab = 'Scenario', ylab = '', yaxt = 'n',
        ylim=c(0, max(resdf$spawners*1.01)),
        boxwex = .33, whisklty = 1, medlwd = 1,
        staplewex = 0, staplecol = NA,
        col = 'gray')
axis(2, at=seq(0,max(resdf$spawners+1e5),round(max(resdf$spawners+1e5)/5, -5)),
     labels=sprintf(seq(0,max(resdf$spawners+1e5),round(max(resdf$spawners+1e5)/5, -5)), fmt = '%.0f'),
     las=2
     )
mtext("Adult returns", side = 2, line = 5)
text(x = .5, y = max(resdf$spawners),
     labels=paste(unique(resdf$river), "River"), adj=0)

# boxplot(resdf[ , inds], col='gray87', staplewex=0, medlwd=1,
#         whisklty=1, names = paste('Age', seq(1,length(inds), 1)))

# . Full output plots for testing ----
# # Summarize and plot results
# library(plyr)
# 
# # Summarize spawner and overall population abundance
# # across age classes
# resdf$pop <- apply(resdf[ , .SD, .SDcols=c(names(resdf)[grep(pattern='pop_', names(resdf))])], 1, sum)
# resdf$spawners <- apply(resdf[ , .SD, .SDcols=c(names(resdf)[grep(pattern='spawners_', names(resdf))])], 1, sum)
# 
# # Summarize spawner abundance by year
# sums <- ddply(resdf, .(out_year), summarize, means=mean(spawners),
#               lci=quantile(spawners, probs=c(0.025)),
#               uci=quantile(spawners, probs=c(0.975))              
#               ) 
# 
# # Plot juvenile abundance by year
# # Open file connection
#   png(
#     filename = paste0('notcommit/test_image.png'),
#     height = 600,
#     width = 1500,
#     res = 400,
#     pointsize = 6
#   )
# par(mar=c(4,6,1,1))
# plot(x=sums$out_year,
#      y = sums$means,
#      type='l', col=NA,
#      ylim=c(0, max(sums$uci+1e5)),
#      xlab = 'Year',
#      ylab = '',
#      yaxt='n'
#      ) 
# axis(2, at=seq(0,max(sums$uci+1e5),round(max(sums$uci+1e5)/5, -5)),
#      labels=sprintf(seq(0,max(sums$uci+1e5),round(max(sums$uci+1e5)/5, -5)), fmt = '%.0f'),
#      las=2
#      )
# polygon(x=c(sums$out_year, rev(sums$out_year)),
#         y=c(sums$lci, rev(sums$uci)),
#         col='gray87', border = NA
#         )
# lines(x=sums$out_year, y=sums$means, lty=1, lwd=1, col='black')
# lines(sums$out_year, sums$lci, lty=2)
# lines(sums$out_year, sums$uci, lty=2)
# mtext('Spawner abundance', side = 2, line=5)
# dev.off()
# 
# 
#                
