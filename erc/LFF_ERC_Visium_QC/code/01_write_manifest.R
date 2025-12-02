library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("erc", "LFF_ERC_Visium_QC", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("erc", "LFF_ERC_Visium_QC", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
