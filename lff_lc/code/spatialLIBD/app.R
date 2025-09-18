
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_LC/spatialLIBD/01-Samui_TissSect_SPE_RotsMirrors_logcounts_lowres.RDS"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("lff_lc", "processed-data", "01-Samui_TissSect_SPE_RotsMirrors_logcounts_lowres.RDS"))
}



## Quickly explore the data
vars <- colnames(colData(spe))


#colData(spe)$key <- rownames(colData(spe))
#colData(spe)$ManualAnnotation <- "NA"
rownames(spe) <- rowData(spe)$gene_id


## Colors 
# metadata(spe)$SpD_colors

#lobstr::obj_size(spe)
#1.66 GB

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
