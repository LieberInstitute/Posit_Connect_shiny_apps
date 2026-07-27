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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/LS/bulkseq_lateral_septum/rse_gene_TrkB_KO_LS_n8_wm.Rdata"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("LS", "bulkseq_lateral_septum", "processed-data", "rse_gene_TrkB_KO_LS_n8_wm.Rdata"))
}


source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/LS/bulkseq_lateral_septum/code/initial.R?raw=TRUE")

## Make unique gene names
rownames(rse_gene) <-
    scuttle::uniquifyFeatureNames(rowData(rse_gene)$gencodeID, rowData(rse_gene)$Symbol)


## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(rse_gene) <- cbind(
    colData(rse_gene)[, !colnames(colData(rse_gene)) %in% c("Condition", "SampleID")],
    colData(rse_gene)[, c("SampleID", "Condition")]
)

rse_gene$Condition <- as.factor(rse_gene$Condition)

#rse_gene <- registerAppOptions(rse_gene, color.maxlevels = length(Sample_ID)
iSEE(
    rse_gene,
    appTitle = "bulkRNA-seq_lateral_septum",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        SAMPLE_ID = function(n) {
            cols <- paletteer::paletteer_d(
                palette = "RColorBrewer::Dark2",
                n = length(unique(rse_gene$Condition))
            )
            cols <- as.vector(cols)
            names(cols) <- levels(rse_gene$Condition)
            return(cols)
        }#,
        # SampleID = function(n) {
        #     return(Sample_ID)
        # }
    ))
)
