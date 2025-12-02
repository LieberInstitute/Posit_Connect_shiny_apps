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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Hb_VTA_Neu_Sub-clustering/VTA-neu_sce_sub-clustering.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    neu_sce <- readRDS(posit_connect_file)
} else {
    neu_sce <- readRDS(here::here("hb", "Hb_VTA_Neu_Sub-clustering", "processed-data", "VTA-neu_sce_sub-clustering.rds"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/hb/Hb_VTA_Neu_Sub-clustering/code/initial.R?raw=TRUE")


# Launches the iSEE interactive visualization app with the provided SCE
# The app is titled "Hb_VTA_Neu_Sub-clustering",.
# The `initial` parameter specifies the initial state of the app.
# The `colormap` parameter defines the colors for different clustering results.
iSEE(
    neu_sce,
    appTitle = "Hb_VTA_Neu_Sub-clustering",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        subclust.neu = function(n) {
            # Assigns colors for a clustering result with 7 clusters (neu_subclust)
            if (n == 7) {
                return(metadata(neu_sce)$subclust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        }
    ))
)
