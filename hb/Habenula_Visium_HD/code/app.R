library(spatialLIBD)
library(markdown)
library(tidyverse)
library(here)

#   At JHPCE
#setwd(here("code", "14_HD_shiny"))

options("golem.app.prod" = TRUE)
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_HD/spe_norm_filtered_split.rds"
if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    spe <- readRDS(posit_connect_file)
} else {
    spe = readRDS(here::here("hb", "Habenula_Visium_HD", "processed-data", "spe_norm_filtered_split.rds"))
}

posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_HD/cluster_annotation.csv"
if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    anno_df = read_csv(posit_connect_file1)
} else {
    anno_df = read_csv(here::here("hb", "Habenula_Visium_HD", "processed-data", "cluster_annotation.csv"), show_col_types = FALSE)
}


posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_HD/leiden_res1_8.csv"
if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    cluster_gf = read_csv(posit_connect_file2)
} else {
    cluster_gf = read_csv(here::here("hb", "Habenula_Visium_HD", "processed-data", "leiden_res1_8.csv"), show_col_types = FALSE)
}

#spe = readRDS("spe_norm_filtered_split.rds")

#anno_df = read_csv("cluster_annotation.csv", show_col_types = FALSE)

#   Tibble including banksy cluster and cell type
extra_coldata = tibble(key = spe$key) |>
    left_join(
        cluster_gf, by = 'key'
    ) |>
    mutate(
        cell_type = anno_df$fine_cell_type[
            match(as.character(banksy), anno_df$cluster)
        ]
    )
stopifnot(!any(is.na(extra_coldata$cell_type)))

spe$banksy = extra_coldata$banksy
spe$cell_type = extra_coldata$cell_type

# lobstr::obj_size(spe) is 3.95GB as of 2026-03-05

vars <- colnames(colData(spe))
run_app(
    spe = spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    spe_discrete_vars = c(
        "ManualAnnotation",
        "exclude_overlapping",
        "banksy",
        "cell_type"
    ),
    spe_continuous_vars = c(
        "bin_count",
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio"
    ),
    default_cluster = "cell_type",
    docs_path = "www",
    is_stitched = TRUE
)
