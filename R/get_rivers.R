#' @title Rivers included in habitat data by species
#'
#' @description Get names of rivers included in package for each species.
#'
#' @details The primary uses of this function are (1) so the user can see
#' rivers that can be used for simulation, and (2) so the output can be passed
#' to a random sampler for use in stochastic simulation via
#' parallel processing.
#'
#' @param species Species for which rivers are returned
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @return A character vector of rivers that are included in
#' built-in habitat datasets for selected \code{species}.
#'
#' @example inst/examples/get_rivers_ex.R
#'
#' @export
#'
get_rivers <- function(species = c("ALE", "AMS", "BBH")) {
  # Make sure species is one of those implemented in package
  if (!species %in% c("ALE", "AMS", "BBH")) {
    stop("

    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.")
  }

  if (species == "AMS") {
    return(sort(unique(anadrofish::habitat$system)))
  }
  if (species == "ALE") {
    return(sort(unique(anadrofish::habitat_ale$River_huc)))
  }
  if (species == "BBH") {
    return(sort(unique(anadrofish::habitat_bbh$River_huc)))
  }
}
