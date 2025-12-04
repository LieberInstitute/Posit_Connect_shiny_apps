library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "split_receipt", "code"),
    appFiles = c(
        "app.R"
    )
)
