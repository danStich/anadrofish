#' @title Retrieve latitude for shad rivers.
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets.
#'
#' @param river Character string specifying river name. See 
#' \code{\link{get_rivers}}.
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
  
  # Get latitude and longitude for the first downstream habitat unit
  latitude <- units$latitude[1]
  
  return(latitude)
  
}
