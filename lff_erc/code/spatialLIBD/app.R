
#This will be the app file for this project
library("iSEE")
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())


#sce <- readRDS("sce_ERC_iSEE.rds")
#sn_colors <- readRDS("sn_colors.rds")


## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_ERC/spatialLIBD/spe_ERC_app.rds"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_ERC/spatialLIBD/spe_pseudobulk-SpD.rds"
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_ERC/spatialLIBD/modeling-results-SpD.rds"
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_ERC/spatialLIBD/sig_genes_SpD.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("lff_erc", "processed-data", "spatial-data", "spe_ERC_app.rds"))
}

if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pb <- readRDS(posit_connect_file1)
} else {
    spe_pb <- readRDS(here::here("lff_erc", "processed-data", "spatial-data", "spe_pseudobulk-SpD.rds"))
}

if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    modeling_results <- readRDS(posit_connect_file2)
} else {
    modeling_results <- readRDS(here::here("lff_erc", "processed-data", "spatial-data", "modeling-results-SpD.rds"))
}

if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    sig_genes <- readRDS(posit_connect_file3)
} else {
    sig_genes <- readRDS(here::here("lff_erc", "processed-data", "spatial-data", "sig_genes_SpD.rds"))
}


#### load data ####
## main spe object
#spe <- readRDS("spe_ERC_app.rds")

# Add gene search
rowData(spe)$gene_search <- paste0(rowData(spe)$gene_name, "; ", rowData(spe)$gene_id)

## k09 pseudobulk +modeling data
#spe_pb <- readRDS("spe_pseudobulk-SpD.rds")

## define spatialLIBD column
#spe_pb$spatialLIBD <- spe_pb$SpD

# here::here("processed-data","05_spe_correct_cluster","20_model_pseudobulk_anno","spe_pseudobulk-SpD.rds")

#modeling_results <- readRDS("modeling-results-SpD.rds")
#sig_genes <- readRDS("sig_genes_SpD.rds")

## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)

## Colors 
# metadata(spe)$SpD_colors

spe_discrete_vars = c(
    "SpD",
    "ManualAnnotation",
    vars[grep("^10x_", vars)],
    vars[grep("^scran_", vars)],
    "edge_spot",
    "scran_low_lib_size_edge",
    "qc_anno",
    "scran_qc_anno",
    "ss_qc_anno",
    "qc_anno_all",
    "local_outliers",
    sprintf("BayesSpace_SVGm_k%02d", 2:28),
    sprintf("BayesSpace_Markers_k%02d", c(2,11))
)

spe_discrete_vars <- spe_discrete_vars[spe_discrete_vars %in% vars]

spatialLIBD::run_app(
    spe = spe,
    sce_layer = spe_pb,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "LFF ERC, Visium, Sp09",
    spe_discrete_vars = spe_discrete_vars,
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "edge_distance"
    ),
    default_cluster = "SpD",
    docs_path = "www"
)
