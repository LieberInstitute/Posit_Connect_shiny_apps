library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "Lifespan_DG", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hpc", "Lifespan_DG", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
