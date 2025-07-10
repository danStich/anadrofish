# Example usage
\dontrun{
  
# Simulate a population
n_init <- 1e5  
max_age <- 13
nM <- .505
fM <- 0
pop <- make_pop(max_age = max_age, nM = nM, fM = fM, n_init = n_init)

# Project one time-step without reproduction
new_pop <- project_pop(x = pop, age0 = 1e5, nM = .505, fM = 0, max_age)

# Difference should be about zero 
# because age0 - n_init
new_pop - pop
  
}
