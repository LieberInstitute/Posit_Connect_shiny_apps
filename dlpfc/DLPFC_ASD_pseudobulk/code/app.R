library("SpatialExperiment")
library("iSEE")
library("shiny")
library("scuttle")

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_ASD_pseudobulk/spe_pseudobulk_iSEE.rds"
## Load the pseudobulked object spe_pseudo
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pseudo <- readRDS(posit_connect_file)
} else {
    spe_pseudo <- readRDS(here::here("dlpfc", "DLPFC_ASD_pseudobulk", "processed-data", "spe_pseudobulk_iSEE.rds"))
}
#spe_pseudo <- readRDS("spe_pseudobulk_iSEE.rds")

## Make unique gene names ## these are ensemble ids
# rownames(spe_pseudo) <-
#     scuttle::uniquifyFeatureNames(rowData(spe_pseudo)$gene_id, rowData(spe_pseudo)$gene_name)
rownames(spe_pseudo) <- rowData(spe_pseudo)$gene_name
anyDuplicated(rowData(spe_pseudo)$gene_name)
## Don't run this on app.R since we don't want to run this every single time
# lobstr::obj_size(spe_pseudo)
# 56.41 MB

#source("initial.R", echo = TRUE, max.deparse.length = 500)
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/dlpfc/DLPFC_ASD_pseudobulk/code/initial.R?raw=TRUE", print.eval = TRUE)

## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(spe_pseudo) <- cbind(
    colData(spe_pseudo)[, !colnames(colData(spe_pseudo)) %in% c("sample_id", "SpD")],
    colData(spe_pseudo)[, c("SpD", "sample_id")]
)

# spe_pseudo <-
#     registerAppOptions(spe_pseudo, color.maxlevels = length(colData(spe_pseudo)$BayesSpace_colors)) ## tyhese is SpD_colors
#names(spe_pseudo$SpD_colors) <- spe_pseudo$SpD

iSEE(
    spe_pseudo,
    appTitle = "DLPFC_ASD, Visium-CytAssist, Sp11, pseudobulked",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        SpD = function(n) {
            return(colData(spe_pseudo)$SpD_colors)
        }
    ))
)
