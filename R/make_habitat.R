#' @title Make cumulative habitat for river
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
make_habitat <- function(river, upstream, historical){
  
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers()")    
  }
  
  if(!river %in% get_rivers()){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # Select habitat units based on huc_code and whether
  # this is an historical analysis (historical == FALSE
  # by default)
  # Contemporary habitat data subset
  units <- anadrofish::habitat[anadrofish::habitat$system==river,]
  
  # Historical habitat data subset
  if(historical == TRUE){
    units <- anadrofish::habitat_hist[anadrofish::habitat_hist$system==river,]
    # units[with(units, order(dam_order)), ]
    
  }
  
  # Calculate passage to habitat segment
  units$p_to_habitat <- upstream^units$dam_order
  if(historical == TRUE){
    units$p_to_habitat <- cumprod(upstream)
  }
  
  units$functional_upstream <- units$habitatSegment_sqkm * units$p_to_habitat
  
  # Calculate habitat surface acres from the 
  # sum of functional habitat in the subset
    acres <- 247.105 * sum(units$functional_upstream)
  
  return(acres)
}
