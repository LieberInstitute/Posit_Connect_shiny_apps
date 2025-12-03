
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_Visium_SPG/spe.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe_IF <- readRDS(posit_connect_file)
} else {
    spe_IF <- readRDS(here::here("dlpfc", "spatialDLPFC_Visium_SPG", "processed-data", "spe.rds"))
}

vars <- colnames(colData(spe_IF))


## Deploy the website
spatialLIBD::run_app(
    spe_IF,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatialDLPFC, Visium SPG",
    spe_discrete_vars = c(
        vars[grep("^10x_", vars)],
        "manual_layer_label",
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        vars[grep("^(broad|layer|cart)_", vars)],
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "VistoSeg_count_deprecated",
        "cellpose_count"
    ),
    default_cluster = "10x_graphclust",
    docs_path = "www"
)
