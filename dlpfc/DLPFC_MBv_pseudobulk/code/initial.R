initial <- list()

################################################################################
# Settings for Reduced dimension plot 1
################################################################################

initial[["ReducedDimensionPlot1"]] <- new("ReducedDimensionPlot", Type = "PCA_1663", XAxis = 1L, YAxis = 2L,
                                          FacetRowByColData = "sex", FacetColumnByColData = "sex",
                                          ColorByColumnData = "sample_id", ColorByFeatureNameAssay = "logcounts",
                                          ColorBySampleNameColor = "#FF0000", ShapeByColumnData = "sex",
                                          SizeByColumnData = "age", TooltipColumnData = character(0),
                                          FacetRowBy = "None", FacetColumnBy = "None", ColorBy = "Column data",
                                          ColorByDefaultColor = "#000000", ColorByFeatureName = "LINC01409",
                                          ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE,
                                          ColorBySampleName = "1", ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE,
                                          ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1,
                                          ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE,
                                          VisualChoices = "Color", ContourAdd = FALSE, ContourColor = "#0000FF",
                                          FixAspectRatio = FALSE, ViolinAdd = TRUE, PointSize = 1,
                                          PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200,
                                          CustomLabels = FALSE, CustomLabelsText = "1", FontSize = 1,
                                          LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE,
                                          LabelCenters = FALSE, LabelCentersBy = "sex", LabelCentersColor = "#000000",
                                          VersionInfo = list(iSEE = structure(list(c(2L, 24L, 0L)), class = c("package_version",
                                                                                                              "numeric_version"))), PanelId = c(ReducedDimensionPlot = 1L),
                                          PanelHeight = 600L, PanelWidth = 5L, SelectionBoxOpen = FALSE,
                                          RowSelectionSource = "---", ColumnSelectionSource = "---",
                                          DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE,
                                          RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE,
                                          SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data",
                                      XAxisColumnData = "sample_id", XAxisFeatureName = "LINC01409",
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE,
                                      YAxisFeatureName = "LINC01409", YAxisFeatureSource = "RowDataTable1",
                                      YAxisFeatureDynamicSource = TRUE, FacetRowByColData = "sex",
                                      FacetColumnByColData = "sex", ColorByColumnData = "sample_id",
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000",
                                      ShapeByColumnData = "sex", SizeByColumnData = "age", TooltipColumnData = character(0),
                                      FacetRowBy = "None", FacetColumnBy = "None", ColorBy = "Column data",
                                      ColorByDefaultColor = "#000000", ColorByFeatureName = "LINC01409",
                                      ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE,
                                      ColorBySampleName = "1", ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE,
                                      ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1,
                                      ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE,
                                      VisualChoices = "Color", ContourAdd = FALSE, ContourColor = "#0000FF",
                                      FixAspectRatio = FALSE, ViolinAdd = TRUE, PointSize = 1,
                                      PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200,
                                      CustomLabels = FALSE, CustomLabelsText = "1", FontSize = 1,
                                      LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE,
                                      LabelCenters = FALSE, LabelCentersBy = "sex", LabelCentersColor = "#000000",
                                      VersionInfo = list(iSEE = structure(list(c(2L, 24L, 0L)), class = c("package_version",
                                                                                                          "numeric_version"))), PanelId = c(FeatureAssayPlot = 1L),
                                      PanelHeight = 600L, PanelWidth = 7L, SelectionBoxOpen = FALSE,
                                      RowSelectionSource = "---", ColumnSelectionSource = "---",
                                      DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE,
                                      RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE,
                                      SelectionHistory = list())

################################################################################
# Settings for Row data table 1
################################################################################

initial[["RowDataTable1"]] <- new("RowDataTable", Selected = "LINC01409", Search = "", SearchColumns = c("",
                                                                                                         "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""),
                                  HiddenColumns = character(0), VersionInfo = list(iSEE = structure(list(
                                      c(2L, 24L, 0L)), class = c("package_version", "numeric_version"
                                      ))), PanelId = c(RowDataTable = 1L), PanelHeight = 600L,
                                  PanelWidth = 5L, SelectionBoxOpen = FALSE, RowSelectionSource = "---",
                                  ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE,
                                  ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE,
                                  ColumnSelectionRestrict = FALSE, SelectionHistory = list())
