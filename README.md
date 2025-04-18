# anadrofish

R package for modeling anadromous fish population responses to habitat changes

[![DOI](https://zenodo.org/badge/186272264.svg)](https://doi.org/10.5281/zenodo.14285894)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![R-CMD-check](https://github.com/danStich/anadrofish/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/danStich/anadrofish/actions/workflows/R-CMD-check.yaml)
[![test-coverage.yaml](https://github.com/danStich/anadrofish/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/danStich/anadrofish/actions/workflows/test-coverage.yaml)

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Directories](#directories)
- [Examples](#examples)
- [References](#references)

## Overview
### Purpose
The purpose of this package is to distribute code and provide a user interface for modeling anadromous fish population responses to dam passage, fisheries, or restoration activities in Atlantic coastal rivers of Canada and the United States. The main `sim_pop()` function uses various helper functions (see `?anadrofish` in R) that link dam passage to habitat availability and stochastic population models to simulate species-specific responses to dams and fisheries across marine and freshwater habitats. Built-in habitat datasets are currently derived separately for each species based on best available knowledge and expert opinion from state and federal fishery biologists, managers, and scientists. Likewise, all species-specific life-history parameters (size at age, age at maturity, natural mortality) are derived directly from interstate stock assessments or informed by empirical estimates from the fisheries literature. The application of these models is described in [ASMFC 2020](https://asmfc.org/uploads/file/63d8437dAmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf), [Zydlewski et al. 2021](https://www.frontiersin.org/journals/marine-science/articles/10.3389/fmars.2021.734213/full), and [ASMFC 2024](https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf).

Existing (built-in) population models for each species can be implemented using the `sim_pop()` function. New models can be constructed using the existing helper functions within `anadrofish` and appropriately structured habitat data. **As of version 2.1.0** (2024-11-26), we implemented the `custom_habitat_template()` function. This allows use of default habitat data sets, modifying habitat data based on built-in datasets, querying custom habitat datasets ranging from the single stream segment to regional stock scales for each species, or constructing completely custom habitat configurations including fabricated (i.e., theoretical) habitat configurations for optimization studies. 

### Species
These models are available for 167 American shad (*Alosa sapidissima*)  populations, 222 alewife (*Alosa pseudoharengus*) populations, and 238 blueback herring (*Alosa aestivalis*) populations in Atlantic Coastal rivers of North America from Florida, USA (St. Johns River) to Quebec, Canada (St. Lawrence drainage). American shad models and data were peer-reviewed during the [2020 Atlantic States Marine Fisheries Commission (ASMFC) American Shad Benchmark Stock Assessment](https://asmfc.org/wp-content/uploads/2025/01/AmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf). River herring models and underlying data were peer-reviewed during development and application to the [2024 ASMFC River Herring Benchmark Stock Assessment](https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf). 

The full list of rivers available for each species can be viewed with `get_rivers()` once the package is installed.

We are currently working with collaborators to extend to multiple additional species. Please feel free to contact us with requests, post an issue, or see [Contributing.md](https://github.com/danStich/anadrofish/blob/master/Contributing.md) for details about other ways to contribute!

</br>

## Installation
### Versions 2.3.0 and later
As of version 2.3.0 the `anadrofish` package no longer requires compilation and can therefore be installed using the `remotes` package (Csardi et al. 2021) in R. Once you have installed the `remotes` package, `anadrofish` can be installed like this: 

`remotes::install_github("danStich/anadrofish")`

Specific releases can be installed by referencing the release tag, like this:

`remotes::install_github("danStich/anadrofish@v2.3.0")`

The `remotes` package can be installed directly from CRAN or from GitHub following instructions in the repository [https://github.com/r-lib/remotes#readme](https://github.com/r-lib/remotes#readme).

### Versions 2.20 and earlier
Earlier versions of this package can be installed with the [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) package in R using the repository url:

`devtools::install_github("danStich/anadrofish")`

Specific releases can be installed by referencing the release tag, like this:

`devtools::install_github("danStich/anadrofish@v2.1.0")`

To install `anadrofish`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already. You may need to work with your IT specialists or someone with administrative privileges if you do not have them to install these utilities.

</br>

## Examples



## Directories

`data/` Built-in data sets for the package

`inst/examples/` Examples for those requiring more than a one-liner

`man/` Help files and documentation

`R/` R functions in scripts

`tests/` Function tests and checks using the `testhat` package

</br>

## References

ASMFC (Atlantic States Marine Fisheries Commission). 2020. American Shad Benchmark Stock Assessment and Peer-Review Report. Atlantic States Marine Fisheries Commission. [https://asmfc.org/wp-content/uploads/2025/01/AmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf](https://asmfc.org/wp-content/uploads/2025/01/AmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf).

ASMFC (Atlantic States Marine Fisheries Commission). 2024. River Herring Benchmark Stock Assessment and Peer-Review Report. Atlantic States Marine Fisheries Commission. [https://asmfc.org/wp-content/uploads/2025/01/RiverHerringAssessment_PeerReviewReport_2024.pdf](https://asmfc.org/wp-content/uploads/2025/01/RiverHerringAssessment_PeerReviewReport_2024.pdf).

Csardi G., J. Hester J, H. Wickham, W. Chang, M. Morgan, and D. Tenenbaum. 2024. remotes: R Package Installation from Remote Repositories, Including 'GitHub'. R package version 2.5.0,
[https://CRAN.R-project.org/package=remotes](https://CRAN.R-project.org/package=remotes).

Zydlewski, J., D. S. Stich, S. Roy, M. Bailey, T. Sheehan, and K. Sprankle. 2021. What Have We Lost? Modeling Dam Impacts on American Shad Populations Through Their Native Range. Frontiers in Marine Science 8. [https://doi.org/10.3389/fmars.2021.734213](https://doi.org/10.3389/fmars.2021.734213).



