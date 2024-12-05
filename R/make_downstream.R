#' @title Calculate downstream survival given dam passage scenario.
#'
#' @description Function used to create population-level
#' survival during out-migration through dams.
#'
#' @param river Character string specifying river name.
#' 
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param downstream Numeric indicating proportional downstream survival 
#' through a single dam.
#' 
#' @param upstream Numeric indicating proportional upstream passage 
#' through a single dam.
#' 
#' @param historical Logical indicating whether to use contemporary or
#' historical habitat data.
#' 
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from custom_habitat_template(). NEED TO ADD LINK.
#' 
#' @return Numeric of length 1 representing catchment-scale 
#' downstream migration mortality for juvenile or adult fish.
#' 
#' @details This function assigns cumulative downstream passage values 
#' to all features in \code{\link{habitat}} corresponding to \code{river}.
#' It then calculates the proportion of habitat in each 
#' habitat segment of a river, and weights downstream mortality at the catchment-scale
#' by proportion of habitat. This implicitly assumes that fish are distributed 
#' throughout the river during spawning in proportion to available
#' habitat.
#' 
#' @example inst/examples/make_downstream_ex.R
#' 
#' @export
#'
make_downstream <- function(river, 
                            species = c("AMS", "ALE", "BBH"), 
                            downstream, 
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
    
    # American shad ----
    if(species == "AMS"){
      # Select habitat units based on huc_code and whether
      # this is an historical analysis (historical == FALSE
      # by default)
      # Contemporary habitat data subset
      units <- anadrofish::habitat[anadrofish::habitat$system==river,]
      
      # Assign cumulative downstream passage to feature
      units$p_downstream <- downstream^units$dam_order
        
      # Calculate passage to habitat segment
      units$p_to_habitat <- upstream^units$dam_order
      
      # Calculate functional upstream habitat
      units$functional_upstream <- units$habitatSegment_sqkm * units$p_to_habitat
      
      # Calculate proportion of habitat in each segment of available
      units$p_habitat <- units$functional_upstream/sum(units$functional_upstream)
        
      # The ratio is survival rate
      s_downstream <- sum(units$p_habitat*((downstream^units$dam_order)))
    }
    
    # Alewife ----
    if(species == "ALE"){
      # Select habitat units based on huc_code
      units <- anadrofish::habitat_ale[anadrofish::habitat_ale$River_huc==river,]
      
      # Assign cumulative downstream passage to feature
      units$p_downstream <- downstream^units$DamOrder
      
      # Calculate passage to habitat segment
      units$p_to_habitat <- upstream^units$DamOrder
      
      # Available habitat
      units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
      
      # Calculate proportion of habitat in each segment of available
      units$p_habitat <- units$functional_upstream/
        sum(units$functional_upstream, na.rm = TRUE)
      
      # The ratio is survival rate
      s_downstream <- sum(units$p_habitat*((downstream^units$DamOrder)),
                          na.rm = TRUE)
    }  
    
    # Blueback herring ----
    if(species == "BBH"){
      # Select habitat units based on huc_code
      units <- anadrofish::habitat_bbh[anadrofish::habitat_bbh$River_huc==river,]
      
      # Assign cumulative downstream passage to feature
      units$p_downstream <- downstream^units$DamOrder
      
      # Calculate passage to habitat segment
      units$p_to_habitat <- upstream^units$DamOrder
      
      # Available habitat
      units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
      
      # Calculate proportion of habitat in each segment of available
      units$p_habitat <- units$functional_upstream/sum(units$functional_upstream)
      
      # The ratio is survival rate
      s_downstream <- sum(units$p_habitat*((downstream^units$DamOrder)))
    }    
    
  # Custom habitat routine  
  } else {
    # Assign custom habitat to units
    units <- custom_habitat
    
    # Assign cumulative downstream passage to feature
    units$p_downstream <- downstream^units$dam_order
    
    # Calculate passage to habitat segment
    units$p_to_habitat <- upstream^units$dam_order
    
    # Available habitat
    units$functional_upstream <- units$Hab_sqkm * units$p_to_habitat
    
    # Calculate proportion of habitat in each segment of available
    units$p_habitat <- units$functional_upstream/sum(units$functional_upstream)
    
    # The ratio is survival rate
    s_downstream <- sum(units$p_habitat*((downstream^units$dam_order)))    
  }
  
  return(s_downstream)
  
}
