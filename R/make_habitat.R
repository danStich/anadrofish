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
#' @param upstream Proportional upstream passage through dams.
#' 
#' @param historical Testing parameter only. Logical indicating whether this
#' is an historical analysis. Default is FALSE. If TRUE, then use test 
#' habitat data for Merrimack, Presumpscot, or Salmon Falls rivers for
#' American shad. Not implemented for any other systems or species.
#' 
#' @param custom_habitat Numeric vector of habitat areas corresponding to 
#' production units between features in \code{\link{habitat}} for \code{river}.
#' 
# #' @example inst/examples/makehabitat_ex.R
#' 
#' @export
#'
make_habitat <- function(river, 
                         species = c("AMS", "ALE", "BBH"),
                         upstream, 
                         historical = FALSE, 
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
    
    To see a list of available rivers, run get_rivers()")    
  }
  
  if(!river %in% get_rivers(species)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # American shad habitat
  if(species == "AMS"){
    # Select habitat units based on huc_code and whether
    # this is an historical analysis (historical = FALSE
    # by default)
    # Contemporary habitat data subset
    units <- anadrofish::habitat[anadrofish::habitat$system==river,]
    
    # Historical habitat data subset for American shad
    if(historical == TRUE){
      units <- anadrofish::habitat_hist[anadrofish::habitat_hist$system==river,]
      # units[with(units, order(dam_order)), ]
      
    }
    
    # Calculate passage to habitat segment
    units$p_to_habitat <- upstream^units$dam_order
    if(historical == TRUE){
      units$p_to_habitat <- cumprod(upstream)
    }
    
    # Add option for custom habitat
    if(!is.null(custom_habitat)){
      if(length(custom_habitat) != nrow(units)){
        stop("
             
             length of custom_habitat must be equal to the number of rows in
             get_dams(river)"
        )
      }
      
      units$habitatSegment_sqkm <- custom_habitat
    }
    
    units$functional_upstream <- units$habitatSegment_sqkm * units$p_to_habitat
    
    # Calculate habitat surface acres from the 
    # sum of functional habitat in the subset
    acres <- 247.105 * sum(units$functional_upstream)
  }
  
  if(species == "ALE"){
    # Select habitat units based on huc_code and whether
    # this is an historical analysis (historical = FALSE
    # by default)
    # Contemporary habitat data subset
    units <- anadrofish::habitat_ale[anadrofish::habitat_ale$River_huc==river,]
    
    
    # Calculate passage to habitat segment
    units$p_to_habitat <- upstream^units$DamOrder
    
    
    # Add option for custom habitat
    if(!is.null(custom_habitat)){
      if(length(custom_habitat) != nrow(units)){
        stop("
             
             length of custom_habitat must be equal to the number of rows in
             get_dams(river)"
        )
      }
      
      units$Hab_sqkm <- custom_habitat
    }
    
    units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
    
    # Calculate habitat surface acres from the 
    # sum of functional habitat in the subset
    acres <- 247.105 * sum(units$functional_upstream, na.rm = TRUE) 
    
  }
  
  if(species == "BBH"){
    # Select habitat units based on huc_code and whether
    # this is an historical analysis (historical = FALSE
    # by default)
    # Contemporary habitat data subset
    units <- anadrofish::habitat_bbh[anadrofish::habitat_bbh$River_huc==river,]
    
    
    # Calculate passage to habitat segment
    units$p_to_habitat <- upstream^units$DamOrder
    
    
    # Add option for custom habitat
    if(!is.null(custom_habitat)){
      if(length(custom_habitat) != nrow(units)){
        stop("
             
             length of custom_habitat must be equal to the number of rows in
             get_dams(river)"
        )
      }
      
      units$Hab_sqkm <- custom_habitat
    }
    
    units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
    
    # Calculate habitat surface acres from the 
    # sum of functional habitat in the subset
    acres <- 247.105 * sum(units$functional_upstream, na.rm = TRUE) 
  }  
  
  
  return(acres)
}
