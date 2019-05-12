#' @title Make spawning population 
#'
#' @description The purpose of this function is to create an age-structured
#' spawning population from an age-structured population by
#' applying age-specific spawning probabilities.
#'
#' @param pop Age-structured population abundance.
#' 
#' @param probs Vector of spawning probabilities. May be a single value or 
#' multiple. If multiple values are passed as a vector, the length of 
#' \code{probs} should correspond to the length of \code{pop}.
#'
#' @return A numeric vector of \code{length = length(pop)}
#'
#' @example inst/examples/bevholt_ex.R
#'
#' @references None
#'
#' @export
#'
make_spawners <- function(pop, probs){
  
  pop * probs
  
}


