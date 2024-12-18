# anadrofish
R package for modeling anadromous fish population responses to freshwater habitat changes

[![DOI](https://zenodo.org/badge/186272264.svg)](https://doi.org/10.5281/zenodo.14285894)

## Installation
This package can be installed with the [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) package in R using the repository url:

`devtools::install_github("danStich/anadrofish")`

To install `anadrofish`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already. For users working on agency networked computers, you will need to work with your IT specialists or someone with administrative privileges if you do not have them.

</br>

## Overview
### Purpose
The purpose of this package is to distribute code and provide a user interface for modeling anadromous fish population responses to dam passage and fisheries in Atlantic coastal rivers of Canada and the United States. The main `sim_pop()` function uses various helper functions (see `?anadrofish` in R) that links dam passage to habitat availability and stochastic population models to simulate species-specific responses to dams and fisheries. Habitat datasets are currently derived separately for each species based on best available knowledge and expert opinion from state and federal fishery biologists, managers, and scientists. Likewise, all species-specific life-history parameters (size at age, age at maturity, natural mortality) are derived directly from interstate stock assessments or informed by empirical estimates from the fisheries literature. The application of these models is described in [ASMFC 2020](https://asmfc.org/uploads/file/63d8437dAmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf), [Zydlewski et al. 2021](https://www.frontiersin.org/journals/marine-science/articles/10.3389/fmars.2021.734213/full), and [ASMFC 2024](https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf).

Existing population models for each species can be implemented using the `sim_pop()` function. New models can theoretically be constructed using the existing functions within `anadrofish` and appropriately structured habitat data. **As of version 2.1.0** (2024-11-26), we implemented the `custom_habitat_template()` function. This allows use of default habitat data sets, modifying habitat data based on built-in datasets, querying custom habitat datasets ranging from the single stream segment to regional stock scales for each species, or constructing completely custom habitat configurations including completely fabricated (i.e., theoretical) hydrosystem configurations for optimization studies. 

### Species
These models are available for American shad (*Alosa sapidissima*) in 167 Atlantic Coastal rivers of North America from Florida (St. Johns River) to Quebec (St. Lawrence drainage). The full list of rivers available for assessment can be viewed with `anadrofish::get_rivers(...)` once the package is installed.

River herring population models are available for 56 populations of alewife (*Alosa pseudoharengus*) and 49 blueback herring (*Alosa aestivalis*) populations. River herring models and underlying data were peer-reviewed during development and application to the [2024 Atlantic States Marine Fisheries Commission (ASMFC) River Herring Benchmark Stock Assessment](https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf). We are currently delineating smaller stock units for defaults to provide greater utility and flexibility for local managers.

### Ongoing development
Finally, the code and documentation for all of these models are currently being updated in preparation for additional peer-review and thus may be updated at any time. After that, our hope is to submit the R package to CRAN with the hope of providing a  stable, backward-compatible version of the software moving forward.

</br>

## Directories

`data/` Built-in data sets for the package

`inst/examples/` Examples for those requiring more than a one-liner 

`man/`  Help files and documentation

`R/`    R functions in scripts

## Contributing
We encourage contributions from the community and welcome collaborations for extension to other species and systems!

You can ask questions or submit bug reports at any time through the [issues page](https://github.com/danStich/anadrofish/issues). Please check to see whether a similar issue already exists before submitting a new issue. If you would like to contribute improvements or modifications directly to the repository, you can fork the repository and submit a merge request so those contributions can be reviewed.

