#' @title Make instantaneous natural mortality. 
#'
#' @description The purpose of this function is to query the 
#' instantaneous natural mortality (regional estimates) 
#' for the selected river from built-in data set containing 
#' region-specific \code{\link{mortality}} for American shad or
#' \code{\link{mortality_rh}} for river herring.
#'
#' @param river River for which maximum age is needed.
#'
#' @param sex Fish sex. If \code{NULL} (default) or \code{"Pooled"}, then mean
#' of male and female estimates is used.
#' 
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#' 
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#' 
#' @return A numeric vector of \code{length = 1} containing
#' natural instantaneous mortality of fish in population.
#'
#' @examples make_mortality(river = "Penobscot", species = "BBH")
#' 
#' @references Atlantic States Marine Fisheries Commission (ASMFC). 2020. 
#' American shad benchmark stock assessment and peer-review report. ASMFC, 
#' Arlington, VA.
#' 
#' Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA. 
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @source Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_mortality <- function(river, 
                           sex = c(NULL, "female", "male"),
                           species = c("AMS", "ALE", "BBH"),
                           custom_habitat = NULL){
  
  if(!missing(species)) species <- match.arg(species) 
  
  if(!missing(sex)) sex <- match.arg(sex)
  
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
  
  # Get region
  region <- get_region(river = river, species = species, 
                       custom_habitat = custom_habitat) 
  
  # Get natural mortality
  if(species == "AMS"){
    if(missing(sex)){
      nM <- mean(anadrofish::mortality$M[
        anadrofish::mortality$region == region])
    }
    
    if(!missing(sex)){
      if(sex == 'female'){
        nM <- anadrofish::mortality$M[
          anadrofish::mortality$region == region & 
            anadrofish::mortality$sex == 'F']
      }  
    
      if(sex == 'male'){
        nM <- anadrofish::mortality$M[
          anadrofish::mortality$region == region & 
            anadrofish::mortality$sex == 'M']
      }
    }
  }
  
  if(species == "ALE"){
    if(missing(sex)){
      nM <- anadrofish::mortality_rh$M[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$sex == "Pooled" &
          anadrofish::mortality_rh$species == species]
    }
    
    if(!missing(sex)){
      if(sex == 'female'){
        nM <- anadrofish::mortality_rh$M[
          anadrofish::mortality_rh$region == region &
            anadrofish::mortality_rh$sex == "Female" &
            anadrofish::mortality_rh$species == species]
      }  
      
      if(sex == 'male'){
        nM <- anadrofish::mortality_rh$M[
          anadrofish::mortality_rh$region == region &
            anadrofish::mortality_rh$sex == "Male" &
            anadrofish::mortality_rh$species == species]
      }
    }
  }
  
  
  if(species == "BBH"){
    if(missing(sex)){
      nM <- anadrofish::mortality_rh$M[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$sex == "Pooled" &
          anadrofish::mortality_rh$species == species]
    }
    
    if(!missing(sex)){
      if(sex == 'female'){
        nM <- anadrofish::mortality_rh$M[
          anadrofish::mortality_rh$region == region &
            anadrofish::mortality_rh$sex == "Female" &
            anadrofish::mortality_rh$species == species]
      }  
      
      if(sex == 'male'){
        nM <- anadrofish::mortality_rh$M[
          anadrofish::mortality_rh$region == region &
            anadrofish::mortality_rh$sex == "Male" &
            anadrofish::mortality_rh$species == species]
      }
    }
  }  
  
  return(nM)
}
