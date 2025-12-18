library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "spatialLIBD_Human_Lymph_Node_10x", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("misc", "spatialLIBD_Human_Lymph_Node_10x", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
