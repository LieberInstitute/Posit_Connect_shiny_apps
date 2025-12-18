library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LC", "Locus_coeruleus", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("LC", "Locus_coeruleus", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
