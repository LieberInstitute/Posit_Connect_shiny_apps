library("SpatialExperiment")
library("iSEE")
library("shiny")
library("scuttle")

## Load the pseudobulked object sce_pseudo
# sce_pseudo <- readRDS("pseudobulk_cluster_atlas.rds")

posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Hb_Rat_Fentanyl_pb/pseudobulk_cluster_atlas.rds"
## Load the pseudobulked object spe_pseudo
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe_pseudo <- readRDS(posit_connect_file)
} else {
    spe_pseudo <- readRDS(here::here("hb", "Hb_Rat_Fentanyl_pb", "processed-data", "pseudobulk_cluster_atlas.rds"))
}

## Make unique gene names ## these are ensemble ids
# rownames(sce_pseudo) <-
#     scuttle::uniquifyFeatureNames(rowData(sce_pseudo)$gene_id, rowData(sce_pseudo)$gene_name)
rownames(sce_pseudo) <- rowData(sce_pseudo)$gene_name
anyDuplicated(rowData(sce_pseudo)$gene_name)
## Don't run this on app.R since we don't want to run this every single time
# lobstr::obj_size(sce_pseudo)

cluster_cols <- c(
  "Excit.Thal" = "#6B3FA0",
  "Inhib.Thal" = "#A99BC9",
  "LHb_A"      = "#F08A24",
  "LHb_B"      = "#C2410C",
  "LHb_C"      = "#F7C16B",
  "LHb_D"      = "#DB6B3F",
  "MHb_A"      = "#1F5FA8",
  "MHb_B"      = "#6FB7E9",
  "Astrocyte"  = "#CBD87A",
  "Epen.1"     = "#7ec78e",
  "Epen.2"     = "#1D7F4C",
  "Mural.Endo.Micro" = "#8FA82A",
  "Oligo"      = "#B3243B",
  "OPC"        = "#C93C8E"
)

sce_pseudo$cluster_atlas <- as.character(sce_pseudo$cluster_atlas)
sce_pseudo$cluster_atlas <- factor(
    sce_pseudo$cluster_atlas,
    levels = c(
        "Astrocyte",
        "Epen.1",
        "Epen.2",
        "Mural.Endothelial.Microglia",
        "Oligo",
        "OPC",
        "MHb_A",
        "MHb_B",
        "LHb_A",
        "LHb_C",
        "LHb_B",
        "LHb_D",
        "Excit.Thal"
    )
)
sce_pseudo$cluster_atlas <- sub(
    "Mural.Endothelial.Microglia",
    "Mural.Endo.Micro",
    sce_pseudo$cluster_atlas,
    fixed = TRUE
)

sce_pseudo$cluster_cols <- cluster_cols[sce_pseudo$cluster_atlas]
#table(sce_pseudo$cluster_atlas, sce_pseudo$cluster_cols) ##cannot map colors to OPC


#source("initial.R", echo = TRUE, max.deparse.length = 500)
source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/hb/Hb_Rat_Fentanyl_pb/code/initial.R?raw=TRUE", print.eval = TRUE)


## From https://github.com/LieberInstitute/10xPilot_snRNAseq-human/blob/810b47364af4c8afe426bd2a6b559bd6a9f1cc98/shiny_apps/tran2021_AMY/app.R#L10-L14
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce_pseudo) <- cbind(
    colData(sce_pseudo)[, !colnames(colData(sce_pseudo)) %in% c("chromium_id", "cluster_atlas")],
    colData(sce_pseudo)[, c("cluster_atlas", "chromium_id")]
)

sce_pseudo$chromium_id <- as.factor(sce_pseudo$chromium_id)

# sce_pseudo <-
#     registerAppOptions(sce_pseudo, color.maxlevels = length(colData(sce_pseudo)$BayesSpace_colors)) ## tyhese is SpD_colors

names(sce_pseudo$cluster_cols) <- sce_pseudo$cluster_atlas
iSEE(
    sce_pseudo,
    appTitle = "Hb_Rat_Fentanyl, snRNA-seq, pseudobulked",
    initial = initial,
   colormap = ExperimentColorMap(colData = list(
        cluster_atlas = function(n) {
            return(colData(sce_pseudo)$cluster_cols)
        }
    ))
)