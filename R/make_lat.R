#' @title Retrieve latitude for American shad rivers.
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets for American shad. Not implemented for river herring.
#'
#' @param river Character string specifying river name. See 
#' \code{\link{get_rivers}}.
#' 
#' @examples make_lat(river = 'Susquehanna')
#' 
#' @export
#'
make_lat <- function(river, species = c("AMS", "ALE", "BBH")){
  
  # Error handling
  # Species error handling
  if(missing(species)){
    stop("
    
    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.")   
  }
  
  if(!species %in% c('ALE', 'AMS', 'BBH')){
    stop("
         
    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.") 
  }
  
  # River error handling  
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers()")    
  }
  
  if(!river %in% get_rivers(species = species)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }  

  # Select habitat units based on HUC 10 watershed names
  if(species == "AMS"){
    lat <- anadrofish::habitat$latitude[anadrofish::habitat$system == river][1]
  }
  if(species == "ALE"){
    lat <- anadrofish::habitat_ale$Latitude[anadrofish::habitat_ale$River_huc == river][1]
  }
  if(species == "BBH"){
    lat <- anadrofish::habitat_bbh$Latitude[anadrofish::habitat_bbh$River_huc == river][1]
  }
  
  return(lat)
  
}
