This document describes this Shiny web application made by the  [`spatialLIBD`](https://bioconductor.org/packages/spatialLIBD) Bioconductor package. You can either find the documentation about this package through [Bioconductor](https://bioconductor.org/packages/spatialLIBD) or at the [`spatialLIBD` documentation website](http://lieberinstitute.github.io/spatialLIBD). Below we explain the options common across tabs.

## Documentation video

You might be interested in this video demonstration of `spatialLIBD` for the [LIBD rstats club](http://research.libd.org/rstatsclub/).

<iframe width="560" height="315" src="https://www.youtube.com/embed/LZ2kvCiRVdM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Raw summary

Before the documentation, this tab displays the [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment) object that contains the cell-level data. It's basically useful to know that the data has been loaded and that you can start navigating the app. Throughout the rest of this document, we'll refer to this object by the name `spe`.

## Common options

* `Sample`: which sample to plot on the `Interactive` tab.
* `Histology image`: which image resolution to use in the `Interactive` tab.
* `Discrete variable to plot`: which discrete variable (typically with the cluster labels) to visualize. We include the clusters:
  - `ManualAnnotation`: your own annotations of each cell.
  - `ficture_cluster`: the dominant `FICTURE` cluster present in nearby extracellular bins
  - `banksy_cluster`: cell-level clusters found by `Banksy`.
  - `cell_type`: cell types corresponding to the `banksy_cluster` clusters.
* `Reduced dimensions`: which reduced dimension to visualize on the `clusters (interactive)` tab. Only the first two dimensions will be shown.
* `Continuous feature(s)`: which gene(s) or continuous variable(s) (such as the cell count, the ratio of the mitochondrial chromosome expression) to visualize in the `Interactive` and `Static grid` tabs. Multiple choices may be selected, in which case `Combine features` controls the method used to combine information from all selected variables.
* `Combine features`: when selecting more than one continuous variable, the method used to combine information from all selected variables. See [the multi gene plots vignette](https://research.libd.org/spatialLIBD/articles/multi_gene_plots.html) for more information about these methods for combining multiple continuous variables.
  * `z_score`: to summarize multiple continuous variables, each is normalized to represent a Z-score. The multiple scores are then averaged.
  * `pca`: PCA dimension reduction is conducted on the matrix formed by the continuous variables, and the first PC is then used and multiplied by -1 if needed to have the majority of the values for PC1 to be positive. 
  * `sparsity`: the proportion of continuous variables with positive values for each spot is computed.
* `Assay`: typically counts or logcounts: the gene expression assay to use.
* `Embedding`: which reduced dimension to visualize on the `Interactive` tab. Only the first two dimensions will be shown.
* `Clusters to show`: optional filters on the discrete variable's values shown in the `Interactive` and `Static grid` tabs.
* `Show values greater than`: Values from the selected `Continuous feature(s)` at or below this threshold will not be displayed.
* `Maximum percentile`: Sets the maximum count to display based on percentile, with acceptable values in (0, 1]. For example, a value of 0.95 sets the top 5% of counts to the value at the 95th percentile. This can be useful to make the color scale more dynamic in the presence of a small set of high outliers. This setting applies to plots of continuous variables only.

## Appearance-related options

Click `Appearance` / `Show settings` in the sidebar to reveal these controls. Changes apply immediately in `Interactive`; click `Update grid` to apply shared appearance settings to the `Static grid` and its download.

* `Cell/spot boundaries`: when boundaries were included in the prepared inputs, choose `Outlines` (default) to show their edges or `Filled` to color their interiors using the continuous or discrete values. Boundaries appear as you zoom into the spatial panels; at wider views, units are shown as points. This setting applies only to the spatial panels in `Interactive`. Static grids always use points.
* `Discrete palette`: choose colors for the categories of the selected `Discrete variable`, in both `Interactive` and `Static grid`. Choices include supplied colors from a matching metadata column (for example, `BayesSpace_colors` for `BayesSpace`) and palettes with enough colors for the categories. Historical LIBD layer annotations retain their established colors.
* `Reverse discrete palette`: reverse the order of colors assigned from a generated discrete palette. This does not reverse supplied colors or the fixed colors for historical LIBD annotations.
* `Continuous palette`: choose the color scale for the selected continuous feature or combined score, in both `Interactive` and `Static grid`. The default is the color-blind-friendly `viridis` palette; other options include `magma`, `inferno`, `plasma`, `cividis`, `rocket`, `mako`, `turbo`, and the custom `paper` scale.
* `Dark to light`: control the direction of the continuous palette. Checked by default, this maps lower values toward the dark end and higher values toward the light end of the default `viridis` scale. Unchecking it reverses the selected scale, including the custom `paper` scale.
* `Unit opacity`: set the opacity of spatial units (e.g. spots or cells) and embedding points from 0 (transparent) to 1 (opaque, the default). Lower values can help reveal the histology beneath spatial units. This setting applies to `Interactive` and `Static grid`; units excluded by filters remain hidden.
* `Image opacity`: set the histology background opacity in the spatial panels of `Interactive`, from 0 (hidden) to 1 (opaque). The default is 0.8. This is independent of `Unit opacity` and does not change the static grid's background.
* `Point size adjustment`: multiply the automatically chosen point radius in `Interactive`. A value of 1 (default) uses the suggested radius, 2 doubles it, and 0.5 halves it. Automatic sizing uses the sample's local point spacing and the panel dimensions, with separate estimates for spatial and embedding panels. Filtering does not change the suggested size. This control does not resize segmentation boundaries. The `Static grid` has its own `Point size (mm)` control.
* `Legend point size`: change the size of point symbols in the discrete legend of the `Static grid`. This does not change the plotted spatial units or the interactive legends.

Annotation download and import are covered under `Interactive` below.

## Interactive

Explore one sample in linked panels: spatial views above and the selected embedding below, with continuous values on the left and discrete categories on the right. Choose `None` under `Embedding` to hide the lower panels. Sidebar filters apply to all panels.

* **Navigate:** use `Pan` to drag, scroll or use the +/− buttons to zoom, and expand a panel for a closer look. Spatial panels share one view; embedding panels share another. `Reset view` fits the data again. Full-resolution histology reveals more detail as you zoom, and segmentation boundaries appear when available.
* **Inspect and select:** hover for unit details; click a unit, drag a rectangle with `Select`, or draw a region with `Lasso`. Selections highlight the same units across all panels. Hold Shift to add or Alt to remove units; use `Clear selection` to start over. The status shows visible and selected unit counts.
* **Annotate:** enter a `Manual annotation label` and click `Label selected units`, or enable `Annotate individual units on click`. `Undo last annotation` reverses the latest label change or annotation import. Choose `ManualAnnotation` as the discrete variable to see your labels.
* **Save and restore:** annotations belong to your current session, so use `Download annotations` before closing it. `Omit unlabeled units from CSV` is enabled by default. Restore labels with `Import annotations`; CSV files require `sample_id`, `spot_name`, and `ManualAnnotation` columns. Later imported files overwrite earlier labels for matching units.

## Static grid

Compare selected samples in a grid of spatial plots, colored by continuous values or discrete categories. Units are always shown as points; use `Interactive` for zooming, selection, and segmentation boundaries.

* **Choose and arrange:** set `Color by` to `Continuous` or `Discrete`, choose `Samples` in the desired display order, and set positive whole numbers for `Rows` and `Columns`. Extra rows are added if needed; wide grids scroll horizontally. The grid's sample selection is independent of the sidebar's `Sample` selector.
* **Style:** toggle `Show histology` or `Image beside features`, and adjust `Point size (mm)`. Histology uses low-resolution images, even when a full-resolution pyramid is selected. Sidebar features, filters, palettes, unit opacity, and legend point size also apply.
* **Update and download:** click `Update grid` after changing settings. `Download plot` exports the displayed grid using its saved settings, dimensions, and point sizes. The format is PDF when the average number of displayed units per sample is below 50,000, or a 300 dpi PNG otherwise.
```

## Edit image

This panel shows you all the options we have for manipulating the colors and properties of the selected background image. These results will be available under the `edited_image` option in the image chooser menu. You can perform sequential manipulations of the image, though it will get hard to keep track of all the changes you made.

```{r}
## Reproduce locally with
spatialLIBD::img_update_all()
```
