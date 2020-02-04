#' @title Simulate population dynamics through time.
#' 
#' @description Use functions from \code{\link{anadrofish}} to simulate
#' population change through time.
#' 
#' @param nyears Number of years for simulation(s).
#' 
#' @param river River basin. Available rivers implemented in package 
#' can be viewed by calling \code{\link{get_rivers}}. Alternatively,
#' the user can specify \code{rivers = sample(get_rivers, 1)} 
#' to randomly sample river within larger simulation studies. Information
#' about each river can be found in \code{\link{inventory}}, 
#' \code{\link{shad_rivers}}, and \code{\link{habitat}} datasets.
#' 
#' @param max_age Maximum age of fish in population. If \code{NULL}
#' (default), then based on the maximum age of females for the
#' corresponding region in the \code{\link{max_ages}} dataset.
#' 
#' @param nM Instantaneous natural mortality. If \code{NULL}
#' (default), then based the average of males and females for the
#' corresponding region in the \code{\link{mortality}} dataset.
#' 
#' @param fM Instantaneous fishing mortality. The default value is zero.
#' 
#' @param n_init Initial population seed (number of Age-1 individuals) 
#' used to simulate the starting population.
#' 
#' @param spawnRecruit Probability of recruitment to spawn at age. Numeric 
#' vector with length \code{max_age}
#' 
#' @param eggs Number of eggs per female. Can be a vector of length 1
#' if eggs per female is age invariant, or can be vector of length 
#' \code{max_age} if age-specific. If \code{NULL} (default) then 
#' estimated based on regression relationships in \code{\link{make_eggs}}.
#' 
#' @param sr Sex ratio (expressed as percent female or P(female)).
#' 
#' @param s_prespawn Pre-spawn survival for spawners.
#' 
#' @param s_juvenile Survival from hatch to outmigrant. If NULL
#' (default) then simulated from a (log) normal distribution using
#' mean and sd of \code{Sc} through \code{70 d} for 1979-1982 from
#' Crecco et al. (1983).
#' 
#' @param upstream Numeric of length 1 representing proportional 
#' upstream passage through dams.
#' 
#' @param downstream Numeric of length 1 indicating proportional 
#' downstream survival through dams. 
#' 
#' @param downstream_j Numeric of length 1 indicating proportional
#' downstream survival through dams for juveniles.
#' 
#' @param output Level of detail provided in output. The default
#' value of '\code{last}' returns the final year of simulation.
#' Any value other than the default '\code{last}' will return
#' data for all years of simulation. This is useful for testing.
#' 
#' @return A data.frame containing simulation inputs (arguments
#' to \code{sim_pop}) and output (number of spawners) by year.
#' 
# #' @example inst/examples/simpop_ex.R
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
  s_juvenile = NULL,
  upstream,
  downstream,  
  downstream_j,
  output = 'last'
)

{
  # Get region for river system
    region <- inventory$region[inventory$system == river]
    
  # Get governmental unit
    govt <- substr(inventory$termcode[inventory$system == river],
                   start = 3, stop = 4)
    
  # Get life-history parameters if not specified 
  # Instantaneous natural mortality - avg for M and F within region
    if(is.null(nM)){ nM <- mean(mortality$M[mortality$region==region])}
      
  # Maximum age if not specified 
    if(is.null(max_age)){ max_age <- max(max_ages$maxage[max_ages$region==region])}
    
  # Maturity schedule if not specified 
    if(is.null(spawnRecruit)){ spawnRecruit <- as.numeric(maturity[maturity$region==region & maturity$sex=='F', 3:(2+max_age)])}
    
  # Get estimated number of eggs per female if not specified 
    if(is.null(eggs)){eggs <- make_eggs(region, max_age)}
    
  # Get hatch-to-outmigrant survival if not specified  
    if(is.null(s_juvenile)){s_juvenile <- sim_juvenile_s(crecco_1983)}
    
  # Make a hidden environment to avoid
  # cluttering .GlobalEnv
    .sim_pop <- new.env()
    
  # Make output vectors
    environment(make_output) <- .sim_pop
    list2env(make_output(), envir = .sim_pop)
  
  # Make habitat from built-in data sets
    .sim_pop$acres <- make_habitat(river = river, upstream=upstream)
    
  # Make downstream survival through dams
    .sim_pop$s_downstream <- make_downstream(
      river = river, downstream=downstream, upstream=upstream)
    .sim_pop$s_downstream_j <- make_downstream(
      river = river, downstream=downstream_j, upstream=upstream)       
    
  # Make the population
    environment(make_pop) <- .sim_pop
    .sim_pop$pop <-  make_pop(max_age = max_age,
                              nM = nM,
                              fM = fM,
                              n_init = n_init
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
        sr = sr, s_juvenile = s_juvenile
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
