## Cell-level data

**Raw summary** describes the [`SpatialExperiment`](https://bioconductor.org/packages/SpatialExperiment)
for nucleus accumbens (NAc) cells from Br6522, Br3943, and Br3899. Use
**Interactive** to examine gene expression and cell labels together in one donor,
or **Static grid** to compare donors. These replace the separate gene and
cluster views in older versions of [spatialLIBD](https://lieberinstitute.github.io/spatialLIBD/).

## Shared controls

- **Sample** selects the donor in **Interactive**. **Static grid** has its own
  **Samples** selector.
- **Histology image** selects the background or hides it with **None**.
  **Interactive** supports tiled full-resolution histology; **Static grid** and
  **Edit image** use low-resolution images.
- **Discrete variable** selects the labels to display. Use **Clusters to show**
  to restrict which labels are visible. Available columns include:
  - `ManualAnnotation`: labels added during the session or imported from a CSV.
  - `celltyping_<token>`, `celltyping_supp_<token>`, `domains_<token>`, and
    `domains_supp_<token>`: 48 BANKSY label columns, from four runs at 12 Leiden
    resolutions each. Cell typing uses lambda 0.2 and k = 15; domains use lambda
    0.9 and k = 25. All runs use Harmony. The supplemented runs replace genes in
    the spatially variable gene set, not cells. Resolution tokens replace the
    decimal point with an underscore (for example, `0_4` for 0.4). This app
    defaults to `celltyping_0_4`, also used for its pseudobulk data.
  - `rctd_cell_type`: unsmoothed RCTD `first_type` calls, including eligible
    doublets. `Dropped` remains a separate label.
  - `rctd_domain_raw` and `rctd_domain_smoothed`: labels inherited from bins,
    before and after smoothing bin weights within each donor, respectively.
- **Continuous feature(s)** accepts genes by symbol or Ensembl ID and the QC
  columns below. **Assay** is `logcounts` in this dataset; raw counts are not
  included. When selecting multiple features, use **Combine features** to choose
  **Mean Z-score**, **PC1**, or **Proportion nonzero**.

  | Column | Meaning |
  | --- | --- |
  | `sum_umi` | Total UMIs per cell |
  | `sum_gene` | Genes with nonzero counts per cell |
  | `expr_chrM` | Mitochondrial UMIs per cell |
  | `expr_chrM_ratio` | Fraction of UMIs from mitochondrial genes |

- **Show values greater than** filters by the continuous value; **Maximum
  percentile (0–1)** caps values used for coloring.
- **Embedding** selects PCA, UMAP, or **None** to hide the embedding panels.

Under **Appearance**, use **Show settings** to adjust the cell boundary style,
palettes, image and cell opacity, and point sizes. Changes apply immediately in
**Interactive**; click **Update grid** to apply them in **Static grid**.

## Interactive

The spatial panels show the same cells colored by the selected continuous
feature and discrete label. The optional embedding panels show the same
colorings in PCA or UMAP space. Hover over a cell for details. Use **Pan**, the
zoom buttons, or **Reset view** to navigate. Zoom in on the histology to see the
vendor's expanded 5 µm contours. These outlines are not independently validated
cell membranes.

Use **Select** to pick individual cells or **Lasso** to select a group. Selections
are linked across panels. Hold **Shift** to add to a selection or **Alt** to
remove from it. To annotate, enter a **Manual annotation label** and click
**Label selected units**, or enable **Annotate individual units on click**.
**Undo last annotation** reverses the latest labeling action or import. Choose
`ManualAnnotation` as the **Discrete variable** to see your labels.

## Static grid

Use **Color by** to choose **Continuous** or **Discrete**, then choose the donor
order under **Samples** and set **Rows** and **Columns**. Use **Show histology**
to display the image behind the cells, or **Image beside features** to compare
them side by side. **Point size (mm)** controls the size of the cell markers.
The grid draws points, not outlines; use **Interactive** for detailed inspection.

Click **Update grid** after changing settings. **Download plot** exports the
last updated grid as PDF when fewer than 50,000 cells are displayed per sample
on average, or as a 300 dpi PNG otherwise.

## Edit image

Adjust the thumbnail appearance and click **Update custom image**, then select
`edited_imaged` under **Histology image**. Edits apply to the low-resolution
variants for all donors and do not modify the full-resolution pyramids.

## Save and restore annotations

Annotations are session-specific. Click **Download annotations** before closing
the app. **Omit unlabeled units from CSV** is selected by default. To restore
labels, use **Import annotations** with a CSV containing `sample_id`, `spot_name`
(the exported cell identifier), and `ManualAnnotation`. Later imports replace
labels for matching cells.
