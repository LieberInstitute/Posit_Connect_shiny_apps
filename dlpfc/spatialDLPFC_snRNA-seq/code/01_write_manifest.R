library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "spatialDLPFC_snRNA-seq", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
