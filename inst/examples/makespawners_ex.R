# Example usage
\dontrun{
  
# Population vital rates
max_age <- 9
nM <- 0.38
fM <- 0.00
n_init <- 1e5
  
# Simulate a fish population at stable age distribution
pop <- make_pop(max_age = max_age, nM = nM, fM = fM, n_init = n_init)
  
# Spawners ----
# Define probability of recruitment to spawn- probability of
# recruitment to the first spawning event
# by age class (Bailey and Zydlewski 2013)
spawnRecruit <- c(0, 0, 0, 0.01, .33, .84, .97, .99, 1.00)  

# Get spawner numbers  
spawners <- make_spawners(pop, probs = spawnRecruit)
spawners

}
