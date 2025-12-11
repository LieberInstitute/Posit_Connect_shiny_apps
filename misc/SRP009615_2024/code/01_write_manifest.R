library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "SRP009615_2024", "code"),
    appFiles = c(
        "app.R"
    )
)
