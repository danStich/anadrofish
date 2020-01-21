#' @title Simulate population dynamics through time
#' 
#' @description Use functions from anadrofish to simulate
#' population change through time.
#' 
#' @param nyears Number of years.
#' 
#' @param river River basin. All rivers implemented in package 
#' can be viewed by calling \code{get_rivers()}. Alternatively,
#' the user can specify \code{rivers = sample(get_rivers(), 1)} 
#' to randomly sample river within larger simulation studies.
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
#' @param egg_est Method used to estimate fecundity. Currently either
#' parameterized from fecundity~length relationships from the Hudson
#' River, NY, USA (\code{Lehman} Lehman 1953) or region-specific, 
#' multiple-regression relationships from five coastal rivers
#' (\code{Leggett} Legget and Cascardden 1978)
#' 
#' @param sr Sex ratio (expressed as percent female or P(female)).
#' 
#' @param s_prespawn Pre-spawn survival for spawners.
#' 
#' @param s_hatch Survival from hatch to outmigrant
#' 
#' @param type Type of habitat calculation used. 
#' The default \code{functional} assumes current functional
#' habitat available based on dam locations. \code{total}
#' assumes that fish have access to all historical habitat
#' identified through GIS mapping in combination with 
#' expert opinion.
#' 
#' @param upstream Numeric of length 1 representing proportional 
#' upstream passage through dams.
#' 
#' @param downstream Numeric of length 1 indicating proportional 
#' downstream survival through dams. 
#' 
#' @param downstream_j Numeric of length 1 indicating proportional
#' downstream survival through dams for juveniles, if different
#' from adults.
#' 
#' @param output Level of detail provided in output. The default
#' value of '\code{last}' returns the final year of simulation.
#' Any value other than the default '\code{last}' will return
#' data for all years of simulation. This is useful for testing.
#' 
#' @return A data.frame containing simulation inputs (arguments) 
#' and outputs (pop, spawners) by year.
#' 
#' @example inst/examples/simpop_ex.R
#' 
#' @importFrom demogR leslie.matrix eigen.analysis
#' 
#' @export
#' 
sim_pop <- function(
  nyears,
  river,
  max_age = NULL,
  nM = NULL,
  fM,
  n_init,
  spawnRecruit = NULL, 
  eggs = NULL,
  sr,
  s_prespawn,  
  s_hatch,
  s_downstream = NULL,
  type = 'total',
  upstream = NULL,
  downstream = NULL,  
  downstream_j = NULL,
  output = 'last'
)

{
  # Get region for river system
    region <- inventory$region[inventory$system == river]
    
  # Get governmental unit
    govt <- substr(inventory$termcode[inventory$system == river],
                   start = 3, stop = 4)
    
  # Get life-history parameters
  # Instantaneous natural mortality - avg for M and F within region
    if(is.null(nM)){ nM <- mean(mortality$M[mortality$region==region])}
      
  # Maximum age
    if(is.null(max_age)){ max_age <- max(max_ages$maxage[max_ages$region==region])}
    
  # Maturity schedule
    if(is.null(spawnRecruit)){ spawnRecruit <- as.numeric(maturity[maturity$region==region & maturity$sex=='F', 3:(2+max_age)])}
    
  # Get estimated number of eggs per female
    if(is.null(eggs)){eggs <- make_eggs(region, max_age, egg_est)}
    
    
  # Get upstream passage if not specified
    if(type == 'functional'){upstream <- 0}
    if(type == 'total'){upstream <- 1}
    
  # Get downstream passage if not specified  
    if(type == 'functional'){downstream <- 1}
    if(type == 'total'){downstream <- 1}
    if(type == 'functional'){downstream_j <- 1}
    if(type == 'total'){downstream_j <- 1}
    
  # Assign juvenile downstream survival to be the same
  # as adult downstream survival if not specified.
    if(is.null(downstream_j)){ downstream_j <- downstream}
  
  # Error message for unspecified passage rates if
  # type == passage
    if(type == 'passage' & (is.null(upstream) | is.null(downstream))){
      stop('if type == `passage` then a value must be provided for both upstream and downstream in the call to sim_pop()')
    }
    
  # Make a hidden environment to avoid
  # cluttering .GlobalEnv
    .sim_pop <- new.env()
    
  # Make output vectors
    environment(make_output) <- .sim_pop
    list2env(make_output(), envir = .sim_pop)
  
  # Make habitat from built-in data sets
    .sim_pop$acres <- make_habitat(river = river, type=type,
                                   upstream=upstream)
    
  # Make downstream survival through dams
    .sim_pop$s_downstream <- make_downstream(river = river, type=type,
                                             downstream=downstream)
    if(downstream_j == downstream){
    .sim_pop$s_downstream_j <- make_downstream(river = river, type=type,
                                             downstream=downstream)      
    } else {
    .sim_pop$s_downstream_j <- make_downstream(river = river, type=type,
                                             downstream=downstream_j)       
    }  
  
    
  # Make the population
    environment(make_pop) <- .sim_pop
    .sim_pop$pop <-  make_pop(max_age = max_age,
                              nM = nM,
                              fM = fM,
                              n_init = n_init,
                              f = (eggs*sr*s_hatch*s_prespawn)/2
                              )
    
  # Simulate for nyears until population stabilizes.  
  for(t in 1:nyears){    
      
    # Make spawning population
      .sim_pop$spawners <- make_spawners(.sim_pop$pop, probs = spawnRecruit)
      
    # Subtract the spawners from the ocean population
      .sim_pop$pop <- .sim_pop$pop - .sim_pop$spawners  
      
    # Apply prespawn survival to spawners  
      .sim_pop$spawners1 <- .sim_pop$spawners * s_prespawn  
    
    # Make annual fecundity of spawners  
      .sim_pop$fec <- make_fec(
        eggs = eggs,
        sr = sr, s_hatch = s_hatch
        )
     
    # Calculate recruitment from Beverton-Holt curve   
      .sim_pop$recruits_f_age <- beverton_holt(
        a = .sim_pop$fec,
        S=.sim_pop$spawners1,
        acres = .sim_pop$acres,
        age_structured = TRUE
        )
    
    # Sum recruits to get age0 fish  
      .sim_pop$age0 <- sum(.sim_pop$recruits_f_age)    
      
    # Get rate of iteroparity from river based on latitude
      .sim_pop$latitude <- make_lat(river)
      .sim_pop$iteroparity <- make_iteroparity(.sim_pop$latitude)
      
    # Apply post-spawn survival
      .sim_pop$s_postspawn <- make_postspawn(.sim_pop$iteroparity, nM)
      .sim_pop$spawners2 <- .sim_pop$spawners1 * .sim_pop$s_postspawn      

    # Outmigrant survival
    .sim_pop$age0_down <- .sim_pop$age0 * .sim_pop$s_downstream_j
    .sim_pop$spawners_down <- .sim_pop$spawners2 * .sim_pop$s_downstream  
      
    # Project population into next time step
      .sim_pop$pop <- project_pop(
        x = .sim_pop$pop + .sim_pop$spawners_down, 
        age0 = .sim_pop$age0_down,
        nM = nM, 
        fM = fM,
        max_age = max_age)  
    
    # Fill the output vectors
      environment(fill_output) <- .sim_pop
      list2env(fill_output(), envir =.sim_pop)    
      
  } # YEAR LOOP  
    
  # Write the results to an object
    environment(write_output) <- .sim_pop
    write_output()
    
}
