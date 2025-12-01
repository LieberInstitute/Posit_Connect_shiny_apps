
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dACC", "snRNAseq_dACC", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
