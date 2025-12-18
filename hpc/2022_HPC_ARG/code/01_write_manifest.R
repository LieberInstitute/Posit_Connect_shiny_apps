
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "2022_HPC_ARG", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
