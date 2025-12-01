library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "spatialDLPFC_Visium_Sp09", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("dlpfc", "spatialDLPFC_Visium_Sp09", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
