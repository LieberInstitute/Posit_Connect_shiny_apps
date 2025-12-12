library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LC", "locus-c_Visium", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("LC", "locus-c_Visium", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
