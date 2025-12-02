initial <- list()

################################################################################
# Settings for Reduced dimension plot 1
################################################################################

initial[["ReducedDimensionPlot1"]] <- new("ReducedDimensionPlot", Type = "TSNE", XAxis = 1L, YAxis = 2L, 
                                          FacetRowByColData = "Sample", FacetColumnByColData = "Sample", 
                                          ColorByColumnData = "subclust.neu", ColorByFeatureNameAssay = "logcounts", 
                                          ColorBySampleNameColor = "#FF0000", ShapeByColumnData = "Sample", 
                                          SizeByColumnData = "e.out_FDR", TooltipColumnData = character(0), 
                                          FacetRowBy = "None", FacetColumnBy = "None", ColorBy = "Column data", 
                                          ColorByDefaultColor = "#000000", ColorByFeatureName = "ENSMUSG00000051951", 
                                          ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE, 
                                          ColorBySampleName = "1_AAACCCACAGAGTCTT-1", ColorBySampleSource = "---", 
                                          ColorBySampleDynamicSource = FALSE, ShapeBy = "None", SizeBy = "None", 
                                          SelectionAlpha = 0.1, ZoomData = numeric(0), BrushData = list(), 
                                          VisualBoxOpen = TRUE, VisualChoices = "Color", ContourAdd = FALSE, 
                                          ContourColor = "#0000FF", PointSize = 1, PointAlpha = 1, 
                                          Downsample = FALSE, DownsampleResolution = 200, CustomLabels = FALSE, 
                                          CustomLabelsText = "1_AAACCCACAGAGTCTT-1", FontSize = 1, 
                                          LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE, 
                                          LabelCenters = FALSE, LabelCentersBy = "Sample", LabelCentersColor = "#000000", 
                                          VersionInfo = list(iSEE = structure(list(c(2L, 14L, 0L)), class = c("package_version", 
                                                                                                              "numeric_version"))), PanelId = c(ReducedDimensionPlot = 1L), 
                                          PanelHeight = 700L, PanelWidth = 6L, SelectionBoxOpen = FALSE, 
                                          RowSelectionSource = "---", ColumnSelectionSource = "---", 
                                          DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE, 
                                          RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                          SelectionHistory = list())

################################################################################
# Settings for Complex heatmap 1
################################################################################

initial[["ComplexHeatmapPlot1"]] <- new("ComplexHeatmapPlot", Assay = "logcounts", CustomRows = TRUE, 
                                        CustomRowsText = "ENSMUSG00000027273 #Snap25\r\nENSMUSG00000070880 #Gad1\r\nENSMUSG00000026787 # Gad2\r\nENSMUSG00000041607 #Mbp\r\nENSMUSG00000032517 #Mobp\r\nENSMUSG00000020932 #Gfap", 
                                        ClusterRows = TRUE, ClusterRowsDistance = "spearman", ClusterRowsMethod = "ward.D2", 
                                        DataBoxOpen = FALSE, VisualChoices = "Annotations", ColumnData = c("projection", 
                                                                                                           "subclust.neu"), RowData = character(0), CustomBounds = FALSE, 
                                        LowerBound = NA_real_, UpperBound = NA_real_, AssayCenterRows = FALSE, 
                                        AssayScaleRows = FALSE, DivergentColormap = "purple < black < yellow", 
                                        ShowDimNames = "Rows", LegendPosition = "Bottom", LegendDirection = "Horizontal", 
                                        VisualBoxOpen = FALSE, NamesRowFontSize = 10, NamesColumnFontSize = 10, 
                                        ShowColumnSelection = FALSE, OrderColumnSelection = TRUE, 
                                        VersionInfo = list(iSEE = structure(list(c(2L, 14L, 0L)), class = c("package_version", 
                                                                                                            "numeric_version"))), PanelId = c(ComplexHeatmapPlot = 1L), 
                                        PanelHeight = 700L, PanelWidth = 6L, SelectionBoxOpen = FALSE, 
                                        RowSelectionSource = "RowDataTable1", ColumnSelectionSource = "---", 
                                        RowSelectionDynamicSource = TRUE, ColumnSelectionDynamicSource = FALSE, 
                                        RowSelectionRestrict = FALSE, ColumnSelectionRestrict = TRUE, 
                                        SelectionHistory = list())

################################################################################
# Settings for Row data table 1
################################################################################

initial[["RowDataTable1"]] <- new("RowDataTable", Selected = "ENSMUSG00000051951", Search = "", 
                                  SearchColumns = c("", "", "", "", "", "", ""), HiddenColumns = character(0), 
                                  VersionInfo = list(iSEE = structure(list(c(2L, 14L, 0L)), class = c("package_version", 
                                                                                                      "numeric_version"))), PanelId = c(RowDataTable = 1L), PanelHeight = 700L, 
                                  PanelWidth = 4L, SelectionBoxOpen = FALSE, RowSelectionSource = "---", 
                                  ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, 
                                  ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE, 
                                  ColumnSelectionRestrict = FALSE, SelectionHistory = list())

################################################################################
# Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data", 
                                      XAxisColumnData = "subclust.neu", XAxisFeatureName = "ENSMUSG00000051951", 
                                      XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE, 
                                      YAxisFeatureName = "ENSMUSG00000051951", YAxisFeatureSource = "RowDataTable1", 
                                      YAxisFeatureDynamicSource = TRUE, FacetRowByColData = "projection", 
                                      FacetColumnByColData = "Sample", ColorByColumnData = "subclust.neu", 
                                      ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000", 
                                      ShapeByColumnData = "Sample", SizeByColumnData = "e.out_FDR", 
                                      TooltipColumnData = character(0), FacetRowBy = "Column data", 
                                      FacetColumnBy = "None", ColorBy = "Column data", ColorByDefaultColor = "#000000", 
                                      ColorByFeatureName = "ENSMUSG00000051951", ColorByFeatureSource = "---", 
                                      ColorByFeatureDynamicSource = FALSE, ColorBySampleName = "1_AAACCCACAGAGTCTT-1", 
                                      ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE, 
                                      ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1, 
                                      ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = TRUE, 
                                      VisualChoices = c("Color", "Facet"), ContourAdd = FALSE, 
                                      ContourColor = "#0000FF", PointSize = 1, PointAlpha = 1, 
                                      Downsample = FALSE, DownsampleResolution = 200, CustomLabels = FALSE, 
                                      CustomLabelsText = "1_AAACCCACAGAGTCTT-1", FontSize = 1, 
                                      LegendPointSize = 1, LegendPosition = "Bottom", HoverInfo = TRUE, 
                                      LabelCenters = FALSE, LabelCentersBy = "Sample", LabelCentersColor = "#000000", 
                                      VersionInfo = list(iSEE = structure(list(c(2L, 14L, 0L)), class = c("package_version", 
                                                                                                          "numeric_version"))), PanelId = c(FeatureAssayPlot = 1L), 
                                      PanelHeight = 700L, PanelWidth = 8L, SelectionBoxOpen = FALSE, 
                                      RowSelectionSource = "---", ColumnSelectionSource = "---", 
                                      DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE, ColumnSelectionDynamicSource = FALSE, 
                                      RowSelectionRestrict = FALSE, ColumnSelectionRestrict = FALSE, 
                                      SelectionHistory = list())