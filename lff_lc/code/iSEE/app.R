
#This will be the app file for this project
library("iSEE")
library("spatialLIBD")
library("here")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())


### define a custom class with a different titling scheme
setClass("CustomMetadataTable", contains = "ColumnDataTable")
setMethod(".fullName", "CustomMetadataTable", function(x) "Subset data from this table for graphs below")

setClass("CustomMetadataPlot", contains = "ColumnDataPlot")
setMethod(".fullName", "CustomMetadataTable", function(x) "Feature Assay Plot - with data filtered based upon the table at the top")

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_LC/pseudobulk/02b-iSEE_pbulkobj_FOR_SHARING.RDS"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("lff_lc", "processed-data", "02b-iSEE_pbulkobj_FOR_SHARING.RDS"))
}

#sce <- readRDS(posit_connect_file)

#load initial.R setup file for iSEE apps
#Source
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/lff_lc/code/iSEE/initial.R?raw=TRUE")
#source("initial.R")


# sce <- readRDS("sce_neuropil_spd.rds")




#rownames(sce) <- rowData(sce)$gene_name



iSEE(
    sce,
    appTitle = "LFF LC Pseudobulked data",
    initial = initial
)
