#' @title Write simulation results
#' 
#' @description Internal function used to collect and
#' return all model inputs and relevant model
#' outputs (e.g., population size) from all years t.
#' 
#' Not intended to be called directly.
#' 
#' @return A list of results.
#' 
#' @export
#' 
write_output <- function(){

  # Unlist and recruitment to spawn probabilities
    out_spawnRecruit <- do.call("rbind", lapply(out_spawnRecruit, unlist))
    colnames(out_spawnRecruit) <- paste('spawnRecruit_', 1:dim(out_spawnRecruit)[2], sep = '')
  
  # Unlist and stack eggs per female by age class
    out_eggs <- do.call("rbind", lapply(out_eggs, unlist))
    colnames(out_eggs) <- paste('eggs_', 1:dim(out_eggs)[2], sep = '')
      
  # Unlist and stack population size
    out_pop <- do.call("rbind", lapply(out_pop, unlist))
    colnames(out_pop) <- paste('pop_', 1:dim(out_pop)[2], sep = '')
  
  # Unlist and spawner abundance
    out_spawners <- do.call("rbind", lapply(out_spawners, unlist))
    colnames(out_spawners) <- paste('spawners_', 1:dim(out_spawners)[2], sep = '')
    spawners <- rowSums(out_spawners)
    
  # Make a list of objects for export
    out <- data.frame(
      river = out_river,
      year = out_year,
      type = out_type,
      upstream = out_upstream,
      downstream = out_downstream,
      downstream_j = out_downstream_j,
      region = out_region,
      govt = out_govt,
      max_age = out_max_age,
      nM = out_nM,
      fM = out_fM,
      n_init = out_n_init,
      # out_spawnRecruit,
      # out_eggs,
      sr = out_sr,
      s_hatch = out_s_hatch,
      s_prespawn = out_s_prespawn,
      s_postspawn = out_s_postspawn,
      iteroparity = out_iteroparity,
      spawners
      # out_spawners,
      # out_pop
    )
  
  ifelse(
     output=='last',
     yes = return(out[nrow(out), ]),
     no = return(out)
  )

}
