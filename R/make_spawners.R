#' @title Make spawning population 
#'
#' @description The purpose of this function is to create an age-structured
#' spawning population from an existing age-structured population by
#' applying region- and age-specific spawning probabilities.
#'
#' @param pop Age-structured spawner abundance.
#' 
#' @param probs Vector of spawning probabilities. May be a single value or 
#' multiple. If multiple values are passed as a vector, the length of 
#' \code{probs} should correspond to the length of \code{pop}.
#'
#' @return A numeric vector of \code{length = length(pop)}
#'
#' @example inst/examples/makespawners_ex.R
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_spawners <- function(pop, probs){
  
  pop * probs
  
}
