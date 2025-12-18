
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library("SingleCellExperiment")
library("iSEE")
library("SpatialExperiment")
library("scuttle")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/Kwon2022_pseudobulk_wholegenome/sce_pseudo_pathology_wholegenome.rds"


if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce_IF <- readRDS(posit_connect_file)
} else {
    sce_IF <- readRDS(here::here("dlpfc", "Kwon2022_pseudobulk_wholegenome", "processed-data", "sce_pseudo_pathology_wholegenome.rds"))
}

source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/dlpfc/Kwon2022_pseudobulk_wholegenome/code/initial.R?raw=TRUE")


## Make unique gene names
rownames(sce_IF) <-
    uniquifyFeatureNames(rowData(sce_IF)$gene_id, rowData(sce_IF)$gene_name)



## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce_IF) <- cbind(
    colData(sce_IF)[, !colnames(colData(sce_IF)) %in% c("subject", "path_groups")],
    colData(sce_IF)[, c("path_groups", "subject")]
)

sce_IF$subject <- as.factor(sce_IF$subject)

sce_IF <- registerAppOptions(sce_IF, color.maxlevels = length(colData(sce_IF)$path_groups_colors))

iSEE(
    sce_IF,
    appTitle = "Kwon2022_pseudobulk_AD_pathology_wholegenome",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        subject = function(n) {
            cols <- paletteer::paletteer_d(
                palette = "RColorBrewer::Dark2",
                n = length(unique(sce_IF$subject))
            )
            cols <- as.vector(cols)
            names(cols) <- levels(sce_IF$subject)
            return(cols)
        },
        path_groups = function(n) {
            return(colData(sce_IF)$path_groups_colors)
        }
    ))
)
