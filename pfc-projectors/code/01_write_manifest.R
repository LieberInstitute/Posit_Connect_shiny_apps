
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("bla-crossSpecies", "bla_human", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)