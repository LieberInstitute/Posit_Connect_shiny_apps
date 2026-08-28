library("spatialLIBD")
library("markdown")
library("here")


#spe <- HDF5Array::loadHDF5SummarizedExperiment(
#    "~/Downloads/spatial_md_thalamus/spatial_app/spe_clustered")

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/thalamus/MD_Thalamus/VisiumHD_sfe"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- HDF5Array::loadHDF5SummarizedExperiment(posit_connect_file)
} else {
    spe <- HDF5Array::loadHDF5SummarizedExperiment(here::here("thalamus", "NAC_AP", "processed-data", "VisiumHD_sfe"))
}

# CODE TO WRAP THE SPE WITH IN-TISSUE AND OUT-TISSUE SPOTS NONE FILTERED

## To install new spatialLIBD 1.15.4 (development version):
## .    https://bioconductor.org/packages/devel/data/experiment/html/spatialLIBD.html

## spatialLIBD uses golem.
## Golem is a framework for building production-grade shiny applications
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())
#setwd("/Users/manisha.barse/Library/CloudStorage/OneDrive-LieberInstituteforBrainDevelopment/LIBD_code/dlpfc_asd/code/03_spatialLIBD_app/")
#here("code", "03_spatialLIBD_app")

## I added a symbolic link to point the spe.rds object to wrap.

# if(file.exists("/r_data/lcollado/dlpfc_asd/processed-data/02_build_spe/QC_spe_raw_app.rds")) {
#     ## Location for the https://conn1.libd.org/ server
#     spe <- readRDS("/r_data/lcollado/dlpfc_asd/processed-data/02_build_spe/QC_spe_raw_app.rds")
# } else {
#     spe <- readRDS("QC_probe_test_spe_raw_app.rds")
# }
# message("Finished loading spe data")

# spe <- readRDS("~/Downloads/spatial_md_thalamus/spatial_app/04_QC_final_spe_raw_app.rds")
# spe <- readRDS("~/Downloads/spatial_md_thalamus/spatial_app/04_QC_final_spe.rds")


#spe
## Quickly explore the data
vars <- colnames(colData(spe))
# colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)
#vars
#colnames(colData(spe))
#getwd()

spatialLIBD::run_app(
  spe = spe,
  sce_layer = NULL,
  modeling_results = NULL,
  sig_genes = NULL,
  spe_discrete_vars = c(
    "ManualAnnotation",
    "overlaps_tissue",
    vars[grep("^10x_", vars)],
    vars[grep("^scran_", vars)],
    vars[grep("^PCAHarmony_", vars)],
    #"edge_spots",
    vars[grep("^ss_", vars)],
    vars[grep("^qc_", vars)]
    # vars[grep("^SNN_k10", vars)],
    # vars[grep("^BayesSpace_harmony_", vars)]
  ),
  spe_continuous_vars = c(
    "sum_umi",
    "sum_gene",
    "expr_chrM",
    "expr_chrM_ratio" # ,
    # "edge_distance"
  ),
  default_cluster = "10x_graphclust",
  auto_crop_default = FALSE,
  docs_path = "www"
)

## Note. If fails to read the rds object, go to Session Menu -> Set Working Directory -> To source File location
