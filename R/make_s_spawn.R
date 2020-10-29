#' @title Make total spawning migration mortality
#'
#' @description Function used to derive total in-river adult survival during
#' the spawning migration from annual mortality and post-spawn survival.
#' 
#' @param nM Instantaneous natural mortality rate. 
#' A numeric vector of length 1.
#'
#' @param s_postspawn Post spawning mortality calculated from the
#' output of make_iteroparity and nM.
#' 
#' @return A vector of length one containing pre-spawn survival. 
#'
# #' @example inst/examples/makepop_ex.R
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
