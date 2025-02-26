library("spatialLIBD")
library("markdown") ## Hm... to avoid this error
# 2021-11-11T05:30:49.941401+00:00 shinyapps[5096402]: Listening on http://127.0.0.1:32863
# 2021-11-11T05:30:50.218127+00:00 shinyapps[5096402]: Warning: Error in loadNamespace: there is no package called ‘markdown’
# 2021-11-11T05:30:50.222437+00:00 shinyapps[5096402]:   111: <Anonymous>

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatial_hpc/processed-data/spatial_hpc_spe.rds"
if (file.exists(posit_connect_file)) {
  ## Location for the https://conn1.libd.org/ server
  spe <- readRDS(posit_connect_file)
} else {
  spe <- readRDS(here::here("spatial_hpc", "processed-data", "spatial_hpc_spe.rds"))
}

vars <- colnames(colData(spe))
rownames(spe) <- rowData(spe)$gene_id

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatial_hpc from humanHippocampus2024",
    spe_discrete_vars = c(
        vars[grep("^10x_", vars)],
        "cluster",
        "neuron_cell_body",
        "domain",
        "broad.domain",
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        vars[grep("^nmf", vars)]
    ),
    default_cluster = "cluster",
    docs_path = "www",
    auto_crop_default = FALSE
)
