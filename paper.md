---
title: 'anadrofish: Anadromous fish population responses to dams'
tags:
  - R
  - fish
  - dams
  - anadromous
  - life history
output:
  word_document: default
  html_document:
    df_print: paged
authors:
  - name: Daniel S. Stich
    orcid: "0000-0002-8946-1115"
    corresponding: true
    affiliation: "1, 2"
  - name: Joshua D. Hardesty
    orcid: "0009-0009-0280-1999"
    affiliation: "1"
  - name: Nicholas T. Jordan
    orcid: "0009-0009-8632-6979"
    affiliation: "1"
  - name: Samuel G. Roy
    orcid: "0000-0002-2491-948X"
    affiliation: "3"
  - name: Timothy F. Sheehan
    orcid: "0000-0002-9689-1180"  
    affiliation: "4"
  - name: Shawn D. Snyder
    orcid: "0000-0003-3286-4957"
    affiliation: "5"
  - name: Joseph D. Zydlewski
    orcid: "0000-0002-2255-2303"
    affiliation: "6, 5"
affiliations:
- name: Biology Department, State University of New York at Oneonta, NY 13280 USA
  index: 1
- name: Biological Field Station, State University of New York at Oneonta, Cooperstown, NY 13326 USA
  index: 2
- name: Maine Geological Survey, Department of Agriculture, Conservation and Forestry, Augusta, ME, 04333 USA
  index: 3  
- name: National Oceanic and Atmospheric Administration, National Marine Fisheries Service, Northeast Fisheries Science Center, Woods Hole, MA 02543 USA
  index: 4
- name: Department of Wildlife, Fisheries, and Conservation Biology, University of Maine, Orono, ME, 04469 USA
  index: 5
- name: U.S. Geological Survey Maine Cooperative Fish and Wildlife Research Unit, Orono, ME, 04469 USA
  index: 6
date: 25 April 2025
bibliography: paper.bib
---


# Summary
Diadromous fishes world-wide experienced precipitous declines during the 19^th^ and 20^th^ centuries due to a combination of overfishing, pollution, and freshwater habitat loss through construction of dams [@limburg2009]. Following wide-spread fishing closures and large-scale remediation of many historical pollution sources, dams in coastal rivers remain as the largest tractable impediment to population recovery for many of these species [@waldman2022]. In some cases, dams reduce access to as much as 95% of freshwater and rearing habitat [@hall2011]. These effects are especially pronounced for species that rely on long-distance migrations to spawning and rearing habitat upstream of barriers such as various alosines (herrings; e.g., American shad *Alosa sapidissima*, alewife *A. pseudoharengus*, and blueback herring *A. aestivalis* [@noonan2012]) and salmonines (trout and salmon; e.g., *Salmo* spp. [@parrish1998] and *Oncorhynchus*  spp. [@quinones2015]. 

Traditional stock assessment tools such as per-recruit analyses often fail to capture management complexities related to diadromous life histories such as fish passage at dams, and integrated assessment models can be difficult to parameterize for data-poor species such as herrings [@asmfc:2024]. This has resulted in the development of species- and system-specific approaches to fisheries stock assessment and management strategy evaluation [@nieland2015;@barber:2018;@roy2018;@stich:2019]. We created the `anadrofish` package [@anadrofish] for R [@R] to provide a generalized approach that also allows broader application to novel species, systems, and scenarios.


# Statement of need
`anadrofish` is an R package that can be used to model anadromous fish populations, including responses to dams and other fishery management considerations (e.g., fishery harvest rates). We created it for use by fisheries scientists and managers interested in development of life-history theory,  stock assessment, or decision making. The R package was developed for use in the 2020 Atlantic States Marine Fisheries Commission (ASMFC) American shad benchmark stock assessment [@asmfc:2020] and the 2024 ASMFC river herring benchmark stock assessment [@asmfc:2024]. It has also been used recently to answer coast-wide ecological research questions [@zydlewski:2021] and evaluate local or regional fishery management scenarios.

The package includes a variety of helper functions for simulating life-history events and population dynamics as well as built-in data sets from empirical studies and population assessments for the native North American range of multiple species of fish from Florida, USA through maritime Canada. It generalizes similar routines implemented in other species- or population-specific modeling tools [@barber:2018; @stich:2019; @stich2025], is faster than other empirical life-history models [e.g., @shadia], and can be modified to use outputs of common empirical fisheries analyses from other R packages such as `fishStan` [@Erickson2022] or `FSA` [@FSA]. The package can also be used to simulate new populations in arbitrary watersheds. Default outputs are readily integrated into tidy workflows through packages in the `tidyverse` [@tidyverse], including plotting and visualization of results in `ggplot2` [@ggplot2].

The `sim_pop()` function provides high-level functionality for end users interested in investigating theoretical questions or applied population management scenarios. This function links various helper functions and built-in datasets to simulate populations through time and space. By default, it includes functionality for 169 American shad, 222 alewife, and 238 blueback herring populations. Additionally, optional arguments to this function such as `custom_habitat` and the corresponding `custom_habitat_template()` helper function provide customization options or ability to extend to arbitrarily defined scales or novel systems. This flexibility has the potential to broaden the application of these modeling approaches to novel species and geographies or restoration scenarios for management strategy evaluation. The next steps for this project will include addition of generalized homing and straying routines that can be used to customize probability of fish migration to specific portions of empirical or derived watersheds, and creation of methods that allow for multiyear freshwater residence to accommodate a wider range of life histories, including catadromous fishes that grow in freshwater and spawn in the marine environment.


# Acknowledgements
We acknowledge contributions from M. Bailey, E. Gilligan-Lunda, J. Kipp, and K. Sprankle during initial package development for American shad, and contributions by K. Drew, W. Eakin, and B. Gahagan to package updates for alewife and blueback herring. We thank numerous ASMFC Technical Committee representatives and regional biologists for input during coast-wide stock assessments. This work was funded by the NOAA National Marine Fisheries Service Northeast Fisheries Science Center (award number NMFS-NEFSC-199 MOU), with additional support from the State University of New York Oneonta Biological Field Station, in kind support from the U.S. Geological Survey Maine Cooperative Fish and Wildlife Research Unit, and the University of Maine. We thank the reviewers for helpful guidance and comments that greatly improved the quality of this paper and the open-source software package. Any use of trade, firm, or product names is for descriptive purposes only and does not imply endorsement by the U.S. Government.

# References
