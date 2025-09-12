
#This will be the app file for this project
library("iSEE")
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("scuttle")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatial-nac/processed-data/iSEE/sce_isee"
repo_local_dir <- here::here(
    "spatialNAC/processed-data/iSEE-app/sce_isee"
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

#load("sce.Rdata", verbose = TRUE)
#sce <- readRDS(file = "sce_NAc_app.Rds")
#load("sce_for_iSEE_LS.rda", verbose = TRUE)

#Change the rownames frome ensembl id to gene_name
rownames(sce) <-  uniquifyFeatureNames(rowData(sce)$gene_id, rowData(sce)$gene_name)

#Source
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/spatialNAC/code/iSEE-app/initial.R?raw=TRUE")
#source("initial.R", print.eval = TRUE)

#Increase minimum number of colors to the # of clusters within CellType.Final
sce <- registerAppOptions(sce, color.maxlevels = length(unique(sce$CellType.Final)))

#Deploy app
iSEE(
    sce,
    appTitle = "NAc snRNAseq data",
    initial = initial
)
