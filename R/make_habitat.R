#' @title Make cumulative habitat for river
#'
#' @description Function used to make habitat for rivers listed
#' in \code{\link{get_rivers}} from the built-in dataset(s)
#'
#' @param river Character string specifying river name
#' 
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param upstream Proportional upstream passage through dams. A numeric vector
#' of length 1 or length matching the number of rows in habitat data for
#' selected \code{river} and \code{species}.
#' 
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#' 
#' @return A numeric vector containing amount of accessible habitat in
#' acres. 
#'
#' @examples make_habitat(river = "Penobscot", species = "AMS", upstream = 0.9)
#' 
#' @export
#'
make_habitat <- function(river, 
                         species = c("AMS", "ALE", "BBH"),
                         upstream,
                         custom_habitat = NULL){
  
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
    
    To see a list of available rivers, run get_rivers() or specify river name
    in custom_habitat if used.")    
  }
  
  if(!river %in% get_rivers(species) & is.null(custom_habitat)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers() or in
    custom_habitat if used.
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # Built-in habitat data routines
  if(is.null(custom_habitat)){
    # American shad habitat
    if(species == "AMS"){
      # Select habitat units based on huc_code
      # Contemporary habitat data subset
      units <- anadrofish::habitat[anadrofish::habitat$system == river,]
      
      # Calculate passage to habitat segment
      units$p_to_habitat <- upstream^units$dam_order
      
      # Get functional upstream habitat based on passage rate(s)
      units$functional_upstream <- units$habitatSegment_sqkm * units$p_to_habitat
      
      # Calculate habitat surface acres from the 
      # sum of functional habitat in the subset
      acres <- 247.105 * sum(units$functional_upstream)
    }
    
    if(species == "ALE"){
      # Select habitat units based on huc_code
      # Contemporary habitat data subset
      units <- anadrofish::habitat_ale[anadrofish::habitat_ale$River_huc==river,]
      
      # Calculate passage to habitat segment
      units$p_to_habitat <- upstream^units$DamOrder
      
      # Get functional upstream habitat based on passage rate(s)
      units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
      
      # Calculate habitat surface acres from the 
      # sum of functional habitat in the subset
      acres <- 247.105 * sum(units$functional_upstream, na.rm = TRUE) 

    }
    
    if(species == "BBH"){
      # Select habitat units based on huc_code
      # Contemporary habitat data subset
      units <- anadrofish::habitat_bbh[anadrofish::habitat_bbh$River_huc==river,]
      
      # Calculate passage to habitat segment
      units$p_to_habitat <- upstream^units$DamOrder

      # Get functional upstream habitat based on passage rate(s)
      units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
      
      # Calculate habitat surface acres from the 
      # sum of functional habitat in the subset
      acres <- 247.105 * sum(units$functional_upstream, na.rm = TRUE) 
      
    }
    
  # Custom habitat routine
  } else {
    units <- custom_habitat
    
    # Calculate passage to habitat segment
    units$p_to_habitat <- upstream^units$dam_order
    
    # Get functional upstream habitat based on passage rate(s)
    units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
    
    # Calculate habitat surface acres from the 
    # sum of functional habitat in the subset
    acres <- 247.105 * sum(units$functional_upstream, na.rm = TRUE)     
  }
  
  return(acres)
  
}
