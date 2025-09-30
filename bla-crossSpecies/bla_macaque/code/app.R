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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/bla-crossspecies/bla-macaque/sce_FINAL_macaque.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)

} else {
    load(here::here("bla-crossSpecies", "bla_macaque", "processed-data", "sce_FINAL_macaque.rda"))

}

rda.macaque$broad_celltype <- as.factor(rda.macaque$broad_celltype)

source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/bla-crossSpecies/bla_macaque/code/initial.R?raw=TRUE")


mypalette = Polychrome::createPalette(length(unique(rda.macaque$fine_celltype)),  c("#ff0000", "#00ff00", "#0000ff"))
colors <- setNames(mypalette, unique(rda.macaque$fine_celltype))


#increase max number of colors
rda.macaque <- registerAppOptions(rda.macaque, color.maxlevels = length(unique(rda.macaque$fine_celltype)))

#Deploy app
iSEE(
    rda.macaque,
    appTitle = "BLA - Macaque",
    initial = initial,
    colormap = ExperimentColorMap(
        colData = list(fine_celltype = function(x) {
            colors                       # Return color mapping
        })  # Pass the function for fine_celltype colors
    )
)
