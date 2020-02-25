#' @title Make recruits
#'
#' @description Function used to calculate realized reproductive output 
#' (to outmigrant stage) of female spawners without density-dependence
#' in larval production.
#'
#' @param eggs The number of eggs an individual fish
#' can produce (Potential annual fecundity, PAF).
#' 
#' @param sr Sex ratio
#' 
#' @param s_juvenile Larval-to-outmigrant survival
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
make_recruits <- function(eggs, sr, s_juvenile){

  # Multiply eggs (fecundity) by sex ratio and hatch success
    recruits <- eggs * sr * s_juvenile
  
  # Return the result to R
    return(recruits)

}
