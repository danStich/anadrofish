# Project population

Function used to project population forward one time step using vector
multiplication.

## Usage

``` r
project_pop(x, age0, nM, fM, max_age, species = c("AMS", "ALE", "BBH"))
```

## Arguments

- x:

  A numeric vector containing age-specific abundance at end of year t.

- age0:

  A numeric vector of length one containing number of new recruits at
  end of year t.

- nM:

  Numeric vector of instantaneous natural mortality.

- fM:

  Numeric vector of instantaneous fishing mortality.

- max_age:

  Numeric indicating maximum age of spawning fish.

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

## Value

A numeric vector of age-structured abundance in time t + 1.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
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
  
} # }
```
