# Write simulation results

Internal function used to collect and return all model inputs and
relevant model outputs (e.g., population size) from all years t.

For internal use in
[`sim_pop`](https://danstich.github.io/anadrofish/reference/sim_pop.md).
Not intended to be called directly.

## Usage

``` r
write_output(.sim_pop, sex_specific = FALSE)
```

## Arguments

- .sim_pop:

  A hidden environment in the calling frame of
  [`sim_pop`](https://danstich.github.io/anadrofish/reference/sim_pop.md).
  Arbitrarily any named object with names matching those used in the
  function.

- sex_specific:

  Logical inherited from
  [`sim_pop`](https://danstich.github.io/anadrofish/reference/sim_pop.md)
  indicating whether to use sex-specific output.

## Value

A list of results.
