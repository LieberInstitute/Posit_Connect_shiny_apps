library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Habenula_Visium_raw", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium_raw", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
