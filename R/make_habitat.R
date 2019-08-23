#' @title Project population
#'
#' @description Function used to make habitat from the built-in 
#' dataset(s)
#'
#' @param habitat_data A built-in \code{data.frame} containing habitat 
#' estimates (km2) for the scenario and region selected.
#'
#' @param river Character string specifying river name
#' 
#' @param type Character string indicating the type of habitat 
#' to be considered. Possible values include \code{functional}, 
#' or \code{segment}. For \code{PassageToHabitat < 1}, 
#' \code{type = 'functional'} adjusts \code{habitatSegment_sqkm} 
#' proportionally and uses the variable \code{functional_habitatSegment_sqkm} 
#' for calculations. See \code{?habitat} for explanation of built-in 
#' data sets.
#' 
# #' @example inst/examples/makefec_ex.R
#' 
#' @export
#'
make_habitat <- function(habitat_data, river, type = 'functional'){
  # Get termcode for river
  termcode <- shad_rivers[shad_rivers==river,2]
  
  # Select habitat units based on HUC 10 watershed names
  units <- habitat[termcode == habitat$TERMCODE,]
  
  # Calculate habitat surface acres from the 
  # sum of functional habitat in the subset
  
  if(type == 'functional'){
    acres <- 247.105 * sum(units$functional_habitatSegment_sqkm)
  } else {
    stop('Error: only functional habitat implemented so far!')
  }
  
  return(acres)
}
