#' @title Fill output vectors
#' 
#' @description Internal function to fill output vectors for default
#' arguments in \code{sim_pop} and the output (\code{spawners}).
#' 
#' Not intended to be called directly.
#' 
#' @return list of output vectors
#' 
#' @export
#' 
fill_output <- function(){
  
  # Collect parameters  
    out_river[[t]] = river
    out_region[[t]] = region
    out_govt[[t]] = govt
    out_lat[[t]] = latitude
    out_habitat[[t]] = acres/247.105
    out_upstream[[t]] = upstream
    out_downstream[[t]] = downstream
    out_downstream_j[[t]] = downstream_j
    out_max_age[[t]] = max_age
    out_nM[[t]] = nM
    out_fM[[t]] = fM
    out_n_init[[t]] = n_init
    out_spawnRecruit[[t]] = spawnRecruit
    out_eggs[[t]] = eggs
    out_sr[[t]] = sr
    out_s_juvenile[[t]] = s_juvenile
    out_s_prespawn[[t]] = s_prespawn
    out_s_postspawn[[t]] = s_postspawn
    out_iteroparity[[t]] = iteroparity
    out_spawners[[t]] = spawners
    out_pop[[t]] = pop
    out_year[[t]] = t
    
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
        out_s_prespawn,
        out_s_postspawn,
        out_iteroparity,
        out_spawners,
        out_pop,
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
        'out_s_prespawn',
        'out_s_postspawn',
        'out_iteroparity',
        'out_spawners',
        'out_pop',
        'out_year'
    )
    
    return(filled)
}
