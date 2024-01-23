#' @title Make maximum age for population using built-in data sets. 
#'
#' @description The purpose of this function is to query the maximum age 
#' in the selected river from built-in data set containing 
#' region-specific \code{\link{max_ages}} and.
#'
#' @param river River for which maximum age is needed.
#' 
#' @param sex Sex of fish. If not specified, then mean of
#' male and female maximum ages is returned for American shad,
#' or pooled sex data used for river_herring.
#'
#' @return A numeric vector of \code{length = 1} containing
#' maximum age of fish in population.
#'
#' @examples make_maxage(river = "Susquehanna River", species = "ALE")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_maxage <- function(river, 
                        sex = c('female', 'male'),
                        species = c("AMS", "ALE", "BBH")){
 
  # Required argument matching
  if(!missing(sex)) sex <- match.arg(sex)
  if(!missing(species)) species <- match.arg(species)
  
  # Species error handling
  # Make sure species is one of those implemented in package
  if(!species %in% c("ALE", "AMS", "BBH")){
    stop("
         
    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.") 
  }
  
  # River error handling
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
      max_age <- max(anadrofish::max_ages$maxage[
        anadrofish::max_ages$region == region])
    }
    
    if(!missing(sex)){
      if(sex == 'female'){
        max_age <- anadrofish::max_ages$maxage[
          anadrofish::max_ages$region == region & 
            anadrofish::max_ages$sex == 'F']
      }  
    
      if(sex == 'male'){
        max_age <- anadrofish::max_ages$maxage[
          anadrofish::max_ages$region == region & 
            anadrofish::max_ages$sex == 'M']
      }
    }
  }
  
  # Max age for all sexes and stocks of river herring was 10 years (ASMFC 2024)
  if(species %in% c("ALE", "BBH")){
    
    if(missing(sex)){
      max_age <- max(anadrofish::mortality_rh$age[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$species == species])
    }    

    if(sex == 'female'){
      max_age <- max(anadrofish::mortality_rh$age[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$species == species &
            anadrofish::mortality_rh$sex == "Female"])
    }  
    
    if(sex == 'male'){
      max_age <- max(anadrofish::mortality_rh$age[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$species == species &         
            anadrofish::mortality_rh$sex == "Male"])
    }      
    
  }  
  
  return(max_age)
  
}
