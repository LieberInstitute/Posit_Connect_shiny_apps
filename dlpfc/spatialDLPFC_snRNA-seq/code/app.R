
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library("SingleCellExperiment")
library("iSEE")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_snRNA-seq/sce"
repo_local_dir <- here::here(
    "dlpfc", "spatialDLPFC_snRNA-seq", "processed-data", "sce"
)
if (file.exists(posit_connect_dir)) {
    ## Location for the https://conn1.libd.org/ server
    dir_to_use <- posit_connect_dir
} else {
    dir_to_use <- repo_local_dir
}

sce <- loadHDF5SummarizedExperiment(
    dir = dir_to_use
)

cell_type_colors <- metadata(sce)$cell_type_colors_layer[levels(sce$cellType_layer)]

source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/dlpfc/spatialDLPFC_snRNA-seq/code/initial.R?raw=TRUE")


## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce) <- cbind(
    colData(sce)[, !colnames(colData(sce)) %in% c("Sample", "cellType_layer")],
    colData(sce)[, c("cellType_layer", "Sample")]
)

sce$Sample <- as.factor(sce$Sample)

sce <- registerAppOptions(sce, color.maxlevels = length(cell_type_colors))

iSEE(
    sce,
    appTitle = "spatialDLPFC, snRNA-seq",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        # Sample = function(n) {
        #     cols <- paletteer::paletteer_d(
        #         palette = "RColorBrewer::Dark2",
        #         n = length(unique(sce$Sample))
        #     )
        #     cols <- as.vector(cols)
        #     names(cols) <- levels(sce$Sample)
        #     return(cols)
        # },
        cellType_layer = function(n) {
            return(cell_type_colors)
        }
    ))
)
