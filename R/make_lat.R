#' @title Retrieve latitude for shad rivers.
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets.
#'
#' @param habitat A built-in \code{data.frame} containing habitat 
#' estimates (km2) for the scenario and region selected.
#'
#' @param river Character string specifying river name
#' 
# #' @example inst/examples/makefec_ex.R
#' 
#' @export
#'
make_lat <- function(river){
  
  # Get termcode for river
  termcode <- shad_rivers[shad_rivers==river, 2]
  
  # Select habitat units based on HUC 10 watershed names
  units <- habitat[termcode == habitat$TERMCODE,]
  
  # Get latitude and longitude for the first habitat unit
  latitude <- units$latitude[1]
  
  return(latitude)
  
}
