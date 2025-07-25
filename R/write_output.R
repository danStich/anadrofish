#' @title Write simulation results
#'
#' @description Internal function used to collect and
#' return all model inputs and relevant model
#' outputs (e.g., population size) from all years t.
#'
#' For internal use in \code{\link{sim_pop}}. Not intended
#' to be called directly.
#'
#' @param .sim_pop A hidden environment in the calling frame
#' of \code{\link{sim_pop}}. Arbitrarily any named object with
#' names matching those used in the function.
#'
#' @param sex_specific Logical inherited from \code{\link{sim_pop}}
#' indicating whether to use sex-specific output.
#'
#' @return A list of results.
#'
#' @keywords Internal
#'
#' @export
#'
write_output <- function(.sim_pop, sex_specific = FALSE) {
  # Unlist and stack population size
  out_pop <- do.call("rbind", lapply(.sim_pop$out_pop, unlist))
  if (ncol(out_pop) < 13) {
    out_pop <- data.frame(out_pop, matrix(0, nrow = nrow(out_pop), ncol = (13 - ncol(out_pop)), ))
  }
  colnames(out_pop) <- paste("pop_", 1:dim(out_pop)[2], sep = "")
  out_pop <- apply(out_pop, 2, round)
  out_pop[is.na(out_pop)] <- 0
  pop <- rowSums(out_pop)

  # Unlist and spawner abundance
  out_spawners <- do.call("rbind", lapply(.sim_pop$out_spawners, unlist))
  if (ncol(out_spawners) < 13) {
    out_spawners <- data.frame(out_spawners, matrix(0, nrow = nrow(out_spawners), ncol = (13 - ncol(out_spawners)), ))
  }

  out_spawners <- apply(out_spawners, 2, round)
  colnames(out_spawners) <- paste("spawners_", 1:dim(out_spawners)[2], sep = "")
  out_spawners[is.na(out_spawners)] <- 0
  spawners <- rowSums(out_spawners)

  # Make a list of objects for export
  if (.sim_pop$age_structured_output == TRUE) {
    if (sex_specific == FALSE) {
      out <- data.frame(
        river = .sim_pop$out_river,
        region = .sim_pop$out_region,
        govt = .sim_pop$out_govt,
        lat = .sim_pop$out_lat,
        habitat = .sim_pop$out_habitat,
        year = .sim_pop$out_year,
        upstream = .sim_pop$out_upstream,
        downstream = .sim_pop$out_downstream,
        downstream_j = .sim_pop$out_downstream_j,
        max_age = .sim_pop$out_max_age,
        nM = .sim_pop$out_nM,
        fM = .sim_pop$out_fM,
        n_init = .sim_pop$out_n_init,
        # spawnrecruit = .sim_pop$out_spawnRecruit,
        # eggs = .sim_pop$out_eggs,
        sr = .sim_pop$out_sr,
        s_juvenile = .sim_pop$out_s_juvenile,
        s_spawn = .sim_pop$out_s_spawn,
        s_postspawn = .sim_pop$out_s_postspawn,
        iteroparity = .sim_pop$out_iteroparity,
        out_spawners,
        out_pop,
        juveniles_out = .sim_pop$out_juveniles_out
      )
    }
    if (sex_specific == TRUE) {
      out <- data.frame(
        river = .sim_pop$out_river,
        region = .sim_pop$out_region,
        govt = .sim_pop$out_govt,
        lat = .sim_pop$out_lat,
        habitat = .sim_pop$out_habitat,
        year = .sim_pop$out_year,
        upstream = .sim_pop$out_upstream,
        downstream = .sim_pop$out_downstream,
        downstream_j = .sim_pop$out_downstream_j,
        max_age_m = .sim_pop$out_max_age_m,
        max_age_f = .sim_pop$out_max_age_f,
        nM_m = .sim_pop$out_nM_m,
        nM_f = .sim_pop$out_nM_f,
        fM = .sim_pop$out_fM,
        n_init = .sim_pop$out_n_init,
        # spawnrecruit_m = .sim_pop$out_spawnRecruit_m,
        # spawnrecruit_f = .sim_pop$out_spawnRecruit_f,
        # eggs = .sim_pop$out_eggs,
        sr = .sim_pop$out_sr,
        s_juvenile = .sim_pop$out_s_juvenile,
        s_spawn_m = .sim_pop$out_s_spawn_m,
        s_spawn_f = .sim_pop$out_s_spawn_f,
        s_postspawn_m = .sim_pop$out_s_postspawn_m,
        s_postspawn_f = .sim_pop$out_s_postspawn_f,
        iteroparity = .sim_pop$out_iteroparity,
        out_spawners,
        out_pop,
        juveniles_out = .sim_pop$out_juveniles_out
      )
    }
  } else {
    if (sex_specific == FALSE) {
      out <- data.frame(
        river = .sim_pop$out_river,
        region = .sim_pop$out_region,
        govt = .sim_pop$out_govt,
        lat = .sim_pop$out_lat,
        habitat = .sim_pop$out_habitat,
        year = .sim_pop$out_year,
        upstream = .sim_pop$out_upstream,
        downstream = .sim_pop$out_downstream,
        downstream_j = .sim_pop$out_downstream_j,
        max_age = .sim_pop$out_max_age,
        nM = .sim_pop$out_nM,
        fM = .sim_pop$out_fM,
        n_init = .sim_pop$out_n_init,
        # spawnrecruit = .sim_pop$out_spawnRecruit,
        # eggs = .sim_pop$out_eggs,
        sr = .sim_pop$out_sr,
        s_juvenile = .sim_pop$out_s_juvenile,
        s_spawn = .sim_pop$out_s_spawn,
        s_postspawn = .sim_pop$out_s_postspawn,
        iteroparity = .sim_pop$out_iteroparity,
        spawners,
        pop,
        juveniles_out = .sim_pop$out_juveniles_out
      )
    }
    if (sex_specific == TRUE) {
      out <- data.frame(
        river = .sim_pop$out_river,
        region = .sim_pop$out_region,
        govt = .sim_pop$out_govt,
        lat = .sim_pop$out_lat,
        habitat = .sim_pop$out_habitat,
        year = .sim_pop$out_year,
        upstream = .sim_pop$out_upstream,
        downstream = .sim_pop$out_downstream,
        downstream_j = .sim_pop$out_downstream_j,
        max_age_m = .sim_pop$out_max_age_m,
        max_age_f = .sim_pop$out_max_age_f,
        nM_m = .sim_pop$out_nM_m,
        nM_f = .sim_pop$out_nM_f,
        fM = .sim_pop$out_fM,
        n_init = .sim_pop$out_n_init,
        # spawnrecruit = .sim_pop$out_spawnRecruit,
        # eggs = .sim_pop$out_eggs,
        sr = .sim_pop$out_sr,
        s_juvenile = .sim_pop$out_s_juvenile,
        s_spawn_m = .sim_pop$out_s_spawn_m,
        s_spawn_f = .sim_pop$out_s_spawn_f,
        s_postspawn_m = .sim_pop$out_s_postspawn_m,
        s_postspawn_f = .sim_pop$out_s_postspawn_f,
        iteroparity = .sim_pop$out_iteroparity,
        spawners,
        pop,
        juveniles_out = .sim_pop$out_juveniles_out
      )
    }
  }

  ifelse(
    .sim_pop$output_years == "last",
    yes = return(out[nrow(out), ]),
    no = return(out)
  )
}
