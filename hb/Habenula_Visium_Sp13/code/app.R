
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp13/sig_genes_k13.Rdata"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("hb", "Habenula_Visium_Sp13", "processed-data", "sig_genes_k13.Rdata"))
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp13/modeling_results_BayesSpace_k13.Rdata"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file1)
} else {
    load(here::here("hb", "Habenula_Visium_Sp13", "processed-data", "modeling_results_BayesSpace_k13.Rdata"))
}
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp13/sce_pseudo_PCA_brain_area_k13.rds"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    sce_pseudo <- readRDS(posit_connect_file2)
} else {
    sce_pseudo <- readRDS(here::here("hb", "Habenula_Visium_Sp13", "processed-data", "sce_pseudo_PCA_brain_area_k13.rds"))
}
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp13/spe_shiny.rds"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file3)
} else {
    spe <- readRDS(here::here("hb", "Habenula_Visium_Sp13", "processed-data", "spe_shiny.rds"))
}


colnames(colData(spe))
levels(colData(spe)$BayesSpace)
levels(colData(sce_pseudo)$BayesSpace)

## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)
#

BayesSpace_k <- "13"
title_name <- paste0("spatialHabenula, Visium, Sp", BayesSpace_k)
# "spatialHabenula, Visium, Sp13"


spatialLIBD::run_app(
    spe,
    sce_layer = sce_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = title_name,
    spe_discrete_vars = c( ## this are the variables for the spe object not the sce_pseudo object
        "BayesSpace",
        "ManualAnnotation",
        "overlaps_tissue",
        vars[grep("^10x_", vars)],
        vars[grep("^scran_", vars)],
        "edge_spot",
        vars[grep("^SNN_k10", vars)],
        vars[grep("^BayesSpace_harmony_", vars)],
        "local_outliers"
        #"BayesSpace_colors"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "edge_distance"
    ),
    default_cluster = "BayesSpace",
    docs_path = "www"
)


## Note. If fails to read the rds object, go to Session Menu -> Set Working Directory -> To source File location
