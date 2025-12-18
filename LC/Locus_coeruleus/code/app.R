
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/LC/Locus_coeruleus/LC_Shiny.RData"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("LC", "Locus_coeruleus", "processed-data", "LC_Shiny.RData"))
}



docs_path <- "www"


## Deploy the app
spatialLIBD::run_app(
    spe = spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    docs_path = docs_path,
    title = "Locus coeruleus",
    spe_discrete_vars = c(
        "all",
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "counts_DBH",
        "counts_TH",
        "counts_SLC6A2",
        "logcounts_DBH",
        "logcounts_TH",
        "logcounts_SLC6A2"
    ),
    default_cluster = "all"
)

