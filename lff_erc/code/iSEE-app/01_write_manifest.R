library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialNAC", "code", "iSEE-app"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
