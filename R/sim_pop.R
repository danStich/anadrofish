#' @title Simulate population dynamics through time.
#' 
#' @param nyears Number of years for simulation.
#' 
#' @description Use functions from \code{\link{anadrofish}} to simulate
#' population change through time relative to upstream and downstream
#' passage probabilities and uncertainty in life-history information.
#' 
#' @param river River basin. Available rivers implemented in package 
#' can be viewed by calling \code{\link{get_rivers}} with no arguments
#' (e.g., \code{get_rivers()}). Alternatively, the user can specify 
#' \code{rivers = sample(get_rivers, 1)} to randomly sample river 
#' within larger simulation studies. Information about each river can be 
#' found in the \code{\link{habitat}} dataset.
#' 
#' @param max_age Maximum age of fish in population. If \code{NULL}
#' (default), then based on the maximum age of females for the
#' corresponding region in the \code{\link{max_ages}} dataset.
#' 
#' @param nM Instantaneous natural mortality. If \code{NULL}
#' (default), then based on the average of males and females for the
#' corresponding region in the \code{\link{mortality}} dataset.
#' 
#' @param fM Instantaneous fishing mortality. The default value is zero.
#' 
#' @param n_init Initial population seed (number of Age-1 individuals) 
#' used to simulate the starting population. Default is to use a draw
#' from a wide uniform distribution, but it may be beneficial to narrow
#' once expectations for abundance at population stability are determined.
#' 
#' @param spawnRecruit Probability of recruitment to spawn at age. If 
#' \code{NULL} (default), then probabilities are based on the mean of
#' male and female recruitment to first spawn at age from the
#' \code{\link{maturity}} dataset.
#' 
#' @param eggs Number of eggs per female. Can be a vector of length 1
#' if eggs per female is age invariant, or can be vector of length 
#' \code{max_age} if age-specific. If \code{NULL} (default) then 
#' estimated based on weight-batch fecundity regression relationships 
#' for each life-history region in the \code{\link{olney_mcbride}}
#' dataset (Olney and McBride 2003) and mean number of batches spawned
#' (6.1 +/- 2.1, McBride et al. 2016) using \code{\link{make_eggs}}.
#' 
#' @param sr Sex ratio (expressed as percent female or P(female)).
#' 
#' @param s_juvenile Survival from hatch to outmigrant. If NULL
#' (default) then simulated from a (log) normal distribution using
#' mean and sd of \code{Sc} through \code{70 d} for 1979-1982 from
#' Crecco et al. (1983) in \code{\link{crecco_1983}}.
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
#' @param output_years Temporal level of detail provided in output. 
#' The default value of '\code{last}' returns the final year of simulation.
#' Any value other than the default '\code{last}' will return
#' data for all years of simulation. This is useful for testing.
#' 
#' @param age_structured_output Should population and spawner abundance
#' in the output dataframe be age-structured? If \code{FALSE} (default),
#' then \code{pop} (non-spawning population) and \code{spawners} (spawning
#' population) are summed across all age classes for each year of simulation.
#' If \code{TRUE} then \code{pop} and \code{spawners} are returned for
#' each age class. For the sake of managing outputs, abundances for
#' \code{pop} and \code{spawners} are reported for all age classes 1-13 
#' regardless of \code{max_age}, but all abundances for ages greater 
#' than \code{max_age} are zero.
#' 
#' @param historical TESTING PARAM ONLY. Logical indicating whether this
#' is an historical analysis. Default is FALSE. If TRUE, then use test 
#' habitat data for Merrimack, Presumpscot, or Salmon Falls rivers. Not 
#' implemented for any other systems.
#' 
#' @param sex_specific Whether to use sex-specific life-history data.
#'
#' @param custom_habitat A vector of habitat values corresponding to square km
#' of habitat upstream of each feature and the next. Must be the same length
#' as the number of rows in \code{\link{habitat}} for the selected \code{river}. 
#' Added for compatibility with historical management plan habitat estimates. 
#' 
#' @return A dataframe containing simulation inputs (arguments
#' to \code{sim_pop}) and output (number of spawners) by year.
#' 
# #' NEED TO ADD COLUMN DESCRIPTIONS HERE
#'
#' @example inst/examples/simpop_ex.R
#' 
#' @references Olney, J. E. and R. S. McBride. 2003. Intraspecific 
#' variation in batch fecundity of American shad (*Alosa sapidissima*): 
#' revisiting the paradigm of reciprocal latitudinal trends 
#' in reproductive traits. American Fisheries Society 
#' Symposium 35:185-192.
#' 
#' @export
#' 
sim_pop <- function(
  nyears = 50,  
  river,
  max_age = NULL,
  nM = NULL,
  fM = 0,
  n_init = runif(1, 10e5, 80e7),
  spawnRecruit = NULL, 
  eggs = NULL,
  sr = 0.50,
  s_juvenile = NULL,
  upstream = 1,
  downstream = 1,  
  downstream_j = 1,
  output_years = c('last', 'all'),
  age_structured_output = FALSE,
  historical = FALSE,
  sex_specific = TRUE,
  custom_habitat = NULL
)

{
  # Make a hidden environment to avoid
  # cluttering .GlobalEnv
    .sim_pop <- new.env()  
  
  # Unlist function args to internal environment
    list2env(mget(names(formals(sim_pop))), envir=.sim_pop)
    
  # Argument matching for output_years
    .sim_pop$output_years <- output_years
    
  # Get region for river system
    .sim_pop$region <- as.character(unique(anadrofish::habitat$region[
      anadrofish::habitat$system == .sim_pop$river]))
    
  # Get governmental unit
    .sim_pop$govt <- unique(substr(anadrofish::habitat$TERMCODE[
      anadrofish::habitat$system == .sim_pop$river],
      start = 3, stop = 4))
    
  # Get whether sex specific
    .sim_pop$sex_specific <- sex_specific
    
  # Get life-history parameters if not specified 
    if(sex_specific == FALSE){
    # Instantaneous natural mortality - avg for M and F within region
      if(is.null(.sim_pop$nM)){ .sim_pop$nM <- make_mortality(.sim_pop$river)}
        
    # Maximum age if not specified 
      if(is.null(.sim_pop$max_age)){.sim_pop$max_age <- make_maxage(.sim_pop$river)}
      
    # Maturity schedule if not specified 
      if(is.null(.sim_pop$spawnRecruit)){ 
        .sim_pop$spawnRecruit <- make_spawnrecruit(.sim_pop$river)
      }
    }
    
  # If sex_specific == TRUE
    if(sex_specific == TRUE){
      
    # Instantaneous natural mortality - avg for M and F within region
      if(is.null(.sim_pop$nM_m)){ 
        .sim_pop$nM_m <- make_mortality(.sim_pop$river, sex = "male")
        .sim_pop$nM_f <- make_mortality(.sim_pop$river, sex = "female")
      }
        
    # Maximum age if not specified 
      if(is.null(.sim_pop$max_age)){
        .sim_pop$max_age_m <- make_maxage(.sim_pop$river, sex = "male")
        .sim_pop$max_age_f <- make_maxage(.sim_pop$river, sex = "female")
        }
      
    # Maturity schedule if not specified 
      if(is.null(.sim_pop$spawnRecruit)){ 
        .sim_pop$spawnRecruit_m <- make_spawnrecruit(.sim_pop$river, sex = "male")
        .sim_pop$spawnRecruit_f <- make_spawnrecruit(.sim_pop$river, sex = "female")
        }
      
    }
    
  # Get estimated number of eggs per female if not specified 
    if(is.null(.sim_pop$eggs)){.sim_pop$eggs <- make_eggs(.sim_pop$river)}
            
  # Get hatch-to-outmigrant survival if not specified  
    if(is.null(.sim_pop$s_juvenile)){.sim_pop$s_juvenile <- 
      sim_juvenile_s(anadrofish::crecco_1983)}
    
  # Make output vectors
    environment(make_output) <- .sim_pop
    list2env(make_output(nyears = .sim_pop$nyears, sex_specific = sex_specific), 
             envir = .sim_pop)
  
  # Make habitat from built-in data sets
    .sim_pop$acres <- make_habitat(river = .sim_pop$river, 
                                   upstream = .sim_pop$upstream,
                                   historical = .sim_pop$historical,
                                   custom_habitat = .sim_pop$custom_habitat)
    
  # Make downstream survival through dams
    .sim_pop$s_downstream <- make_downstream(
      river = .sim_pop$river, 
      downstream = .sim_pop$downstream, 
      upstream = .sim_pop$upstream,
      historical = .sim_pop$historical,
      custom_habitat = .sim_pop$custom_habitat
      )
    .sim_pop$s_downstream_j <- make_downstream(
      river = .sim_pop$river, 
      downstream = .sim_pop$downstream_j, 
      upstream = .sim_pop$upstream,
      historical = .sim_pop$historical,
      custom_habitat = .sim_pop$custom_habitat
      )       
    
  # Make the population
    environment(make_pop) <- .sim_pop
    if(sex_specific == FALSE){
      .sim_pop$pop <-  make_pop(max_age = .sim_pop$max_age,
                                nM = .sim_pop$nM,
                                fM = .sim_pop$fM,
                                n_init = .sim_pop$n_init
                                )
    }
    if(sex_specific == TRUE){
      .sim_pop$pop_m <-  make_pop(max_age = .sim_pop$max_age_m,
                                nM = .sim_pop$nM_m,
                                fM = .sim_pop$fM,
                                n_init = .sim_pop$n_init * (1-.sim_pop$sr)
                                )
      .sim_pop$pop_f <-  make_pop(max_age = .sim_pop$max_age_f,
                                nM = .sim_pop$nM_f,
                                fM = .sim_pop$fM,
                                n_init = .sim_pop$n_init * .sim_pop$sr
                                )      
    }    
    
    
  # Simulate for nyears until population stabilizes.  
  for(t in 1:.sim_pop$nyears){    
    # Assign iterator to the hidden work spaces
      .sim_pop$t <- t
    
    if(sex_specific == FALSE){
      # Make spawning population
        .sim_pop$spawners <- make_spawners(
          .sim_pop$pop, probs = .sim_pop$spawnRecruit)
        
      # Subtract the spawners from the ocean population
        .sim_pop$pop <- .sim_pop$pop - .sim_pop$spawners  
      
    }
      
    if(sex_specific == TRUE){
      # Make spawning population
        # Males
        .sim_pop$spawners_m <- make_spawners(
          .sim_pop$pop_m, probs = .sim_pop$spawnRecruit_m)
        # Females
        .sim_pop$spawners_f <- make_spawners(
          .sim_pop$pop_f, probs = .sim_pop$spawnRecruit_f)   
        # Total
        .sim_pop$spawners <- add_unequal_vectors(
          .sim_pop$spawners_m,  
          .sim_pop$spawners_f)
        
      # Subtract the spawners from the ocean population
        .sim_pop$pop_m <- .sim_pop$pop_m - .sim_pop$spawners_m
        .sim_pop$pop_f <- .sim_pop$pop_f - .sim_pop$spawners_f
        .sim_pop$pop <- add_unequal_vectors(.sim_pop$pop_m, .sim_pop$pop_f)
    }
      
    # Make realized reproductive output of spawners 
      .sim_pop$fec <- make_recruits(
        eggs = .sim_pop$eggs,
        sr = .sim_pop$sr
        )
      
    # Calculate density-dependent recruitment from Beverton-Holt curve   
      .sim_pop$recruits_f_age <- beverton_holt(
        a = .sim_pop$fec,
        S = .sim_pop$spawners,
        acres = .sim_pop$acres,
        age_structured = TRUE
        )
      
    # Apply density-independent mortality for 0-70 d
    # Sum recruits to get age0 fish  
      .sim_pop$age0 <- sum(.sim_pop$recruits_f_age * .sim_pop$s_juvenile)    
      
    # Get rate of iteroparity from river based on latitude
      .sim_pop$latitude <- make_lat(.sim_pop$river)
      .sim_pop$iteroparity <- make_iteroparity(.sim_pop$latitude)
      
    # Apply post-spawn survival
      if(sex_specific == FALSE){
        
        .sim_pop$s_postspawn <- make_postspawn(.sim_pop$river)
        .sim_pop$spawners2 <- .sim_pop$spawners * .sim_pop$s_postspawn   
        
      }
      
      if(sex_specific == TRUE){
        
        .sim_pop$s_postspawn_m <- make_postspawn(
          river = .sim_pop$river, 
          nM = .sim_pop$nM_m)
        .sim_pop$s_postspawn_f <- make_postspawn(
          river = .sim_pop$river, 
          nM = .sim_pop$nM_f)
        
        .sim_pop$spawners2_m <- .sim_pop$spawners_m * .sim_pop$s_postspawn_m
        .sim_pop$spawners2_f <- .sim_pop$spawners_f * .sim_pop$s_postspawn_f
        
        .sim_pop$spawners2 <- add_unequal_vectors(
          .sim_pop$spawners2_m,  
          .sim_pop$spawners2_f)
        
      }      
      
      
    # Calculate pre-spawn (fw survival) based on post-spawn and M
      if(sex_specific == FALSE){
        .sim_pop$s_spawn <- make_s_spawn(.sim_pop$nM, .sim_pop$s_postspawn)
      }
      
      if(sex_specific == TRUE){
        .sim_pop$s_spawn_m <- make_s_spawn(
          nM = .sim_pop$nM_m,
          s_postspawn = .sim_pop$s_postspawn_m)
        .sim_pop$s_spawn_f <- make_s_spawn(
          nM = .sim_pop$nM_f,
          s_postspawn = .sim_pop$s_postspawn_f)
      }      

    # Outmigrant survival
    .sim_pop$age0_down <- .sim_pop$age0 * .sim_pop$s_downstream_j
    .sim_pop$spawners_down <- .sim_pop$spawners2 * .sim_pop$s_downstream  
      
    # Project population into next time step
    if(sex_specific == FALSE){
      .sim_pop$pop <- project_pop(
        x = .sim_pop$pop + .sim_pop$spawners_down, 
        age0 = .sim_pop$age0_down,
        nM = .sim_pop$nM, 
        fM = .sim_pop$fM,
        max_age = .sim_pop$max_age) 
    }
    if(sex_specific == TRUE){
      .sim_pop$pop_m <- project_pop(
        x = add_unequal_vectors(
          .sim_pop$pop_m,
          .sim_pop$spawners_down*(1-.sim_pop$sr))[1:.sim_pop$max_age_m], 
        age0 = .sim_pop$age0_down*(1-.sim_pop$sr),
        nM = .sim_pop$nM_m, 
        fM = .sim_pop$fM,
        max_age = .sim_pop$max_age_m) 
      
      .sim_pop$pop_f <- project_pop(
        x = add_unequal_vectors(
          .sim_pop$pop_f, .sim_pop$spawners_down*.sim_pop$sr), 
        age0 = .sim_pop$age0_down*.sim_pop$sr,
        nM = .sim_pop$nM_f, 
        fM = .sim_pop$fM,
        max_age = .sim_pop$max_age_f)       
      
        .sim_pop$pop <- add_unequal_vectors(
          .sim_pop$pop_m,  
          .sim_pop$pop_f)
      
    }    
    
    # Fill the output vectors
      environment(fill_output) <- .sim_pop
      list2env(fill_output(.sim_pop, sex_specific = sex_specific), 
               envir =.sim_pop)
      
  } # YEAR LOOP  
    
  # Write the results to an object
    environment(write_output) <- .sim_pop
    write_output(.sim_pop, sex_specific = sex_specific)
    
}
