#' @title Retrieve latitude for American shad rivers.
#'
#' @description Function used to extract river-specific latitude
#' from built-in data sets for American shad. Not implemented for river herring.
#'
#' @param river Character string specifying river name. See
#' \code{\link{get_rivers}}.
#'
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from custom_habitat_template(). NEED TO ADD LINK.
#'
#' @examples make_lat(river = "Susquehanna", species = "AMS")
#'
#' @export
#'
make_lat <- function(river, species = c("AMS", "ALE", "BBH"),
                     custom_habitat = NULL) {
  # Error handling
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

  if (is.null(custom_habitat)) {
    # Select habitat units based on names used in ASMFC (2020) or ASMFC (2024)
    if (species == "AMS") {
      lat <- anadrofish::habitat$latitude[anadrofish::habitat$system == river][1]
    }
    if (species == "ALE") {
      lat <- anadrofish::habitat_ale$Latitude[anadrofish::habitat_ale$River_huc == river][1]
    }
    if (species == "BBH") {
      lat <- anadrofish::habitat_bbh$Latitude[anadrofish::habitat_bbh$River_huc == river][1]
    }
  } else {
    lat <- custom_habitat$lat[1]
  }

  return(lat)
}
