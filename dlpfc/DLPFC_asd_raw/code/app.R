
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_asd_raw/QC_spe_raw_app.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("dlpfc", "DLPFC_asd_raw", "processed-data", "QC_spe_raw_app.rds"))
}




#spe
## Quickly explore the data
vars <- colnames(colData(spe))
colnames(colData(spe)) <- vars <- gsub("X10x", "10x", vars)


spatialLIBD::run_app(
    spe = spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    spe_discrete_vars = c(
        #"ManualAnnotation",
        vars[grep("^Manual", vars)],
        "overlaps_tissue",
        vars[grep("^10x_", vars)],
        vars[grep("^scran_q", vars)],
        vars[grep("^ss_", vars)],
        vars[grep("^qc_", vars)],
        vars[grep("^scran_high_lib", vars)]
        # vars[grep("^SNN_k10", vars)],
        # vars[grep("^BayesSpace_harmony_", vars)]
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "edge_distance",
        "scran_low_lib_size",
        "scran_low_n_features"
    ),
    default_cluster = "10x_graphclust",
    docs_path = "www"
)


## Note. If fails to read the rds object, go to Session Menu -> Set Working Directory -> To source File location
