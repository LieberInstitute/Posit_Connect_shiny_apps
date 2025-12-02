
#This will be the app file for this project
library("iSEE")
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())


#sce <- readRDS("sce_ERC_iSEE.rds")
#sn_colors <- readRDS("sn_colors.rds")


## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/erc/LFF_ERC_Visium_QC/spe_raw.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("erc", "LFF_ERC_Visium_QC", "processed-data", "spe_raw.rds"))
}




## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)

spe_discrete_vars = c(
    "ManualAnnotation",
    "in_tissue",
    vars[grep("^10x_", vars)],
    vars[grep("^scran_", vars)],
    "edge_spot",
    "scran_low_lib_size_edge",
    "qc_anno",
    "scran_qc_anno",
    "ss_qc_anno",
    "qc_anno_all",
    "local_outliers"
)


spe_discrete_vars <- spe_discrete_vars[spe_discrete_vars %in% vars]

spatialLIBD::run_app(
    spe = spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    spe_discrete_vars = spe_discrete_vars,
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "edge_distance"
    ),
    default_cluster = "10x_graphclust",
    docs_path = "www"
)
