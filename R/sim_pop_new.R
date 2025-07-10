#' @title Simulate population dynamics through time.
#'
#' @param nyears Number of years for simulation.
#'
#' @description Use functions from \code{\link{anadrofish}} to simulate
#' population change through time relative to upstream and downstream
#' passage probabilities and uncertainty in life-history information.
#'
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param river River basin. Available rivers implemented in package
#' can be viewed by calling \code{\link{get_rivers}} with no arguments
#' (e.g., \code{get_rivers()}). Alternatively, the user can specify
#' \code{rivers = sample(get_rivers, 1)} to randomly sample river
#' within larger simulation studies. Information about each river can be
#' found in the \code{\link{habitat}} dataset.
#'
#' @param max_age Maximum age of fish in population. If \code{NULL}
#' (default), then based on the maximum age of females for the
#' corresponding region in the \code{\link{max_ages}} dataset.
#'
#' @param nM Instantaneous natural mortality. If \code{NULL}
#' (default), then based on the average of males and females for the
#' corresponding region in the \code{\link{mortality}} dataset.
#'
#' @param fM Instantaneous fishing mortality. The default value is zero.
#'
#' @param n_init Initial population seed (number of Age-1 individuals)
#' used to simulate the starting population. Default is to use a draw
#' from a wide uniform distribution, but it may be beneficial to narrow
#' once expectations for abundance at population stability are determined.
#'
#' @param spawnRecruit Probability of recruitment to spawn at age. If
#' \code{NULL} (default), then probabilities are based on the mean of
#' male and female recruitment to first spawn at age from the
#' \code{\link{maturity}} dataset.
#'
#' @param eggs Number of eggs per female. Can be a vector of length 1
#' if eggs per female is age invariant, or can be vector of length
#' \code{max_age} if age-specific. If \code{NULL} (default) then
#' estimated based on weight-batch fecundity regression relationships
#' for each life-history region in the \code{\link{olney_mcbride}}
#' dataset (Olney and McBride 2003) and mean number of batches spawned
#' (6.1 +/- 2.1, McBride et al. 2016) using \code{\link{make_eggs}} for
#' American shad or parameters from Sullivan et al. (2019) for river herring.
#'
#' @param sr Sex ratio (expressed as percent female or P(female)).
#'
#' @param b Density-dependent parameter for the Beverton-Holt
#' stock-recruitment relationship. The default value (\code{0.21904}) is used
#' to approximate a larval carrying capacity at 100 adult fish per acre based
#' on fecundity American shad and river herring. A value of about 0.05
#' approximates a carrying capacity that corresponds to about 500 adult fish
#' per acre.
#'
#' @param s_juvenile Survival from hatch to outmigrant. If NULL
#' (default) then simulated from a (log) normal distribution using
#' mean and sd of \code{Sc} through \code{70 d} for 1979-1982 from
#' Crecco et al. (1983) in \code{\link{crecco_1983}}.
#'
#' @param upstream Numeric of length 1 representing proportional
#' upstream passage through dams.
#'
#' @param downstream Numeric of length 1 indicating proportional
#' downstream survival through dams.
#'
#' @param downstream_j Numeric of length 1 indicating proportional
#' downstream survival through dams for juveniles.
#'
#' @param output_years Temporal level of detail provided in output.
#' The default value of '\code{last}' returns the final year of simulation.
#' Any value other than the default '\code{last}' will return
#' data for all years of simulation. This is useful for testing.
#'
#' @param age_structured_output Should population and spawner abundance
#' in the output dataframe be age-structured? If \code{FALSE} (default),
#' then \code{pop} (non-spawning population) and \code{spawners} (spawning
#' population) are summed across all age classes for each year of simulation.
#' If \code{TRUE} then \code{pop} and \code{spawners} are returned for
#' each age class. For the sake of managing outputs, abundances for
#' \code{pop} and \code{spawners} are reported for all age classes 1-13
#' regardless of \code{max_age}, but all abundances for ages greater
#' than \code{max_age} are zero.
#'
#' @param sex_specific Whether to use sex-specific life-history data.
#'
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#'
#' @return A dataframe containing simulation inputs (arguments
#' to \code{sim_pop}) and outputs (number of spawners) by year, minimally
#' including the following variables:
#'
#' \itemize{
#'     \item \code{river} Name of river.
#'     \item \code{region} Regional grouping, see \code{\link{get_region}}.
#'     \item \code{govt} Governmental unit at downstream terminus of habitat unit.
#'     \item \code{lat} Latitude at downstream terminus of habitat unit.
#'     \item \code{habitat} Amount of accessible habitat given upstream passage and river.
#'     \item \code{year} year of simulation. If \code{output_years = "last"} then \code{nyears}.
#'     \item \code{upstream} upstream passage through dams. Currently a single value.
#'     \item \code{downstream} adult downstream survival through dams. Currently a single value.
#'     \item \code{downstream_j} adult downstream survival through dams. Currently a single value.
#'     \item \code{max_age_m} maximum age of males in population.
#'     \item \code{max_age_m} maximum age of females in population.
#'     \item \code{nM_m} instantaneous natural mortality of males.
#'     \item \code{nM_f} instantaneous natural mortality of females.
#'     \item \code{fM} instantaneous fishing mortality rate in population.
#'     \item \code{n_init} number of adult fish used to seed population.
#'     \item \code{sr} sex ratio of adults.
#'     \item \code{s_juvenile} survival of juveniles from hatch to outmigrant.
#'     \item \code{s_spawn_m} survival of males during upstream spawning migration.
#'     \item \code{s_spawn_f} survival of females during upstream spawning migration.
#'     \item \code{s_postspawn_m} survival of males after spawning.
#'     \item \code{s_postspawn_f} survival of females after spawning.
#'     \item \code{iteroparity} probability of repeat spawning.
#'     \item \code{spawners} number of spawning adults entering river each year.
#'     \item \code{pop} total population abundance prior to spawning each year.
#'     \item \code{juveniles_out} number of juveniles exiting river each year.
#' }
#'
#' Additional columns and years are included depending on the values passed to
#' \code{ouput_years}, \code{age_structured_output}.
#'
#' @example inst/examples/simpop_ex.R
#'
#' @references Sullivan, K.M, M.M. Bailey, and D.L. Berlinksky. 2019.
#' Digital Image Analysis as a Technique for Alewife Fecundity Estimation in a
#' New Hampshire River. North American Journal of Fisheries Management 39:353-361.
#'
#' McBride, R. S., R. Ferreri, E. K. Towle, J. M. Boucher, and
#' G. Basilone, G. 2016. Yolked oocyte dynamics support agreement
#' between determinate- and indeterminate-method estimates of annual
#' fecundity for a northeastern United States population of
#' American shad. PLoS ONE 11(10):10.1371/journal.pone.0164203
#'
#' Olney, J. E. and R. S. McBride. 2003. Intraspecific
#' variation in batch fecundity of American shad (*Alosa sapidissima*):
#' revisiting the paradigm of reciprocal latitudinal trends
#' in reproductive traits. American Fisheries Society
#' Symposium 35:185-192.
#'
#' @export
#'
sim_pop <- function(
    species = c("ALE", "AMS", "BBH"),
    nyears = 50,
    river,
    max_age = NULL,
    nM = NULL,
    fM = 0,
    n_init = runif(1, 10e5, 80e7),
    spawnRecruit = NULL,
    eggs = NULL,
    sr = 0.50,
    b = 0.21904,
    s_juvenile = NULL,
    upstream = 1,
    downstream = 1,
    downstream_j = 1,
    output_years = c("last", "all"),
    age_structured_output = FALSE,
    sex_specific = TRUE,
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

  # Make a hidden environment so it is easier
  # to pass output to fill_output() and write_output()
  .sim_pop <- new.env()

  # Unlist function args to internal environment
  list2env(mget(names(formals(sim_pop))), envir = .sim_pop)

  # Argument matching for output_years
  .sim_pop$output_years <- output_years

  # Get region for river system
  .sim_pop$region <- get_region(
    river = .sim_pop$river,
    species = .sim_pop$species,
    custom_habitat = .sim_pop$custom_habitat
  )

  # Get governmental unit
  .sim_pop$govt <- get_govt(.sim_pop$river, .sim_pop$species,
    custom_habitat = .sim_pop$custom_habitat
  )

  # Get life-history parameters if not specified
  if (sex_specific == FALSE) {
    # Instantaneous natural mortality - avg for M and F within region
    if (is.null(.sim_pop$nM)) {
      .sim_pop$nM <- make_mortality(
        river = .sim_pop$river,
        sex = NULL,
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
    }

    # Maximum age if not specified
    ### ASMFC (2024) assumed age 10, but we have mort estimates through age
    ### 12 for some systems
    if (is.null(.sim_pop$max_age)) {
      .sim_pop$max_age <- make_maxage(
        river = .sim_pop$river,
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
    }

    # Maturity schedule if not specified
    if (is.null(.sim_pop$spawnRecruit)) {
      .sim_pop$spawnRecruit <- make_spawnrecruit(
        river = .sim_pop$river,
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
    }
  }

  # If sex_specific == TRUE
  if (sex_specific == TRUE) {
    # Instantaneous natural mortality - avg for M and F within region
    if (is.null(.sim_pop$nM_m)) {
      .sim_pop$nM_m <- make_mortality(
        river = .sim_pop$river,
        sex = "male",
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
      .sim_pop$nM_f <- make_mortality(
        river = .sim_pop$river,
        sex = "female",
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
    }

    # Maximum age if not specified
    if (is.null(.sim_pop$max_age)) {
      .sim_pop$max_age_m <- make_maxage(
        river = .sim_pop$river,
        sex = "male",
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
      .sim_pop$max_age_f <- make_maxage(
        river = .sim_pop$river,
        sex = "female",
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
    }

    # Maturity schedule if not specified
    if (is.null(.sim_pop$spawnRecruit)) {
      .sim_pop$spawnRecruit_m <- make_spawnrecruit(
        .sim_pop$river,
        sex = "male",
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
      .sim_pop$spawnRecruit_f <- make_spawnrecruit(
        .sim_pop$river,
        sex = "female",
        species = .sim_pop$species,
        custom_habitat = .sim_pop$custom_habitat
      )
    }
  }

  # Get estimated number of eggs per female if not specified
  if (is.null(.sim_pop$eggs)) {
    .sim_pop$eggs <- make_eggs(.sim_pop$river,
      species = .sim_pop$species,
      custom_habitat = .sim_pop$custom_habitat
    )
  }

  # Get hatch-to-outmigrant survival if not specified
  if (is.null(.sim_pop$s_juvenile)) {
    .sim_pop$s_juvenile <-
      sim_juvenile_s(species = .sim_pop$species)
  }

  # Make output vectors
  environment(make_output) <- .sim_pop
  list2env(make_output(nyears = .sim_pop$nyears, sex_specific = sex_specific),
    envir = .sim_pop
  )

  # Make habitat from built-in data sets
  .sim_pop$acres <- make_habitat(
    river = .sim_pop$river,
    species = .sim_pop$species,
    upstream = .sim_pop$upstream,
    custom_habitat = .sim_pop$custom_habitat
  )

  # Make downstream survival through dams
  # Adult out-migrants
  .sim_pop$s_downstream <- make_downstream(
    river = .sim_pop$river,
    species = .sim_pop$species,
    downstream = .sim_pop$downstream,
    upstream = .sim_pop$upstream,
    custom_habitat = .sim_pop$custom_habitat
  )

  # Juvenile out-migrants
  .sim_pop$s_downstream_j <- make_downstream(
    river = .sim_pop$river,
    species = .sim_pop$species,
    downstream = .sim_pop$downstream_j,
    upstream = .sim_pop$upstream,
    custom_habitat = .sim_pop$custom_habitat
  )

  # Make the population
  environment(make_pop) <- .sim_pop
  if (sex_specific == FALSE) {
    .sim_pop$pop <- make_pop(
      species = .sim_pop$species,
      max_age = .sim_pop$max_age,
      nM = .sim_pop$nM,
      fM = .sim_pop$fM,
      n_init = .sim_pop$n_init
    )
  }
  if (sex_specific == TRUE) {
    .sim_pop$pop_m <- make_pop(
      species = .sim_pop$species,
      max_age = .sim_pop$max_age_m,
      nM = .sim_pop$nM_m,
      fM = .sim_pop$fM,
      n_init = .sim_pop$n_init * (1 - .sim_pop$sr)
    )
    .sim_pop$pop_f <- make_pop(
      species = .sim_pop$species,
      max_age = .sim_pop$max_age_f,
      nM = .sim_pop$nM_f,
      fM = .sim_pop$fM,
      n_init = .sim_pop$n_init * .sim_pop$sr
    )
  }


  # Simulate for nyears until population stabilizes.
  for (t in 1:.sim_pop$nyears) {
    # Assign iterator to the hidden work spaces
    .sim_pop$t <- t

    if (sex_specific == FALSE) {
      # Make spawning population
      .sim_pop$spawners <- make_spawners(
        .sim_pop$pop,
        probs = .sim_pop$spawnRecruit
      )

      # Subtract the spawners from the ocean population
      .sim_pop$pop <- .sim_pop$pop - .sim_pop$spawners
    }

    if (sex_specific == TRUE) {
      # Make spawning population
      # Males
      .sim_pop$spawners_m <- make_spawners(
        .sim_pop$pop_m,
        probs = .sim_pop$spawnRecruit_m
      )
      # Females
      .sim_pop$spawners_f <- make_spawners(
        .sim_pop$pop_f,
        probs = .sim_pop$spawnRecruit_f
      )
      # Total
      .sim_pop$spawners <- add_unequal_vectors(
        .sim_pop$spawners_m,
        .sim_pop$spawners_f
      )

      # Subtract the spawners from the ocean population
      .sim_pop$pop_m <- .sim_pop$pop_m - .sim_pop$spawners_m
      .sim_pop$pop_f <- .sim_pop$pop_f - .sim_pop$spawners_f
      .sim_pop$pop <- add_unequal_vectors(.sim_pop$pop_m, .sim_pop$pop_f)
    }

    # Make realized reproductive output of spawners
    .sim_pop$fec <- make_recruits(
      eggs = .sim_pop$eggs,
      sr = .sim_pop$sr
    )

    # Calculate density-dependent recruitment from Beverton-Holt curve
    .sim_pop$recruits_f_age <- beverton_holt(
      a = .sim_pop$fec,
      S = .sim_pop$spawners,
      b = .sim_pop$b,
      acres = .sim_pop$acres,
      age_structured = TRUE
    )

    # Apply density-independent mortality for 0-70 d
    # Sum recruits to get age0 fish
    .sim_pop$age0 <- sum(.sim_pop$recruits_f_age * .sim_pop$s_juvenile)


    # Get latitude for river by species
    .sim_pop$latitude <- make_lat(
      river = .sim_pop$river,
      species = .sim_pop$species,
      custom_habitat = .sim_pop$custom_habitat
    )

    # Get rate of iteroparity from river based on latitude for American shad
    # or assume a value of 1 (for now) for river herring
    .sim_pop$iteroparity <- 1
    if (species == "AMS") {
      .sim_pop$iteroparity <- make_iteroparity(.sim_pop$latitude)
    }

    # Apply post-spawn survival
    if (sex_specific == FALSE) {
      .sim_pop$s_postspawn <- make_postspawn(
        river = .sim_pop$river,
        species = .sim_pop$species,
        iteroparity = .sim_pop$iteroparity,
        nM = .sim_pop$nM,
        custom_habitat = .sim_pop$custom_habitat
      )

      .sim_pop$spawners2 <- .sim_pop$spawners * .sim_pop$s_postspawn
    }

    if (sex_specific == TRUE) {
      .sim_pop$s_postspawn_m <- make_postspawn(
        river = .sim_pop$river,
        species = .sim_pop$species,
        iteroparity = .sim_pop$iteroparity,
        nM = .sim_pop$nM_m,
        custom_habitat = .sim_pop$custom_habitat
      )
      .sim_pop$s_postspawn_f <- make_postspawn(
        river = .sim_pop$river,
        species = .sim_pop$species,
        iteroparity = .sim_pop$iteroparity,
        nM = .sim_pop$nM_f,
        custom_habitat = .sim_pop$custom_habitat
      )

      .sim_pop$spawners2_m <- .sim_pop$spawners_m * .sim_pop$s_postspawn_m
      .sim_pop$spawners2_f <- .sim_pop$spawners_f * .sim_pop$s_postspawn_f

      .sim_pop$spawners2 <- add_unequal_vectors(
        .sim_pop$spawners2_m,
        .sim_pop$spawners2_f
      )
    }

    # Calculate pre-spawn (fw survival) based on post-spawn and M
    if (sex_specific == FALSE) {
      .sim_pop$s_spawn <- make_s_spawn(.sim_pop$nM, .sim_pop$s_postspawn)
    }

    if (sex_specific == TRUE) {
      .sim_pop$s_spawn_m <- make_s_spawn(
        nM = .sim_pop$nM_m,
        s_postspawn = .sim_pop$s_postspawn_m
      )
      .sim_pop$s_spawn_f <- make_s_spawn(
        nM = .sim_pop$nM_f,
        s_postspawn = .sim_pop$s_postspawn_f
      )
    }

    # Outmigrant survival
    .sim_pop$age0_down <- .sim_pop$age0 * .sim_pop$s_downstream_j
    .sim_pop$spawners_down <- .sim_pop$spawners2 * .sim_pop$s_downstream

    # Project population into next time step
    if (sex_specific == FALSE) {
      .sim_pop$pop <- project_pop(
        x = .sim_pop$pop + .sim_pop$spawners_down,
        age0 = .sim_pop$age0_down,
        nM = .sim_pop$nM,
        fM = .sim_pop$fM,
        max_age = .sim_pop$max_age,
        species = .sim_pop$species
      )
    }
    if (sex_specific == TRUE) {
      .sim_pop$pop_m <- project_pop(
        x = add_unequal_vectors(
          .sim_pop$pop_m,
          .sim_pop$spawners_down * (1 - .sim_pop$sr)
        )[1:.sim_pop$max_age_m],
        age0 = .sim_pop$age0_down * (1 - .sim_pop$sr),
        nM = .sim_pop$nM_m,
        fM = .sim_pop$fM,
        max_age = .sim_pop$max_age_m,
        species = .sim_pop$species
      )

      .sim_pop$pop_f <- project_pop(
        x = add_unequal_vectors(
          .sim_pop$pop_f, .sim_pop$spawners_down * .sim_pop$sr
        ),
        age0 = .sim_pop$age0_down * .sim_pop$sr,
        nM = .sim_pop$nM_f,
        fM = .sim_pop$fM,
        max_age = .sim_pop$max_age_f,
        species = .sim_pop$species
      )

      .sim_pop$pop <- add_unequal_vectors(
        .sim_pop$pop_m,
        .sim_pop$pop_f
      )
    }

    # Fill the output vectors
    environment(fill_output) <- .sim_pop
    list2env(fill_output(.sim_pop, sex_specific = sex_specific),
      envir = .sim_pop
    )
  } # YEAR LOOP

  # Write the results to an object
  environment(write_output) <- .sim_pop
  write_output(.sim_pop, sex_specific = sex_specific)
}
