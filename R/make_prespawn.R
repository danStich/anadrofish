#' @title Make pre-spawning mortality
#'
#' @description Function used to derive pre-spawning survival from
#' natural mortality rate (river and/or sex-specific) and post-spawning
#' survival (sex-specific or not) based on river-specific iteroparity.
#'
#' @param nM Instantaneous natural mortality rate. 
#' A numeric vector of length 1.
#'
#' @param s_postspawn Post spawning mortality calculated from the
#' output of make_iteroparity and nM
#' 
#' @return A vector of length one containing pre-spawn survival. 
#'
# #' @example inst/examples/makepop_ex.R
#'
#' @export
#'
make_prespawn <- function(nM, s_postspawn){

    Z <- nM
    s <- 1-(1-exp(-Z))
    
    # Iteroparous rivers
    s_prespawn <- nM*((s)^(2/12))
    
    # Semelparous rivers
    if(s_postspawn == 0){
      s_prespawn <- s^(2/12)
    }
        
  # Return the result to R
    return(s_prespawn)

}
