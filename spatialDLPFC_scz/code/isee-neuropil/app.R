#This will be the app file for this project
library("SingleCellExperiment")
library("iSEE")
library("shiny")
library("paletteer")
library("Polychrome")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialAmygdala/processed-data/Visium/03_qc_metrics/spe_stitched_local_outliers.Rdata"

    ## Location for the https://conn1.libd.org/ server
    #load(posit_connect_file, verbose = TRUE)
sce <- readRDS(posit_connect_file)
initial_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_scz/isee-neuropil/initial.R"



# sce <- readRDS("sce_neuropil_spd.rds")


source(initial_file, print.eval = TRUE)

rownames(sce) <- rowData(sce)$gene_name

domain_colors <- paletteer::paletteer_d(palette = "Polychrome::palette36", n = length(levels(unique(sce$spd_label))))


iSEE(
    sce,
    appTitle = "pseudobulk DLPFC SCZ - neuropil",
    initial = initial,
    colormap = ExperimentColorMap( colData = list(
        DX = function(n) {
            cols = c("blue","red")
            
            cols <- as.vector(cols)
            names(cols) <- levels(sce$DX)
            return(cols)
        }
        ,
        spd_label = function(n) {
            cols <- domain_colors
            cols <- as.vector(cols)
            names(cols) <- levels(sce$spd_label)
            return(cols)
        }
        
    ) )
    
)
