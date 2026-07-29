library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "DLPFC_ASD_pseudobulk", "code"),
    appFiles = c(
        "app.R"
    )
)
