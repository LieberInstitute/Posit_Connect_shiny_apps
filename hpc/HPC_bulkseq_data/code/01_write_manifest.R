
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "HPC_bulkseq_data", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
