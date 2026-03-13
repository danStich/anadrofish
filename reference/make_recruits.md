# Make recruits

Function used to calculate realized reproductive output (to larval
stage) of female spawners without density-dependence in larval
production.

## Usage

``` r
make_recruits(eggs, sr)
```

## Arguments

- eggs:

  The number of eggs an individual fish can produce (Potential annual
  fecundity, PAF).

- sr:

  Sex ratio of spawning adults.

## Value

Number of juvenile recruits. Numeric vector of `length(eggs`. May be a
single value (vector of length 1) or a vector of `length = maximum age`
depending on whether age-specific values are passed to `eggs`.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
# Using values from Bailey and Zydlewski (2013)  
eggs <- c(0, 0, 0, 20654, 34674, 58210, 79433, 88480, 97724)
sr <- 0.50
s_hatch <- 0.10   

# Calculate expected number of age-0 fish  
fec <- make_recruits(eggs = eggs, sr = sr, s_hatch = s_hatch)
  
} # }
```
