library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("nac", "NAC_AP", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("nac", "NAC_AP", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
