#' @title Rivers included in package
#'
#' @description Get rivers included in package. A function with no arguments.
#'
#' @details The primary uses of this function are (1) so the user can see 
#' rivers that can be used for simulation, and (2) so the output can be passed 
#' to a random sampler for use in stochastic simulation via parallel processing.
#'
#' @return A character vector of rivers that are included in both 
#' \link{inventory} and \link{habitat}.
#'
#' @export
#'
get_rivers <- function(){
  return(as.vector(shad_rivers$system))
  }
