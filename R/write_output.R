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
    if(ncol(out_pop) < 13){
      out_pop <- data.frame(out_pop, matrix(0, nrow=nrow(out_pop), ncol=(13-ncol(out_pop)),))
    }
    colnames(out_pop) <- paste('pop_', 1:dim(out_pop)[2], sep = '')
    out_pop <- apply(out_pop, 2, round)
    out_pop[is.na(out_pop)] <- 0
    pop <- rowSums(out_pop)
    
  # Unlist and spawner abundance
    out_spawners <- do.call("rbind", lapply(out_spawners, unlist))
    if(ncol(out_spawners) < 13){
      out_spawners <- data.frame(out_spawners, matrix(0, nrow=nrow(out_spawners), ncol=(13-ncol(out_spawners)),))
    }
    out_spawners <- apply(out_spawners, 2, round)
    colnames(out_spawners) <- paste('spawners_', 1:dim(out_spawners)[2], sep = '')
    out_spawners[is.na(out_spawners)] <- 0
    spawners <- rowSums(out_spawners)
    
  # Make a list of objects for export
    if(age_structured_output==TRUE){
      out <- data.frame(
        river = out_river,
        region = out_region,
        govt = out_govt,
        lat = out_lat,
        habitat = out_habitat,
        year = out_year,
        upstream = out_upstream,
        downstream = out_downstream,
        downstream_j = out_downstream_j,
        max_age = out_max_age,
        nM = out_nM,
        fM = out_fM,
        n_init = out_n_init,
        # out_spawnRecruit,
        # out_eggs,
        sr = out_sr,
        s_juvenile = out_s_juvenile,
        s_prespawn = out_s_prespawn,
        s_postspawn = out_s_postspawn,
        iteroparity = out_iteroparity,
        out_spawners,
        out_pop
      )
    } else {
      out <- data.frame(
        river = out_river,
        region = out_region,
        govt = out_govt,
        lat = out_lat,
        habitat = out_habitat,
        year = out_year,
        upstream = out_upstream,
        downstream = out_downstream,
        downstream_j = out_downstream_j,
        max_age = out_max_age,
        nM = out_nM,
        fM = out_fM,
        n_init = out_n_init,
        # out_spawnRecruit,
        # out_eggs,
        sr = out_sr,
        s_juvenile = out_s_juvenile,
        s_prespawn = out_s_prespawn,
        s_postspawn = out_s_postspawn,
        iteroparity = out_iteroparity,
        spawners,
        pop
      )      
    }
  
  ifelse(
     output_years == 'last',
     yes = return(out[nrow(out), ]),
     no = return(out)
  )

}
