library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "DLPFC_MBv_companion", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("dlpfc", "DLPFC_MBv_companion", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
