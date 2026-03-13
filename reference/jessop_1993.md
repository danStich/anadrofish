# Fork length-fecundity relationships for alewife

A dataset containing fork length-fecundity relationships for blueback
herring from several spawning groups in New Brunswick and Nova Scotia,
Canada. Parameters are for equations of the form:

`log10(fec / 1000) ~ alpha + beta * log10(fork length)`.

## Usage

``` r
jessop_1993
```

## Format

A data frame with 4 observations of 6 variables:

- `reference`:

  Reference for study (in case others are added)

- `system`:

  Study system

- `alpha`:

  Intercept

- `alpha.se`:

  Standard error of the intercept

- `beta`:

  Slope

- `beta.se`:

  Standard error of the slope

## References

Jessop, B. M. 1993. Fecundity of anadromous alewives and blueback
herring in New Brunswick and Nova Scotia. Transactions of the American
Fisheries Society 122:85-98.
