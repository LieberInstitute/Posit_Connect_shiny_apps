library(spatialLIBD)
library(markdown)
library(qs2)

#   For interactive testing at JHPCE
# setwd(here::here('code', '04_shiny'))
setwd('/r_data/lcollado/Posit_Connect_shiny_apps/illumina_early_access')

discrete_vars = c('^ManualAnnotation$', '^banksy')
continuous_vars = c(
    'sum_umi', 'sum_gene', 'expr_chrM', 'expr_chrM_ratio'
)

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

spe = qs_read('spe_shiny.qs2')

## Deploy the website
run_app(
    spe,
    sce_layer = NULL,
    modeling_results = NULL,
    sig_genes = NULL,
    title = "Illumina Early Access Br8667",
    spe_discrete_vars = colnames(colData(spe))[
        grepl(paste(discrete_vars, collapse = "|"), colnames(colData(spe)))
    ],
    spe_continuous_vars = continuous_vars,
    default_cluster = "banksy_lam0_8_res0_575",
    docs_path = 'www',
    is_stitched = TRUE
)
