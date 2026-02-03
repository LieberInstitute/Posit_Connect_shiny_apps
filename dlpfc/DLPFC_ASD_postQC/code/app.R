
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/spe_shiny.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "spe_shiny.rds"))
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/spe_pseudobulk-BayesSpace_PCA_Harmony_k11.rds"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pb_k11 <- readRDS(posit_connect_file1)
} else {
    spe_pb_k11 <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "spe_pseudobulk-BayesSpace_PCA_Harmony_k11.rds"))
}
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/modeling_results-BayesSpace_PCA_Harmony_k11.rds"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    modeling_results_k11 <- readRDS(posit_connect_file2)
} else {
    modeling_results_k11 <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "modeling_results-BayesSpace_PCA_Harmony_k11.rds"))
}
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/sig_genes_k11.rds"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    sig_genes_k11 <- readRDS(posit_connect_file3)
} else {
    sig_genes_k11 <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "sig_genes_k11.rds"))
}


## define spatialLIBD column
spe_pb_k11$spatialLIBD <- spe_pb_k11$BayesSpace_PCA_Harmony_k11
#spe_pb_k09$spatialLIBD <- spe_pb_k09$BayesSpace_PCA_Harmony_k09


## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)
#vars
#colnames(colData(spe))
#getwd()

spe_discrete_vars = c(
    "ManualAnnotation",
    "in_tissue",
    vars[grep("^10x_", vars)],
    vars[grep("^scran_", vars)],
    #"edge_spots",
    "scran_low_lib_size_edge",
    "scran_qc_anno",
    "ss_qc_anno", #vars[grep("^ss_", vars)],
    "qc_anno_all",#vars[grep("^qc_", vars)],
    "local_outliers",
    "sample_processing",
    sprintf("BayesSpace_PCA_Harmony_k%02d", 2:28) #,
    #sprintf("BayesSpace_Markers_k%02d", c(2,11))
)

spatialLIBD::run_app(
    spe = spe,
    sce_layer = spe_pb_k11,
    modeling_results = modeling_results_k11,
    sig_genes = sig_genes_k11,
    spe_discrete_vars = spe_discrete_vars,
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "edge_distance"
    ),
    default_cluster = "BayesSpace_PCA_Harmony_k11",
    docs_path = "www"
)

## Note. If fails to read the rds object, go to Session Menu -> Set Working Directory -> To source File location
