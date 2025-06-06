#' @title Blueback herring habitat
#'
#' @description A dataset containing the surface area of blueback herring
#' habitat and features for individual flow line segments 
#' comprising habitat units in Atlantic coast drainages.
#'
#' @format A data frame with 282,809 observations of 7 variables:
#' \describe{
#'     \item{\code{REACHCODE}}{Code used to identify individual habitat units}
#'     \item{\code{Hab_sqkm}}{Surface area of habitat in square kilometers}
#'     \item{\code{Latitude}}{Latitude at downstream terminus of habitat unit}
#'     \item{\code{State}}{Governmental unit at downstream terminus of habitat unit}
#'     \item{\code{River_huc}}{Name of river to which habitat unit belongs, derived from hydrologic unit codes}
#'     \item{\code{POP}}{Genetic reporting group geographic region within which habitat unit falls}
#'     \item{\code{DamOrder}}{Order of dam at downstream terminus of habitat unit. Cumulatively assigned such that all habitat units upstream of a given dam all have dam_order >= 1}
#' }
#' 
#' @source Shawn Snyder
"habitat_bbh"
