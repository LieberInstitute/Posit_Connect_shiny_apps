
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/LS/spatial_LS_Visium-XL_trial/shiny-spe.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("LS", "spatial_LS_Visium-XL_trial", "processed-data", "shiny-spe.rds"))
}


## Load the data

vars <- BiocGenerics::colnames(colData(spe))
#spe$exclude_overlapping <- as.factor(spe$exclude_overlapping)

#Change rownames to the symbol unique
#rownames(spe) <- rowData(spe)$Symbol.uniq

spe$exclude_overlapping = FALSE

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    is_stitched = TRUE,
    title = "Spatial LS XL - initial",
    spe_discrete_vars = c(
        vars[grep("^10x_", vars)],
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "10x_graphclust"#,
    #auto_crop_default = FALSE,
    #docs_path = "www"
)
