#' @title Estimate rate of iteroparity for American shad from
#' latitude based on Leggett and Cascardden (1978) and 
#' Bailey and Zydlewski (2013).
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets.
#'
#' @param latitude Latitude, in decimal degrees. Can be queried for
#' each river using \code{\link{make_lat}}.
#' 
#' @return Probability of repeat spawning. A numeric vector 
#' of \code{length = 1}.
#' 
#' @examples make_iteroparity( make_lat(river = 'Susquehanna', species = 'AMS') )
#' 
#' @references Bailey, M.M., and J. D. Zydlewski. 2013. To stock or not 
#' to stock? Assessing therestoration potential of a remnant 
#' American shad spawning run with hatchery supplementation. North 
#' American Journal of Fisheries Management 33:459-467.
#' 
#' Leggett, W., and J. E. Cascardden. 1978. Latitudinal Variation in 
#' Reproductive Characteristics of American Shad (Alosa sapidissima):  
#' Evidence for Population Specific Life History Strategies in Fish. 
#' Journal of the Fisheries Research Board of Canada 35:1469-1478.
#' 
#' @export
#'
make_iteroparity <- function(latitude){
  
  iteroparity = (5.08*latitude - 165)/100
  
  if(iteroparity < 0){iteroparity <- 0}
  
  return(iteroparity)
  
}
