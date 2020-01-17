#' @title Estimate rate of iteroparity for American shad from
#' latitude based on Leggett and Cascardden (1978) and 
#' Bailey and Zydlewski (2014)
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets.
#'
#' @param habitat A built-in \code{data.frame} containing habitat 
#' estimates (km2) for the scenario and region selected.
#' 
# #' @example inst/examples/makefec_ex.R
#' 
#' @export
#'
make_iteroparity <- function(latitude){
  
  iteroparity = (5.08*latitude - 165)/100
  
  return(iteroparity)
}
