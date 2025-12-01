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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dACC/snRNAseq_dACC/sce_azimuth_logcounts.Rdata"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
    #sce <- rda.baboon
    #rm(rda.baboon)
} else {
    load(here::here("dACC", "snRNAseq_dACC", "processed-data", "sce_azimuth_logcounts.Rdata"))
    #sce <- rda.baboon
    #rm(rda.baboon)
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/dACC/snRNAseq_dACC/code/initial.R?raw=TRUE")


colData(sce) <- cbind(
    colData(sce)[, !colnames(colData(sce)) %in% c("Sample", "round")],
    colData(sce)[, c("round", "Sample")]
)

sce$Sample <- as.factor(sce$Sample)

#Deploy app
iSEE(
    sce,
    appTitle = "snRNAseq_dACC",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        Sample = function(n) {
            cols <- paletteer::paletteer_d(
                palette = "RColorBrewer::Dark2",
                n = length(unique(sce$Sample))
            )
            cols <- as.vector(cols)
            names(cols) <- levels(sce$Sample)
            return(cols)
        }
        # ,
        # cellType.final = function(n) {
        #     return(cell_cols.clean)
        # }
    ))
)
