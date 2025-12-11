
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "habenulaPilot_bulk", "code"),
    appFiles = c(
        "app.R"
    )
)
