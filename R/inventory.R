#' @title Inventory of U.S Atlantic coast American shad rivers
#'
#' @description A dataset containing the name of each of the U.S
#' Atlantic coast rivers identified as historical American
#' shad habitat. Not used directly in package. Included for reference.
#'
#' @format A data frame with 65 observations of 6 variables:
#' \describe{
#' 
#' \code{system}{ The name of each river system.}
#' 
#' \code{included}{ Names of other rivers included within the system.}
#' 
#' \code{huc_level}{ The HUC level used to calculate surface acres
#' of habitat in the river system}
#' 
#' \code{termcode}{ A unique identifier for each river system that is
#' region (NI = Northern iteroparous, SI = Southern iteroparous, 
#' SP = Semelparous), state of outlet, and HUC code.}
#' }
#' 
#' \code{huc_code}{ Code for HUC used to calculate habitat in
#' \code{habitat}}
#'
#' \code{operational_notes}{ Notes related to data management, processing,
#' etc. Not used directly. Included for transparency.} 
#' @source Atlantic States Marine Fisheries Commission
"inventory"
