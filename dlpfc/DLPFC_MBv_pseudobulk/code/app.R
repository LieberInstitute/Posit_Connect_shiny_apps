
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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_MBv_pseudobulk/spe_n119_pseudo-no-lowUMI_sample-seurat-pc30_norm-filt.Rdata"


if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
} else {
    load(here::here("dlpfc", "DLPFC_MBv_pseudobulk", "processed-data", "spe_n119_pseudo-no-lowUMI_sample-seurat-pc30_norm-filt.Rdata"))
}

#load("spe_n119_pseudo-no-lowUMI_sample-seurat-pc30_norm-filt.Rdata", verbose = TRUE)
#load("spatial_palettes_isee.rda")

## Don't run this on app.R since we don't want to run this every single time
#lobstr::obj_size(spe_pseudo)

rownames(spe_pseudo) <- rowData(spe_pseudo)$gene_name


source("initial.R", print.eval = TRUE)


#rse_gene <- registerAppOptions(rse_gene, color.maxlevels = length(Sample_ID)
iSEE(
  spe_pseudo,
  appTitle = "pseudobulk DLPFC spatial data, MDD/BPD",
  initial = initial#,
  #colormap = ExperimentColorMap(colData = list(
  #  domain = function(n) {
  #    cols <- spatial.palette
  #  },
  #  broad.domain = function(n) {
  #    cols <- spatial.palette2
  #  }

  #))
)
