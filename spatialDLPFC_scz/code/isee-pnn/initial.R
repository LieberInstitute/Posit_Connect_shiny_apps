initial <- list()

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data", 
                                      XAxisColumnData = "DX", XAxisFeatureName = "A1BG, p-value=3.22e-01", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "GABRA3, p-value=3.84e-02", YAxisFeatureSource = "---", 
                                      YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "sample_id", 
                                      FacetColumnByColData = "sample_id", ColorByColumnData = "spd_label", 
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000", 
                                      ShapeByColumnData = "sex", SizeByColumnData = "age", TooltipColumnData = character(0), 
                                      FacetRowBy = "None", FacetColumnBy = "None", ColorBy = "Column data", 
                                      ColorByDefaultColor = "#000000", ColorByFeatureName = "A1BG, p-value=3.22e-01", 
                                      ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                      ColorBySampleName = "V12D07-334_A1_spd02", ColorBySampleSource = "---", 
                                      ColorBySampleDynamicSource = FALSE, ShapeBy = "Column data", 
                                      SizeBy = "None", SelectionAlpha = 0.1, ZoomData = numeric(0), 
                                      BrushData = list(), VisualBoxOpen = FALSE, VisualChoices = c("Color", 
                                                                                                   "Shape"), ContourAdd = FALSE, ContourColor = "#0000FF", FixAspectRatio = FALSE, 
                                      ViolinAdd = TRUE, PointSize = 1, PointAlpha = 1, Downsample = FALSE, 
                                      DownsampleResolution = 200, CustomLabels = FALSE, CustomLabelsText = "V12D07-334_A1_spd02", 
                                      FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom", 
                                      HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "sample_id", 
                                      LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                          c(2L, 18L, 0L)), class = c("package_version", "numeric_version"
                                          ))), PanelId = c(FeatureAssayPlot = 1L), PanelHeight = 580L, 
                                      PanelWidth = 6L, SelectionBoxOpen = FALSE, RowSelectionSource = "---", 
                                      ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, 
                                      ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE, 
                                      ColumnSelectionRestrict = FALSE, SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 2
################################################################################

initial[["FeatureAssayPlot2"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data", 
                                      XAxisColumnData = "DX", XAxisFeatureName = "A1BG, p-value=3.22e-01", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "GABRA3, p-value=3.84e-02", YAxisFeatureSource = "---", 
                                      YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "DX", 
                                      FacetColumnByColData = "spd_label", ColorByColumnData = "spd_label", 
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000", 
                                      ShapeByColumnData = "sex", SizeByColumnData = "age", TooltipColumnData = character(0), 
                                      FacetRowBy = "None", FacetColumnBy = "Column data", ColorBy = "Column data", 
                                      ColorByDefaultColor = "#000000", ColorByFeatureName = "A1BG, p-value=3.22e-01", 
                                      ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                      ColorBySampleName = "V12D07-334_A1_spd02", ColorBySampleSource = "---", 
                                      ColorBySampleDynamicSource = FALSE, ShapeBy = "Column data", 
                                      SizeBy = "None", SelectionAlpha = 0.1, ZoomData = numeric(0), 
                                      BrushData = list(), VisualBoxOpen = FALSE, VisualChoices = c("Color", 
                                                                                                   "Shape", "Facet"), ContourAdd = FALSE, ContourColor = "#0000FF", 
                                      FixAspectRatio = FALSE, ViolinAdd = TRUE, PointSize = 1, 
                                      PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200, 
                                      CustomLabels = FALSE, CustomLabelsText = "V12D07-334_A1_spd02", 
                                      FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom", 
                                      HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "sample_id", 
                                      LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                          c(2L, 18L, 0L)), class = c("package_version", "numeric_version"
                                          ))), PanelId = 2L, PanelHeight = 580L, PanelWidth = 6L, SelectionBoxOpen = FALSE, 
                                      RowSelectionSource = "---", ColumnSelectionSource = "---", 
                                      DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE, 
                                      RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                      SelectionHistory = list())