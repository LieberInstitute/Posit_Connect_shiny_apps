
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library("SingleCellExperiment")
library("iSEE")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/spatialDLPFC_Visium_Sp09_pseudobulk/sce_pseudo_BayesSpace_k09.rds"


if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce_pseudo <- readRDS(posit_connect_file)
} else {
    sce_pseudo <- readRDS(here::here("dlpfc", "spatialDLPFC_Visium_Sp09_pseudobulk", "processed-data", "sce_pseudo_BayesSpace_k09.rds"))
}

source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/dlpfc/spatialDLPFC_Visium_Sp09_pseudobulk/code/initial.R?raw=TRUE")


## Make unique gene names
rownames(sce_pseudo) <-
    scuttle::uniquifyFeatureNames(rowData(sce_pseudo)$gene_id, rowData(sce_pseudo)$gene_name)

## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce_pseudo) <- cbind(
    colData(sce_pseudo)[, !colnames(colData(sce_pseudo)) %in% c("subject", "BayesSpace")],
    colData(sce_pseudo)[, c("BayesSpace", "subject")]
)

sce_pseudo$subject <- as.factor(sce_pseudo$subject)

sce_pseudo <-
    registerAppOptions(sce_pseudo, color.maxlevels = length(colData(sce_pseudo)$BayesSpace_colors))

iSEE(
    sce_pseudo,
    appTitle = "spatialDLPFC, Visium, Sp09, pseudo-bulked",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        BayesSpace = function(n) {
            return(colData(sce_pseudo)$BayesSpace_colors)
        }
    ))
)
