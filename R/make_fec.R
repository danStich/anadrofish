#' @title Make fecundity
#'
#' @description Function used to make fecundity values
#' for age-structured spawning population of fish
#'
#' @param eggs The number of eggs an individual fish
#' can produce
#' 
#' @param sr Sex ratio
#' 
#' @param s_juvenile Hatching success (hatch to larval survival)
#'
#' @return Number of age-0 recruits produced. May be a single 
#' value (vector of length 1) or a vector of length = maximum age
#' depending on whether age-specific values are passed to \code{eggs}
#'
#' @example inst/examples/makefec_ex.R
#'
#' @references Bailey, M. M., and J. D. Zydlewski. 2013. To stock or not
#' to stock? Assessing the restoration potential of a remnant American shad
#' spawning run with hatchery supplementation. North American Journal of
#' Fisheries Management 33:459-467. doi: 10.1080/02755947.2013.763874.
#' 
#' @export
#'
make_fec <- function(eggs, sr, s_juvenile){

  # Multiply eggs (fecundity) by sex ratio and hatch success
    fec <- eggs * sr * s_juvenile
  
  # Return the result to R
    return(fec)

}
