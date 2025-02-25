library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatial_hpc", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("spatial_hpc", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
