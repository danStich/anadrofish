# American shad habitat

A dataset containing the surface area of American shad habitat segments
by feature (dam or outlet) in Atlantic coast drainages of North America.

## Usage

``` r
habitat
```

## Format

A data frame with 868 observations of 22 variables:

- `TERMCODE`:

  Code used to identify regional, state, or river units in which
  features are located, assists with subselecting features for analysis.

- `system`:

  Name or name(s) of rivers included in catchment.

- `region`:

  Life-history region within which river is located (NI = northern
  iteroparous, SI = southern iteroparous, SP = semelparous).

- `huc_code`:

  n-digit huc code for the huc identifier used in `TERMCODE`.

- `huc_level`:

  Watershed level used to determine `huc_code`.

- `count`:

  Number of habitat segments (features) included within `system`.

- `total`:

  Total historical habitat available in `system` (sq km).

- `UNIQUE_ID`:

  Unique value given to each dam and outlet feature.

- `type`:

  Type of feature, either `dam` or `outlet`.

- `catchmentID`:

  Unique value of the coastal outlet in which the dam is located
  upstream.

- `habitat_sqkm`:

  Total habitat upstream, given in square kilometers of river area.

- `habitatSegment_sqkm`:

  Amount of habitat in the segment upstream of the feature, between the
  feature and the next group of adjacent upstream features.

- `functional_habitatSegment_sqkm`:

  The value of `habitatSegment_sqkm` multiplied by the compounded
  passage fraction from outlet up to the feature.

- `PassageToHabitat`:

  Passage fraction at feature, compounded over this and all downstream
  features. Default dam passage is zero, default outlet passage is one.
  These values can be modified at start of model run.

- `terminal_name_huc10`:

  Name of HUC10 watershed of feature's outlet.

- `terminal_name_huc8`:

  Name of HUC8 watershed of feature's outlet.

- `terminal_name_huc6`:

  Name of HUC6 watershed of feature's outlet.

- `terminal_name_huc4`:

  Name of HUC4 watershed of feature's outlet.

- `dam_name`:

  Name of dam feature, "n/a" if `outlet`.

- `latitude`:

  Latitudinal coordinate of feature centroid.

- `longitude`:

  Longitudinal coordinate of feature centroid.

- `dam_order`:

  Order in which dam is located in river, starting from coastal outlet.
  Outlets have code = 0.

## Source

Samuel G. Roy: <https://github.com/samGroy/AmShadProject>

## References

Zydlewski, J., D. S. Stich, S. Roy, M. Bailey, T. Sheehan, and K.
Sprankle. 2021. What Have We Lost? Modeling Dam Impacts on American Shad
Populations Through Their Native Range. Frontiers in Marine Science 8.
DOI: https://doi.org/10.3389/fmars.2021.734213.
