library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("itc", "Visium_SPG_AD_TGE", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("itc", "Visium_SPG_AD_TGE", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
