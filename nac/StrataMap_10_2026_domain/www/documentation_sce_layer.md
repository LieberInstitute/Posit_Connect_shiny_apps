Domain-level documentation
==================================

This document describes the domain-level portion (called "layer-level" in the app) of the Shiny web application made by the  [`spatialLIBD`](https://bioconductor.org/packages/spatialLIBD) Bioconductor package. You can either find the documentation about this package through [Bioconductor](https://bioconductor.org/packages/spatialLIBD) or at the [`spatialLIBD` documentation website](http://lieberinstitute.github.io/spatialLIBD). Below we explain the options common across tabs and each of the tabs at the domain-level data. The nucleus accumbens domain-level data sums counts by main BANKSY domain cluster and sample, retaining groups with at least 10 cells, across donors Br6522, Br3943, and Br3899. PCA and UMAP use the top 1,000 spatially variable genes (SVGs) for the pseudobulk data.

## Slides and videos

You might find the following slides useful for understanding the features from this part of the web application. Particularly slides 10-12 and 15-22.

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/dde92cd6dfc04f9589770e074915658f" title="BioTuring_spatialLIBD" allowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 100%; height: auto; aspect-ratio: 560 / 420;" data-ratio="1.3333333333333333"></iframe>

These slides were part of our 2021-04-27 webinar for BioTuring that you can watch on YouTube:

<iframe width="560" height="315" src="https://www.youtube.com/embed/S8884Kde-1U" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A recording of an earlier version of this talk is also available on YouTube.

<iframe width="560" height="315" src="https://www.youtube.com/embed/aD2JU-vUv54" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

You might also be interested in this video demonstration of `spatialLIBD` for the [LIBD rstats club](http://research.libd.org/rstatsclub/). Particularly starting at minute 26 with 25 seconds.

<iframe width="560" height="315" src="https://www.youtube.com/embed/LZ2kvCiRVdM?start=1584" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Raw summary

This tab summarizes the NAc domain pseudobulk data and model results. From the
`NAc_domain` app directory in the project checkout, load the same inputs with:

```{r}
sce_pseudo <- qs2::qs_read("spe_pb_domain.qs2")
modeling_results <- qs2::qs_read("modeling_results_domain.qs2")
sig_genes <- qs2::qs_read("sig_genes_domain.qs2")
```

## Common options

* `Model results`: the statistical modeling results to use. We computed three different types of models:
  1. `enrichment`: one domain against the rest; reports t-statistics.
  2. `pairwise`: one domain against another; reports t-statistics with two-sided p-values.
  3. `anova`: tests for expression differences across all domains (`all`).

Domains 22, 24, 25, and 26 are represented in only one donor after pseudobulk
filtering. Interpret model results involving these domains cautiously.

## Reduced dim

In this panel you can visualize the domain-level data (`sce_pseudo`) across reduced dimensionality representations derived from the gene expression data from the domain-level pseudo-bulked data. Select which dimensionality reduction method to use with `Reduced Dimension` (PCA or UMAP). Then use `Color by` to choose which variable to color data by, which can be useful to identify groups of pseudo-bulked samples. The `colData` columns are:

* `domains_1_05`: main BANKSY domain cluster.
* `sum_umi`: total number of UMIs in a pseudobulked sample.
* `sum_gene`: total number of genes with nonzero expression in a pseudobulked sample.
* `expr_chrM`: sum of chrM counts in a pseudobulked sample.
* `expr_chrM_ratio`: ratio of `expr_chrM` / `sum_umi`.
* `ncells`: number of cells that were combined when pseudo-bulking.
* `sample_id`: sample identifier.
* `ManualAnnotation`: manual annotation field.

At runtime, a `domains_1_05_colors` column is also added for cluster colors.

```{r}
## Reproduce locally with
scater::plotReducedDim(sce_pseudo)
```

## Model boxplots

This tab shows pseudobulk `logcounts` by domain. Search for a gene by symbol or
Ensembl ID, then select **Model results** and **Model test** to display the
comparison of interest. For example, `1` under `enrichment` compares BANKSY
domain 1 against the other domains.

Below the plot you can find the subset of the table of results  (`sig_genes` from earlier), sort the table by the different columns, and download it as a CSV if you want. For more details about what each of these columns mean, check the [`spatialLIBD` vignette documentation](http://LieberInstitute.github.io/spatialLIBD/articles/spatialLIBD.html#extract-significant-genes).

```{r}
## Reproduce locally with
spatialLIBD::layer_boxplot()
```

## Gene Set Enrichment

This tab allows you to upload a CSV file that has a particular format as illustrated [in this example file](https://github.com/LieberInstitute/spatialLIBD/blob/master/data-raw/asd_sfari_geneList.csv). This CSV file should contain:

* one column per gene set of interest labeled as column names on the first row,
* no row names, 
* and human Ensembl gene IDs as values in the cells. 

Once you have uploaded a CSV file following this specific format, you can then check if the genes on each of your gene sets are enriched among the statistics from `model results` (`enrichment`, etc) that have a false discovery rate (FDR) adjusted p-value less than `FDR cutoff` (0.1 by default).

Similar to the `Model boxplots` tab, you can interact with the results table or download it.

```{r}
## Reproduce locally with
spatialLIBD::gene_set_enrichment()
spatialLIBD::gene_set_enrichment_plot()
```

## Spatial registration

If you have a single nucleus or single cell RNA-sequencing (snRNA-seq)  (scRNA-seq) dataset, you might group your cells into clusters. Once you do, you could compress the data by pseudo-bulking (like we did to go from `spe` to `sce_pseudo`). You could then compute `enrichment` (`pairwise`, `anova`) statistics for your cell clusters. If you do so, you can then upload a specially formatted CSV file just like the one in [this example file](https://github.com/LieberInstitute/spatialLIBD/blob/master/data-raw/tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer.csv). This file has:

* column names,
* human Ensembl gene IDs as the row names (first column, no name for the column),
* statistics (numeric values) for the cells.

The heatmap and correlation table compare your statistics with the NAc domain
statistics using the Ensembl gene IDs present in both datasets. This can help
compare your sn/scRNA-seq clusters or spatial transcriptomics results against
the NAc domains.

Finally, you can change the `Maximum correlation` for visualization purposes on the heatmap as it will change the dynamic range for the colors.

```{r}
## Reproduce locally with
spatialLIBD::layer_stat_cor()
spatialLIBD::layer_stat_cor_plot()
```

