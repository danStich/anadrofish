#' @title Get region for specified river by species
#'
#' @description Function used to get region for rivers listed
#' in output of \code{\link{get_rivers}} from the built-in 
#' habitat data sets
#'
#' @param river Character string specifying river name
#' 
#' @param species Character string specifying species for simulation.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @return a data.frame with 4 variables containing dam name,
#' latitude and longitude, and dam order in the watershed
#' 
# #' @example inst/examples/makehabitat_ex.R
#' 
#' @export
#'
get_region <- function(river, species = c("ALE", "AMS", "BBH")){
  
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
  
  if(!river %in% get_rivers(species)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # Select habitat units based on huc_code
  if(species == "AMS"){
    units <- anadrofish::habitat$region[anadrofish::habitat$system == river]
  }
  
  if(species == "ALE"){
    units <- anadrofish::habitat_ale$POP[anadrofish::habitat_ale$River_huc == river]
  }  
  
  if(species == "BBH"){
    units <- anadrofish::habitat_bbh$POP[anadrofish::habitat_bbh$River_huc == river]
  }    
  
  # Get the region
  region <- unique(units)[1]
  
  return(region)
}
