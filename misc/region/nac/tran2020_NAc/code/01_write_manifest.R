library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "region", "nac", "tran2020_NAc", "code"),
    appFiles = c(
        "app.R"
    )
)
