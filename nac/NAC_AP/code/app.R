library(spatialLIBD)
library(markdown)
library(here)
library(HDF5Array)
library(SpatialFeatureExperiment)
#library(qs2)

#   For interactive testing at JHPCE
# setwd(here('code', '12_apps_and_sharing', 'shiny_HD_app'))

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/nac/NAC_AP/VisiumHD_sfe"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- HDF5Array::loadHDF5SummarizedExperiment(posit_connect_file)
} else {
    spe <- HDF5Array::loadHDF5SummarizedExperiment(here::here("nac", "NAC_AP", "processed-data", "VisiumHD_sfe"))
}


spe = as(spe,"SpatialExperiment")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())


discrete_vars = c(
    'Sample', 'Barcode', 'sample_id', 'labels',
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

spe = as(spe,"SpatialExperiment")

colData(spe)$ManualAnnotation <- "NA"
colData(spe)$key <- rownames(colData(spe))
#rownames(spe) <- paste0(rowData(spe)$gene_name, "; ", rowData(spe)$gene_id)

rownames(spe) <- rowData(spe)$gene_id

vars <- colnames(colData(spe))

colnames(spatialCoords(spe))[colnames(spatialCoords(spe)) == "X"] <- "pxl_col_in_fullres"
colnames(spatialCoords(spe))[colnames(spatialCoords(spe)) == "Y"] <- "pxl_row_in_fullres"

#vis_gene(spe,geneid = "ENSG00000187634")

#   Load objects
#spe = qs_read('spe_shiny.qs2')
#modeling_results = qs_read('modeling_results.qs2')
#sce_pb = qs_read('sce_pb_shiny.qs2')
#sig_genes = qs_read('sig_genes_shiny.qs2')

#stopifnot(all(all_vars_pb %in% colnames(colData(sce_pb))))
#colData(sce_pb) = colData(sce_pb)[, all_vars_pb]

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
    docs_path = 'www'
)

#SpatialExperiment::readImgData
#SpatialExperiment::readImgData(spe)

#spe1 <- readRDS(here::here("nac", "NAC_AP", "processed-data", "spe_norm.Rds"))


#("gene_id", "gene_name", "gene_search")
#"ID"     "Symbol"
#rowData(spe1)
#colnames(rowData(spe))
