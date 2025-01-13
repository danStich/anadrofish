#' @title Get governmental unit for specified river by species
#'
#' @description Function used to get governmental unit for rivers listed
#' in output of \code{\link{get_rivers}} from the built-in 
#' habitat data sets.
#'
#' @param river Character string specifying river name.
#' 
#' @param species Character string specifying species.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#' 
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#' 
#' @return A character string indicating governmental district corresponding
#' to selected river.
#' 
#' @examples get_govt(river = "Hudson", species = "AMS")
#' 
#' @export
#'
get_govt <- function(river, species = c("ALE", "AMS", "BBH"), 
                     custom_habitat = NULL){
  
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
    
    To see a list of available rivers, run get_rivers() or specify river name
    in custom_habitat if used.")    
  }
  
  if(!river %in% get_rivers(species) & is.null(custom_habitat)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers() or in
    custom_habitat if used.
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # If using custom_habitat, then get govt
  if(!is.null(custom_habitat)){
    
    govt = custom_habitat$govt[1]
    
  } else {
    
    # Else select habitat units based on huc_code using built-in data sets
    if(species == "AMS"){
      units <- anadrofish::habitat[anadrofish::habitat$system == river, ]
      govt <- unique(substr(units$TERMCODE, start = 3, stop = 4))    
    }
    
    if(species == "ALE"){
      govt <- anadrofish::habitat_ale$State[anadrofish::habitat_ale$River_huc == river][1]
    }  
    
    if(species == "BBH"){
      govt <- anadrofish::habitat_bbh$State[anadrofish::habitat_bbh$River_huc == river][1]
    }      
  }
  
  # Return governmental unit(s)
  return(govt)
  
}
