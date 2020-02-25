#' @title Make maximum age for population using built-in data sets. 
#'
#' @description The purpose of this function is to query the maximum age 
#' in the selected river from built-in data set containing 
#' region-specific \code{\link{max_ages}} and.
#'
#' @param river River for which maximum age is needed.
#' 
#' @param sex Sex of fish. If not specified, then mean of
#' male and female maximum ages is returned.
#'
#' @return A numeric vector of \code{length = 1} containing
#' maximum age of fish in population.
#'
#' @examples make_maxage(river = "Susquehanna")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_maxage <- function(river, sex = c('female', 'male')){
 
  if(!missing(sex)) sex <- match.arg(sex)
   
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
  
  region <- anadrofish::shad_rivers$region[
    anadrofish::shad_rivers$system==river]
  
  if(missing(sex)){
    max_age <- max(anadrofish::max_ages$maxage[
      anadrofish::max_ages$region==region])
  }
  
  if(!missing(sex)){
    if(sex=='female'){
      max_age <- anadrofish::max_ages$maxage[
        anadrofish::max_ages$region==region & 
          anadrofish::max_ages$sex=='F']
    }  
  
    if(sex=='male'){
      max_age <- anadrofish::max_ages$maxage[
        anadrofish::max_ages$region==region & 
          anadrofish::max_ages$sex=='M']
    }
  }
  
  return(max_age)
}
