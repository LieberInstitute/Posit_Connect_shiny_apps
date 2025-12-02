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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/LS/LS_snRNAseq/sce_app.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("LS", "LS_snRNAseq", "processed-data", "sce_app.rda"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/LS/LS_snRNAseq/code/initial.R?raw=TRUE")

#Change the rownames frome ensembl id to gene_name
rownames(sce) <-  uniquifyFeatureNames(rowData(sce)$gene_id, rowData(sce)$gene_name)
#Increase minimum number of colors to the # of clusters within CellType.Final
sce <- registerAppOptions(sce, color.maxlevels = length(unique(sce$CellType.Final)))


#Deploy app
iSEE(
    sce,
    appTitle = "LS snRNAseq data",
    initial = initial
)
