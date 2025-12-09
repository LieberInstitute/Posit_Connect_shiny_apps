
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "bulkseq_HPC", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
