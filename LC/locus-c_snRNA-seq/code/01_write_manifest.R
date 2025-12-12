
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LC", "locus-c_snRNA-seq", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
