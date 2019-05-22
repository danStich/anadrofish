#' anadrofish: Anadromous Fish Population Responses to Habitat Changes
#' 
#' The anadrofish package is a collection of tools for running
#' coastwide or river-specific population models for
#' anadromous fish in response to habitat change.
#' 
#' @section Functions called directly:
#'  \describe{
#'    \code{\link{beverton_holt}} \cr
#'    \code{\link{lower95}} \cr 
#'    \code{\link{make_fec}} \cr
#'    \code{\link{make_habitat}}
#'    \code{\link{make_pop}} \cr
#'    \code{\link{make_spawners}} \cr
#'    \code{\link{project_pop}} \cr
#'    \code{\link{upper95}} \cr
#'  }
#'  
#' @section Data:
#'   \describe{
#'     \code{\link{habitat}} \cr
#'   }
#'
#'
#' @docType package
#' 
#' @name anadrofish
#' 
#' @importFrom demogR leslie.matrix eigen.analysis
#' @importFrom stats quantile
#' 
NULL
