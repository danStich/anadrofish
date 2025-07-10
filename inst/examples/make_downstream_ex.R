# Example usage
\dontrun{
  
# Example 1. ----  
# Calculate population-level survival during outmigration
# for fixed upstream and downstream dam passage probabilities
s_down <- make_downstream(habitat_data = habitat,
                          river = 'Susquehanna',
                          downstream = 0.95,
                          upstream = 0.80)
  
# Example 2. ----
# Explore how upstream passage affects catchment-wide survival
# during outmigration for a fixed downstream passage
upstream_p <- seq(from = 0, to = 1, by = 0.01)
s_down <- vector(mode = 'numeric', length = length(upstream_p))
for(i in 1:length(upstream_p)){
  s_down[i] <- make_downstream(habitat_data = habitat,
                               river = 'Susquehanna',
                               downstream = 0.5,
                               upstream = upstream_p[i])  
} 

Zd <- 1 - s_down

plot(x = upstream_p, 
     y = Zd, 
     type = 'l',
     xlab = 'Upstream passage',
     ylab = 'Total downstream mortality',
     main = 'Susquehanna River')

# Example 3. ----
# Explore interactions between upstream and downstream 
# passage probabilities when both vary. This changes
# drastically from one river to another depending on
# habitat above and below dams, and number of dams.
upstream_p <- seq(from = 0, to = 1, by = 0.01)
downstream_p <- seq(from = 0, to = 1, by = 0.01)
s_down <- matrix(data = NA, 
                 nrow = length(upstream_p), 
                 ncol = length(downstream_p))

for(i in 1:length(upstream_p)){
  for(t in 1:length(downstream_p)){
    s_down[i,t] <- make_downstream(habitat_data = habitat,
                                   river = 'Susquehanna',
                                   downstream = downstream_p[t],
                                   upstream = upstream_p[i])  
  }   
}

zd <- 1 - s_down
filled.contour(x = upstream_p, 
               y = downstream_p, 
               z = zd,
               xlab = 'Upstream passage probability',
               ylab = 'Downstream survival per dam',
               main = 'Catchment-wide dam mortality')
}
