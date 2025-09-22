
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("lff_lc", "code", "iSEE"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)