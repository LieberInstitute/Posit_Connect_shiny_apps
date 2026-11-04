library(spatialLIBD)
library(markdown)
library(qs2)
library(Polychrome)

# For interactive testing at JHPCE:
# setwd(here::here('code', '04_shiny', 'NAc_cell'))
setwd('/r_data/lcollado/Posit_Connect_shiny_apps/nac/StrataMap_10_2026_cell')

discrete_vars = c(
    '^ManualAnnotation$', '^(celltyping|domains)_', '^rctd_cell_type$',
    '^rctd_domain_raw$', '^rctd_domain_smoothed$'
)
continuous_vars = c('sum_umi', 'sum_gene', 'expr_chrM', 'expr_chrM_ratio')
main_cluster_var = 'celltyping_0_4'

## spatialLIBD uses golem
options('golem.app.prod' = TRUE)
options(repos = BiocManager::repositories())

spe = qs_read('spe.qs2')
spe_pb = qs_read('spe_pb_cell.qs2')
modeling_results = qs_read('modeling_results_cell.qs2')
sig_genes = qs_read('sig_genes_cell.qs2')

# Accept previously prepared objects without rewriting expression data.
short_names = function(names) {
    names = sub('^banksy_(celltyping|domains)_svg3000_lam.*_res', '\\1_', names)
    names = sub('^banksy_(celltyping|domains)_supplemented3000_lam.*_res', '\\1_supp_', names)
    stopifnot(!anyDuplicated(names))
    names
}
colnames(colData(spe)) = short_names(colnames(colData(spe)))
colnames(colData(spe_pb)) = short_names(colnames(colData(spe_pb)))

spe_discrete_vars = colnames(colData(spe))[
    grepl(paste(discrete_vars, collapse = '|'), colnames(colData(spe))) &
        !grepl('_colors$', colnames(colData(spe)))
]
stopifnot(main_cluster_var %in% spe_discrete_vars,
          main_cluster_var %in% colnames(colData(spe_pb)))

cluster_colors = function(labels) {
    n = length(labels)
    colors = c(unname(glasbey.colors(32)[-1]), unname(palette36.colors(36))[32:36])
    if (n > 36L) colors = c(colors, grDevices::hcl.colors(n - 36L, 'Dynamic'))
    setNames(colors[seq_len(n)], labels)
}
for (variable in spe_discrete_vars) {
    if (!is.factor(spe[[variable]])) spe[[variable]] = factor(spe[[variable]])
    colors = cluster_colors(levels(spe[[variable]]))
    spe[[paste0(variable, '_colors')]] = colors[as.character(spe[[variable]])]
}

spe_pb[[main_cluster_var]] = factor(
    spe_pb[[main_cluster_var]], levels = levels(spe[[main_cluster_var]])
)
colors = cluster_colors(levels(spe[[main_cluster_var]]))
spe_pb[[paste0(main_cluster_var, '_colors')]] = colors[
    as.character(spe_pb[[main_cluster_var]])
]
stopifnot(!anyNA(spe_pb[[main_cluster_var]]), length(reducedDims(spe)) == 0L)
run_app(
    spe,
    sce_layer = spe_pb,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = 'Illumina NAc Cell Types',
    spe_discrete_vars = spe_discrete_vars,
    spe_continuous_vars = continuous_vars,
    default_cluster = main_cluster_var,
    docs_path = 'www',
    is_stitched = TRUE
)
