
#This will be the app file for this project
library("iSEE")
library("spatialLIBD")
library("here")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_LC/pseudobulk/02-iSEE_pbulkobj.RDS"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("lff_lc", "processed-data", "02-iSEE_pbulkobj.RDS"))
}

#sce <- readRDS(posit_connect_file)

#load initial.R setup file for iSEE apps
#Source
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/lff_lc/code/iSEE/initial.R?raw=TRUE")



# sce <- readRDS("sce_neuropil_spd.rds")




#rownames(sce) <- rowData(sce)$gene_name



iSEE(
    sce,
    appTitle = "LFF LC Pseudobulked data",
    initial = initial
)