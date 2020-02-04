#' @title Calculate downstream survival given dam passage scenario.
#'
#' @description Function used to create population-level survival during
#' out-migration through dams if downstream passage < 1.
#'
#' @param habitat_data An internal data.frame in \code{\link{sim_pop}} 
#' containing habitat estimates (km2) for the scenario and region selected.
#'
#' @param river Character string specifying river name.
#' 
#' @param downstream Numeric indicating proportional downstream survival 
#' through a single dam.
#' 
#' @param upstream Numeric indicating proportional upstream passage 
#' through a single dam.
#' 
#' @return Numeric of length 1 representing catchment-scale 
#' downstream migration mortality for juvenile or adult fish.
#' 
#' @details This function assigns cumulative downstream passage values 
#' to all features in \code{habitat_data} corresponding to \code{river}.
#' It then calculates the proportion of habitat in each 
#' habitat segment, and weights downstream mortality at the catchment-scale
#' by proportion of habitat. This implicitly assumes that fish are distributed 
#' throughout the river during spawning in proportion to available
#' habitat.
#' 
# #' @example inst/examples/makefec_ex.R
#' 
#' @export
#'
make_downstream <- function(habitat_data, river, downstream, upstream){
  
  # Get termcode for river
  termcode <- shad_rivers$termcode[shad_rivers$system==river]
  
  # Select habitat units based on huc_code
  units <- habitat[habitat$TERMCODE==termcode, ]

  # Assign cumulative downstream passage to feature
  units$p_downstream <- downstream^units$dam_order
    
  # Calculate passage to habitat segment
  units$p_to_habitat <- upstream^units$dam_order
  units$functional_upstream <- units$habitatSegment_sqkm * units$p_to_habitat
  
  # Calculate proportion of habitat in each segment of available
  units$p_habitat <- units$functional_upstream/sum(units$functional_upstream)
    
  # Start with some number of fish
  units$starting <- units$p_habitat*1e6
    
  # Calculate number surviving
  units$ending <- units$starting*units$p_downstream
    
  # The ratio is survival rate
  s_downstream <- sum(units$ending)/sum(units$starting)
  
  return(s_downstream)
}
