#' @title Post-spawning survival
#'
#' @description Function used to estimate post-spawn survival 
#' from proportion of repeat spawners by latitude (Leggett and
#' Cascardden 1978, Bailey and Zydlewski 2013) and natural mortality
#' by life-history region.
#'
#' @param habitat A built-in \code{data.frame} containing habitat 
#' estimates (km2) for the scenario and region selected.
#' 
# #' @example inst/examples/make_postspawn_ex.R
#'
#' @references Bailey, M.M., and J. D. Zydlewski. 2013. To stock or not
#' to stock? Assessing therestoration potential of a remnant 
#' American shad spawning run with hatchery supplementation. North 
#' American Journal of Fisheries Management 33:459–467.
#' 
#' Leggett, W., and J. E. Cascardden. 1978. Latitudinal Variation in 
#' Reproductive Characteristics of American Shad (Alosa sapidissima): 
#' Evidence for Population Specific Life History Strategies in Fish.
#' Journal of the Fisheries Research Board of Canada 35:1469-1478.
#'   
#' @export
#'
make_postspawn <- function(iteroparity, nM){
  
  A <- 1 - exp(-nM)
  S <- 1 - A
  I <- iteroparity
  post_spawn_s <- I/S
  
  if(post_spawn_s < 0){post_spawn_s <- 0}
  if(post_spawn_s > 1){post_spawn_s <- 1}
  
  return(post_spawn_s)
  
}
