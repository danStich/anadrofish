# Length-weight regression coefficients for river herring

A dataset containing sex-specific regression coefficients of
log10length-log10weight relationships for each genetic reporting group
of river herring.

## Usage

``` r
lw_pars_rh
```

## Format

A data frame with 30 observations of 7 variables:

- `Species`:

  Species of river herring ("ALE" or "BBH")

- `Region`:

  Genetic reporting group region

- `Sex`:

  Fish sex: `"Female"`, `"Male"`, or `"Pooled"`

- `alpha`:

  Intercept

- `alpha.se`:

  Standard error for the intercept

- `beta`:

  Slope

- `beta.se`:

  Standard error for the slope

## Source

Atlantic States Marine Fisheries Commission

## References

Atlantic States Marine Fisheries Commission. 2024. River herring
benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
URL:
https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
