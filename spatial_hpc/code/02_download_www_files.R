library("spatialLIBD")
library("here")
library("sessioninfo")

## Locate spatialLIBD www files
original <- system.file("app", "www", package = "spatialLIBD")
file.copy(original, here("spatial_hpc", "code"), recursive = TRUE)

## Use favicon from spatial_hpc
download.file(
  "https://raw.githubusercontent.com/LieberInstitute/spatial_hpc/refs/heads/gh-pages/img/favicon.ico",
  here("spatial_hpc", "code", "www", "favicon.ico"),
  mode = "wb"
)

## Use README.md from spatial_hpc
download.file(
  "https://raw.githubusercontent.com/LieberInstitute/spatial_hpc/refs/heads/main/README.md",
  here("spatial_hpc", "code", "www", "README.md"),
  mode = "wb"
)

## Reproducibility information
print("Reproducibility information:")
Sys.time()
proc.time()
options(width = 120)
session_info()
