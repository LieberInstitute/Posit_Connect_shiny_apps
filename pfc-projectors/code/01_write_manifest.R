
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("pfc-projectors", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)