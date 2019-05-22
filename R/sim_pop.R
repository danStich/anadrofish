#' @title Simulate population dynamics through time
#' 
#' @description Use functions from anadrofish to simulate
#' population change through time.
#' 
#' @param nyears Number of years.
#' 
#' @param river River basin. Currently defined as HUC 10 watershed.
#' 
#' @param max_age Maximum age of fish in population.
#' 
#' @param nM Instantaneous natural mortality estimate.
#' 
#' @param fM Instantaneous fishing mortality estimate.
#' 
#' @param n_init Initial population seed (number of Age-1 individuals) 
#' used to seed the population.
#' 
#' @param spawnRecruit Probability of recruitment to spawn at age. Numeric 
#' vector with length \code{max_age}
#' 
#' @param eggs Number of eggs per female. Can be a vector of length 1
#' if eggs per female is age invariant, or can be vector of length 
#' \code{max_age} if age-specific.
#' 
#' @param sr Sex ratio (expressed as percent female or P(female)).
#' 
#' @param s_prespawn Pre-spawn survival for spawners.
#' 
#' @param s_hatch Survival from hatch to outmigrant
#' 
#' @return A data.frame containing simulation inputs (arguments) 
#' and outputs (pop, spawners) by year.
#' 
#' @example inst/examples/simpop_ex.R
#' 
#' @importFrom demogR, leslie.matrix, eigen.analysis
#' 
#' @export
#' 
sim_pop <- function(
  nyears = 100,
  river = 'Penobscot',
  max_age = 9,
  nM = 0.38,
  fM = 0.00,
  n_init = 1e5,
  spawnRecruit = c(0, 0, 0, 0.01, 0.33, 0.84, 0.97, 0.99, 1.00), 
  eggs = c(0, 0, 0, 20654, 34674, 58210, 79433, 88480, 97724),
  sr = 0.50,
  s_prespawn = 0.90,  
  s_hatch = 0.10,
  params = c('river',
             'max_age',
             'nM',
             'fM',
             'n_init',
             'spawnRecruit',
             'eggs',
             'sr',
             's_hatch',
             'S_prespawn',
             'spawners',
             'pop'
             )
)

{
  # Make a hidden environment to avoid
  # cluttering .GlobalEnv
    .sim_pop <- new.env()
  
  # Make output vectors
    environment(make_output) <- .sim_pop
    list2env(make_output(), env = .sim_pop)
  
  # Make habitat from built-in data sets
    .sim_pop$acres <- make_habitat(river = river)
  
  # Make the population
    environment(make_pop) <- .sim_pop
    .sim_pop$pop <-  make_pop(max_age = max_age,
                              nM = nM,
                              fM = fM,
                              n_init = n_init,
                              f = eggs*sr*s_hatch*s_prespawn
                              )
    
  for(t in 1:nyears){    
      
    # Make spawning population
      .sim_pop$spawners <- make_spawners(.sim_pop$pop, probs = spawnRecruit)
      
    # Subtract the spawners from the ocean population
      .sim_pop$pop <- .sim_pop$pop - .sim_pop$spawners  
      
    # Apply prespawn survival to spawners  
      .sim_pop$spawners <- .sim_pop$spawners * s_prespawn  
    
    # Make realized fecundity of spawners  
      .sim_pop$fec <- make_fec(eggs = eggs, sr = sr, s_hatch = s_hatch)
     
    # Calculate recruitment from Beverton-Holt curve   
      .sim_pop$recruits_f_age <- beverton_holt(
        a = .sim_pop$fec,
        S=.sim_pop$spawners,
        acres = .sim_pop$acres,
        age_structured = TRUE
        )
    
    # Sum recruits to get age0 fish  
      .sim_pop$age0 <- sum(.sim_pop$recruits_f_age)    
        
    ### NEED TO ADD:
    ### - Hatch-to-outmigrant survival
    ### - Outmigrant survival
    ###    + Adults (incl. post-spawn survival)
    ###    + Juveniles    
      
    # Project population into next time step
      .sim_pop$pop <- project_pop(
        x = .sim_pop$pop + .sim_pop$spawners, 
        age0 = .sim_pop$age0,
        nM = nM, 
        fM = fM,
        max_age = max_age)  
    
    # Fill the output vectors
      environment(fill_output) <- .sim_pop
      list2env(fill_output(), env=.sim_pop)    
      
  } # YEAR LOOP  
    
  # Write the results to an object
    environment(write_output) <- .sim_pop
    write_output()
    
}