# Make one row of simulation output

Internal function used to capture all output fields from `.sim_pop` for
a single year. Called inside the simulation loop in
[`sim_pop`](https://danstich.github.io/anadrofish/reference/sim_pop.md).

Fields stored as scalar values are passed through as-is. Fields wrapped
in [`list()`](https://rdrr.io/r/base/list.html) are treated as
age-structured vectors.
[`assemble_output`](https://danstich.github.io/anadrofish/reference/assemble_output.md)
dynamically detects all list-valued fields and, depending on
`age_structured_output`, either expands them into one column per age
class (`<field>_1`, `<field>_2`, ...) or collapses them to a single
summed column. Adding a new age-structured field requires only wrapping
its value in [`list()`](https://rdrr.io/r/base/list.html) here; no
changes to `assemble_output` are needed.

## Usage

``` r
make_output_row(.sim_pop, sex_specific = FALSE)
```

## Arguments

- .sim_pop:

  The simulation environment.

- sex_specific:

  Logical indicating whether to use sex-specific output.

## Value

A named list representing one row of output. Scalar fields are stored as
atomic values; age-structured fields are stored as single-element lists
containing numeric vectors.
