
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


#sce <- readRDS("sce_ERC_iSEE.rds")
#sn_colors <- readRDS("sn_colors.rds")


## Load the data
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_LC/spatialLIBD/spe_shiny"
repo_local_dir <- here::here(
    "lff_lc", "processed-data", "spe_shiny"
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

#### load data ####
## main spe object
#spe <- readRDS("spe_ERC_app.rds")

# Add gene search
#rowData(spe)$gene_search <- paste0(rowData(spe)$gene_name, "; ", rowData(spe)$gene_id)

## k09 pseudobulk +modeling data
#spe_pb <- readRDS("spe_pseudobulk-SpD.rds")

## define spatialLIBD column
#spe_pb$spatialLIBD <- spe_pb$SpD

# here::here("processed-data","05_spe_correct_cluster","20_model_pseudobulk_anno","spe_pseudobulk-SpD.rds")

#modeling_results <- readRDS("modeling-results-SpD.rds")
#sig_genes <- readRDS("sig_genes_SpD.rds")

## Quickly explore the data
vars <- colnames(colData(spe))


colData(spe)$key <- rownames(colData(spe))
colData(spe)$ManualAnnotation <- "NA"
rownames(spe) <- rowData(spe)$gene_id
#spe$exclude_overlapping <- as.factor(spe$exclude_overlapping)
#colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)

## Colors 
# metadata(spe)$SpD_colors



spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatial LFF_LC",
    spe_discrete_vars = c(
        "sum_umi",
        "sum_gene",
        "Domain"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "Domain",
    docs_path = "www",
    auto_crop_default = FALSE
)
