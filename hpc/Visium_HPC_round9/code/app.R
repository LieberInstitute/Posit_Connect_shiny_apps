library("HDF5Array")
library("spatialLIBD")
library("markdown")
library("here")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/Visium_HPC_round9/spe_round9.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("hpc", "Visium_HPC_round9", "processed-data", "spe_round9.rds"))
}

# speB$BayesSpace <- speB$spatial.cluster
# speB$BayesSpace_initial <- speB$cluster.init
vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "Visium HPC_round9",
    spe_discrete_vars = c(
        vars[grep("^10x_", vars)],
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "10x_graphclust"
)
