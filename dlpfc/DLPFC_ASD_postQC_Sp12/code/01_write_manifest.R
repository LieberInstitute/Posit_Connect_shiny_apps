library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "DLPFC_ASD_postQC_Sp12", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("dlpfc", "DLPFC_ASD_postQC_Sp12", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
