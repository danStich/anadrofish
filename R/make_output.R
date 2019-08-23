#' @title Make output vectors
#' 
#' @description Create output vectors for default
#' arguments in \code{\link{sim_pop}}.
#' 
#' Not intended to be called directly.
#' 
#' @export
#' 
make_output <- function(){
  
  out_river = vector(mode='character', length=nyears)
  out_max_age = vector(mode='numeric', length=nyears)
  out_nM = vector(mode='numeric', length=nyears)
  out_fM = vector(mode='numeric', length=nyears)
  out_n_init = vector(mode='numeric', length=nyears)
  out_spawnRecruit = vector(mode='list', length=nyears)
  out_eggs = vector(mode='list', length=nyears)
  out_sr = vector(mode='numeric', length=nyears)
  out_s_hatch = vector(mode='numeric', length=nyears)
  out_s_prespawn = vector(mode='numeric', length=nyears)
  out_spawners = vector(mode='list', length=nyears)
  out_pop = vector(mode='list', length=nyears)
  out_year = vector(mode='numeric', length=nyears)
  
  return(
    list(
      out_river = out_river,
      out_max_age = out_max_age,
      out_nM = out_nM,
      out_fM = out_fM,
      out_n_init = out_n_init,
      out_spawnRecruit = out_spawnRecruit,
      out_eggs = out_eggs,
      out_sr = out_sr,
      out_s_hatch = out_s_hatch,
      out_s_prespawn = out_s_prespawn,
      out_spawners = out_spawners,
      out_pop = out_pop,
      out_year = out_year
    )
  )
  
  
}
