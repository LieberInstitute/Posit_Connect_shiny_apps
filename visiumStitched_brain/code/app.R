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
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/visiumStitched_brain/spe"
repo_local_dir <- here::here(
    "visiumStitched_brain", "processed-data", "spe"
)
if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else {
    dir_to_use <- repo_local_dir
}

spe <- loadHDF5SummarizedExperiment(
    dir = dir_to_use
)

vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "visiumStitched_brain",
    spe_discrete_vars = c(
        "ManualAnnotation",
        vars[grep("^precast_k[248]", vars)],
        "scran_quick_cluster"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "precast_k2_stitched",
    docs_path = "www",
    is_stitched = TRUE
)
