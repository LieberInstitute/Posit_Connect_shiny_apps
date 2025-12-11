library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "spatial_FetalCortex", "code"),
    appFiles = c(
        "app.R"
    )
)
