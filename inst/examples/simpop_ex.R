# Example usage
\dontrun{
  
# Example 1. Simulate a single population one time for 50 years -----------

  # Simulate a single population for fifty years one time
    res <- sim_pop(
      river = 'Susquehanna',
      nyears = 50,
      max_age = NULL,
      nM = NULL,
      fM = 0,
      n_init = runif(1, 10e5, 50e7),
      spawnRecruit = NULL,
      eggs = NULL,
      sr = rbeta(1, 100, 100),
      s_prespawn = rbeta(1, 90, 10),  
      s_juvenile = NULL,
      upstream = 1,
      downstream = 1,
      downstream_j = 1,
      output_years = 'all',
      age_structured_output = FALSE
      )
  
  # Plot the output - the result will be different for each
  # simulated model run above
    plot(x = res$year, y = res$spawners, type = 'l',
         xlab = 'Year of simulation',
         ylab = 'Spawner abundance')    
   

# Example 2. Simulate a single population 100 times in parallel ----------------
  # Package load ----
    library(snowfall)
    library(anadrofish)
    library(plyr)
  
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
    # Run with a single set of upstream and downstream
    # dam passage probabilities
      res <- sim_pop(
        river = 'Susquehanna',
        nyears = 50,
        max_age = NULL,
        nM = NULL,
        fM = 0,
        n_init = runif(1, 10e5, 80e7),
        spawnRecruit = NULL,
        eggs = NULL,
        sr = rbeta(1, 100, 100),
        s_prespawn = rbeta(1, 90, 10),  
        s_juvenile = NULL,
        upstream = 1,
        downstream = 1,
        downstream_j = 1,
        output_years = 'all',
        age_structured_output = FALSE
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
  
  # . Run the simulation ----
    start <- Sys.time()
    
    result <- sfLapply(1:niterations, sim) 
    
    Sys.time()-start
  
  # . Stop snowfall ----
    sfStop()
  
  # Results ----
  # 'result' is a list of lists. Save this:
  # save(result, file = "sim_result.rda")
  
  # Extract results dataframes by string and rbind them
    res <- lapply(result, function(x) x[[c('res')]])
    library(data.table)
    resdf <- data.frame(rbindlist(res))
    
  # Calculate mean  
    mean(resdf$spawners)
      
  # Summarize spawner abundance by year
    sums <- ddply(resdf, .(year), summarize, means=mean(spawners),
                  lci=quantile(spawners, probs=c(0.025)),
                  uci=quantile(spawners, probs=c(0.975))
                  ) 
    
  # Plot the result 
    par(mar=c(4,6,1,1))
    maxes <- max(sums$uci[sums$year==50]+max(sums$uci[sums$year==50])*.20)
    plot(x=sums$year,
         y = sums$means,
         type='l', col=NA,
         ylim=c(0, maxes),
         xlab = 'Year',
         ylab = '',
         yaxt='n'
         )
    axis(2, at=seq(0,maxes,round(maxes/5, -5)),
         labels=sprintf(seq(0, maxes, round(maxes/5,-5)), fmt = '%.0f'),
         las=2
         )
    polygon(x=c(sums$year, rev(sums$year)),
            y=c(sums$lci, rev(sums$uci)),
            col='gray87', border = NA
            )
    lines(x=sums$year, y=sums$means, lty=1, lwd=1, col='black')
    lines(sums$year, sums$lci, lty=2)
    lines(sums$year, sums$uci, lty=2)
    mtext('Spawner abundance', side = 2, line=5)
    box()  
    

# Example 3. Multi-river simulation ---------------------------------------
# Simulate population size for randomly
# selected rivers and randomly chosen passage
# probabilities from a pre-defined list.
    
# Run simulations in parallel, saving age-structured
# output, but only for the final year of simulation
    
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
    # Define passage scenarios (ASFMC 2020) 
      passages <- list(
        c(0,0,0),
        c(1,1,1),
        c(0.4, 0.80, 0.95)
      )
      passage <- unlist(sample(passages, 1))  
      
    # Run the sim  
      res <- sim_pop(
        river = get_rivers()[sample(1:length(get_rivers()), 1)],
        nyears = 50,    
        max_age = NULL,
        nM = NULL,
        fM = 0,
        n_init = MASS::rnegbin(1, 4e5, 1),
        spawnRecruit = NULL,
        eggs = NULL,
        sr = rbeta(1, 100, 100),
        s_prespawn = rbeta(1, 90, 10),  
        s_juvenile = NULL,
        upstream = passage[1],
        downstream = passage[2],
        downstream_j = passage[3],
        output_years = 'last',
        age_structured_output = TRUE
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
  
  # . Run the simulation ----
    start <- Sys.time()
    
    result <- sfLapply(1:niterations, sim) 
    
    Sys.time()-start
  
  # . Stop snowfall ----
    sfStop()
  
  # Results ----
  # 'result' is a list of lists. Save this:
  # save(result, file = "sim_result.rda")
  
  # Extract results dataframes by string and rbind them
    res <- lapply(result, function(x) x[[c('res')]])
    library(data.table)
    resdf <- rbindlist(res)
  
  # . Summary statistics by passage scenario -----
    resdf$river <- as.character(resdf$river)
    library(dplyr)
  
  # Sum population size and spawners across age groups
    resdf$spawners <- resdf %>%
      select(grep("spawners", colnames(resdf))) %>%
      rowSums 
    resdf$pop <- resdf %>%
      select(grep("pop", colnames(resdf))) %>%
      rowSums 
    
  # Assign scenarios based on upstream passage
    resdf$scenario <- 'No dams'
    resdf$scenario[resdf$upstream==0] <- 'No passage'
    resdf$scenario[resdf$upstream==.40] <- 'Current condition'
  
  # System-specific summaries
    total <- resdf[ , list(n = length(spawners),
                           mean=mean(spawners),
                           lower=quantile(spawners, .25, na.rm=TRUE),
                           upper=quantile(spawners, .75, na.rm=TRUE)),
                         by=c(names(resdf)[c(1:4,ncol(resdf),5)])]
    summary_stats <- total[with(total, order(river, scenario)), ]

  # Coastal summary ----
    coastal <- summary_stats[ , list(mean=sum(mean),
                                     lower = sum(lower),
                                     upper = sum(upper)),
                                by = c('scenario')]
    coastal <- coastal[with(coastal, order(scenario)), ]
    coastal <- coastal[c(3, 1, 2), ]
  
  # . Coastal output plots ----
    par(mar=c(5, 5, 1, 1))
    plot(x = c(1.5, 2.5, 3.5),
         y = unlist(coastal[c(1,2,3), 2]), pch=21, bg='black', cex=1.5,
         ylim = c(0, max(coastal[,2:4])), yaxt='n',
         ylab='Coast-wide spawners (millions)',
         xlim = c(1,4), xaxt='n', xlab = ''
         )
    axis(side = 1, at = seq(1.5,3.5,1), c("No Passage", "Current Condition", "No Dams"))
    axis(side = 2, at=seq(0, 10e7, 1e7), labels = seq(0, 100, 10), las=2)
    mtext("Scenario", side = 1, line = 3.5)
    segments(x0 = seq(1.5, 3.5, 1), x1=seq(1.5, 3.5, 1),
             y0=unlist(coastal[c(1,2,3), 3]),
             y1=unlist(coastal[c(1,2,3), 4])
             )

}
