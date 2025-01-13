#' @title Alewife habitat
#'
#' @description A dataset containing the surface area of Alewife 
#' habitat and features for individual flow line segments or waterbodies (lakes)
#' comprising habitat units in Atlantic coast drainages. 
#'
#' @format A data frame with 246,259 observations of 7 variables:
#' \describe{
#' 
#' \code{REACHCODE}{ code used to identify individual habitat units}
#' 
#' \code{Hab_sqkm}{ surface area of habitat in square kilometers}
#' 
#' \code{Latitude}{ latitude at downstream terminus of habitat unit}
#' 
#' \code{State}{ governmental unit at downstream terminus of habitat unit}
#' 
#' \code{River_huc}{ name of river to which habitat unit belongs, derived from hydrologic unit codes}
#' 
#' \code{POP}{ genetic reporting group geographic region within which habitat unit falls}
#' 
#' \code{DamOrder}{ order of dam at downstream terminus of habitat unit. Cumulatively assigned such that all habitat units upstream of a given dam all have dam_order >= 1}
#' 
#' }
#' 
#' @examples head(habitat_ale)
#'
#' 
#' @source Shawn Snyder
"habitat_ale"
