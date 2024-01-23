#' @title Make instantaneous natural mortality. 
#'
#' @description The purpose of this function is to query the 
#' instantaneous natural mortality (regional estimates) 
#' for the selected river from built-in data set containing 
#' region-specific \code{\link{mortality}} and.
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
#' @return A numeric vector of \code{length = 1} containing
#' natural instantaneous mortality of fish in population.
#'
#' @examples make_mortality(river = "Susquehanna", species = "BBH")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_mortality <- function(river, 
                           sex = c(NULL, "female", "male"),
                           species = c("AMS", "ALE", "BBH")){
  
  if(!missing(species)) species <- match.arg(species) 
  
  if(!missing(sex)) sex <- match.arg(sex)
  
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers()")    
  }
  
  if(!river %in% get_rivers(species)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }  
  
  region <- get_region(river = river, species = species)
  
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
