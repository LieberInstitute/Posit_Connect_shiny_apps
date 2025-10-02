#This will be the app file for this project
library("SingleCellExperiment")
library("iSEE")
library("spatialLIBD")
library("here")
library("paletteer")
library("scuttle")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/pfc-projectors/sce.Rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)

} else {
    sce <- readRDS(here::here("pfc-projectors", "processed-data", "sce.Rds"))

}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/pfc-projectors/code/initial.R?raw=TRUE")


#Deploy app
iSEE(
    sce,
    appTitle = "PFC - Projectors",
    initial = initial

)
