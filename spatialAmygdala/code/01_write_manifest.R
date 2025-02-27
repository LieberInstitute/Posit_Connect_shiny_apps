library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialAmygdala", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("spatialAmygdala", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
