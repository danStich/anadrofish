#' @title 
#'
#' @description Function used to estimate post-spawn survival 
#' from proportion of repeat spawners by latitude (Leggett and
#' Cascardden 1978, Bailey and Zydlewski 2013) and natural mortality
#' by life-history region (ASMFC 2020)
#'
#' @param habitat A built-in \code{data.frame} containing habitat 
#' estimates (km2) for the scenario and region selected.
#' 
# #' @example inst/examples/make_postspawn_ex.R
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
