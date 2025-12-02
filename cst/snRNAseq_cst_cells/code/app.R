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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/cst/snRNAseq_cst_cells/sce-app.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("cst", "snRNAseq_cst_cells", "processed-data", "sce-app.rds"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/cst/snRNAseq_cst_cells/code/initial.R?raw=TRUE")


#Increase minimum number of colors to the # of clusters within CellType.Final
sce <- registerAppOptions(sce, color.maxlevels = length(unique(sce$lieden_k25)))

#Deploy app
iSEE(
    sce,
    appTitle = "CST snRNAseq data",
    initial = initial
)
