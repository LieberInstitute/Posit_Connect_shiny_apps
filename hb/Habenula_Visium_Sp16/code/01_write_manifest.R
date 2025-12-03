library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Habenula_Visium_Sp16", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium_Sp16", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
