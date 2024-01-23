#' @title Fill output vectors
#' 
#' @description Internal function to fill output vectors for default
#' arguments in \code{sim_pop} and the output (\code{spawners}).
#' 
#' For internal use in \code{\link{sim_pop}}. Not intended 
#' to be called directly.
#' 
#' @param .sim_pop A hidden environment in the calling frame 
#' of \code{\link{sim_pop}}. Arbitrarily any named object with
#' names matching those used in the function.
#' @return list of output vectors
#' 
#' @param sex_specific Logical inherited from \code{\link{sim_pop}}
#' indicating whether to use sex-specific output.
#' 
#' @keywords Internal
#' 
#' @export
#' 
fill_output <- function(.sim_pop, sex_specific = FALSE){
  
  # Collect parameters  
    out_river[[t]] = .sim_pop$river
    out_region[[t]] = .sim_pop$region
    out_govt[[t]] = .sim_pop$govt
    out_lat[[t]] = .sim_pop$latitude
    out_habitat[[t]] = .sim_pop$acres/247.105
    
    if(length(.sim_pop$upstream) > 1){
      out_upstream[[t]] = "dam specific: check your scenarios"
    } else {
      out_upstream[[t]] = .sim_pop$upstream
    }
    
    if(length(.sim_pop$downstream) > 1){
      out_downstream[[t]] <- "dam specific: check your scenarios"
    } else {
      out_downstream[[t]] <- .sim_pop$downstream
    }
    
    if(length(.sim_pop$downstream_j) > 1){
      out_downstream_j[[t]] <- "dam specific: check your scenarios"
    } else {
      out_downstream_j[[t]] <- .sim_pop$downstream_j
    }    
    
    # Fill vectors for sex-aggregate
    if(sex_specific == FALSE){
    
      out_max_age[[t]] = .sim_pop$max_age
      out_nM[[t]] = mean(.sim_pop$nM, na.rm = TRUE)
      out_fM[[t]] = mean(.sim_pop$fM[.sim_pop$fM!=0], na.rm = TRUE)
      out_n_init[[t]] = .sim_pop$n_init
      out_spawnRecruit[[t]] = .sim_pop$spawnRecruit
      out_eggs[[t]] = .sim_pop$eggs
      out_sr[[t]] = .sim_pop$sr
      out_s_juvenile[[t]] = .sim_pop$s_juvenile
      out_s_spawn[[t]] = mean(.sim_pop$s_spawn, na.rm = TRUE)
      out_s_postspawn[[t]] = mean(.sim_pop$s_postspawn, na.rm = TRUE)
      out_iteroparity[[t]] = .sim_pop$iteroparity
      out_spawners[[t]] = .sim_pop$spawners
      out_pop[[t]] = .sim_pop$pop
      out_juveniles_out[[t]] = .sim_pop$age0_down
      out_year[[t]] = .sim_pop$t
      
    # Return the result to the environment
      filled <- 
        list(
          out_river,
          out_region,
          out_govt,
          out_lat,
          out_habitat,
          out_upstream,
          out_downstream,
          out_downstream_j,
          out_max_age,
          out_nM,
          out_fM,
          out_n_init,
          out_spawnRecruit,
          out_eggs,
          out_sr,
          out_s_juvenile,
          out_s_spawn,
          out_s_postspawn,
          out_iteroparity,
          out_spawners,
          out_pop,
          out_juveniles_out,
          out_year
        )
      
      names(filled) <- c(
          'out_river',
          'out_region',
          'out_govt',
          'out_lat',
          'out_habitat',
          'out_upstream',
          'out_downstream',
          'out_downstream_j',
          'out_max_age',
          'out_nM',
          'out_fM',
          'out_n_init',
          'out_spawnRecruit',
          'out_eggs',
          'out_sr',
          'out_s_juvenile',
          'out_s_spawn',
          'out_s_postspawn',
          'out_iteroparity',
          'out_spawners',
          'out_pop',
          'out_juveniles_out',
          'out_year'
      )
    
    }  
    
    if(sex_specific == TRUE){
      out_max_age_m[[t]] = .sim_pop$max_age_m
      out_max_age_f[[t]] = .sim_pop$max_age_f
      out_nM_m[[t]] = mean(.sim_pop$nM_m, na.rm = TRUE)
      out_nM_f[[t]] = mean(.sim_pop$nM_f, na.rm = TRUE)
      out_fM[[t]] = mean(.sim_pop$fM[.sim_pop$fM!=0], na.rm = TRUE)
      out_n_init[[t]] = .sim_pop$n_init
      out_spawnRecruit_m[[t]] = .sim_pop$spawnRecruit_m
      out_spawnRecruit_f[[t]] = .sim_pop$spawnRecruit_f
      out_eggs[[t]] = .sim_pop$eggs
      out_sr[[t]] = .sim_pop$sr
      out_s_juvenile[[t]] = .sim_pop$s_juvenile
      out_s_spawn_m[[t]] = mean(.sim_pop$s_spawn_m, na.rm = TRUE)
      out_s_spawn_f[[t]] = mean(.sim_pop$s_spawn_f, na.rm = TRUE)      
      out_s_postspawn_m[[t]] = mean(.sim_pop$s_postspawn_m, na.rm = TRUE)
      out_s_postspawn_f[[t]] = mean(.sim_pop$s_postspawn_f, na.rm = TRUE)
      out_iteroparity[[t]] = .sim_pop$iteroparity
      out_spawners[[t]] = .sim_pop$spawners
      out_pop[[t]] = .sim_pop$pop
      out_juveniles_out[[t]] = .sim_pop$age0_down
      out_year[[t]] = .sim_pop$t
      
    # Return the result to the environment
      filled <- 
        list(
          out_river,
          out_region,
          out_govt,
          out_lat,
          out_habitat,
          out_upstream,
          out_downstream,
          out_downstream_j,
          out_max_age_m,
          out_max_age_f,
          out_nM_m,
          out_nM_f,
          out_fM,
          out_n_init,
          out_spawnRecruit_m,
          out_spawnRecruit_f,
          out_eggs,
          out_sr,
          out_s_juvenile,
          out_s_spawn_m,
          out_s_spawn_f,
          out_s_postspawn_m,
          out_s_postspawn_f,
          out_iteroparity,
          out_spawners,
          out_pop,
          out_juveniles_out,
          out_year
        )
      
      names(filled) <- c(
          'out_river',
          'out_region',
          'out_govt',
          'out_lat',
          'out_habitat',
          'out_upstream',
          'out_downstream',
          'out_downstream_j',
          'out_max_age_m',
          'out_max_age_f',
          'out_nM_m',
          'out_nM_f',
          'out_fM',
          'out_n_init',
          'out_spawnRecruit_m',
          'out_spawnRecruit_f',
          'out_eggs',
          'out_sr',
          'out_s_juvenile',
          'out_s_spawn_m',
          'out_s_spawn_f',
          'out_s_postspawn_m',
          'out_s_postspawn_f',
          'out_iteroparity',
          'out_spawners',
          'out_pop',
          'out_juveniles_out',
          'out_year'
      )      
      
    }
    
    return(filled)
}
