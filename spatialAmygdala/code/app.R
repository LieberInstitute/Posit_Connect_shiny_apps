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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialAmygdala/processed-data/Visium/03_qc_metrics/spe_stitched_local_outliers.Rdata"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file, verbose = TRUE)
} else {
    load(here::here("spatialAmygdala/processed-data/Visium/03_qc_metrics/spe_stitched_local_outliers.Rdata"), verbose = TRUE)
}

vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatialDLPFC_mdd_bpd (sparseMatrix version)",
    spe_discrete_vars = c(
        vars[grep("^X10x_", vars)],
        "local_outliers",
        "exclude_overlapping",
        "sum_umi_outliers",
        "sum_gene_outliers",
        "expr_chrM_ratio_outliers",
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "sum_umi_log",
        "sum_gene_log",
        "sum_umi_z",
        "expr_chrM_ratio_z",
        "sum_gene_z"
    ),
    default_cluster = "X10x_graphclust",
    auto_crop_default = FALSE,
    is_stitched = TRUE
)
