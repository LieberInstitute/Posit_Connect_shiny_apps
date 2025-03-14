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
repo_local_dir <- here::here(
    "spatialDLPFC_mdd_bpd/processed-data/04_feature_selection"
)
if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else if (file.exists(repo_local_dir)) {
    dir_to_use <- repo_local_dir
} else {
    dir_to_use <- getwd()
}

spe <- loadHDF5SummarizedExperiment(
    dir = dir_to_use,
    prefix = "spe_n120_postQC_norm_"
)
# > lobstr::obj_size(spe)
# 154.04 MB

# > spe
# class: SpatialExperiment
# dim: 28965 535248
# metadata(0):
# assays(2): counts logcounts
# rownames(28965): ENSG00000243485 ENSG00000238009 ... ENSG00000278817 ENSG00000277196
# rowData names(7): source type ... gene_type gene_search
# colnames(535248): GACCTGGTCTGGGCGT-1_V13F27-338_A1 CGTCCAGATGGCTCCA-1_V13F27-338_A1 ... ACCTCAGCGAGGCGCA-1_V13B23-282_D1
#   GGCTGAGCATCGTAAG-1_V13B23-282_D1
# colData names(21): sample_id in_tissue ... problem_area_flag sizeFactor
# reducedDimNames(0):
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor

# > system(paste0("ls -lh ", repo_local_dir, "/spe_n120_postQC_norm_*"))
# -rw-r-----@ 1 leocollado  staff    13G Feb 26 17:04 /Users/leocollado/Dropbox/Code/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/04_feature_selection/spe_n120_postQC_norm_assays.h5
# -rw-r-----@ 1 leocollado  staff    25M Feb 26 17:11 /Users/leocollado/Dropbox/Code/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/04_feature_selection/spe_n120_postQC_norm_se.rds

## Load the data that has images
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/02_build_spe"
repo_local_dir <- here::here(
    "spatialDLPFC_mdd_bpd/processed-data/02_build_spe"
)

if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else if (file.exists(repo_local_dir)) {
    dir_to_use <- repo_local_dir
} else {
    dir_to_use <- getwd()
}

spe_with_images <- loadHDF5SummarizedExperiment(
    dir = dir_to_use,
    prefix = "spe_n120_imgs_"
)
# > lobstr::obj_size(spe_with_images)
# 505.20 MB

# > spe_with_images
# class: SpatialExperiment
# dim: 36601 599034
# metadata(0):
# assays(1): counts
# rownames(36601): ENSG00000243485 ENSG00000237613 ... ENSG00000278817 ENSG00000277196
# rowData names(7): source type ... gene_type gene_search
# colnames(599034): AAACAACGAATAGTTC-1_V13B23-380_C1 AAACAAGTATCTCCCA-1_V13B23-380_C1 ... TTGTTTGTATTACACG-1_V13B23-340_A1
#   TTGTTTGTGTAAATTC-1_V13B23-340_A1
# colData names(19): sample_id in_tissue ... MBv_sample round
# reducedDimNames(0):
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor

# > system(paste0("ls -lh ", repo_local_dir, "/spe_n120_imgs_*"))
# -rw-r-----@ 1 leocollado  staff   1.4G Feb 27 09:14 /Users/leocollado/Dropbox/Code/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/02_build_spe/spe_n120_imgs_assays.h5
# -rw-r-----@ 1 leocollado  staff   115M Feb 27 09:14 /Users/leocollado/Dropbox/Code/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/02_build_spe/spe_n120_imgs_se.rds

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
