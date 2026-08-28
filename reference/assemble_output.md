# Assemble simulation results

Internal function used to assemble per-year output rows into a single
data.frame.

For internal use in
[`sim_pop`](https://danstich.github.io/anadrofish/reference/sim_pop.md).
Not intended to be called directly.

## Usage

``` r
assemble_output(rows, age_structured_output, output_years)
```

## Arguments

- rows:

  A list of named lists, one per simulation year, as returned by
  `make_output_row`.

- age_structured_output:

  Logical; if TRUE, list-valued fields (e.g. pop, spawners) provided in
  `make_row_output` are returned as age-structured columns.

- output_years:

  Character; if "last", only the final year is returned.

## Value

A data.frame of simulation results.
