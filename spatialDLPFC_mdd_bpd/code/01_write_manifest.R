library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialDLPFC_mdd_bpd", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("spatialDLPFC_mdd_bpd", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
