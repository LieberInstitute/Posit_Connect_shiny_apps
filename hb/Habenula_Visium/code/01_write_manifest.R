library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Habenula_Visium", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
