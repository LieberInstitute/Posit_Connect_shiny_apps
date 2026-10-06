
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

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/spe_pseudobulk-SpD.rds"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pb_k09 <- readRDS(posit_connect_file1)
} else {
    spe_pb_k09 <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "spe_pseudobulk-SpD.rds"))
}
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/modeling_results-SpD.rds"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    modeling_results_k09 <- readRDS(posit_connect_file2)
} else {
    modeling_results_k09 <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "modeling_results-SpD.rds"))
}
posit_connect_file3 <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_postQC/sig_genes_SpD.rds"
if (file.exists(posit_connect_file3)) {
    ## Location for the https://conn1.libd.org/ server
    sig_genes_k09 <- readRDS(posit_connect_file3)
} else {
    sig_genes_k09 <- readRDS(here::here("dlpfc", "DLPFC_ASD_postQC", "processed-data", "sig_genes_SpD.rds"))
}


## define spatialLIBD column
spe_pb_k09$spatialLIBD <- spe_pb_k09$SpD
#spe_pb_k09$spatialLIBD <- spe_pb_k09$BayesSpace_PCA_Harmony_k09


## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)
#vars
#colnames(colData(spe))
#getwd()

## add names to colors
names(spe_pb_k09$SpD_colors) <- spe_pb_k09$SpD

## code to fix geneset heatmap with pairwise test colors
SpD_colors <- spe_pb_k09$SpD_colors
names(SpD_colors) <- spe_pb_k09$SpD

pairwise_tests <- sub(
    "^t_stat_",
    "",
    grep("^t_stat_", colnames(modeling_results_k09$pairwise), value = TRUE)
)

pairwise_colors <- setNames(
    vapply(
        pairwise_tests,
        function(x) {
            groups <- strsplit(x, "-", fixed = TRUE)[[1]]

            grDevices::colorRampPalette(
                c(SpD_colors[groups[1]], SpD_colors[groups[2]])
            )(3)[2]
        },
        character(1)
    ),
    pairwise_tests
)

SpD_colors <- c(
    SpD_colors,
    pairwise_colors
)

length(SpD_colors) # 180
setMethod(
    "[[",
    signature(x = "SpatialExperiment", i = "character", j = "missing"),
    function(x, i, j) {
        if (length(i) == 1 && i == "SpD_colors") {
            return(SpD_colors)
        }

        callNextMethod()
    }
)

length(spe_pb_k09[["SpD_colors"]]) # 180

length(colData(spe_pb_k09)$SpD_colors) # 144

## drop the 10x reduced dims
reducedDims(spe)$`10x_pca` <- NULL
reducedDims(spe)$`10x_tsne` <- NULL
reducedDims(spe)$`10x_umap` <- NULL
reducedDims(spe_pb_k09)$`10x_pca` <- NULL
reducedDims(spe_pb_k09)$`10x_tsne` <- NULL
reducedDims(spe_pb_k09)$`10x_umap` <- NULL


# model_colors <- c("#FE00FA", "#1CFFCE", "#B00068", "#2ED9FF", "#E4E1E3", "#FEAF16", "#3283FE", "#90AD1C", "#F6222E", "#16FF32")
# names(model_colors) <- levels(spe$SpD)
spe_discrete_vars = c(
    #"ManualAnnotation",
    "in_tissue",
    #vars[grep("^10x_", vars)],
    #vars[grep("^scran_", vars)],
    #"scran_low_lib_size_edge",
    #"scran_qc_anno",
    #"ss_qc_anno", #vars[grep("^ss_", vars)],
    #"qc_anno_all",#vars[grep("^qc_", vars)],
    #"local_outliers",
    "sample_processing",
    "SpD",
    sprintf("BayesSpace_PCA_Harmony_k%02d", 2:28),
    #"SpD_colors",
    "num_nuclei_within",
    "num_nuclei_intersect",
    "num_nuclei_centroid_within"
)

spatialLIBD::run_app(
    spe = spe,
    sce_layer = spe_pb_k09,
    modeling_results = modeling_results_k09,
    sig_genes = sig_genes_k09,
    spe_discrete_vars = spe_discrete_vars,
    title = "DLPFC ASD, Visium CytAssist, Sp09",
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

## Note. If fails to read the rds object, go to Session Menu -> Set Working Directory -> To source File location
