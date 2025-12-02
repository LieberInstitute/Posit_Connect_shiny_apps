
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LS", "LS_snRNAseq", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
