#' @title Get dams for specified river from American shad habitat data
#'
#' @description Function used to get dams for rivers listed
#' in \code{\link{get_rivers}} from the built-in \code{\link{habitat}}
#' dataset for American shad. Not implemented for river herring.
#'
#' @param river Character string specifying river name. Must match one from
#' \code{get_rivers(species = 'AMS')}.
#'
#' @return A data.frame with 4 variables containing dam name,
#' latitude and longitude, and dam order in the watershed.
#'
#' @examples get_dams("Penobscot")
#'
#' @export
#'
get_dams <- function(river) {
  if (missing(river)) {
    stop("

    Argument 'river' must be specified.

    To see a list of available rivers, run get_rivers(species = 'AMS')")
  }

  if (!river %in% get_rivers(species = "AMS")) {
    stop("

    Argument 'river' must be one of those included in get_rivers().

    To see a list of available rivers, run get_rivers(species = 'AMS')")
  }

  # Select habitat units based on huc_code
  units <- anadrofish::habitat[anadrofish::habitat$system == river, ]

  # Get dams
  dams <- units[, 19:22]

  return(dams)
}
