library("ExperimentHub")
library("here")
library("lobstr")
library("sessioninfo")

## Download the SPE object using the instructions from
## https://bioconductor.org/packages/devel/data/experiment/vignettes/humanHippocampus2024/inst/doc/humanHippocampus2024.html
ehub <- ExperimentHub()
myfiles <- query(ehub, "humanHippocampus2024")
spatial_hpc_spe <- myfiles[["EH9605"]]
spatial_hpc_spe
# class: SpatialExperiment
# dim: 31483 150917
# metadata(1): Obtained_from
# assays(2): counts logcounts
# rownames(31483): MIR1302-2HG AL627309.1 ... AC007325.4 AC007325.2
# rowData names(7): source type ... gene_type gene_search
# colnames(150917): AAACAACGAATAGTTC-1_V10B01-086_D1 AAACAAGTATCTCCCA-1_V10B01-086_D1 ...
#   TTGTTTCCATACAACT-1_Br2720_B1 TTGTTTGTATTACACG-1_Br2720_B1
# colData names(150): sample_id in_tissue ... nmf99 nmf100
# reducedDimNames(3): 10x_pca 10x_tsne 10x_umap
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor
lobstr::obj_size(spatial_hpc_spe)
# 8.81 GB

## Code adapted from
## https://github.com/LieberInstitute/spatialDLPFC/blob/53fcbf53ec3e03ac41083812695d62b678ea57e4/code/analysis/01_build_spe/03_add_deconvolution.R#L228C1-L238

## Start removing pieces for the shiny apps
imgData(spatial_hpc_spe) <- imgData(spatial_hpc_spe)[imgData(spatial_hpc_spe)$image_id == "lowres", ]
lobstr::obj_size(spatial_hpc_spe)
# 5.52 GB

## Drop the counts which take quite a bit of space
counts(spatial_hpc_spe) <- NULL
## Check the size in GB
lobstr::obj_size(spatial_hpc_spe)
# 2.92 GB

spatial_hpc_spe
# class: SpatialExperiment
# dim: 31483 150917
# metadata(1): Obtained_from
# assays(1): logcounts
# rownames(31483): MIR1302-2HG AL627309.1 ... AC007325.4 AC007325.2
# rowData names(7): source type ... gene_type gene_search
# colnames(150917): AAACAACGAATAGTTC-1_V10B01-086_D1 AAACAAGTATCTCCCA-1_V10B01-086_D1 ...
#   TTGTTTCCATACAACT-1_Br2720_B1 TTGTTTGTATTACACG-1_Br2720_B1
# colData names(150): sample_id in_tissue ... nmf99 nmf100
# reducedDimNames(3): 10x_pca 10x_tsne 10x_umap
# mainExpName: NULL
# altExpNames(0):
# spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
# imgData names(4): sample_id image_id data scaleFactor

## Save later use
saveRDS(
  spatial_hpc_spe,
  file = here("spatial_hpc", "processed-data", "spatial_hpc_spe.rds")
)

## Reproducibility information
print("Reproducibility information:")
Sys.time()
proc.time()
options(width = 120)
session_info()
