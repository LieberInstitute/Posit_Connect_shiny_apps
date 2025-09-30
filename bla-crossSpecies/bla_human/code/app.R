#This will be the app file for this project
library("SingleCellExperiment")
library("iSEE")
library("spatialLIBD")
library("here")
library("paletteer")
library("scuttle")

## spatialLIBD uses golem
options("golem.app.prod" = TRUE)

## You need this to enable shinyapps to install Bioconductor packages
options(repos = BiocManager::repositories())

## Load the data
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/bla-crossspecies/bla-baboon/sce_FINAL_baboon.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)
    #sce <- rda.baboon
    #rm(rda.baboon)
} else {
    load(here::here("bla-crossSpecies", "bla_baboon", "processed-data", "sce_FINAL_baboon.rda"))
    #sce <- rda.baboon
    #rm(rda.baboon)
}

rda.baboon$broad_celltype <- as.factor(rda.baboon$broad_celltype)

source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/bla-crossSpecies/bla_baboon/code/initial.R?raw=TRUE")


mypalette = Polychrome::createPalette(length(unique(rda.baboon$fine_celltype)),  c("#ff0000", "#00ff00", "#0000ff"))
colors <- setNames(mypalette, unique(rda.baboon$fine_celltype))


#increase max number of colors
rda.baboon <- registerAppOptions(rda.baboon, color.maxlevels = length(unique(rda.baboon$fine_celltype)))

#Deploy app
iSEE(
    rda.baboon,
    appTitle = "BLA - Baboon",
    initial = initial,
    colormap = ExperimentColorMap(
        colData = list(fine_celltype = function(x) {
            colors                       # Return color mapping
        })  # Pass the function for fine_celltype colors
    )
)
