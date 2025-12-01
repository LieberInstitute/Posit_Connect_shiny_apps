
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/LC/LC-NIA_spatial/spe_raw_VIF.Rdata"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("LC", "LC-NIA_spatial", "processed-data", "spe_raw_VIF.Rdata"))
}


vars <- BiocGenerics::colnames(colData(spe))
## Deploy the website
# spatialLIBD::run_app(
#     spe,
#     sce_layer = spe_pseudo,
#     modeling_results = modeling_results,
#     sig_genes = sig_genes,
#     title = "spatialLC-NIA, Visium_SPG",
#     spe_discrete_vars = c(vars[grep("10x_", vars)], "ManualAnnotation"),
#     spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
#     default_cluster = "layer",
#     docs_path = "www"
# )

spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "LC-NIA_spatial, Visium-SPG",
    spe_discrete_vars = c(vars[grep("10x_", vars)], "ManualAnnotation"),
    spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
    default_cluster = "10x_graphclust"
)

