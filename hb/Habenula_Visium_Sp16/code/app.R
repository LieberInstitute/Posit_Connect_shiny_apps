
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp16/sig_genes_subset_k16.Rdata"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp16/modeling_results_BayesSpace_k16.Rdata"
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp16/sce_pseudo_BayesSpace_k16.rds"
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_Sp16/spe_subset_for_spatialLIBD.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("hb", "Habenula_Visium_Sp16", "processed-data", "sig_genes_subset_k16.Rdata"))
}

if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file1)
} else {
    load(here::here("hb", "Habenula_Visium_Sp16", "processed-data", "modeling_results_BayesSpace_k16.Rdata"))
}

if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    sce_pseudo <- readRDS(posit_connect_file2)
} else {
    sce_pseudo <- readRDS(here::here("hb", "Habenula_Visium_Sp16", "processed-data", "sce_pseudo_BayesSpace_k16.rds"))
}

if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file3)
} else {
    spe <- readRDS(here::here("hb", "Habenula_Visium_Sp16", "processed-data", "spe_subset_for_spatialLIBD.rds"))
}


colnames(colData(spe))
BayesSpace_k <- 16
spe <- cluster_import(spe,
                      cluster_dir = "clusters_BayesSpace",
                      prefix = ""
)

spe$BayesSpace <- spe$BayesSpace_harmony_k16

## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)

colors_BayesSpace <- Polychrome::palette36.colors(28)
names(colors_BayesSpace) <- c(1:28)
m <- match(as.character(spe$BayesSpace_harmony_k16), names(colors_BayesSpace))
stopifnot(all(!is.na(m)))
spe$BayesSpace_colors <- spe$BayesSpace_harmony_k16_colors <- colors_BayesSpace[m]

spatialLIBD::run_app(
    spe,
    sce_layer = sce_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "spatialHabenula, Visium, Sp16",
    spe_discrete_vars = c( ## this is the variables for the spe object not the sce_pseudo object
        "BayesSpace",
        "ManualAnnotation",
        "overlaps_tissue",
        vars[grep("^10x_", vars)],
        vars[grep("^scran_", vars)],
        "edge_spots",
        vars[grep("^SNN_k10", vars)],
        # vars[grep("^BayesSpace_pca", vars)],
        vars[grep("^BayesSpace_harmony_", vars)],
        "BayesSpace_colors"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "edge_distance"
    ),
    default_cluster = "BayesSpace", #"10x_graphclust",
    docs_path = "www"
)
