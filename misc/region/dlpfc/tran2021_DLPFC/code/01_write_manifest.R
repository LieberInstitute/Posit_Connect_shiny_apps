library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "region", "dlpfc", "tran2021_DLPFC", "code"),
    appFiles = c(
        "app.R"
    )
)
