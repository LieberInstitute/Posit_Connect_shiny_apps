library("iSEE")
library("spatialLIBD")
library("here")
#library("devtools")
library("HDF5Array")
library("scuttle")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_dir <- "/r_data/lcollado/Posit_Connect_shiny_apps/bla-crossspecies/bla-crossspecies/sce_app"
repo_local_dir <- here::here(
    "bla-crossSpecies", "bla_crossSpecies", "processed-data", "sce_app"
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

#Change the rownames frome ensembl id to gene_name
#rownames(sce) <-  uniquifyFeatureNames(rowData(sce)$gene_id, rowData(sce)$gene_name)


#Source
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/bla-crossSpecies/bla_crossSpecies/code/initial.R?raw=TRUE")
#source("initial.R", print.eval = TRUE)


#Deploy app
iSEE(
    sce,
    appTitle = "BLA Cross Species - snRNA",
    initial = initial
)


