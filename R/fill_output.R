#' @title Fill output vectors
#' 
#' @description Fill output vectors for default
#' arguments in \code{sim_pop}.
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
    out_type[[t]] = type
    out_upstream[[t]] = upstream
    out_downstream[[t]] = downstream
    out_downstream_j[[t]] = downstream_j
    out_region[[t]] = region
    out_govt[[t]] = govt
    out_max_age[[t]] = max_age
    out_nM[[t]] = nM
    out_fM[[t]] = fM
    out_n_init[[t]] = n_init
    out_spawnRecruit[[t]] = spawnRecruit
    out_eggs[[t]] = eggs
    out_sr[[t]] = sr
    out_s_hatch[[t]] = s_hatch
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
        out_type,
        out_upstream,
        out_downstream,
        out_downstream_j,
        out_region,
        out_govt,
        out_max_age,
        out_nM,
        out_fM,
        out_n_init,
        out_spawnRecruit,
        out_eggs,
        out_sr,
        out_s_hatch,
        out_s_prespawn,
        out_s_postspawn,
        out_iteroparity,
        out_spawners,
        out_pop,
        out_year
      )
    
    names(filled) <- c(
        'out_river',
        'out_type',
        'out_upstream',
        'out_downstream',
        'out_downstream_j',
        'out_region',
        'out_govt',
        'out_max_age',
        'out_nM',
        'out_fM',
        'out_n_init',
        'out_spawnRecruit',
        'out_eggs',
        'out_sr',
        'out_s_hatch',
        'out_s_prespawn',
        'out_s_postspawn',
        'out_iteroparity',
        'out_spawners',
        'out_pop',
        'out_year'
    )
    
    return(filled)
}
