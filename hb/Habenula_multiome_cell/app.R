library(SingleCellExperiment)
library(iSEE)
library(shiny)
library(qs2)

#   For interactive testing at JHPCE
# setwd(here::here('code', '16_shiny_app', 'cell_RNA_iSEE'))
setwd('/r_data/lcollado/Posit_Connect_shiny_apps/hb/Habenula_multiome_cell')

source("initial.R")

sce = qs_read('sce_cell_RNA_logcounts.qs2')

iSEE(
    sce,
    appTitle = "Habenula Atlas Multiome RNA Cell-Level Data",
    initial = initial,
    colormap = ExperimentColorMap(colData = list(
        mid_cluster = function(n) {
            return(sce$mid_cluster_colors)
        }
    ))
)
