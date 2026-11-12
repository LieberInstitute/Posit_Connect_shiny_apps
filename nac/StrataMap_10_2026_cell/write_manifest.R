library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("nac", "StrataMap_10_2026_cell"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here("nac", "StrataMap_10_2026_cell"), dir("www", full.names = TRUE)
        )
    )
)
