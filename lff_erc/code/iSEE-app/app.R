
#This will be the app file for this project
library("iSEE")
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())


#sce <- readRDS("sce_ERC_iSEE.rds")
#sn_colors <- readRDS("sn_colors.rds")


## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_ERC/isee/sce_ERC_iSEE.rds"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/lff_ERC/isee/sn_colors.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("lff_erc/processed-data/iSEE-app/sce_ERC_iSEE.rds"))
}

if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    sn_colors <- readRDS(posit_connect_file1)
} else {
    sn_colors <- readRDS(here::here("lff_erc/processed-data/iSEE-app/sn_colors.rds"))
}


#Change the rownames frome ensembl id to gene_name
rownames(sce) <-  uniquifyFeatureNames(rowData(sce)$gene_id, rowData(sce)$gene_name)

sce <- registerAppOptions(sce, color.maxlevels = 38)

#Source
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/lff_erc/code/iSEE-app/initial.R?raw=TRUE")
#source("initial.R", print.eval = TRUE)

#Increase minimum number of colors to the # of clusters within CellType.Final
sce <- registerAppOptions(sce, color.maxlevels = length(unique(sce$CellType.Final)))

#Deploy app
iSEE(
    sce,
    appTitle = "LFF-ERC snRNAseq data",
    initial = initial
)
