library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialNAC", "code", "spatialLIBD"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("spatialNAC", "code", "spatialLIBD"),
            dir("www", full.names = TRUE)
        )
    )
)
