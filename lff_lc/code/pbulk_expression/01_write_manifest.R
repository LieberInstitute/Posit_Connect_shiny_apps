library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("thalamus", "MD_thalamus", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("thalamus", "MD_thalamus", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
