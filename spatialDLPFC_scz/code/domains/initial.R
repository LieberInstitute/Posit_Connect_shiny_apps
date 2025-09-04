initial <- list()

################################################################################
# Settings for Reduced dimension plot 1
################################################################################

initial[["ReducedDimensionPlot1"]] <- new("ReducedDimensionPlot", Type = "PCA", XAxis = 1L, YAxis = 2L, 
                                          FacetRowByColData = "DX", FacetColumnByColData = "sex", ColorByColumnData = "spd_label", 
                                          ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000", 
                                          ShapeByColumnData = "DX", SizeByColumnData = "age", TooltipColumnData = character(0), 
                                          FacetRowBy = "Column data", FacetColumnBy = "Column data", 
                                          ColorBy = "Column data", ColorByDefaultColor = "#000000", 
                                          ColorByFeatureName = "AL627309.5, p-value=8.34e-01", ColorByFeatureSource = "---", 
                                          ColorByFeatureDynamicSource = FALSE, ColorBySampleName = "V12D07-334_A1_spd01", 
                                          ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE, 
                                          ShapeBy = "Column data", SizeBy = "None", SelectionAlpha = 0.1, 
                                          ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE, 
                                          VisualChoices = c("Color", "Shape", "Facet"), ContourAdd = FALSE, 
                                          ContourColor = "#0000FF", FixAspectRatio = FALSE, ViolinAdd = TRUE, 
                                          PointSize = 2, PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200, 
                                          CustomLabels = FALSE, CustomLabelsText = "V12D07-334_A1_spd01", 
                                          FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom", 
                                          HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "sample_id", 
                                          LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                              c(2L, 20L, 0L)), class = c("package_version", "numeric_version"
                                              ))), PanelId = c(ReducedDimensionPlot = 1L), PanelHeight = 750L, 
                                          PanelWidth = 6L, SelectionBoxOpen = FALSE, RowSelectionSource = "---", 
                                          ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, 
                                          ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE, 
                                          ColumnSelectionRestrict = FALSE, SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 2
################################################################################

initial[["FeatureAssayPlot2"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "None", 
                                      XAxisColumnData = "sample_id", XAxisFeatureName = "AL627309.5, p-value=8.34e-01", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "BDNF, p-value=5.72e-04", YAxisFeatureSource = "---", 
                                      YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "DX", 
                                      FacetColumnByColData = "DX", ColorByColumnData = "DX", ColorByFeatureNameAssay = "logcounts", 
                                      ColorBySampleNameColor = "#FF0000", ShapeByColumnData = "sample_id", 
                                      SizeByColumnData = "age", TooltipColumnData = character(0), 
                                      FacetRowBy = "None", FacetColumnBy = "Column data", ColorBy = "Column data", 
                                      ColorByDefaultColor = "#000000", ColorByFeatureName = "AL627309.5, p-value=8.34e-01", 
                                      ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                      ColorBySampleName = "V12D07-334_A1_spd01", ColorBySampleSource = "---", 
                                      ColorBySampleDynamicSource = FALSE, ShapeBy = "None", SizeBy = "None", 
                                      SelectionAlpha = 0.1, ZoomData = numeric(0), BrushData = list(), 
                                      VisualBoxOpen = FALSE, VisualChoices = c("Color", "Facet"
                                      ), ContourAdd = FALSE, ContourColor = "#0000FF", FixAspectRatio = FALSE, 
                                      ViolinAdd = TRUE, PointSize = 1, PointAlpha = 1, Downsample = FALSE, 
                                      DownsampleResolution = 200, CustomLabels = FALSE, CustomLabelsText = "V12D07-334_A1_spd01", 
                                      FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom", 
                                      HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "sample_id", 
                                      LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                          c(2L, 20L, 0L)), class = c("package_version", "numeric_version"
                                          ))), PanelId = 2L, PanelHeight = 750L, PanelWidth = 6L, SelectionBoxOpen = FALSE, 
                                      RowSelectionSource = "---", ColumnSelectionSource = "---", 
                                      DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE, 
                                      RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                      SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data", 
                                      XAxisColumnData = "DX", XAxisFeatureName = "AL627309.5, p-value=8.34e-01", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "BDNF, p-value=5.72e-04", YAxisFeatureSource = "---", 
                                      YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "sample_id", 
                                      FacetColumnByColData = "spd_label", ColorByColumnData = "DX", 
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000", 
                                      ShapeByColumnData = "sex", SizeByColumnData = "age", TooltipColumnData = character(0), 
                                      FacetRowBy = "None", FacetColumnBy = "Column data", ColorBy = "Column data", 
                                      ColorByDefaultColor = "#000000", ColorByFeatureName = "AL627309.5, p-value=8.34e-01", 
                                      ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                      ColorBySampleName = "V12D07-334_A1_spd01", ColorBySampleSource = "---", 
                                      ColorBySampleDynamicSource = FALSE, ShapeBy = "Column data", 
                                      SizeBy = "None", SelectionAlpha = 0.1, ZoomData = numeric(0), 
                                      BrushData = list(), VisualBoxOpen = FALSE, VisualChoices = c("Color", 
                                                                                                   "Shape", "Facet"), ContourAdd = FALSE, ContourColor = "#0000FF", 
                                      FixAspectRatio = FALSE, ViolinAdd = TRUE, PointSize = 2, 
                                      PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200, 
                                      CustomLabels = FALSE, CustomLabelsText = "V12D07-334_A1_spd01", 
                                      FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom", 
                                      HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "sample_id", 
                                      LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                          c(2L, 20L, 0L)), class = c("package_version", "numeric_version"
                                          ))), PanelId = c(FeatureAssayPlot = 1L), PanelHeight = 550L, 
                                      PanelWidth = 12L, SelectionBoxOpen = FALSE, RowSelectionSource = "---", 
                                      ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, 
                                      ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE, 
                                      ColumnSelectionRestrict = FALSE, SelectionHistory = list())