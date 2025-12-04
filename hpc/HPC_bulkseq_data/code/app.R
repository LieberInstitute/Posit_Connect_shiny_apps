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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/HPC_bulkseq_data/spe_pseudo.rda"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hpc/HPC_bulkseq_data/spatial_palettes_isee.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("hpc", "HPC_bulkseq_data", "processed-data", "spe_pseudo.rda"))
}
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file1)
} else {
    load(here::here("hpc", "HPC_bulkseq_data", "processed-data", "spatial_palettes_isee.rda"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/hpc/HPC_bulkseq_data/code/initial.R?raw=TRUE")


#rse_gene <- registerAppOptions(rse_gene, color.maxlevels = length(Sample_ID)
iSEE(
    spe_pseudo,
    appTitle = "pseudobulk HPC spatial data",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        domain = function(n) {
            cols <- spatial.palette
        },
        broad.domain = function(n) {
            cols <- spatial.palette2
        }

    ))
)
