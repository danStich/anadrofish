# Make total spawning migration mortality

Function used to derive total in-river adult survival during the
spawning migration from annual mortality and post-spawn survival. This
function is not currently implemented in the underlying population
model, can be used to estimate numbers of fish lost in freshwater
environments for purposes such as nutrient modeling.

## Usage

``` r
make_s_spawn(nM, s_postspawn)
```

## Arguments

- nM:

  Instantaneous natural mortality rate. A numeric vector containing
  either an age-invariant natural mortality rate of length 1 or an
  age-specific natural mortality rate with length = max_age.

- s_postspawn:

  Post spawning mortality calculated from the output of
  [`make_iteroparity`](https://danstich.github.io/anadrofish/reference/make_iteroparity.md)
  and `nM`, or alternatively a numeric vector for each.

## Value

A vector of length one containing pre-spawn survival.

## Examples

``` r
make_s_spawn(0.68, 0.92)
#> [1] 0.8214248
```
