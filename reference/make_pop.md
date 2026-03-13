# Make population

Function used to seed initial age-structured population for simulation
based on life-history characteristics. Uses an initial population seed,
mortality estimates, and maximum age to create a starting population.

## Usage

``` r
make_pop(species, max_age, nM, fM, n_init)
```

## Arguments

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- max_age:

  The maximum age of fish in the population(s). A numeric vector of
  length 1.

- nM:

  Instantaneous natural mortality rate. A numeric vector of length for
  (`"AMS"` or a vector of length `max_age` for `"ALE"` and `"BBH"`.

- fM:

  Instantaneous fishing mortality rate. A numeric vector of length 1.

- n_init:

  Initial population abundance (includes all age classes).

## Value

A vector containing age-specific abundances with `length = max_age`.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
# Simulate a fish population at stable age distribution
pop <- make_pop(max_age, nM, fM, n_init)
  
} # }
```
