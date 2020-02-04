#' @title Project population
#'
#' @description Function used to make habitat for rivers listed
#' in \code{\link{get_rivers}} from the built-in 
#' dataset(s)
#'
#' @param habitat_data A built-in data.frame containing habitat 
#' estimates (km2) for the scenario and region selected.
#'
#' @param river Character string specifying river name
#' 
#' @param upstream Proportional upstream passage through dams.
#' 
# #' @example inst/examples/makehabitat_ex.R
#' 
#' @export
#'
make_habitat <- function(habitat_data, river, upstream){
  
  # Get termcode for river
  termcode <- shad_rivers$termcode[shad_rivers$system==river]
  
  # Select habitat units based on huc_code
  units <- habitat[habitat$TERMCODE==termcode,]
  
  # Calculate passage to habitat segment
  units$p_to_habitat <- upstream^units$dam_order
  units$functional_upstream <- units$habitatSegment_sqkm * units$p_to_habitat
  
  # Calculate habitat surface acres from the 
  # sum of functional habitat in the subset
    acres <- 247.105 * sum(units$functional_upstream)
  
  return(acres)
}
