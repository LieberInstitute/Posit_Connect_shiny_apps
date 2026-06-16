
#This will be the app file for this project
library("spatialLIBD")
library("here")
library("devtools")
library("HDF5Array")
library("markdown")
library("SingleCellExperiment")
library("iSEE")
## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())



## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_MBv_pseudobulk/iSEE_pseudobulk-spe_both-annotations.rds"


if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    spe <- readRDS(here::here("dlpfc", "DLPFC_MBv_pseudobulk", "processed-data", "iSEE_pseudobulk-spe_both-annotations.rds"))
}

#load("spe_n119_pseudo-no-lowUMI_sample-seurat-pc30_norm-filt.Rdata", verbose = TRUE)
#load("spatial_palettes_isee.rda")

## Don't run this on app.R since we don't want to run this every single time
#lobstr::obj_size(spe_pseudo)

rownames(spe) <- rowData(spe)$gene_name

# read in custom functions
#source("iSEE_custom-plot_utils.r")

source("initial.R", print.eval = TRUE)


ecm <- ExperimentColorMap(

    # Use standard viridis for everything else
    global_continuous = viridis::viridis
)

#rse_gene <- registerAppOptions(rse_gene, color.maxlevels = length(Sample_ID)
iSEE(
  spe,
  appTitle = "pseudobulk DLPFC spatial data, MDD/BPD",
  initial = initial,
  colormap = ecm
  #colormap = ExperimentColorMap(colData = list(
  #  domain = function(n) {
  #    cols <- spatial.palette
  #  },
  #  broad.domain = function(n) {
  #    cols <- spatial.palette2
  #  }

  #))
)
