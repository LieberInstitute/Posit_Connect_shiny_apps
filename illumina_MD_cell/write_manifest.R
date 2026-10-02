library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("illumina_MD_cell"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here("illumina_MD_cell"), dir("www", full.names = TRUE)
        )
    )
)