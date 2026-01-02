library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "region", "hpc", "tran2020_HPC", "code"),
    appFiles = c(
        "app.R"
    )
)
