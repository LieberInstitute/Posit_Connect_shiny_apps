library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "DLPFC_MBv_pseudobulk", "code"),
    appFiles = c(
        "app.R"
    )
)
