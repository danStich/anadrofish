#' @title Calculate downstream survival given dam passage scenario.
#'
#' @description Function used to create population-level survival during
#' out-migration through dams if downstream passage < 1.
#'
#' @param habitat_data A built-in \code{data.frame} containing habitat 
#' estimates (km2) for the scenario and region selected.
#'
#' @param river Character string specifying river name.
#' 
#' @param type Character string indicating the type of habitat 
#' to be considered. Possible values include \code{'functional'}, 
#' \code{'total'}, or \code{'passage'}. See \code{?sim_pop} for explanation
#' of these types.
#' 
#' @param downstream Numeric indicating proportional downstream survival 
#' through a single dam.
#' 
# #' @example inst/examples/makefec_ex.R
#' 
#' @export
#'
make_downstream <- function(habitat_data, river, type, downstream){
  
  # Get termcode for river
  termcode <- shad_rivers[shad_rivers==river, 2]
  
  # Select habitat units based on HUC 10 watershed names
  units <- habitat[termcode == habitat$TERMCODE,]
  
  # Set downstream survival to 100% for no-dam types
  if((type == 'total' | type == 'functional')){
    s_downstream <- 1.00
  }
  
  # Create downstream survival from proportion
  # of habitat in each unit given a known population size
  # if downstream passage < 1
  if(type == 'passage'){
    units$p_downstream <- downstream^units$dam_order
    units$p_habitat <- units$habitatSegment_sqkm/sum(units$habitatSegment_sqkm)
    units$starting <- units$p_habitat*1e6
    units$ending <- units$starting*units$p_downstream
    s_downstream <- sum(units$ending)/sum(units$starting)
  }
  
  return(s_downstream)
}
