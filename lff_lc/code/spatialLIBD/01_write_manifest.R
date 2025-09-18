library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("lff_lc", "code", "spatialLIBD"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("lff_lc", "code", "spatialLIBD"),
            dir("www", full.names = TRUE)
        )
    )
)
