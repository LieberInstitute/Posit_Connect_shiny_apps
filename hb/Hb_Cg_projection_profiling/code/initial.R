initial <- list()

################################################################################
# Settings for Reduced dimension plot 1
################################################################################

initial[["ReducedDimensionPlot1"]] <- new("ReducedDimensionPlot", Type = "UMAP", XAxis = 1L, YAxis = 2L, 
                                          FacetRowByColData = "Sample", FacetColumnByColData = "Sample", 
                                          ColorByColumnData = "prelimClust.15", ColorByFeatureNameAssay = "logcounts", 
                                          ColorBySampleNameColor = "#FF0000", ShapeByColumnData = "Sample", 
                                          SizeByColumnData = "sizeFactor", TooltipColumnData = character(0), 
                                          FacetRowBy = "None", FacetColumnBy = "None", ColorBy = "Column data", 
                                          ColorByDefaultColor = "#000000", ColorByFeatureName = "ENSMUSG00000051951", 
                                          ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                          ColorBySampleName = "1_AAACCCAAGCGTATGG-1", ColorBySampleSource = "---", 
                                          ColorBySampleDynamicSource = FALSE, ShapeBy = "None", SizeBy = "None", 
                                          SelectionAlpha = 0.1, ZoomData = numeric(0), BrushData = list(), 
                                          VisualBoxOpen = FALSE, VisualChoices = "Color", ContourAdd = FALSE, 
                                          ContourColor = "#0000FF", PointSize = 1, PointAlpha = 1, 
                                          Downsample = FALSE, DownsampleResolution = 200, CustomLabels = FALSE, 
                                          CustomLabelsText = "1_AAACCCAAGCGTATGG-1", FontSize = 1, 
                                          LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE, 
                                          LabelCenters = FALSE, LabelCentersBy = "Sample", LabelCentersColor = "#000000", 
                                          VersionInfo = list(iSEE = structure(list(c(2L, 12L, 0L)), class = c("package_version", 
                                                                                                              "numeric_version"))), PanelId = c(ReducedDimensionPlot = 1L), 
                                          PanelHeight = 760L, PanelWidth = 6L, SelectionBoxOpen = FALSE, 
                                          RowSelectionSource = "---", ColumnSelectionSource = "---", 
                                          DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE, 
                                          RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                          SelectionHistory = list())

################################################################################
# Settings for Complex heatmap 1
################################################################################

initial[["ComplexHeatmapPlot1"]] <- new("ComplexHeatmapPlot", Assay = "logcounts", CustomRows = TRUE, 
                                        CustomRowsText = "ENSMUSG00000051951", ClusterRows = TRUE, 
                                        ClusterRowsDistance = "spearman", ClusterRowsMethod = "ward.D2", 
                                        DataBoxOpen = FALSE, VisualChoices = "Annotations", ColumnData = c("Sample", 
                                                                                                           "prelimClust.15"), RowData = character(0), CustomBounds = FALSE, 
                                        LowerBound = NA_real_, UpperBound = NA_real_, AssayCenterRows = FALSE, 
                                        AssayScaleRows = FALSE, DivergentColormap = "purple < black < yellow", 
                                        ShowDimNames = "Rows", LegendPosition = "Bottom", LegendDirection = "Horizontal", 
                                        VisualBoxOpen = FALSE, NamesRowFontSize = 10, NamesColumnFontSize = 10, 
                                        ShowColumnSelection = FALSE, OrderColumnSelection = TRUE, 
                                        VersionInfo = list(iSEE = structure(list(c(2L, 12L, 0L)), class = c("package_version", 
                                                                                                            "numeric_version"))), PanelId = c(ComplexHeatmapPlot = 1L), 
                                        PanelHeight = 760L, PanelWidth = 6L, SelectionBoxOpen = FALSE, 
                                        RowSelectionSource = "RowDataTable1", ColumnSelectionSource = "---", 
                                        RowSelectionDynamicSource = TRUE, ColumnSelectionDynamicSource = FALSE, 
                                        RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                        SelectionHistory = list())

################################################################################
# Settings for Row data table 1
################################################################################

initial[["RowDataTable1"]] <- new("RowDataTable", Selected = "ENSMUSG00000104328", Search = "", 
                                  SearchColumns = c("", "", "", "", "", "", ""), HiddenColumns = character(0), 
                                  VersionInfo = list(iSEE = structure(list(c(2L, 12L, 0L)), class = c("package_version", 
                                                                                                      "numeric_version"))), PanelId = c(RowDataTable = 1L), PanelHeight = 640L, 
                                  PanelWidth = 4L, SelectionBoxOpen = FALSE, RowSelectionSource = "---", 
                                  ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, 
                                  ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE, 
                                  ColumnSelectionRestrict = FALSE, SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data", 
                                      XAxisColumnData = "prelimClust.15", XAxisFeatureName = "ENSMUSG00000051951", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "ENSMUSG00000104328", YAxisFeatureSource = "RowDataTable1", 
                                      YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "Sample", 
                                      FacetColumnByColData = "Sample", ColorByColumnData = "prelimClust.15", 
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000", 
                                      ShapeByColumnData = "Sample", SizeByColumnData = "sizeFactor", 
                                      TooltipColumnData = character(0), FacetRowBy = "Column data", 
                                      FacetColumnBy = "None", ColorBy = "Column data", ColorByDefaultColor = "#000000", 
                                      ColorByFeatureName = "ENSMUSG00000051951", ColorByFeatureSource = "---", 
                                      ColorByFeatureDynamicSource = FALSE, ColorBySampleName = "1_AAACCCAAGCGTATGG-1", 
                                      ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE, 
                                      ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1, 
                                      ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE, 
                                      VisualChoices = c("Color", "Facet"), ContourAdd = FALSE, 
                                      ContourColor = "#0000FF", PointSize = 1, PointAlpha = 1, 
                                      Downsample = FALSE, DownsampleResolution = 200, CustomLabels = FALSE, 
                                      CustomLabelsText = "1_AAACCCAAGCGTATGG-1", FontSize = 1, 
                                      LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE, 
                                      LabelCenters = FALSE, LabelCentersBy = "Sample", LabelCentersColor = "#000000", 
                                      VersionInfo = list(iSEE = structure(list(c(2L, 12L, 0L)), class = c("package_version", 
                                                                                                          "numeric_version"))), PanelId = c(FeatureAssayPlot = 1L), 
                                      PanelHeight = 640L, PanelWidth = 8L, SelectionBoxOpen = FALSE, 
                                      RowSelectionSource = "---", ColumnSelectionSource = "---", 
                                      DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE, 
                                      RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                      SelectionHistory = list())