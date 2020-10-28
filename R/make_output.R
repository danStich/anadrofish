#' @title Make output vectors
#' 
#' @description Internal function to create output 
#' vectors in \code{\link{sim_pop}}.
#' 
#' @param nyears Number of years for simulation output.
#' 
#' Not intended to be called directly.
#' 
#' @export
#' 
make_output <- function(nyears){
  
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
  out_s_postspawn = vector(mode='numeric', length=nyears)
  out_iteroparity = vector(mode='numeric', length=nyears)
  out_spawners = vector(mode='list', length=nyears)
  out_pop = vector(mode='list', length=nyears)
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
      out_s_postspawn = out_s_postspawn,
      out_iteroparity = out_iteroparity,
      out_spawners = out_spawners,
      out_pop = out_pop,
      out_year = out_year
    )
  )
  
  
}
