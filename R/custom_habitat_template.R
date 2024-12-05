#' @title Make custom habitat for an existing river or a template for a new 
#' river of interest
#'
#' @description Function used to make habitat for rivers listed
#' in \code{\link{get_rivers}} from the built-in dataset(s)
#'
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param built_in A logical indicating whether the custom habitat template is a
#' a subset of built-in habitat datasets for the \code{species} indicated.
#'
#' @param river Character string specifying river name or NULL for custom river.
#' If making custom habitat from an existing river in \code{\link{habitat}} (American
#' shad), \code{\link{habitat_ale}} (Alewife), or \code{\link{habitat_bbh}} (Blueback herring), 
#' then river must be included in rivers from \code{\link{get_rivers}} for the target 
#' species. Otherwise, an arbitrary character string identifying river name 
#' is acceptable.
#' 
# #' @example inst/examples/custom_habitat_template.R
#' 
#' @export
#'
custom_habitat_template <- function(species = c("AMS", "ALE", "BBH"),
                                    built_in = TRUE,
                                    river){
  
  if(!missing(species)) species <- match.arg(species) 
  
  # River error handling
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers() or specify river name
    for custom_habitat template.")    
  }
  
  # Check whether the river is included in built-ins if using built-in datasets
  # to create the template
  if(built_in == TRUE){
    if(!river %in% get_rivers(species)){
      stop("
      
      If using built_in datasets to create the custom habitat template, then
      argument 'river' must be one of those included in get_rivers() for the
      species indicated.
      
      To see a list of available rivers, run get_rivers() for the species")
    }
  }

  # Templates for new habitat object that are not included in get_rivers()
  if(built_in == FALSE){
    custom_habitat <- data.frame(
      river = NaN,
      region = NaN,
      govt = NaN,
      lat = NA,
      lon = NA,
      dam_name = NaN,
      dam_order = NA,
      Hab_sqkm = NA)
  }
  
  if(built_in == TRUE){
    
    # American shad
    if(species == "AMS"){
      # Select built-in habitat for river from built-in data
      units <- anadrofish::habitat[anadrofish::habitat$system == river, ]
    
      custom_habitat <- data.frame(
        river = units$system,
        region = units$region,
        govt = substr(units$TERMCODE, start = 3, stop = 4),
        lat = units$latitude,
        lon = units$longitude,
        dam_name = units$dam_name,
        dam_order = units$dam_order,
        Hab_sqkm = units$habitat_sqkm)
    }
    
    # Alewife
    if(species == "ALE"){
      # Select built-in habitat for river from built-in data
      units <- anadrofish::habitat_ale[
        anadrofish::habitat_ale$River_huc == river, ]
      
      custom_habitat <- data.frame(
        river = units$River_huc,
        region = units$POP,
        govt = units$State,
        lat = units$Latitude,
        reach_code = units$REACHCODE,
        dam_order = units$DamOrder,
        Hab_sqkm = units$Hab_sqkm)
    }
    
    # Blueback herring
    if(species == "BBH"){
      # Select built-in habitat for river from built-in data
      units <- anadrofish::habitat_ale[
        anadrofish::habitat_ale$River_huc == river, ]
      
      custom_habitat <- data.frame(
        river = units$River_huc,
        region = units$POP,
        govt = units$State,
        lat = units$Latitude,
        reach_code = units$REACHCODE,
        dam_order = units$DamOrder,
        Hab_sqkm = units$Hab_sqkm)
    }  
  
  } 
  
  return(custom_habitat)
  
}
