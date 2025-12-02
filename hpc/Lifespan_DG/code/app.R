library("HDF5Array")
library("spatialLIBD")
library("markdown")
library("here")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
#spe <- loadHDF5SummarizedExperiment("spe_shiny")
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/Lifespan_DG/spe_shiny"
repo_local_dir <- here::here(
    "hpc", "Lifespan_DG", "processed-data", "spe_shiny"
)

if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else {
    dir_to_use <- repo_local_dir
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/Lifespan_DG/sig_genes_subset.rds"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    sig_genes <- readRDS(posit_connect_file1)
} else {
    sig_genes <- readRDS(here::here("hpc", "Lifespan_DG", "processed-data", "sig_genes_subset.rds"))
}

posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/Lifespan_DG/pseudobulk_spe.rds"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pseudo <- readRDS(posit_connect_file2)
} else {
    spe_pseudo <- readRDS(here::here("hpc", "Lifespan_DG", "processed-data", "pseudobulk_spe.rds"))
}

posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/Lifespan_DG/modeling_results.rds"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    modeling_results <- readRDS(posit_connect_file3)
} else {
    modeling_results <- readRDS(here::here("hpc", "Lifespan_DG", "processed-data", "modeling_results.rds"))
}

spe <- loadHDF5SummarizedExperiment(
    dir = dir_to_use
)

#docs_path = here("spatialNAC", "code", "spatialLIBD", "www")

#spe_name <- here("spatialNAC", "code", "spatialLIBD", "spe_shiny.rds")
#spe1 <- readRDS(spe_name)
vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = spe_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "spatial_DG_lifespan, Visium",
    spe_discrete_vars = c("BayesSpace", "ManualAnnotation"),
    spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
    default_cluster = "BayesSpace",
    auto_crop_default = FALSE,
    docs_path = "www"
)
