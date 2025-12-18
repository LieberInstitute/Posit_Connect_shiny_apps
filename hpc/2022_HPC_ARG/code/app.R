#This will be the app file for this project
library("SingleCellExperiment")
library("iSEE")
library("spatialLIBD")
library("here")
library("paletteer")
library("scuttle")
library("shiny")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/2022_HPC_ARG/sce_iSEE.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("hpc", "2022_HPC_ARG", "processed-data", "sce_iSEE.rda"))
}



source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/hpc/2022_HPC_ARG/code/initial.R?raw=TRUE")


colData(sce) <- cbind(
    colData(sce)[, !colnames(colData(sce)) %in% c("Sample", "cellType")],
    colData(sce)[, c("cellType", "Sample")]
)

sce$Sample <- as.factor(sce$Sample)

sce <- registerAppOptions(sce, color.maxlevels = 18)
iSEE(
    sce,
    appTitle = "2022_HPC_ARG",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        Sample = function(n) {
            cols <- paletteer::paletteer_d(
                palette = "RColorBrewer::Dark2",
                n = length(unique(sce$Sample))
            )
            cols <- as.vector(cols)
            names(cols) <- levels(sce$Sample)
            return(cols)
        },
        cellType = function(n) {
            cols <- paletteer::paletteer_d(
                palette = "Polychrome::palette36",
                n = length(levels(sce$cellType))
            )
            cols <- as.vector(cols)
            names(cols) <- levels(sce$cellType)
            return(cols)
        }
    ))
)
