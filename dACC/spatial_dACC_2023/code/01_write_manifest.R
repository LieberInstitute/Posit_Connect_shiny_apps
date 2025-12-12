
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dACC", "spatial_dACC_2023", "code"),
    appFiles = c(
        "app.R"
    )
)
