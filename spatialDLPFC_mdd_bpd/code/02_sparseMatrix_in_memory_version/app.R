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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_mdd_bpd/processed-data/04_feature_selection/spatialDLPFC_mdd_bpd_spe.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here(
        "spatialDLPFC_mdd_bpd",
        "processed-data",
        "04_feature_selection",
        "spatialDLPFC_mdd_bpd_spe.rds"
    ))
}
# > spe
# class: SpatialExperiment
# dim: 28965 535248
# metadata(0):
# assays(1): logcounts
# rownames(28965): ENSG00000243485 ENSG00000238009 ... ENSG00000278817 ENSG00000277196
# rowData names(7): source type ... gene_type gene_search
# colnames(535248): GACCTGGTCTGGGCGT-1_V13F27-338_A1 CGTCCAGATGGCTCCA-1_V13F27-338_A1 ...
#   ACCTCAGCGAGGCGCA-1_V13B23-282_D1 GGCTGAGCATCGTAAG-1_V13B23-282_D1
# colData names(21): sample_id in_tissue ... problem_area_flag sizeFactor
# reducedDimNames(0):
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor

# > lobstr::obj_size(spe)
# 10.69 GB

spe$ManualAnnotation <- NA
vars <- colnames(colData(spe))

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "spatialDLPFC_mdd_bpd (sparseMatrix version)",
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
