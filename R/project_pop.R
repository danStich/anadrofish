#' @title Project population
#'
#' @description Function used to project population forward 
#' one time step using matrix multiplication. Based on 
#' modification of the \code{project.leslie} in \code{demogR}
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
#' #@example inst/examples/makefec_ex.R
#' 
#' @importFrom demogR leslie.matrix
#' 
#' @export
#'
project_pop <- function(x, age0, nM, fM, max_age){
  
  # Calculate total mortality
    Z <- nM + fM

  # Survival rate
    s <- rep(1-(1-exp(-Z)), max_age+2)  
      
  # Make the projection matrix
    les <- demogR::leslie.matrix(
      lx = cumprod(c(s)),
      mx = rep( 1, length(s) )
      )  
  
  # Multiply eggs (fecundity) by sex ratio and hatch success
    tplus1 <- les %*% c(age0, x)[1:(length(c(age0, x)))]
  
  # Return the result to R
    return(tplus1[2:length(tplus1)])

}
