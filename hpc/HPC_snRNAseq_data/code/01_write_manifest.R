
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "HPC_snRNAseq_data", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
