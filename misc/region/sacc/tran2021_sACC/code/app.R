
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library("SingleCellExperiment")
library("iSEE")
library("shiny")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/sacc/tran2021_sACC/sce_sacc_small.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce_small <- readRDS(posit_connect_file)
} else {
    sce_small <- readRDS(here::here("misc", "region", "sacc", "tran2021_sACC", "processed-data", "sce_sacc_small.rds"))
}
sce_small <- readRDS("/Users/ryan.miller/Documents/projects/code/Posit_Connect_shiny_apps/misc/region/sacc/tran2021_sACC/processed-data/sce_sacc_small.rds")
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/sacc/tran2021_sACC/cell_colors_sacc.rds"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    cell_colors <- readRDS(posit_connect_file1)
} else {
    cell_colors <- readRDS(here::here("misc", "region", "sacc", "tran2021_sACC", "processed-data", "cell_colors_sacc.rds"))
}
cell_colors <- readRDS("/Users/ryan.miller/Documents/projects/code/Posit_Connect_shiny_apps/misc/region/sacc/tran2021_sACC/processed-data/cell_colors_sacc.rds")
## Related to https://github.com/iSEE/iSEE/issues/568
colData(sce_small) <- cbind(
    colData(sce_small)[, !colnames(colData(sce_small)) %in% c("donor", "cell_type")],
    colData(sce_small)[, c("cell_type", "donor")]
)

initial <- list()

################################################################################
# Settings for Reduced dimension plot 1
################################################################################

initial[["ReducedDimensionPlot1"]] <- new("ReducedDimensionPlot", Type = "PCA_corrected", XAxis = 1L,
                                          YAxis = 2L, FacetRowByColData = "Barcode", FacetColumnByColData = "Barcode",
                                          ColorByColumnData = "cell_type", ColorByFeatureNameAssay = "logcounts",
                                          ColorBySampleNameColor = "#FF0000", ShapeByColumnData = "donor",
                                          SizeByColumnData = "sum", FacetRowBy = "None", FacetColumnBy = "None",
                                          ColorBy = "Column data", ColorByDefaultColor = "#000000",
                                          ColorByFeatureName = "SNAP25", ColorByFeatureSource = "---",
                                          ColorByFeatureDynamicSource = FALSE, ColorBySampleName = "donor4_AAACCCAAGAGTCTTC.1",
                                          ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE,
                                          ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1,
                                          ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE,
                                          VisualChoices = c("Color", "Shape"), ContourAdd = FALSE,
                                          ContourColor = "#0000FF", PointSize = 1, PointAlpha = 1,
                                          Downsample = FALSE, DownsampleResolution = 200, CustomLabels = FALSE,
                                          CustomLabelsText = "donor4_AAACCCAAGAGTCTTC.1", FontSize = 1,
                                          LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE,
                                          LabelCenters = FALSE, LabelCentersBy = "Barcode", LabelCentersColor = "#000000",
                                          VersionInfo = list(iSEE = structure(list(c(2L, 4L, 0L)), class = c("package_version",
                                                                                                             "numeric_version"))), PanelId = c(ReducedDimensionPlot = 1L),
                                          PanelHeight = 600L, PanelWidth = 6L, SelectionBoxOpen = FALSE,
                                          RowSelectionSource = "---", ColumnSelectionSource = "---",
                                          DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE,
                                          RowSelectionRestrict = FALSE, ColumnSelectionRestrict = TRUE,
                                          SelectionHistory = list())

################################################################################
# Settings for Complex heatmap 1
################################################################################

initial[["ComplexHeatmapPlot1"]] <- new("ComplexHeatmapPlot", Assay = "logcounts", CustomRows = TRUE,
                                        CustomRowsText = "SNAP25
SLC17A6
SLC17A7
SLC17A8
GAD1
GAD2
DRD1
DRD2
AQP4
GFAP
CLDN5
FLT1
CD163
SIGLEC1
C3
CD74
COL1A2
PDGFRB
MBP
PDGFRA
VCAN
SKAP1
CD247", ClusterRows = FALSE,
                                        ClusterRowsDistance = "spearman", ClusterRowsMethod = "ward.D2",
                                        DataBoxOpen = FALSE, VisualChoices = "Annotations", ColumnData = c("cell_type",
                                                                                                           "donor"), RowData = character(0), CustomBounds = FALSE,
                                        LowerBound = NA_real_, UpperBound = NA_real_, AssayCenterRows = FALSE,
                                        AssayScaleRows = FALSE, DivergentColormap = "purple < black < yellow",
                                        ShowDimNames = "Rows", LegendPosition = "Bottom", LegendDirection = "Horizontal",
                                        VisualBoxOpen = FALSE, NamesRowFontSize = 10, NamesColumnFontSize = 10,
                                        ShowColumnSelection = TRUE, OrderColumnSelection = TRUE,
                                        VersionInfo = list(iSEE = structure(list(c(2L, 4L, 0L)), class = c("package_version",
                                                                                                           "numeric_version"))), PanelId = 1L, PanelHeight = 600L, PanelWidth = 6L,
                                        SelectionBoxOpen = FALSE, RowSelectionSource = "---", ColumnSelectionSource = "---",
                                        RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE,
                                        RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE,
                                        SelectionHistory = list())

################################################################################
# Settings for Row data table 1
################################################################################

initial[["RowDataTable1"]] <- new("RowDataTable", Selected = "SNAP25", Search = "", SearchColumns = c("",
                                                                                                      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
                                                                                                      "", "", "", "", "", "", "", "", "", "", ""), HiddenColumns = character(0),
                                  VersionInfo = list(iSEE = structure(list(c(2L, 4L, 0L)), class = c("package_version",
                                                                                                     "numeric_version"))), PanelId = c(RowDataTable = 1L), PanelHeight = 600L,
                                  PanelWidth = 6L, SelectionBoxOpen = FALSE, RowSelectionSource = "---",
                                  ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE,
                                  ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE,
                                  ColumnSelectionRestrict = FALSE, SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data",
                                      XAxisColumnData = "cell_type", XAxisFeatureName = "SNAP25",
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE,
                                      YAxisFeatureName = "SNAP25", YAxisFeatureSource = "RowDataTable1",
                                      YAxisFeatureDynamicSource = TRUE, FacetRowByColData = "Barcode",
                                      FacetColumnByColData = "Barcode", ColorByColumnData = "cell_type",
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000",
                                      ShapeByColumnData = "donor", SizeByColumnData = "sum", FacetRowBy = "None",
                                      FacetColumnBy = "None", ColorBy = "Column data", ColorByDefaultColor = "#000000",
                                      ColorByFeatureName = "SNAP25", ColorByFeatureSource = "---",
                                      ColorByFeatureDynamicSource = FALSE, ColorBySampleName = "donor4_AAACCCAAGAGTCTTC.1",
                                      ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE,
                                      ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1,
                                      ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE,
                                      VisualChoices = "Color", ContourAdd = FALSE, ContourColor = "#0000FF",
                                      PointSize = 1, PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200,
                                      CustomLabels = FALSE, CustomLabelsText = "donor4_AAACCCAAGAGTCTTC.1",
                                      FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom",
                                      HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "Barcode",
                                      LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                          c(2L, 4L, 0L)), class = c("package_version", "numeric_version"
                                          ))), PanelId = c(FeatureAssayPlot = 1L), PanelHeight = 600L,
                                      PanelWidth = 6L, SelectionBoxOpen = FALSE, RowSelectionSource = "---",
                                      ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE,
                                      ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE,
                                      ColumnSelectionRestrict = TRUE, SelectionHistory = list())


sce_small <- registerAppOptions(sce_small, color.maxlevels=length(cell_colors[!grepl("drop", names(cell_colors))]))

iSEE(
    sce_small,
    appTitle = "M.N. Tran et al 2021, sACC region https://bit.ly/LIBD10xHuman",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        donor = function(n) {
            cols <- RColorBrewer::brewer.pal(8, "Dark2")
            names(cols) <- paste0("donor", seq_len(8))
            return(cols)
        },
        cell_type = function(n) {
            cell_colors[!grepl("drop", names(cell_colors))]
        }
    ))
)
