library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dACC", "spatialdACC_Visium_IF", "code"),
    appFiles = c(
        "app.R"
    )
)
