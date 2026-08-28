library(spatialLIBD)
library(markdown)
library(qs2)

#   For interactive testing at JHPCE
# setwd(here::here('code', '04_shiny'))

discrete_vars = c('^ManualAnnotation$', '^banksy')
continuous_vars = c(
    'sum_umi', 'sum_gene', 'expr_chrM', 'expr_chrM_ratio'
)
# Polychrome::glasbey.colors(28)[2:28] but without the import
cluster_colors = c(
    `1` = "#0000FF", `2` = "#FF0000", `3` = "#00FF00", `4` = "#000033", 
    `5` = "#FF00B6", `6` = "#005300", `7` = "#FFD300", `8` = "#009FFF", 
    `9` = "#9A4D42", `10` = "#00FFBE", `11` = "#783FC1", `12` = "#1F9698", 
    `13` = "#FFACFD", `14` = "#B1CC71", `15` = "#F1085C", `16` = "#FE8F42", 
    `17` = "#DD00FF", `18` = "#201A01", `19` = "#720055", `20` = "#766C95", 
    `21` = "#02AD24", `22` = "#C8FF00", `23` = "#886C00", `24` = "#FFB79F", 
    `25` = "#858567", `26` = "#A10300", `27` = "#14F9FF"
)

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

spe = qs_read('spe_shiny.qs2')
spe_pb = qs_read('spe_pb.qs2')
modeling_results = qs_read('modeling_results.qs2')
sig_genes = qs_read('sig_genes.qs2')

spe_pb$banksy = factor(
    spe_pb$banksy,
    levels = as.character(sort(unique(as.numeric(spe_pb$banksy))))
)
spe_pb$banksy_lam0_2_res2 = spe_pb$banksy
spe_pb$banksy = NULL

spe_pb$banksy_lam0_2_res2_colors = cluster_colors[spe_pb$banksy_lam0_2_res2]
spe$banksy_lam0_2_res2_colors = cluster_colors[spe$banksy_lam0_2_res2]

#   Fake registration stats just to get the app to run. The idea is that there's
#   no clean way to compute pairwise or ANOVA modeling stats with one sample (at
#   least with meaningful significance estimates), so we'll just provide
#   enrichment stats
modeling_results$pairwise = data.frame(
    ensembl = c(1),
    t_stat_dummy = c(1),
    p_value_dummy = c(1),
    fdr_dummy = c(1)
)
modeling_results$anova = data.frame(
    ensembl = c(1),
    f_stat_dummy = c(1),
    p_value_dummy = c(1),
    fdr_dummy = c(1)
)

## Deploy the website
run_app(
    spe,
    sce_layer = spe_pb,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "Illumina Early Access Br8667",
    spe_discrete_vars = colnames(colData(spe))[
        grepl(paste(discrete_vars, collapse = "|"), colnames(colData(spe)))
    ],
    spe_continuous_vars = continuous_vars,
    default_cluster = "banksy_lam0_2_res2",
    docs_path = 'www',
    is_stitched = TRUE
)
