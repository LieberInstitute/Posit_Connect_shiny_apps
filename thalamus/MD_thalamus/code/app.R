library("spatialLIBD")
library("markdown")
library("here")


#spe <- HDF5Array::loadHDF5SummarizedExperiment(
#    "~/Downloads/spatial_md_thalamus/spatial_app/spe_clustered")

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/thalamus/MD_Thalamus/spe_shiny.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("thalamus", "MD_thalamus", "processed-data", "spe_shiny.rds"))
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/thalamus/MD_Thalamus/spe_pseudobulk-spatial_domain.rds"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pb_k12 <- readRDS(posit_connect_file1)
} else {
    spe_pb_k12 <- readRDS(here::here("thalamus", "MD_thalamus", "processed-data", "spe_pseudobulk-spatial_domain.rds"))
}

posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/thalamus/MD_Thalamus/modeling_results-spatial_domain.rds"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    modeling_results_k12 <- readRDS(posit_connect_file2)
} else {
    modeling_results_k12 <- readRDS(here::here("thalamus", "MD_thalamus", "processed-data", "modeling_results-spatial_domain.rds"))
}

posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/thalamus/MD_Thalamus/sig_genes-spatial_domain.rds"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    sig_genes_k12 <- readRDS(posit_connect_file3)
} else {
    sig_genes_k12 <- readRDS(here::here("thalamus", "MD_thalamus", "processed-data", "sig_genes-spatial_domain.rds"))
}


names(spe_pb_k12$spatial_domain_colors) <- spe_pb_k12$spatial_domain

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

spe_discrete_vars = c(
  "in_tissue",
  "spatial_domain",
  sprintf("PCAHarmony_offset_k12")
)

spatialLIBD::run_app(
  spe = spe,
  sce_layer = spe_pb_k12,
  modeling_results = modeling_results_k12,
  sig_genes = sig_genes_k12,
  spe_discrete_vars = spe_discrete_vars,
  title = "MD-Thalamus, Visium CytAssist, spatial_domain_k12",
  spe_continuous_vars = c(
    "sum_umi",
    "expr_chrM",
    "expr_chrM_ratio"
  ),
  default_cluster = "spatial_domain",
  auto_crop_default = FALSE,
  docs_path = here::here("thalamus", "MD_thalamus", "code", "www")
)

## Note. If fails to read the rds object, go to Session Menu -> Set Working Directory -> To source File location
