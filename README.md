# Power System Model to Evaluate Emission Factors Methods 
Assigning an emissions impact to changes in electricity demand will be ever more important as we value carbon appropriately, but this value depends on the method used. How well do these methods fair against a power grid model?

## Overview
This model was built to carry out the research in:

[Elenes, A. G., Williams, E., Hittinger, E., & Goteti, N. S. (2022). How Well Do Emission Factors Approximate Emission Changes from Electricity System Models?. Environmental Science & Technology, 56(20), 14701-14712.](https://doi.org/10.1021/acs.est.2c02344)

This model was built upon previous work by [Naga Srujana Goteti](https://www.proquest.com/docview/2313404648?pq-origsite=gscholar&fromopenview=true), and adapted by Alejandro Elenes for this project. This model is a portion of the original, with minimal-effort adaptations, so some portions of the model may seem unnecessary -feel free to purge your version as needed.

This model allows the user to test different emission factors using emissions input data from a power system model, and comparing the actual changes in emissions caused by the electricity demand changes of introducing new technologies in the grid.

At this point, this project has all the data used in Elenes et al. (2022): 
- electricity demand, fuel prices and renewable resources relevant to New York & Midcontinent Independent System Operators
- demand changes caused by adding an electric vehicle, a heat pump, and a solar panel (and a million of each)
- emission factors (EF) tested: annual average EF, demand-based marginal EF, thermal marginal EF, costliest marginal EF, incremental marginal EF
- time resolutions: hourly, 24-hr seasonal averages, 24-hr annual averages, annual average

The model has not yet been adjusted to be "easily" replicated for other case studies. If you are interested, feel free to clone this repository, try it yourself, and contact me with questions.

## Documentation
The model equations and more detail on data and model assumptions can be found in the [Supporting Information](https://pubs.acs.org/doi/suppl/10.1021/acs.est.2c02344/suppl_file/es2c02344_si_001.pdf) of the research article, whereas the equations for the emission factors methods tested can be found in the [main manuscript](https://doi.org/10.1021/acs.est.2c02344) (inquiries to an2013@rit.edu).

## Running the base case (Elenes et al. (2022))
1. [Clone this repository to your machine](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
2. Open MATLAB; confirm the add-ons are installed: `distrib_computing_toolbox` and `statistics_toolbox`
3. Navigate to the project directory `Emission_Factors`
4. Run `MEFs.m` script.
