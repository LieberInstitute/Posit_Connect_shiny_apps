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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Hb_Cg_projection_profiling/Hb_Cg_sce.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("hb", "Hb_Cg_projection_profiling", "processed-data", "Hb_Cg_sce.rds"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/hb/Hb_Cg_projection_profiling/code/initial.R?raw=TRUE")


iSEE(
    sce,
    appTitle = "Hb_Cg_projection_profiling",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        prelimClust.10 = function(n) {
            # Assigns colors for a clustering result with 17 clusters (k10)
            if (n == 17) {
                return(metadata(sce)$k10_clust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        },
        prelimClust.15 = function(n) {
            # Assigns colors for a clustering result with 10 clusters (k15)
            if (n == 10) {
                return(metadata(sce)$k15_clust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        },
        prelimClust.20 = function(n) {
            # Assigns colors for a clustering result with 13 clusters (k20)
            if (n == 13) {
                return(metadata(sce)$k20_clust.colors)
            } else {
                return(rep("#000000", n))  # Default color
            }
        }
    ))
)
