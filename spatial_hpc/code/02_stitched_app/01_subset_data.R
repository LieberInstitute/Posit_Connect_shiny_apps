library("SpatialExperiment")
library("here")
library("sessioninfo")

## Load data
load(
  here::here(
    "spatial_hpc/processed-data/06_clustering/PRECAST/spe_norm_norm_with_domain.rda"
  ),
  verbose = TRUE
)
spe_norm
# class: SpatialExperiment
# dim: 31483 188762
# metadata(0):
# assays(2): counts logcounts
# rownames(31483): MIR1302-2HG AL627309.1 ... AC007325.4 AC007325.2
# rowData names(7): source type ... gene_type gene_search
# colnames(188762): AAACAACGAATAGTTC-1_V10B01-086_D1 AAACAAGTATCTCCCA-1_V10B01-086_D1 ...
#   TTGTTTGTATTACACG-1_V12D07-335_A1_Br8325 TTGTTTGTGTAAATTC-1_V12D07-335_A1_Br8325
# colData names(47): sample_id in_tissue ... sizeFactor domain
# reducedDimNames(3): 10x_pca 10x_tsne 10x_umap
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor

## Check size of the object
lobstr::obj_size(spe_norm)
# 13.97 GB

## Start removing pieces for the shiny apps
imgData(spe_norm) <- imgData(spe_norm)[imgData(spe_norm)$image_id == "lowres", ]
lobstr::obj_size(spe_norm)
# 9.94 GB

## Drop the counts which take quite a bit of space
counts(spe_norm) <- NULL
## Check the size in GB
lobstr::obj_size(spe_norm)
# 6.31 GB

spe_norm
# class: SpatialExperiment
# dim: 31483 188762
# metadata(0):
# assays(1): logcounts
# rownames(31483): MIR1302-2HG AL627309.1 ... AC007325.4 AC007325.2
# rowData names(7): source type ... gene_type gene_search
# colnames(188762): AAACAACGAATAGTTC-1_V10B01-086_D1 AAACAAGTATCTCCCA-1_V10B01-086_D1 ...
#   TTGTTTGTATTACACG-1_V12D07-335_A1_Br8325 TTGTTTGTGTAAATTC-1_V12D07-335_A1_Br8325
# colData names(47): sample_id in_tissue ... sizeFactor domain
# reducedDimNames(3): 10x_pca 10x_tsne 10x_umap
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor

## Save later use
saveRDS(
  spe_norm,
  file = here(
    "spatial_hpc",
    "processed-data",
    "06_clustering",
    "PRECAST",
    "spe_norm_with_domain_filtered.rds"
  )
)

## Reproducibility information
print("Reproducibility information:")
Sys.time()
proc.time()
options(width = 120)
session_info()
