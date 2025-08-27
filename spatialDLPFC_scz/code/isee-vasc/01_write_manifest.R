
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialDLPFC_scz", "code", "isee-vasc"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)