library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "spatialDLPFC_Visium_Sp09_position", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("dlpfc", "spatialDLPFC_Visium_Sp09_position", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
