
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library(FNN)
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/misc/spatialLIBD_Human_Lymph_Node_10x/spe_wrapper.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe_wrapper <- readRDS(posit_connect_file)
} else {
    spe_wrapper <- readRDS(here::here("misc", "spatialLIBD_Human_Lymph_Node_10x", "processed-data", "spe_wrapper.rds"))
}
spe_wrapper <- readRDS("/Users/ryan.miller/Documents/projects/code/Posit_Connect_shiny_apps/misc/spatialLIBD_Human_Lymph_Node_10x/processed-data/spe_wrapper.rds")
vars <- colnames(colData(spe_wrapper))

## Deploy the website
spatialLIBD::run_app(
    spe_wrapper,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatialLIBD: human lymph node by 10x Genomics",
    spe_discrete_vars = c(vars[grep("10x_", vars)], "ManualAnnotation"),
    spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
    default_cluster = "10x_graphclust",
    docs_path = "www"
)
