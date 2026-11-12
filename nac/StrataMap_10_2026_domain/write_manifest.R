library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("nac", "StrataMap_10_2026_domain"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here("nac", "StrataMap_10_2026_domain"),
            dir("www", full.names = TRUE)
        )
    )
)
