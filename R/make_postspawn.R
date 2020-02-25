#' @title Post-spawning survival
#'
#' @description Function used to estimate post-spawn survival 
#' from proportion of repeat spawners by latitude (Leggett and
#' Cascardden 1978, Bailey and Zydlewski 2013) and natural mortality
#' by life-history region.
#'
#' @param river River for which post-spawn survival rate should be 
#' returned. Required argument with no default value. Available rivers
#' can be seen using \code{\link{get_rivers}}.
#'
#' @param iteroparity Optional argument for rate of iteroparity. Values from 
#' \code{\link{make_iteroparity}} can be passed directly to this function, or
#' a numeric vector of \code{length = 1}.
#' 
#' @param nM Instantaneous annual mortality. Values for 
#' natural mortality for life-history regions can be
#' found in \code{\link{mortality}}, or
#' a numeric vector of \code{length = 1}.
#' 
#' @examples make_postspawn(river = "Susquehanna")
#'
#' @references Bailey, M.M., and J. D. Zydlewski. 2013. To stock or not
#' to stock? Assessing the restoration potential of a remnant 
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
make_postspawn <- function(river = river, iteroparity = NULL, nM = NULL){
  
   if(missing(river)){
      stop("
      
      Argument 'river' must be specified.
      
      To see a list of available rivers, run get_rivers()")    
    }
    
    if(!river %in% get_rivers()){
      stop("
      
      Argument 'river' must be one of those included in get_rivers().
      
      To see a list of available rivers, run get_rivers()")
    }    
  
  if(is.null(iteroparity)) iteroparity <- make_iteroparity(make_lat(river))
  if(is.null(nM)) nM <- make_mortality(river)
  
  A <- 1 - exp(-nM)
  S <- 1 - A
  I <- iteroparity
  post_spawn_s <- I/S
  
  if(post_spawn_s < 0){post_spawn_s <- 0}
  if(post_spawn_s > 1){post_spawn_s <- 1}
  
  return(post_spawn_s)
  
}
