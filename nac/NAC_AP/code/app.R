library(spatialLIBD)
library(markdown)
library(here)
library(HDF5Array)
library(SpatialFeatureExperiment)
#library(qs2)

#   For interactive testing at JHPCE
# setwd(here('code', '12_apps_and_sharing', 'shiny_HD_app'))

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/nac/NAC_AP/VisiumHD_spe"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- HDF5Array::loadHDF5SummarizedExperiment(posit_connect_file)
} else {
    spe <- HDF5Array::loadHDF5SummarizedExperiment(here::here("nac", "NAC_AP", "processed-data", "VisiumHD_spe"))
}


#spe = as(spe,"SpatialExperiment")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())


discrete_vars = c(
    'Sample', 'Barcode', 'sample_id', 'labels', "log10_sum",
    'pruned.labels', 'snRNA_label', 'Spatial_Domain', 'spatial_0.4'
)
continuous_vars = c(
    'sum', 'detected', 'subsets_mt_percent', 'delta.next', 'label_score'
)
#all_vars_pb = c(
#    'cell_type', 'cell_type_colors', 'sum_umi', 'sum_gene', 'expr_chrM',
#    'expr_chrM_ratio', 'ncells', 'sample_id', 'donor'
#)

colnames(rowData(spe))[colnames(rowData(spe)) == "ID"] <- "gene_id"
colnames(rowData(spe))[colnames(rowData(spe)) == "Symbol"] <- "gene_name"
rowData(spe)$gene_search <- paste0(rowData(spe)$gene_name, "; ", rowData(spe)$gene_id)
#rowData(spe)$gene_search <- rowData(spe)$gene_id

#spe = as(spe,"SpatialExperiment")

colData(spe)$ManualAnnotation <- "NA"
colData(spe)$key <- rownames(colData(spe))
#rownames(spe) <- paste0(rowData(spe)$gene_name, "; ", rowData(spe)$gene_id)

rownames(spe) <- rowData(spe)$gene_id



colnames(spatialCoords(spe))[colnames(spatialCoords(spe)) == "X"] <- "pxl_col_in_fullres"
colnames(spatialCoords(spe))[colnames(spatialCoords(spe)) == "Y"] <- "pxl_row_in_fullres"
spe$array_row = as.integer(seq(0, 3000, length.out = ncol(spe)))
spe$array_col = as.integer(seq(0, 3000, length.out = ncol(spe)))
spe$exclude_overlapping = FALSE

vars <- colnames(colData(spe))


## Deploy the website
run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "NAC_AP_Visium_HD",
    spe_discrete_vars = discrete_vars,
    spe_continuous_vars = continuous_vars,
    default_cluster = "Spatial_Domain",
    is_stitched = TRUE,
    docs_path = 'www'
)

