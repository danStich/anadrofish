#' anadrofish: Anadromous Fish Population Responses to Habitat Changes
#'
#' The anadrofish package is a collection of tools for running
#' coastwide or river-specific population models for
#' anadromous fish in response to habitat change from dams.
#'
#' @section Functions called directly:
#' The following functions can be called directly from anadrofish:
#'
#'  \describe{
#'
#'    \item{\code{\link{sim_pop}}}{main function used to simulate populations}
#'
#'    \item{\code{\link{add_unequal_vectors}}}{add vectors of unequal length}
#'    \item{\code{\link{beverton_holt}}}{Beverton-Holt recruitment with density dependence}
#'    \item{\code{\link{custom_habitat_template}}}{make custom habitat for an existing river or a template for a new river of interest}
#'    \item{\code{\link{get_dams}}}{get dams for specified river from American shad habitat data}
#'    \item{\code{\link{get_govt}}}{get governmental unit for specified river by species}
#'    \item{\code{\link{get_region}}}{get region for specified river by species}
#'    \item{\code{\link{get_rivers}}}{find out which rivers are available}
#'    \item{\code{\link{make_downstream}}}{river-specific, catchment-wide downstream survival through dams}
#'    \item{\code{\link{make_eggs}}}{simulate eggs per female by species and river}
#'    \item{\code{\link{make_habitat}}}{subset of \code{\link{habitat}} dataset for selected river}
#'    \item{\code{\link{make_iteroparity}}}{predict iteroparity from latitude based on reported relationships}
#'    \item{\code{\link{make_lat}}}{get latitude for specified river}
#'    \item{\code{\link{make_maxage}}}{get region-specific maximum age for specified population}
#'    \item{\code{\link{make_mortality}}}{calculate natural, instantaneous mortality by river}
#'    \item{\code{\link{make_pop}}}{simulate starting population}
#'    \item{\code{\link{make_postspawn}}}{predict post-spawning survival based on natural mortality and iteroparity}
#'    \item{\code{\link{make_recruits}}}{predict recruits from number of adults, fecundity, sex ratio, and juvenile survival}
#'    \item{\code{\link{make_spawners}}}{draw spawners from age-specific spawn recruitment probabilities}
#'    \item{\code{\link{make_spawnrecruit}}}{get region- and age-specific probabilities of recruitment to spawn}
#'    \item{\code{\link{project_pop}}}{project population to next time step without reproduction}
#'    \item{\code{\link{sim_juvenile_s}}}{simulate juvenile survival based on reported rates}
#'
#'    \item{\code{\link{lower95}}}{convenience function for calculating upper 95\% CI}
#'    \item{\code{\link{upper95}}}{convenience function for calculating lower 95\% CI}
#'  }
#'
#' @section Data:
#' The following built-in datasets are included:
#'
#'   \describe{
#'     \item{\code{\link{crecco_1983}}}{Regression parameters for latitude-iteroparity relationship in American shad}
#'     \item{\code{\link{fl_tl_conversions}}}{Fork length - total length conversions for river herring}
#'     \item{\code{\link{habitat}}}{American shad habitat data}
#'     \item{\code{\link{habitat_ale}}}{Alewife habitat data}
#'     \item{\code{\link{habitat_bbh}}}{Blueback herring habitat data}
#'     \item{\code{\link{jessop_1993}}}{Fork length-fecundity relationships for alewife}
#'     \item{\code{\link{length_weight}}}{Regional length-weight regression parameters for American shad}
#'     \item{\code{\link{lw_pars_rh}}}{Regional length-weight regression parameters for river herring}
#'     \item{\code{\link{maki_pars}}}{Regional spawner recruitment parameters for river herring}
#'     \item{\code{\link{maturity}}}{Regional spawner recruitment probabilities for American shad}
#'     \item{\code{\link{max_ages}}}{Regional maximum ages by sex and species}
#'     \item{\code{\link{mortality}}}{Regional mortality estimates for American shad by sex}
#'     \item{\code{\link{mortality_rh}}}{Regional mortality estimates for river herring by sex}
#'     \item{\code{\link{olney_mcbride}}}{Regression parameters for weight-batch fecundity relationships}
#'     \item{\code{\link{vbgf_ale}}}{von Bertalanffy growth parameters for alewife}
#'     \item{\code{\link{vbgf_bbh}}}{von Bertalanffy growth parameters for blueback herring}
#'     \item{\code{\link{vbgf_NI}}}{von Bertalanffy growth parameters for NI American shad}
#'     \item{\code{\link{vbgf_SI}}}{von Bertalanffy growth parameters for SI American shad}
#'     \item{\code{\link{vbgf_SP}}}{von Bertalanffy growth parameters for SP American shad}
#'   }
#'
#'
"_PACKAGE"
#'
#' @aliases anadrofish-package
#'
#' @importFrom stats quantile rnorm runif sd
NULL
