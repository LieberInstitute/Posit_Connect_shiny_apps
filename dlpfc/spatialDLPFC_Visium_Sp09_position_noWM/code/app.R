
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_Visium_Sp09_position_noWM/sig_genes_subset_k09_position.Rdata"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_Visium_Sp09_position_noWM/modeling_results_position_k09.Rdata"
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_Visium_Sp09_position_noWM/sce_pseudo_BayesSpace_k09.rds"
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_Visium_Sp09_position_noWM/spe_subset_for_spatialLIBD.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("dlpfc", "spatialDLPFC_Visium_Sp09_position_noWM", "processed-data", "sig_genes_subset_k09_position.Rdata"))
}

if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file1)
} else {
    load(here::here("dlpfc", "spatialDLPFC_Visium_Sp09_position_noWM", "processed-data", "modeling_results_position_k09.Rdata"))
}

if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    sce_pseudo <- readRDS(posit_connect_file2)
} else {
    sce_pseudo <- readRDS(here::here("dlpfc", "spatialDLPFC_Visium_Sp09_position_noWM", "processed-data", "sce_pseudo_BayesSpace_k09.rds"))
}

if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file3)
} else {
    spe <- readRDS(here::here("dlpfc", "spatialDLPFC_Visium_Sp09_position_noWM", "processed-data", "spe_subset_for_spatialLIBD.rds"))
}

spe$BayesSpace <- spe$BayesSpace_harmony_09
vars <- colnames(colData(spe))
# https://github.com/LieberInstitute/Visium_IF_AD/blob/5e3518a9d379e90f593f5826cc24ec958f81f4aa/code/05_deploy_app_wholegenome/app.R#L61-L72

colors_BayesSpace <- Polychrome::palette36.colors(28)
names(colors_BayesSpace) <- c(1:28)
m <- match(as.character(spe$BayesSpace_harmony_09), names(colors_BayesSpace))
stopifnot(all(!is.na(m)))
spe$BayesSpace_colors <- spe$BayesSpace_harmony_09_colors <- colors_BayesSpace[m]


## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = sce_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "spatialDLPFC, Visium, Sp09, position, no WM",
    spe_discrete_vars = c( # this is the variables for the spe object not the sce_pseudo object
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
        "BayesSpace_colors",
        "position"
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
    default_cluster = "position",
    docs_path = "www"
)
