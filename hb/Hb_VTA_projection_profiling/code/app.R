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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Hb_VTA_projection_profiling/VTA-sce_Top20_markers.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("hb", "Hb_VTA_projection_profiling", "processed-data", "VTA-sce_Top20_markers.rds"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/hb/Hb_VTA_projection_profiling/code/initial.R?raw=TRUE")


# Launches the iSEE interactive visualization app with the provided SCE
# The app is titled "VTA-sce_Top20_markers.rds".
# The `initial` parameter specifies the initial state of the app.
# The `colormap` parameter defines the colors for different clustering results.
iSEE(
    sce,
    appTitle = "Hb_VTA_projection_profiling",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        prelimClust.10 = function(n) {
            # Assigns colors for a clustering result with 11 clusters (k10)
            if (n == 11) {
                return(metadata(sce)$k10_clust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        },
        prelimClust.15 = function(n) {
            # Assigns colors for a clustering result with 11 clusters (k15)
            if (n == 11) {
                return(metadata(sce)$k15_clust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        },
        prelimClust.20 = function(n) {
            # Assigns colors for a clustering result with 11 clusters (k20)
            if (n == 11) {
                return(metadata(sce)$k20_clust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        }
    ))
)
