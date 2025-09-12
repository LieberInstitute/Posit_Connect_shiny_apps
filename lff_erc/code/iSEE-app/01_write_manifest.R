library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("lff_erc", "code", "iSEE-app"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
