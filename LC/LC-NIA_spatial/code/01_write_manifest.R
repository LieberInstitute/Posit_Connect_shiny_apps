library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LC", "LC-NIA_spatial", "code"),
    appFiles = c(
        "app.R"
    )
)
