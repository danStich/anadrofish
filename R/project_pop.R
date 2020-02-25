#' @title Project population
#'
#' @description Function used to project population forward 
#' one time step using vector multiplication.
#'
#' @param x An numeric vector containing age-specific 
#' abundance at end of year t.
#' 
#' @param age0 A vector of length one containing number of new recruits 
#' at end of year t.
#' 
#' @param nM Instantaneous natural mortality.
#' 
#' @param fM Instantaneous fishing mortality.
#' 
#' @param max_age Maximum age of spawning fish.
#'
#' @return A numeric vector of age-structured abundance in time t + 1
#'
#' @example inst/examples/projectpop_ex.R
#' 
#' @export
#'
project_pop <- function(x, age0, nM, fM, max_age){
  
  # Calculate total mortality
    Z <- nM + fM

  # Survival rate
    s <- rep(1-(1-exp(-Z)), max_age + 1)  
    s[1] <- s[1]^3
      
  # Project population one time-step and drop
  # any fish > max_age
    tplus <- c(age0, x)*s
    
  # Return the result to R
    return(tplus[1:max_age])

}
