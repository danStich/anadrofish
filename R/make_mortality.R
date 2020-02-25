#' @title Make instantaneous natural mortality. 
#'
#' @description The purpose of this function is to query the 
#' instantaneous natural mortality (regional estimates) 
#' for the selected river from built-in data set containing 
#' region-specific \code{\link{mortality}} and.
#'
#' @param river River for which maximum age is needed.
#'
#' @param sex Fish sex. If \code{NULL} (default), then mean
#' of male and female estimates is used.
#'
#' @return A numeric vector of \code{length = 1} containing
#' natural instantaneous mortality of fish in population.
#'
#' @examples make_mortality(river = "Susquehanna")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_mortality <- function(river, sex=c(NULL, 'female', 'male')){
  
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
    nM <- mean(anadrofish::mortality$M[
      anadrofish::mortality$region==region])
  }
  
  if(!missing(sex)){
    if(sex=='female'){
      nM <- anadrofish::mortality$M[
        anadrofish::mortality$region==region & 
          anadrofish::mortality$sex=='F']
    }  
  
    if(sex=='male'){
      nM <- anadrofish::mortality$M[
        anadrofish::mortality$region==region & 
          anadrofish::mortality$sex=='M']
    }
  }
  
  return(nM)
}
