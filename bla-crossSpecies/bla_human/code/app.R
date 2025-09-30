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
posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/bla-crossspecies/bla-human/sce_FINAL_human.rda"

if (file.exists(posit_connect_file)) {
    ## Location for the https://conn1.libd.org/ server
    load(posit_connect_file)

} else {
    load(here::here("bla-crossSpecies", "bla_human", "processed-data", "sce_FINAL_human.rda"))

}

rda.human$broad_celltype <- as.factor(rda.human$broad_celltype)

source("https://github.com/LieberInstitute/Posit_Connect_shiny_apps/blob/devel/bla-crossSpecies/bla_human/code/initial.R?raw=TRUE")


mypalette = Polychrome::createPalette(length(unique(rda.human$fine_celltype)),  c("#ff0000", "#00ff00", "#0000ff"))
colors <- setNames(mypalette, unique(rda.human$fine_celltype))


#increase max number of colors
rda.human <- registerAppOptions(rda.human, color.maxlevels = length(unique(rda.human$fine_celltype)))

#Deploy app
iSEE(
    rda.human,
    appTitle = "BLA - Human",
    initial = initial,
    colormap = ExperimentColorMap(
        colData = list(fine_celltype = function(x) {
            colors                       # Return color mapping
        })  # Pass the function for fine_celltype colors
    )
)
