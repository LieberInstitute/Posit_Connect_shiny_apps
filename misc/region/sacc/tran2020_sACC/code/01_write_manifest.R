library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "region", "sacc", "tran2020_sACC", "code"),
    appFiles = c(
        "app.R"
    )
)
