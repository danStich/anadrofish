#' anadrofish: Anadromous Fish Population Responses to Habitat Changes
#' 
#' The anadrofish package is a collection of tools for running
#' coastwide or river-specific population models for
#' anadromous fish in response to habitat change from dams.
#' 
#' @section Functions called directly:
#'  \describe{
#'    \code{\link{beverton_holt}} \cr
#'    \code{\link{get_rivers}} \cr
#'    \code{\link{lower95}} \cr 
#'    \code{\link{make_downstream}} \cr
#'    \code{\link{make_habitat}} \cr
#'    \code{\link{make_iteroparity}} \cr
#'    \code{\link{make_lat}} \cr
#'    \code{\link{make_maxage}} \cr
#'    \code{\link{make_mortality}} \cr
#'    \code{\link{make_pop}} \cr
#'    \code{\link{make_postspawn}} \cr
#'    \code{\link{make_recruits}} \cr
#'    \code{\link{make_spawners}} \cr
#'    \code{\link{make_spawnrecruit}} \cr
#'    \code{\link{project_pop}} \cr
#'    \code{\link{sim_juvenile_s}} \cr
#'    \code{\link{sim_pop}} \cr
#'    \code{\link{upper95}} \cr
#'  }
#'  
#' @section Data:
#'   \describe{
#'     \code{\link{crecco_1983}} \cr
#'     \code{\link{habitat}} \cr
#'     \code{\link{inventory}} \cr
#'     \code{\link{length_weight}} \cr
#'     \code{\link{maturity}} \cr
#'     \code{\link{max_ages}} \cr
#'     \code{\link{mortality}} \cr
#'     \code{\link{olney_mcbride}} \cr
#'     \code{\link{shad_rivers}} \cr
#'     \code{\link{vbgf_NI}} \cr
#'     \code{\link{vbgf_SI}} \cr
#'     \code{\link{vbgf_SP}} \cr
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
