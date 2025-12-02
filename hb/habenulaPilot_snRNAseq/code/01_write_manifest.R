
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "habenulaPilot_snRNAseq", "code"),
    appFiles = c(
        "app.R"
    )
)
