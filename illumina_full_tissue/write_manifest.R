library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("illumina_full_tissue"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here("illumina_full_tissue"), dir("www", full.names = TRUE)
        )
    )
)
