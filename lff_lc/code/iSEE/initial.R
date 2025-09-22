initial <- list()

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "counts", XAxis = "Column data", 
                                      XAxisColumnData = "APOE Genotype", XAxisFeatureName = "NDRG2", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "SNAP25", YAxisFeatureSource = "---", 
                                      YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "Ancestry", 
                                      FacetColumnByColData = "sample_id", ColorByColumnData = "Sex", 
                                      ColorByFeatureNameAssay = "counts", ColorBySampleNameColor = "#FF0000", 
                                      ShapeByColumnData = "Sex", SizeByColumnData = "Age", TooltipColumnData = character(0), 
                                      FacetRowBy = "Column data", FacetColumnBy = "None", ColorBy = "Column data", 
                                      ColorByDefaultColor = "#000000", ColorByFeatureName = "NDRG2", 
                                      ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                      ColorBySampleName = "ACHE_SERT_LC_WM_V13B23_284_A1s1", ColorBySampleSource = "---", 
                                      ColorBySampleDynamicSource = FALSE, ShapeBy = "Column data", 
                                      SizeBy = "None", SelectionAlpha = 0.1, ZoomData = numeric(0), 
                                      BrushData = list(), VisualBoxOpen = FALSE, VisualChoices = c("Color", 
                                                                                                   "Shape", "Facet"), ContourAdd = FALSE, ContourColor = "#0000FF", 
                                      FixAspectRatio = FALSE, ViolinAdd = TRUE, PointSize = 2, 
                                      PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200, 
                                      CustomLabels = FALSE, CustomLabelsText = "ACHE_SERT_LC_WM_V13B23_284_A1s1", 
                                      FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom", 
                                      HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "sample_id", 
                                      LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
                                          c(2L, 20L, 0L)), class = c("package_version", "numeric_version"
                                          ))), PanelId = c(FeatureAssayPlot = 1L), PanelHeight = 550L, 
                                      PanelWidth = 12L, SelectionBoxOpen = FALSE, RowSelectionSource = "---", 
                                      ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, 
                                      ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE, 
                                      ColumnSelectionRestrict = FALSE, SelectionHistory = list())