library(spatialLIBD)
library(markdown)
library(qs2)

#   For interactive testing at JHPCE
# setwd(here::here('code', '04_shiny', 'MD_domain'))

setwd('/r_data/lcollado/Posit_Connect_shiny_apps/illumina_MD_domain')

discrete_vars = c('^ManualAnnotation$', '^banksy')
continuous_vars = c(
    'sum_umi', 'sum_gene', 'expr_chrM', 'expr_chrM_ratio'
)
# Polychrome::glasbey.colors(28)[2:28] but without the import
cluster_colors = c(
    `1` = "#0000FF", `2` = "#FF0000", `3` = "#00FF00", `4` = "#000033", 
    `5` = "#FF00B6", `6` = "#005300", `7` = "#FFD300", `8` = "#009FFF", 
    `9` = "#9A4D42", `10` = "#00FFBE", `11` = "#783FC1", `12` = "#1F9698", 
    `13` = "#FFACFD", `14` = "#B1CC71", `15` = "#F1085C", `16` = "#FE8F42"
)
main_cluster_var = 'banksy_lam0_8_res1_05'

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

spe = qs_read('spe.qs2')
spe_pb = qs_read('spe_pb_domain.qs2')
modeling_results = qs_read('modeling_results_domain.qs2')
sig_genes = qs_read('sig_genes_domain.qs2')

spe[[main_cluster_var]] = factor(
    spe[[main_cluster_var]], levels = names(cluster_colors)
)
spe_pb[[main_cluster_var]] = factor(
    spe_pb[[main_cluster_var]], levels = names(cluster_colors)
)
stopifnot(!any(is.na(spe_pb[[main_cluster_var]])))
stopifnot(!any(is.na(spe[[main_cluster_var]])))

spe_pb[[paste0(main_cluster_var, "_colors")]] = cluster_colors[
    spe_pb[[main_cluster_var]]
]
spe[[paste0(main_cluster_var, "_colors")]] = cluster_colors[
    spe[[main_cluster_var]]
]

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
    title = "Illumina Br8667 MD Spatial Domains",
    spe_discrete_vars = colnames(colData(spe))[
        grepl(paste(discrete_vars, collapse = "|"), colnames(colData(spe)))
    ],
    spe_continuous_vars = continuous_vars,
    default_cluster = main_cluster_var,
    docs_path = 'www',
    is_stitched = TRUE
)
