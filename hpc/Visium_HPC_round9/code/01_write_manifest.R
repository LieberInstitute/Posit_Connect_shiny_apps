library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "Visium_HPC_round9", "code"),
    appFiles = c(
        "app.R"
    )
)
