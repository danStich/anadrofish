#' @title Get dams for specified river
#'
#' @description Function used to get dams for rivers listed
#' in \code{\link{get_rivers}} from the built-in 
#' data set(s)
#'
#' @param river Character string specifying river name
#' 
#' @return a data.frame with 4 variables containing dam name,
#' latitude and longitude, and dam order in the watershed
#' 
# #' @example inst/examples/makehabitat_ex.R
#' 
#' @export
#'
get_dams <- function(river){
  
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
  
  # Select habitat units based on huc_code
  units <- anadrofish::habitat[anadrofish::habitat$system == river, ]
  
  # Get dams
  dams <- units[ , 19:22]
  
  return(dams)
}
