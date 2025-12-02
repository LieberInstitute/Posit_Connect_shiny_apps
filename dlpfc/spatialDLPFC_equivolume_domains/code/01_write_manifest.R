library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "spatialDLPFC_equivolume_domains", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("dlpfc", "spatialDLPFC_equivolume_domains", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
