# DLPFC ASD

[DOI_zenedo_badge](https://dx.doi.org/10.15154/we0x-qc56)

## Overview

Welcome to the `DLPFC_ASD` project! 🧠

In this work, we investigated spatially resolved molecular alterations in the dorsolateral prefrontal cortex (dLPFC) of individuals with autism spectrum disorder (ASD) compared with neurotypical controls (NTC) using 10x Genomics Visium CytAssist. We identified spatial domains (SpDs) to generate a layer-resolved molecular map of the dLPFC. We then performed pseudobulk differential expression analyses at both the cortex-wide and SpD laminar-specific levels. This framework enabled the characterization of baseline ASD-NTC differences across the cortex together with SpD-specific alterations in gene expression associated with mitochondrial ratio (MitoRatio) in ASD.

This work is being was performed by members of [Leonardo Collado-Torres](http://lcolladotor.github.io/), [Kristen R. Maynard](https://www.libd.org/team/kristen-maynard-phd/), [Stephanie C. Page](https://www.libd.org/team/stephanie-cerceo-page-phd/) and [Keri Martinowich](https://www.libd.org/team/keri-martinowich-phd/), teams at the [Lieber Institute for Brain Development](libd.org). 

Thank you for your interest in our work!

## Study Design

<img src="img/DLPFC_ASD_GA.png" width="1000px" align="left"/>

**Overview of spatial transcriptomic study design and differential expression (DE) workflow.**
**(A)** Study design showing human dorsolateral prefrontal cortex (dLPFC) tissue sampling from 8 neurotypical control (NTC) and 8 autism spectrum disorder (ASD) donors, hematoxylin and eosin (H&E) staining, and spatial transcriptomic profiling using 10x Genomics Visium CytAssist (scale bar = 2 mm).
**(B)** Representative granular cortex region showing annotated laminar spatial domains (SpDs).
**(C)** Spatial registration of the study dataset to a manually annotated dLPFC spatial transcriptomic reference dataset from [Maynard.*et*. *al*](https://doi.org/10.1038/s41593-020-00787-0), visualized as a registration heatmap.
**(D)** Mean mitochondrial ratio (MitoRatio) across SpDs, stratified by diagnosis. Points represent the mean MitoRatio across donors within each diagnosis group, and shaded ribbons indicate standard error of the mean (SEM).
**(E)** Schematic of the pseudobulk DE framework, where spatial transcriptomic counts were aggregated by donor within each SpD. The layer adjusted model (LAM) was used to identify baseline ASD–NTC differences across the cortex.
**(F)** Schematic of the layer specific interaction model (LSIM) pseudobulk DE framework used to test whether the relationship between gene expression and increasing MitoRatio differed between ASD and NTC samples. Representative regression plots display covariate-adjusted gene expression values against MitoRatio with separate fitted regression lines for ASD and NTC samples.

## Interactive Websites

We provide the following interactive websites to explore the DLPFC ASD data:

-   🔭 [DLPFC_ASD](https://interactive.libd.org/DLPFC_ASD/): Visium v2 data for 16 samples post-QC w/ clustering and modeling results.

-   🔭 [DLPFC_ASD_PreQC](https://interactive.libd.org/DLPFC_ASD_preQC/): Visium v2 data for 16 samples pre-QC drops (including out-tissue spots).

-   👀 [DLPFC_ASD_pseudobulk](https://interactive.libd.org/DLPFC_ASD_pesudobulk/): Visium v2 pseudobulked data used for differential expression(DE) analysis.

All of these interactive websites are powered by open source software, namely:

-   🔭 [`spatialLIBD`](https://doi.org/10.1186/s12864-022-08601-w) See [spatialLIBD website](https://research.libd.org/spatialLIBD/) for more information
-   👀 [`iSEE`](https://doi.org/10.12688%2Ff1000research.14966.1)

### Local `spatialLIBD` apps

If you are interested in running the
[`spatialLIBD`](https://doi.org/10.1186/s12864-022-08601-w) applications locally, you can do so thanks to the
[`spatialLIBD::run_app()`](http://research.libd.org/spatialLIBD/reference/run_app.html), which you can also use with your own data as shown in our [vignette for publicly available datasets provided by 10x Genomics](http://bioconductor.org/packages/release/data/experiment/vignettes/spatialLIBD/inst/doc/TenX_data_download.html).

``` 
## Run this web application locally with:
spatialLIBD::run_app()
## You could also use spatialLIBD::run_app() to visualize your
## own data given some requirements described
## in detail in the package vignette documentation
## at http://research.libd.org/spatialLIBD/.
```

## Contact

We value public questions, as they allow other users to learn from the
answers. If you have any questions, please ask them at
[LieberInstitute/dlpfc_asd/issues](https://github.com/LieberInstitute/dlpfc_asd/issues). 
Thank you again for your interest in our work!


## Citing our work

Please cite our pre-print [10.15154/we0x-qc56](https://dx.doi.org/10.15154/we0x-qc56) if you use data from this project. Below is the citation in Bibtex format.

## Data & Code availibility

Data and code for this project are available on [Github](https://github.com/LieberInstitute/dlpfc_asd).

Organization of code, data, and plots follows our team's [project template](https://github.com/LieberInstitute/template_project).

Processed data are available through Gene Expression Omnibus (GEO) under accession X, and raw data are available through the National Institute for Mental Health Data Archive (NDA) under study ID [3347](https://dx.doi.org/10.15154/we0x-qc56).

Processed data files (R objects) used to make the interactive apps (logcounts only) 

R objects with both the counts and logcounts can be 
downloaded through the [fetch_data()](https://research.libd.org/spatialLIBD/reference/fetch_data.html) 
function from [spatialLIBD website](https://research.libd.org/spatialLIBD/) v1.23.1 or newer. 

**Access data with spatialLIBD**
```
##spatialLIBD::fetch() 
```

### Installation and Requirements

All software versions are listed in log files. The R session information was automatically generated with `sessioninfo::session_info()`.

The code repo can be downloaded via `git clone` to a normal desktop, this may take up to an hour given it's size.

NOTE this code is specialized for this project's data, and will need to be adapted to run on other datasets.

## Funding

This project was supported by R01MH126393 (KM) and the [Lieber Institute for Brain Development](https://www.libd.org/).

## Main Data

### Visium CytAssist

**SpatialExperiment**

-   Raw version: `processed-data/02_build_spe/04_QC_spe/final_dataset/QC_final_spe_raw_app.rds`

-   Post-QC version: `processed-data/04_spe_correct_cluster/final_dataset/sce_ASD`

```         
## Load HD5F sce
sce <- HDF5Array::loadHDF5SummarizedExperiment(here::here("processed-data", "04_spe_correct_cluster", "final_dataset", "sce_ASD"))
# class: SpatialExperiment 
# dim: 
```

**Input files**

-   `raw-data/sample_info`: metadata about samples.

-   `raw-data/images`: `tif` images used for running `SpaceRanger`.

-   `raw-data/FASTQ`: FASTQ files

**SpaceRanger files**

-   `processed-data/images`: `json` images used for running `SpaceRanger`.

-   `processed-data/01c_spaceranger`: `SpaceRanger` output files for final set of 16 samples.

**Modeling Pseudobulk data**

-   modeling_results: `processed-data/04_spe_correct_cluster/final_dataset/07_model_pseudobulk/BayesSpace_PCA_Harmony/`

-   pseudobulk_data: `processed-data/06_differential_expression/01_pseudobulk_data/final_dataset/QC_final_dataset_summed_k11.rds`

**DE analysis data**

-   LAM: `processed-data/06_differential_expression/03i_layer_adjusted_vmf_covars/post_drop/tt_diagnosis_only.rds`

-   LSIM: `processed-data/06_differential_expression/03d_voomLmFit/post_drop`

## Internal

-   JHPCE location: `/dcs05/lieber/lcolladotor/DLPFC_ASD_LIBD4100/dlpfc_asd`.
