library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("thalamus", "code"),
    appFiles = c(
        "app.R"
    )
)
