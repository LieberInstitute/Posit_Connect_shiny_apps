
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Habenula_multiome", "code"),
    appFiles = c(
        "app.R"
    )
)
