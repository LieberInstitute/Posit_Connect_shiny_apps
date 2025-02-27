# cd /dcs04/lieber/marmaypag/spatialDLPFC_mdd_bpd_LIBD4100/spatialDLPFC_mdd_bpd

library("HDF5Array")
library("SpatialExperiment")
library("here")
library("lobstr")
library("sessioninfo")

spe <- loadHDF5SummarizedExperiment(
    dir = here::here("processed-data/04_feature_selection"),
    prefix = "spe_n120_postQC_norm_"
)
spe_with_images <- loadHDF5SummarizedExperiment(
    dir = here::here("processed-data/02_build_spe"),
    prefix = "spe_n120_imgs_"
)

## Merge the two objects
m <- match(imgData(spe)$sample_id, imgData(spe_with_images)$sample_id)
stopifnot(!any(is.na(m)))

imgData(spe) <- imgData(spe_with_images)[m, ]
rm(spe_with_images)

## Coerce to a sparse matrix
counts(spe) <- NULL
logcounts(spe) <- as(logcounts(spe), "dgCMatrix")
# Error: vector memory limit of 64.0 Gb reached, see mem.maxVSize()

Sys.time()
lobstr::obj_size(spe)
Sys.time()

## Save later use
saveRDS(
  spe,
  file = here("processed-data", "04_feature_selection", "spatialDLPFC_mdd_bpd_spe.rds")
)

## Reproducibility information
print("Reproducibility information:")
Sys.time()
proc.time()
options(width = 120)
session_info()
# ─ Session info ───────────────────────────────────────────────────────────────────
#  setting  value
#  version  R version 4.4.3 RC (2025-02-20 r87831)
#  os       Rocky Linux 9.4 (Blue Onyx)
#  system   x86_64, linux-gnu
#  ui       X11
#  language (EN)
#  collate  en_US.UTF-8
#  ctype    en_US.UTF-8
#  tz       US/Eastern
#  date     2025-02-27
#  pandoc   3.2 @ /jhpce/shared/community/core/conda_R/4.4.x/bin/pandoc
#  quarto   NA
#
# ─ Packages ───────────────────────────────────────────────────────────────────────
#  package              * version date (UTC) lib source
#  abind                * 1.4-8   2024-09-12 [2] CRAN (R 4.4.1)
#  Biobase              * 2.66.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  BiocGenerics         * 0.52.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  cli                    3.6.4   2025-02-13 [2] CRAN (R 4.4.2)
#  colorout             * 1.3-2   2024-11-21 [1] Github (jalvesaq/colorout@2a5f214)
#  colorspace             2.1-1   2024-07-26 [2] CRAN (R 4.4.1)
#  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.4.1)
#  DelayedArray         * 0.32.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.4.1)
#  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.4.0)
#  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.4.0)
#  generics               0.1.3   2022-07-05 [2] CRAN (R 4.4.0)
#  GenomeInfoDb         * 1.42.3  2025-01-27 [2] Bioconductor 3.20 (R 4.4.2)
#  GenomeInfoDbData       1.2.13  2024-10-01 [2] Bioconductor
#  GenomicRanges        * 1.58.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  ggplot2                3.5.1   2024-04-23 [2] CRAN (R 4.4.0)
#  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.4.1)
#  gtable                 0.3.6   2024-10-25 [2] CRAN (R 4.4.2)
#  HDF5Array            * 1.34.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  here                 * 1.0.1   2020-12-13 [2] CRAN (R 4.4.0)
#  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.4.0)
#  htmlwidgets            1.6.4   2023-12-06 [2] CRAN (R 4.4.0)
#  httpuv                 1.6.15  2024-03-26 [2] CRAN (R 4.4.0)
#  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.4.0)
#  IRanges              * 2.40.1  2024-12-05 [2] Bioconductor 3.20 (R 4.4.2)
#  jsonlite               1.9.0   2025-02-19 [2] CRAN (R 4.4.3)
#  later                  1.4.1   2024-11-27 [2] CRAN (R 4.4.2)
#  lattice                0.22-6  2024-03-20 [3] CRAN (R 4.4.3)
#  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.4.0)
#  lobstr               * 1.1.2   2022-06-22 [2] CRAN (R 4.4.0)
#  magick                 2.8.5   2024-09-20 [2] CRAN (R 4.4.1)
#  magrittr               2.0.3   2022-03-30 [2] CRAN (R 4.4.0)
#  Matrix               * 1.7-2   2025-01-23 [3] CRAN (R 4.4.3)
#  MatrixGenerics       * 1.18.1  2025-01-09 [2] Bioconductor 3.20 (R 4.4.2)
#  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.4.2)
#  munsell                0.5.1   2024-04-01 [2] CRAN (R 4.4.0)
#  pillar                 1.10.1  2025-01-07 [2] CRAN (R 4.4.2)
#  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.4.0)
#  png                    0.1-8   2022-11-29 [2] CRAN (R 4.4.0)
#  prettyunits            1.2.0   2023-09-24 [2] CRAN (R 4.4.0)
#  promises               1.3.2   2024-11-28 [2] CRAN (R 4.4.2)
#  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.4.2)
#  Rcpp                   1.0.14  2025-01-12 [2] CRAN (R 4.4.2)
#  rhdf5                * 2.50.2  2025-01-09 [2] Bioconductor 3.20 (R 4.4.2)
#  rhdf5filters           1.18.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  Rhdf5lib               1.28.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  rjson                  0.2.23  2024-09-16 [2] CRAN (R 4.4.1)
#  rlang                  1.1.5   2025-01-17 [2] CRAN (R 4.4.2)
#  rmote                  0.3.4   2024-10-18 [1] Github (cloudyr/rmote@fbce611)
#  rprojroot              2.0.4   2023-11-05 [2] CRAN (R 4.4.0)
#  S4Arrays             * 1.6.0   2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  S4Vectors            * 0.44.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  scales                 1.3.0   2023-11-28 [2] CRAN (R 4.4.0)
#  servr                  0.32    2024-10-04 [1] CRAN (R 4.4.1)
#  sessioninfo          * 1.2.3   2025-02-05 [2] CRAN (R 4.4.2)
#  SingleCellExperiment * 1.28.1  2024-11-10 [2] Bioconductor 3.20 (R 4.4.2)
#  SparseArray          * 1.6.2   2025-02-20 [2] Bioconductor 3.20 (R 4.4.3)
#  SpatialExperiment    * 1.16.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  SummarizedExperiment * 1.36.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  tibble                 3.2.1   2023-03-20 [2] CRAN (R 4.4.0)
#  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.4.0)
#  UCSC.utils             1.2.0   2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.4.0)
#  xfun                   0.51    2025-02-19 [2] CRAN (R 4.4.3)
#  XVector                0.46.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#  zlibbioc               1.52.0  2024-10-29 [2] Bioconductor 3.20 (R 4.4.2)
#
#  [1] /users/lcollado/R/4.4.x
#  [2] /jhpce/shared/community/core/conda_R/4.4.x/R/lib64/R/site-library
#  [3] /jhpce/shared/community/core/conda_R/4.4.x/R/lib64/R/library
#  * ── Packages attached to the search path.
#
# ──────────────────────────────────────────────────────────────────────────────────
