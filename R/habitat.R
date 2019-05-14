#' American shad habitat ("HabitatNE_wd10.0m_slp0.01_tidal1.rda")
#'
#' A dataset containing the surface area of functional American 
#' shad habitat by river reach in the New England Region. 
#'
#' * `UNIQUE_ID`: polygon ID
#' * `type`: river reach type: either \code{outlet} or \code{dam}
#' * `catchmentID`: ID for catchment containing river reach
#' * `habitat_sqkm`: cumulative habitat upstream of feature
#'    indicated in \code{type}
#' * `habitatSegment_sqkm`: surface area (km2) of habitat 
#' * `functional_habitatSegment_sqkm`: surface area (km2) of
#'    habitat in segment adjusted by \code{passageToHabitat}
#' * `PassageToHabitat`: probability of migratory fish passage
#'    to habitat segment
#' * `Decision`: NEEDS DOCUMENTATION
#' * `HUC6_location`: Name for geographic location of
#'    HUC6 catchment basin
#' * `HUC10_location`: Name for geographic location of
#'    HUC10 catchment basin
#'
#' @format A data frame with 53940 rows and 10 variables
#' @source <http://www.diamondse.info/>
"habitat"
