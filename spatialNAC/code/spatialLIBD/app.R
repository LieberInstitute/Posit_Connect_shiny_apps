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
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatial-nac/processed-data/spatialLIBD/spe_shiny"
repo_local_dir <- here::here(
    "spatialNAC/processed-data/spatialLIBD/spe_shiny"
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

#spe_name <- here("spatialNAC", "code", "spatialLIBD", "spe_shiny.rds")
#spe1 <- readRDS(spe_name)
vars <- colnames(colData(spe))
spe$exclude_overlapping <- as.factor(spe$exclude_overlapping)
rownames(spe) <- rowData(spe)$gene_id



## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "Spatial NAc",
    spe_discrete_vars = c(
        vars[grep("^scran_", vars)],
        vars[grep("^X10x_", vars)],
        "exclude_overlapping",
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "X10x_graphclust",
    auto_crop_default = FALSE,
    docs_path = here("spatialNAC", "code", "spatialLIBD", "www")
)
