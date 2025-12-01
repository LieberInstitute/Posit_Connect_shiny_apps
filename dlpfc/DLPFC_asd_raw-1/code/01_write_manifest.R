library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "DLPFC_asd_raw-1", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("dlpfc", "DLPFC_asd_raw-1", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
