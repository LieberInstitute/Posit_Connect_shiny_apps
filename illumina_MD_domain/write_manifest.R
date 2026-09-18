library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("illumina_MD_domain"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here("illumina_MD_domain"), dir("www", full.names = TRUE)
        )
    )
)
