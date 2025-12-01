
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dACC/spatialdACC_Visium/spe_nnSVG_PRECAST_9_labels.Rdata"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("dACC", "spatialdACC_Visium", "processed-data", "spe_nnSVG_PRECAST_9_labels.Rdata"))
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dACC/spatialdACC_Visium/modeling-nnSVG_PRECAST_captureArea_9.Rdata"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file1)
} else {
    load(here::here("dACC", "spatialdACC_Visium", "processed-data", "modeling-nnSVG_PRECAST_captureArea_9.Rdata"))
}
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dACC/spatialdACC_Visium/nnSVG_PRECAST_captureArea_9.Rdata"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file2)
} else {
    load(here::here("dACC", "spatialdACC_Visium", "processed-data", "nnSVG_PRECAST_captureArea_9.Rdata"))
}
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dACC/spatialdACC_Visium/sig_genes_subset.Rdata"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file3)
} else {
    load(here::here("dACC", "spatialdACC_Visium", "processed-data", "sig_genes_subset.Rdata"))
}


## Load the data (all paths are relative to this script's location)
#load("spe_nnSVG_PRECAST_9_labels.Rdata", verbose = TRUE)
#load("modeling-nnSVG_PRECAST_captureArea_9.Rdata", verbose = TRUE)
#load("nnSVG_PRECAST_captureArea_9.Rdata", verbose = TRUE)

#load("sig_genes_subset.Rdata", verbose = TRUE)
# sig_genes <- readRDS("nnSVG_PRECAST_captureArea_9_sig_genes_all.rds")

# Added biocGenerics specifically for finding the right colnames, also due to R update
vars <- BiocGenerics::colnames(colData(spe))


spatialLIBD::run_app(
    spe,
    sce_layer = spe_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "spatialdACC, Visium",
    spe_discrete_vars = c(vars[grep("10x_", vars)], "ManualAnnotation", "layer"),
    spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio"),
    default_cluster = "layer",
    docs_path = "www"
)

