
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("lab-apps", "tran-apps", "tran2020-amyg", "code"),
    appFiles = c(
        "app.R"
    )
)