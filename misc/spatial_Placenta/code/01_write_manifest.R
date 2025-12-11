library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "spatial_Placenta", "code"),
    appFiles = c(
        "app.R"
    )
)
