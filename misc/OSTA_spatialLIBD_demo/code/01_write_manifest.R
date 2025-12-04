library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "OSTA_spatialLIBD_demo", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("misc", "OSTA_spatialLIBD_demo", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
