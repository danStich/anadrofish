#' anadrofish: Anadromous Fish Population Responses to Habitat Changes
#' 
#' The anadrofish package is a collection of tools for running
#' coastwide or river-specific population models for
#' anadromous fish in response to habitat change from dams.
#' 
#' @section Functions called directly:
#' The following functions can be called directly from anadrofish. They 
#' are grouped as follows:  i) the main user-facing functions, ii) functions 
#' used to query predictive relationships or life-history parameters from 
#' built-in datasets, iii) general population dynamics tools, and iv)
#' utility functions.
#' 
#'  \describe{
#'  
#'    \code{\link{sim_pop}}{ main function used to simulate populations} \cr
#'    \code{\link{get_rivers}}{ find out which rivers are available} \cr
#'       
#'    \code{\link{make_downstream}}{ river-specific, catchment-wide downstream survival through dams} \cr
#'    \code{\link{make_habitat}}{ subset of \code{\link{habitat}} dataset for selected river} \cr
#'    \code{\link{make_iteroparity}}{ predict iteroparity from latitude based on reported relationships} \cr
#'    \code{\link{make_lat}}{ get latitude for specified river} \cr
#'    \code{\link{make_maxage}}{ get region-specific maximum age for specified population} \cr
#'    \code{\link{make_mortality}}{ calculate natural, instantaneous mortality by river} \cr
#'    \code{\link{make_pop}}{ simulate starting population} \cr
#'    \code{\link{make_spawners}}{ draw spawners from age-specific spawn recruitment probabilities} \cr
#'    \code{\link{make_spawnrecruit}}{ get region- and age-specific probabilities of recruitment to spawn} \cr
#'    \code{\link{make_postspawn}}{ predict post-spawning survival based on natural mortality and iteroparity} \cr
#'    \code{\link{make_recruits}}{ predict recruits from number of adults, fecundity, sex ratio, and juvenile survival} \cr
#'    
#'    \code{\link{beverton_holt}}{ Beverton-Holt recruitment with density dependence} \cr
#'    \code{\link{project_pop}}{ project population to next time step without reproduction} \cr
#'    \code{\link{sim_juvenile_s}}{ simulate juvenile survival based on reported rates} \cr
#'    
#'    \code{\link{lower95}}{ convenience function for calculating upper 95\% CI} \cr 
#'    \code{\link{upper95}}{ convenience function for calculating lower 95\% CI} \cr
#'  }
#'  
#' @section Data:
#' The following built-in datasets are included for transparency
#' and further development.
#' 
#'   \describe{
#'     \code{\link{crecco_1983}}{ Regression parameters for latitude-iteroparity relationship} \cr
#'     \code{\link{habitat}}{ American shad habitat data} \cr
#'     \code{\link{length_weight}}{ Regional length-weight regression parameters for American shad} \cr
#'     \code{\link{maturity}}{ Regional spawner recruitment probabilities for American shad}  \cr
#'     \code{\link{max_ages}}{ Regional maximum ages for American shad by sex}  \cr
#'     \code{\link{mortality}}{ Regional mortality estimates for American shad by sex}  \cr
#'     \code{\link{olney_mcbride}}{ Regression parameters for weight-batch fecundity relationships} \cr
#'     \code{\link{vbgf_NI}}{ von Bertalanffy growth parameters for NI American shad}  \cr
#'     \code{\link{vbgf_SI}}{ von Bertalanffy growth parameters for SI American shad}  \cr
#'     \code{\link{vbgf_SP}}{ von Bertalanffy growth parameters for SP American shad}  \cr
#'   }
#'
#'
#' @docType package
#' 
#' @name anadrofish
#' 
#' @importFrom truncnorm rtruncnorm
#' @importFrom stats quantile rnorm runif sd
#' 
NULL
