library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("hb", "Habenula_Visium"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium"),
            dir("www", full.names = TRUE)
        )
    )
)
