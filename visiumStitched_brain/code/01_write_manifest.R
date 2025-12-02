library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("visiumStitched_brain", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("visiumStitched_brain", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
