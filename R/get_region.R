#' @title Get region for specified river by species
#'
#' @description Function used to get region for rivers listed
#' in output of \code{\link{get_rivers}} from the built-in
#' habitat data sets.
#'
#' @param river Character string specifying river name.
#'
#' @param species Character string specifying species.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#'
#' @examples get_region(river = "Hudson", species = "AMS")
#'
#' @export
#'
get_region <- function(river, species = c("ALE", "AMS", "BBH"),
                       custom_habitat = NULL) {
  # Species error handling
  if (missing(species)) {
    stop("

    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.")
  }

  if (!species %in% c("ALE", "AMS", "BBH")) {
    stop("

    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.")
  }

  # River error handling
  if (missing(river)) {
    stop("

    Argument 'river' must be specified.

    To see a list of available rivers, run get_rivers() or specify river name
    in custom_habitat if used.")
  }

  if (!river %in% get_rivers(species) & is.null(custom_habitat)) {
    stop("

    Argument 'river' must be one of those included in get_rivers() or in
    custom_habitat if used.

    To see a list of available rivers, run get_rivers()")
  }

  if (!is.null(custom_habitat)) {
    # Select habitat units based on huc_code
    if (species == "AMS") {
      units <- custom_habitat$region[custom_habitat$river == river]
    }

    if (species == "ALE") {
      units <- custom_habitat$region[custom_habitat$river == river]
    }

    if (species == "BBH") {
      units <- custom_habitat$region[custom_habitat$river == river]
    }
  } else {
    # Select habitat units based on huc_code
    if (species == "AMS") {
      units <- anadrofish::habitat$region[anadrofish::habitat$system == river]
    }

    if (species == "ALE") {
      units <- anadrofish::habitat_ale$POP[anadrofish::habitat_ale$River_huc == river]
    }

    if (species == "BBH") {
      units <- anadrofish::habitat_bbh$POP[anadrofish::habitat_bbh$River_huc == river]
    }
  }

  # Get the region
  region <- unique(units)[1]

  return(region)
}
