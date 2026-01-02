library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "region", "amy", "tran2021_AMY", "code"),
    appFiles = c(
        "app.R"
    )
)
