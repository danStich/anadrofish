#' @title Make output vectors
#' 
#' @description Internal function to create output 
#' vectors in \code{\link{sim_pop}}. Not intended to be called directly.
#' 
#' @param nyears Number of years for simulation output.
#' 
#' @param sex_specific Logical inherited from \code{\link{sim_pop}}
#' indicating whether to use sex-specific output.
#' 
#' @keywords Internal
#' 
#' @export
#' 
make_output <- function(nyears, sex_specific = FALSE){
  
  if(sex_specific == FALSE){
      
    out_river = vector(mode='character', length=nyears)
    out_region = vector(mode='character', length=nyears)
    out_govt = vector(mode='character', length=nyears)
    out_lat = vector(mode='numeric', length=nyears)
    out_habitat = vector(mode='character', length=nyears) 
    out_upstream = vector(mode='numeric', length=nyears) 
    out_downstream = vector(mode='numeric', length=nyears) 
    out_downstream_j = vector(mode='numeric', length=nyears) 
    out_max_age = vector(mode='numeric', length=nyears)
    out_nM = vector(mode='numeric', length=nyears)
    out_fM = vector(mode='numeric', length=nyears)
    out_n_init = vector(mode='numeric', length=nyears)
    out_spawnRecruit = vector(mode='list', length=nyears)
    out_eggs = vector(mode='list', length=nyears)
    out_sr = vector(mode='numeric', length=nyears)
    out_s_juvenile = vector(mode='numeric', length=nyears)
    out_s_spawn = vector(mode='numeric', length=nyears)
    out_s_postspawn = vector(mode='numeric', length=nyears)
    out_iteroparity = vector(mode='numeric', length=nyears)
    out_spawners = vector(mode='list', length=nyears)
    out_pop = vector(mode='list', length=nyears)
    out_juveniles_out = vector(mode='numeric', length=nyears)
    out_year = vector(mode='numeric', length=nyears)
    
    return(
      list(
        out_river = out_river,
        out_region = out_region,
        out_govt = out_govt,
        out_lat = out_lat,
        out_habitat = out_habitat,
        out_upstream = out_upstream,
        out_downstream = out_downstream,
        out_downstream_j = out_downstream_j,
        out_max_age = out_max_age,
        out_nM = out_nM,
        out_fM = out_fM,
        out_n_init = out_n_init,
        out_spawnRecruit = out_spawnRecruit,
        out_eggs = out_eggs,
        out_sr = out_sr,
        out_s_juvenile = out_s_juvenile,
        out_s_spawn = out_s_spawn,
        out_s_postspawn = out_s_postspawn,
        out_iteroparity = out_iteroparity,
        out_spawners = out_spawners,
        out_pop = out_pop,
        out_juveniles_out = out_juveniles_out,
        out_year = out_year
      )
    )
  }
  
  if(sex_specific == TRUE){
    
    out_river = vector(mode='character', length=nyears)
    out_region = vector(mode='character', length=nyears)
    out_govt = vector(mode='character', length=nyears)
    out_lat = vector(mode='numeric', length=nyears)
    out_habitat = vector(mode='character', length=nyears) 
    out_upstream = vector(mode='numeric', length=nyears) 
    out_downstream = vector(mode='numeric', length=nyears) 
    out_downstream_j = vector(mode='numeric', length=nyears) 
    out_max_age_m = vector(mode='numeric', length=nyears)
    out_max_age_f = vector(mode='numeric', length=nyears)
    out_nM_m = vector(mode='numeric', length=nyears)
    out_nM_f = vector(mode='numeric', length=nyears)
    out_fM = vector(mode='numeric', length=nyears)
    out_n_init = vector(mode='numeric', length=nyears)
    out_spawnRecruit_m = vector(mode='list', length=nyears)
    out_spawnRecruit_f = vector(mode='list', length=nyears)
    out_eggs = vector(mode='list', length=nyears)
    out_sr = vector(mode='numeric', length=nyears)
    out_s_juvenile = vector(mode='numeric', length=nyears)
    out_s_spawn_m = vector(mode='numeric', length=nyears)
    out_s_spawn_f = vector(mode='numeric', length=nyears)
    out_s_postspawn_m = vector(mode='numeric', length=nyears)
    out_s_postspawn_f = vector(mode='numeric', length=nyears)
    out_iteroparity = vector(mode='numeric', length=nyears)
    out_spawners = vector(mode='list', length=nyears)
    out_pop = vector(mode='list', length=nyears)
    out_juveniles_out = vector(mode='numeric', length=nyears)
    out_year = vector(mode='numeric', length=nyears)
    
    return(
      list(
        out_river = out_river,
        out_region = out_region,
        out_govt = out_govt,
        out_lat = out_lat,
        out_habitat = out_habitat,
        out_upstream = out_upstream,
        out_downstream = out_downstream,
        out_downstream_j = out_downstream_j,
        out_max_age_m = out_max_age_m,
        out_max_age_f = out_max_age_f,
        out_nM_m = out_nM_m,
        out_nM_f = out_nM_f,
        out_fM = out_fM,
        out_n_init = out_n_init,
        out_spawnRecruit_m = out_spawnRecruit_m,
        out_spawnRecruit_f = out_spawnRecruit_f,
        out_eggs = out_eggs,
        out_sr = out_sr,
        out_s_juvenile = out_s_juvenile,
        out_s_spawn_m = out_s_spawn_m,
        out_s_spawn_f = out_s_spawn_f,        
        out_s_postspawn_m = out_s_postspawn_m,
        out_s_postspawn_f = out_s_postspawn_f,
        out_iteroparity = out_iteroparity,
        out_spawners = out_spawners,
        out_pop = out_pop,
        out_juveniles_out = out_juveniles_out,
        out_year = out_year
      )
    )    
  }
  
  
  
}
