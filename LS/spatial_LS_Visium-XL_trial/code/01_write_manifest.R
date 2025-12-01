library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LS", "spatial_LS_Visium-XL_trial", "code"),
    appFiles = c(
        "app.R"
    )
)
