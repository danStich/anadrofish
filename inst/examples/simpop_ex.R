# Example usage
\dontrun{
  
# Example 1. Simulate a single population one time for 50 years ----------------
  library(anadrofish)
  library(ggplot2)
  
  # Set rng seed ----
  set.seed(1)
  
  # Simulate a single population for fifty years one time
  res <- sim_pop(
    species = "AMS",
    nyears = 50,
    river = 'Susquehanna',
    fM = 0,
    n_init = runif(1, 10e5, 50e6),
    sr = rbeta(1, 100, 100),
    upstream = 1,
    downstream = 1,
    downstream_j = 1,
    output_years = 'all',
    age_structured_output = FALSE)
  
  # Plot the output - the result will be different for each
  # simulated model run above
  ggplot(res, aes(x = year, y = spawners)) +
    geom_line() +
    xlab("Year") +
    ylab("Number of spawners")
   

# Example 2. Simulate a single population 100 times in parallel ----------------
  # Package load ----
  library(snowfall)
  library(parallel)
  library(anadrofish)
  library(tidyverse)
  
  # Set rng seed ----
  set.seed(1)
  
  # Parallel settings ----
  # Get number of cores
  ncpus = parallel::detectCores() - 1
  
  # Initialize snowfall
  sfInit(parallel = TRUE, cpus = ncpus, type="SOCK")
  
  # Wrapper function ----
  sim <- function(x){

  # . Call simulation ----
  # Run with a single set of upstream and downstream
  # dam passage probabilities
  res <- sim_pop(
    species = "AMS",
    nyears = 50,
    river = 'Susquehanna',
    fM = 0,
    n_init = runif(1, 8e6, 50e6),
    sr = rbeta(1, 100, 100),
    upstream = 1,
    downstream = 1,
    downstream_j = 1,
    output_years = 'all',
    age_structured_output = FALSE)
  
  # . Define the output lists ----
  retlist <- list(res=res)      
  
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
  
  total_time <- Sys.time() - start
  total_time
  
  # . Stop snowfall ----
  sfStop()
  
  # Results ----
  # 'result' is a list of lists. Save this:
  # save(result, file = "sim_result.rda")
  
  # Extract results dataframes by string and rbind them
  res <- lapply(result, function(x) x[[c('res')]])
  library(data.table)
  resdf <- data.frame(rbindlist(res))
  
  glimpse(resdf)
  
  # Results summary
  plotter <- resdf %>% 
    group_by(year) %>% 
    summarize(fit = mean(spawners),
              lwr = quantile(spawners, 0.025),
              upr = quantile(spawners, 0.975))
    
  # Plotting
  ggplot(plotter, aes(x = year, y = fit)) +
    geom_line() +
    geom_ribbon(aes(xmax = year, ymin = lwr, ymax = upr,
                    color = NULL), alpha = 0.40)
    
  
# Example 3. Multi-river simulation --------------------------------------------
# Simulate population size for randomly
# selected rivers and randomly chosen passage
# probabilities from a pre-defined list.
    
# Run simulations in parallel, saving age-structured
# output, but only for the final year of simulation
  # Package load ----
  library(snowfall)
  library(parallel)
  library(anadrofish)
  library(tidyverse)
  
  # Set rng seed ----
  set.seed(1)
  
  # Parallel settings ----
  # Get number of cores
  ncpus = parallel::detectCores() - 1
  
  # Initialize snowfall
  sfInit(parallel = TRUE, cpus = ncpus, type="SOCK")
  
  # Wrapper function ----
  sim <- function(x){
  
    # . Call simulation ----
    # Define passage scenarios (ASFMC 2020) 
    passages <- list(
      c(0,0,0),
      c(1,1,1),
      c(0.4, 0.80, 0.95))
    passage <- unlist(sample(passages, 1))  
      
    # Run the sim  
    res <- sim_pop(
      species = "AMS",
      nyears = 50,
      river = get_rivers(species = "AMS")[sample(1:length(get_rivers(species = "AMS")), 1)],    
      fM = 0,
      n_init = runif(1, 10e5, 50e6),
      sr = rbeta(1, 100, 100),
      upstream = passage[1],
      downstream = passage[2],
      downstream_j = passage[3],
      output_years = 'last',
      age_structured_output = TRUE
      )
    
    # . Define the output lists ----
    retlist <- list(res = res)      
  
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
  
  total_time <- Sys.time() - start
  total_time
  
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
  
  # . System-specific summaries ----
  rivers <- resdf %>% 
    group_by(region, river, scenario) %>% 
    summarize(fit = mean(spawners),
              lwr = quantile(spawners, 0.025),
              upr = quantile(spawners, 0.975))
  

  # . Coastal summary ----
  coastal <- rivers %>% 
    group_by(scenario) %>% 
    summarize(fit = sum(fit),
              lwr = sum(lwr),
              upr = sum(upr))
  
  # . River plot ----
  rivers %>% 
    filter(region == "SI") %>% 
    ggplot(aes(x = river, y = fit, color = scenario, fill = scenario)) +
      geom_col() +
      coord_flip() +
      xlab("River") +
      ylab("Number of spawning adults") +
      ggtitle("Southern Iteroparous Region") +
      theme(plot.title = element_text(hjust = 0.5))
  
  # . Coastal plot ----
  ggplot(coastal, aes(x = scenario, y = fit)) +
    geom_point(size = 4) +
    geom_linerange(aes(xmax = scenario, ymin = lwr, ymax = upr),
                   linewidth = 1) +
    xlab("Scenario") +
    ylab("Number of spawning adults")

}
