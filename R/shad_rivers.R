#' @title Altantic Coast American shad Rivers in North America
#'
#' @description A dataset containing the names of North American
#' Atlantic coast rivers identified as historical American
#' shad habitat. Derived from \code{inventory}. Used to relate 
#' user-specified river(s) to amount of habitat in each system 
#' and regional biological parameters via \code{huc_code}.
#'
#' @format A data frame with 65 observations of 6 variables:
#' \describe{
#' 
#' \code{system}{ The name of each river system.}
#' 
#' \code{region}{ Life-history region (NI = Northern 
#' iteroparous, SI = Southern iteroparous, SP = Semelparous)}
#' 
#' \code{huc_code}{ Code for the HUC level (4, 6, 8, 10)
#' used to identify river system, with 3 - 9 digits (
#' \code{huc_level-1}).}
#' 
#' \code{termcode}{ A unique identifier for each river system that is
#' region, state of outlet, and HUC code.}
#' 
#' \code{count}{ Count of habitat segments per system}
#' 
#' \code{total}{ Sum of habitat segments (sqaure km) in system}
#' }
#' 
#' @source Atlantic States Marine Fisheries Commission
"shad_rivers"
