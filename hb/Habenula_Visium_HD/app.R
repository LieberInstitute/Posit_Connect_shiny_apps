library(spatialLIBD)
library(markdown)
library(qs2)

discrete_vars = c(
    'ManualAnnotation', 'ficture_cluster', 'banksy_cluster', 'cell_type',
    'cell_type_colors'
)
continuous_vars = c(
    'bin_count', 'sum_umi', 'sum_gene', 'expr_chrM', 'expr_chrM_ratio'
)
all_vars_pb = c(
    'cell_type', 'cell_type_colors', 'sum_umi', 'sum_gene', 'expr_chrM',
    'expr_chrM_ratio', 'ncells', 'sample_id', 'donor'
)

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

#   Load objects
dataset <- spatialLIBD::open_app_dataset(
    "/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_Visium_HD/app_inputs"
)
modeling_results = qs_read('modeling_results.qs2')
sce_pb = qs_read('sce_pb_shiny.qs2')
sig_genes = qs_read('sig_genes_shiny.qs2')

stopifnot(all(all_vars_pb %in% colnames(colData(sce_pb))))
colData(sce_pb) = colData(sce_pb)[, all_vars_pb]

## Deploy the website
run_app(
    dataset,
    sce_layer = sce_pb,
    modeling_results = modeling_results,
    sig_genes = sig_genes,
    title = "habenula_atlas_Visium_HD",
    spe_discrete_vars = discrete_vars,
    spe_continuous_vars = continuous_vars,
    default_cluster = "cell_type",
    docs_path = 'www',
    is_stitched = TRUE
)
