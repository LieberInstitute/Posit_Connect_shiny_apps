library("HDF5Array")
library("spatialLIBD")
library("markdown")
library("here")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
#spe <- loadHDF5SummarizedExperiment("spe_shiny")
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatial-nac/processed-data/spatialLIBD/spe_shiny"
repo_local_dir <- here::here(
    "spatialNAC/processed-data/spatialLIBD/spe_shiny"
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

#docs_path = here("spatialNAC", "code", "spatialLIBD", "www")

#spe_name <- here("spatialNAC", "code", "spatialLIBD", "spe_shiny.rds")
#spe1 <- readRDS(spe_name)
vars <- colnames(colData(spe))
spe$exclude_overlapping <- as.factor(spe$exclude_overlapping)
rownames(spe) <- rowData(spe)$gene_id



## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "Spatial NAc",
    spe_discrete_vars = c(
        vars[grep("^scran_", vars)],
        vars[grep("^X10x_", vars)],
        "exclude_overlapping",
        "ManualAnnotation",
        vars[grep("^PRECAST_K", vars)],
        "spatial_domains"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "Nmask_dark_blue",
        "edge_distance",
        "Oligo",
        "DRD1_MSN_A",
        "DRD1_MSN_B",
        "DRD1_MSN_C",
        "DRD1_MSN_D",
        "DRD2_MSN_A",
        "DRD2_MSN_B",
        vars[grep("^Inh_", vars)],
        "Excitatory",
        "Endothelial",
        "Microglia",
        "Ependymal",
        "Astrocyte_A",
        "Astrocyte_B",
        vars[grep("^MERINGUE", vars)],
        vars[grep("^human_snRNA_nmf", vars)],
        vars[grep("^morphine_volitional_nmf", vars)],
        vars[grep("^morphine_acute_nmf", vars)],
        vars[grep("^cocaine_acute_nmf", vars)]
        
    ),
    default_cluster = "X10x_graphclust",
    auto_crop_default = FALSE,
    docs_path = "www"
)
