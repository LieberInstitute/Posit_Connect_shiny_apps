library("SpatialExperiment")
library("iSEE")
library("shiny")
library("scuttle")

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_pseudobulk/spe_pseudobulk_iSEE.rds"
## Load the pseudobulked object sce_pseudo
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe <- readRDS(here::here("dlpfc", "DLPFC_ASD_pseudobulk", "processed-data", "spe_pseudobulk_iSEE.rds"))
}
#sce_pseudo <- readRDS("spe_pseudobulk_iSEE.rds")

## Make unique gene names ## these are ensemble ids
# rownames(sce_pseudo) <-
#     scuttle::uniquifyFeatureNames(rowData(sce_pseudo)$gene_id, rowData(sce_pseudo)$gene_name)
rownames(sce_pseudo) <- rowData(sce_pseudo)$gene_name
anyDuplicated(rowData(sce_pseudo)$gene_name)
## Don't run this on app.R since we don't want to run this every single time
# lobstr::obj_size(sce_pseudo)
# 56.41 MB

#source("initial.R", echo = TRUE, max.deparse.length = 500)
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/dlpfc/DLPFC_ASD_pseudobulk/code/initial.R?raw=TRUE", print.eval = TRUE)

## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce_pseudo) <- cbind(
    colData(sce_pseudo)[, !colnames(colData(sce_pseudo)) %in% c("sample_id", "SpD")],
    colData(sce_pseudo)[, c("SpD", "sample_id")]
)

# sce_pseudo <-
#     registerAppOptions(sce_pseudo, color.maxlevels = length(colData(sce_pseudo)$BayesSpace_colors)) ## tyhese is SpD_colors
#names(sce_pseudo$SpD_colors) <- sce_pseudo$SpD

iSEE(
    sce_pseudo,
    appTitle = "DLPFC_ASD, Visium-CytAssist, Sp11, pseudobulked",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        SpD = function(n) {
            return(colData(sce_pseudo)$SpD_colors)
        }
    ))
)
