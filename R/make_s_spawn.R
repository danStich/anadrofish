#' @title Make total spawning migration mortality
#'
#' @description Function used to derive total in-river adult survival during
#' the spawning migration from annual mortality and post-spawn survival.
#' 
#' @param nM Instantaneous natural mortality rate. 
#' A numeric vector containing either an age-invariant natural mortality
#' rate of length 1 or an age-specific natural mortality rate with 
#' length = max_age.
#'
#' @param s_postspawn Post spawning mortality calculated from the
#' output of \code{\link{make_iteroparity}} and \code{nM}, or alternatively a
#' numeric vector for each.
#' 
#' @return A vector of length one containing pre-spawn survival. 
#'
#' @examples make_s_spawn(0.68, 0.92)
#'
#' @export
#'
make_s_spawn <- function(nM, s_postspawn){

    # Mortality rate conversions
    A <- 1 - exp(-nM)
    Z2 <- (-2/12)*log(1-A)
    s2month <- exp(-Z2)
    
    # Calculate total fw mortality due
    # to time passed and spawning
    s_spawn <- s_postspawn * s2month
        
  # Return the result to R
    return(s_spawn)

}
