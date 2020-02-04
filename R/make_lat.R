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
  termcode <- shad_rivers$termcode[shad_rivers$system==river]
  
  # Select habitat units based on HUC 10 watershed names
  units <- habitat[habitat$TERMCODE == termcode,]
  
  # Get latitude and longitude for the first downstream habitat unit
  latitude <- units$latitude[1]
  
  return(latitude)
  
}
