
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library("Polychrome")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_equivolume_domains/spatialDLPFC_equivolume_domains.Rdata"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("dlpfc", "spatialDLPFC_equivolume_domains", "processed-data", "spatialDLPFC_equivolume_domains.Rdata"))
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_equivolume_domains/spatialDLPFC_equivolume_domains_pseudobulk.Rds"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pseudo <- readRDS(posit_connect_file1)
} else {
    spe_pseudo <- readRDS(here::here("dlpfc", "spatialDLPFC_equivolume_domains", "processed-data", "spatialDLPFC_equivolume_domains_pseudobulk.Rds"))
}
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_equivolume_domains/spatialDLPFC_equivolume_domains_modeling_results.Rds"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    modeling_results <- readRDS(posit_connect_file2)
} else {
    modeling_results <- readRDS(here::here("dlpfc", "spatialDLPFC_equivolume_domains", "processed-data", "spatialDLPFC_equivolume_domains_modeling_results.Rds"))
}
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_equivolume_domains/spatialDLPFC_equivolume_domains_sig_genes.Rds"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    sig_genes <- readRDS(posit_connect_file3)
} else {
    sig_genes <- readRDS(here::here("dlpfc", "spatialDLPFC_equivolume_domains", "processed-data", "spatialDLPFC_equivolume_domains_sig_genes.Rds"))
}

vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = spe_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "spatialDLPFC, Visium, Sp09",
    spe_discrete_vars = c( # this is the variables for the spe object not the spe_pseudo object
        "BayesSpace",
        "ManualAnnotation",
        vars[grep("^SpaceRanger_|^scran_", vars)],
        vars[grep("^BayesSpace_harmony", vars)],
        vars[grep("^BayesSpace_pca", vars)],
        "graph_based_PCA_within",
        "PCA_SNN_k10_k7",
        "Harmony_SNN_k10_k7",
        "manual_layer_label",
        "wrinkle_type",
        "BayesSpace_colors"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        vars[grep("^VistoSeg_", vars)],
        vars[grep("^layer_", vars)],
        vars[grep("^broad_", vars)]
    ),
    default_cluster = "BayesSpace",
    docs_path = "www"
)
