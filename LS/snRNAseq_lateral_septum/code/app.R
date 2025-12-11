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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/LS/snRNAseq_lateral_septum/sce_for_iSEE_LS.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("LS", "snRNAseq_lateral_septum", "processed-data", "sce_for_iSEE_LS.rda"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/LS/snRNAseq_lateral_septum/code/initial.R?raw=TRUE")

## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce.ls.small) <- cbind(
    colData(sce.ls.small)[, !colnames(colData(sce.ls.small)) %in% c("Sample", "cellType.final")],
    colData(sce.ls.small)[, c("cellType.final", "Sample")]
)

sce.ls.small$Sample <- as.factor(sce.ls.small$Sample)

sce.ls.small <- registerAppOptions(sce.ls.small, color.maxlevels = length(cell_cols.clean))

iSEE(
    sce.ls.small,
    appTitle = "snRNAseq_lateral_septum",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        Sample = function(n) {
            cols <- paletteer::paletteer_d(
                palette = "RColorBrewer::Dark2",
                n = length(unique(sce.ls.small$Sample))
            )
            cols <- as.vector(cols)
            names(cols) <- levels(sce.ls.small$Sample)
            return(cols)
        },
        cellType.final = function(n) {
            return(cell_cols.clean)
        }
    ))
)
