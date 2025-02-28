library("spatialLIBD")
library("HDF5Array")
library("markdown") ## Hm... to avoid this error
# 2021-11-11T05:30:49.941401+00:00 shinyapps[5096402]: Listening on http://127.0.0.1:32863
# 2021-11-11T05:30:50.218127+00:00 shinyapps[5096402]: Warning: Error in loadNamespace: there is no package called ‘markdown’
# 2021-11-11T05:30:50.222437+00:00 shinyapps[5096402]:   111: <Anonymous>

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data that has colData info
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/04_feature_selection"
rep_local_dir <- here::here(
    "spatialDLPFC_mdd_bpd/processed-data/04_feature_selection"
)
if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else if (file.exists(repo_local_dir)) {
    dir_to_use <- rep_local_dir
} else {
    dir_to_use <- getwd()
}

spe <- loadHDF5SummarizedExperiment(
    dir = dir_to_use,
    prefix = "spe_n120_postQC_norm_"
)

## Load the data that has images
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/02_build_spe"
rep_local_dir <- here::here(
    "spatialDLPFC_mdd_bpd/processed-data/02_build_spe"
)

if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else if (file.exists(repo_local_dir)) {
    dir_to_use <- rep_local_dir
} else {
    dir_to_use <- getwd()
}

spe_with_images <- loadHDF5SummarizedExperiment(
    dir = dir_to_use,
    prefix = "spe_n120_imgs_"
)

## Merge the two objects
m <- match(imgData(spe)$sample_id, imgData(spe_with_images)$sample_id)
stopifnot(!any(is.na(m)))

imgData(spe) <- imgData(spe_with_images)[m, ]
rm(spe_with_images)

spe$ManualAnnotation <- NA
vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatialDLPFC_mdd_bpd",
    spe_discrete_vars = c(
        vars[grep("^10x_", vars)],
        "problem_area_flag",
        "ManualAnnotation"
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "problem_area_flag"
)
