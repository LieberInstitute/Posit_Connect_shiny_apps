library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Habenula_Visium_HD", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium_HD", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
