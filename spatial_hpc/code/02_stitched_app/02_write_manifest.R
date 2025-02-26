library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatial_hpc", "code", "02_stitched_app"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("spatial_hpc", "code", "02_stitched_app"),
            dir("www", full.names = TRUE)
        )
    )
)
