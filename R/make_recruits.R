#' @title Make recruits
#'
#' @description Function used to calculate realized reproductive output 
#' (to larval stage) of female spawners without density-dependence
#' in larval production.
#'
#' @param eggs The number of eggs an individual fish
#' can produce (Potential annual fecundity, PAF).
#' 
#' @param sr Sex ratio
#'
#' @return Number of juvenile recruits. Numeric vector of
#' \code{length(eggs}. May be a single value (vector of length 1)
#' or a vector of \code{length = maximum age} depending on whether
#' age-specific values are passed to \code{eggs}.
#'
#' @example inst/examples/makerecruits_ex.R
#' 
#' @export
#'
make_recruits <- function(eggs, sr){

  # Multiply eggs (PAF) by sex ratio and hatch success
    recruits <- eggs * sr
  
  # Return the result to R
    return(recruits)

}
