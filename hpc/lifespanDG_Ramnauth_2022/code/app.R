library("HDF5Array")
library("spatialLIBD")
library("markdown")
library("here")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/lifespanDG_Ramnauth_2022/QCed_spe.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("hpc", "lifespanDG_Ramnauth_2022", "processed-data", "QCed_spe.rds"))
}



spe$CellCount <- spe$segmentation_info
spe$CellCount <- spe$NBW
vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatial_DG_lifespan, Visium",
    spe_discrete_vars = c(vars[grep("10x_", vars)], "ManualAnnotation"),
    spe_continuous_vars = c("sum_umi", "sum_gene", "expr_chrM", "expr_chrM_ratio", "CellCount"),
    default_cluster = "10x_graphclust"
)
