#This will be the app file for this project

library("iSEE")
library("spatialLIBD")
library("here")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_scz/isee-vasc/sce_vasc_spd_pvals.rds"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    sce <- readRDS(posit_connect_file)
} else {
    sce <- readRDS(here::here("spatialDLPFC_scz/processed-data/iSEE-apps/vasc/sce_vasc_spd_pvals.rds"))
}

#sce <- readRDS(posit_connect_file)

#load initial.R setup file for iSEE apps
initial_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/spatialDLPFC_scz/isee-vasc/initial.R"
if (file.exists(initial_file)) {
    source(initial_file, print.eval = TRUE)
} else  {
    source(here::here("spatialDLPFC_scz/processed-data/iSEE-apps/vasc/initial.R"), print.eval = TRUE)
}



# sce <- readRDS("sce_neuropil_spd.rds")




#rownames(sce) <- rowData(sce)$gene_name

domain_colors <- paletteer::paletteer_d(palette = "Polychrome::palette36", n = length(levels(unique(sce$spd_label))))


iSEE(
    sce,
    appTitle = "pseudobulk DLPFC SCZ - vasculature",
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
