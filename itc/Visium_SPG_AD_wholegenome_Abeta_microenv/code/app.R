
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/itc/Visium_SPG_AD_wholegenome_Abeta_microenv/spe.Rdata"
posit_connect_file1 <- "/r_data/lcollado/Posit_Connect_shiny_apps/itc/Visium_SPG_AD_wholegenome_Abeta_microenv/Visium_SPG_AD_modeling_results.Rdata"
posit_connect_file2 <- "/r_data/lcollado/Posit_Connect_shiny_apps/itc/Visium_SPG_AD_wholegenome_Abeta_microenv/sce_pseudo_pathology_wholegenome.rds"


if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("itc", "Visium_SPG_AD_wholegenome_Abeta_microenv", "processed-data", "spe.Rdata"))
}

if (file.exists(posit_connect_file1)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file1)
} else {
    load(here::here("itc", "Visium_SPG_AD_wholegenome_Abeta_microenv", "processed-data", "Visium_SPG_AD_modeling_results.Rdata"))
}

if (file.exists(posit_connect_file2)) {
    ## Location for the https://conn1.libd.org/ server
    sce_pseudo <- readRDS(posit_connect_file2)
} else {
    sce_pseudo <- readRDS(here::here("itc", "Visium_SPG_AD_wholegenome_Abeta_microenv", "processed-data", "sce_pseudo_pathology_wholegenome.rds"))
}


## Change Braak info based on latest information from LIBD pathology
sce_pseudo$BCrating <- NULL ## This variable was removed from the phenotype table
sce_pseudo$braak <- c("Br3854" = "Stage VI", "Br3873" = "Stage V", "Br3880" = "Stage VI", "Br3874" = "Stage IV")[sce_pseudo$subject]
sce_pseudo$cerad <- c("Br3854" = "Frequent", "Br3873" = "Frequent", "Br3880" = "Frequent", "Br3874" = "None")[sce_pseudo$subject]

## For sig_genes_extract_all() to work
sce_pseudo$spatialLIBD <- sce_pseudo$path_groups
sig_genes <- sig_genes_extract_all(
    n = nrow(sce_pseudo),
    modeling_results = modeling_results,
    sce_layer = sce_pseudo
)

vars <- colnames(colData(spe))
path_vars <- vars[grep("^path_", vars)]
path_vars <- path_vars[!grepl("_colors$", path_vars)]

## Fix colors
to_fix <- is.na(sce_pseudo$path_groups_colors)
sce_pseudo$path_groups_colors[to_fix] <- "#99700FFF"
names(sce_pseudo$path_groups_colors)[to_fix] <- "Ab_env"

## Deploy the website
spatialLIBD::run_app(
    spe,
    sce_layer = sce_pseudo,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "Visium SPG AD (Abeta microenv), Kwon SH et al, 2023",
    spe_discrete_vars = c(
        path_vars,
        "ManualAnnotation",
        vars[grep("^BayesSpace_", vars)],
        vars[grep("^graph_", vars)],
        "edge_spots",
        vars[grep("^scran_", vars)],
        vars[grep("^10x_", vars)]
    ),
    spe_continuous_vars = c(
        "sum_umi",
        "sum_gene",
        "expr_chrM",
        "expr_chrM_ratio",
        "NAbeta",
        "PAbeta",
        "NDAPI",
        "PDAPI",
        "NpTau",
        "PpTau",
        "edge_distance",
        vars[grep("^c2l_", vars)]
    ),
    default_cluster = "path_groups",
    docs_path = "www"
)
