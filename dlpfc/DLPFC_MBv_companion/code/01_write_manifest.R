library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "DLPFC_MBv_companion", "code"),
    appFiles = c(
        "ui.R",
        "server.R",
        withr::with_dir(
            here::here("dlpfc", "DLPFC_MBv_companion", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
