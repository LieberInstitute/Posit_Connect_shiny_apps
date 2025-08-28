
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialDLPFC_scz", "code", "domains"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)