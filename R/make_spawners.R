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
#' @example inst/examples/makespawners_ex.R
#'
#' @references Bailey, M. M., and J. D. Zydlewski. 2013. To stock or not
#' to stock? Assessing the restoration potential of a remnant American shad
#' spawning run with hatchery supplementation. North American Journal of
#' Fisheries Management 33:459-467. doi: 10.1080/02755947.2013.763874.
#' 
#' @export
#'
make_spawners <- function(pop, probs){
  
  pop * probs
  
}
