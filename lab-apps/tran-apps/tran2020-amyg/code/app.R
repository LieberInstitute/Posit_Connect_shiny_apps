
library("SingleCellExperiment")
library("iSEE")
library("shiny")
library("spatialLIBD")
library("here")
packageVersion("iSEE")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/lab-named-apps/tran2020-amyg/sce_amyg_small.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
    
} else {
    sce <- readRDS(here::here("lab-apps", "tran-apps", "tran2020-amyg", "processed-data", "sce_amyg_small.rds"))
    
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/lab-apps/tran-apps/tran2020-amyg/code/initial.R?raw=TRUE")




iSEE(sce, appTitle = "M.N. Tran et al 2020, Amyg region https://bit.ly/LIBD10xHuman", initial = initial)
