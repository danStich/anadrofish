#' @title Retrieve latitude for shad rivers.
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets.
#'
#' @param river Character string specifying river name. See 
#' \code{\link{get_rivers}}.
#' 
#' @examples make_lat(river = 'Susquehanna')
#' 
#' @export
#'
make_lat <- function(river){
  
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
  
  # Select habitat units based on HUC 10 watershed names
  lat <- anadrofish::habitat$latitude[anadrofish::habitat$system == river][1]
  
  return(lat)
  
}
