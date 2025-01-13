#' @title Juvenile (hatch-to-outmigrant) survival
#'
#' @description Function used to simulate juvenile (hatch-to-outmigrant) 
#' survival from daily rates.
#'
#' @param species Species used for simulation ("AMS", "ALE", or "BBH").
#' 
#' @return A numeric vector of length 1.
#' 
#' @examples sim_juvenile_s(species = "ALE")
#'
#' @references Crecco, V., T. Savoy, and L. Gunn. 1983. Daily mortality rates 
#' of larval and juvenile American shad (*Alosa sapidissima*) in the Connecticut 
#' River with changes in year-class strength. Canadian Journal of 
#' Fisheries and Aquatic Sciences 40:1719-1728.
#' 
#' Overton A. S., N. A. Jones, and R. Rulifson. 2012. Spatial and temporal 
#' variability in instantaneous growth, mortality, and recruitment of larval 
#' river herring in the Tar-Pamlico River, North Carolina. Marine and Coastal 
#' Fisheries: Dynamics, Management, and Ecosystem Science 4:218-227.
#' 
#' Stich, D. S., W. E. Eakin, and G. Kenney. 2024. Population Responses of 
#' Blueback Herring to Dam Passage Standards and Additive Mortality Sources.
#' Journal of Fish and Wildlife Management 15(1):31-48.
#' 
#' Hook, T. O., E. S. Rutherford, D. M. Mason, and G. S. Carter. 2007. Hatch 
#' Dates, Growth, Survival, and Overwinter Mortality of Age-0 Alewives in 
#' Lake Michigan: Implications for Habitat-Specific Recruitment Success.
#' Transactions of the American Fisheries Society 136:1298-1312.
#' 
#' @importFrom truncnorm rtruncnorm
#' 
#' @export
#' 
sim_juvenile_s <- function(species = c("AMS", "ALE", "BBH")){
  
  # Species error handling
  if(missing(species)){
    stop("
    
    Argument 'species' must be one of 'AMS', 'ALE', or 'BBH'.")   
  }
  
  if(!species %in% c('AMS', 'ALE', 'BBH')){
    stop("
         
    Argument 'species' must be one of 'AMS', 'ALE', or 'BBH'.") 
  }
  
  if(species == "AMS"){
    subs <- anadrofish::crecco_1983[
      anadrofish::crecco_1983$Age == 70 & 
        anadrofish::crecco_1983$Year != 1980, ]
    
    theta <-c(mean(subs$Sc), sd(subs$Sc))
    
    juvenile_s <- truncnorm::rtruncnorm(n = 1,
                                        a = 0,
                                        b = 0.014,
                                        mean = theta[1],
                                        sd = theta[1]*0.2)    
  }
  
  if(species == "BBH"){
    #  30-d S based on daily Z estimatesFrom Overton et al. (2012)
    Zd <- truncnorm::rtruncnorm(n = 1, a = 0, mean = 0.21, sd = 0.038^2)
    juvenile_s <- exp(-Zd*30)
  }
  
  if(species == "ALE"){
    # 30-d S based on daily Z estimates from Hook et al. (2007) and 
    # Overton et al. (2012)
    Zd <- truncnorm::rtruncnorm(n = 1, a = 0, mean = 0.205, sd = 0.048^2)
    juvenile_s <- exp(-Zd*30)
  } 
  
  return(juvenile_s)
  
}
