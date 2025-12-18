library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "spatialDLPFC_Visium_Sp16_pseudobulk", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
