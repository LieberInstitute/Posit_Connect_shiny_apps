library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("hb", "Habenula_Visium_HD"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium_HD"),
            dir("www", full.names = TRUE)
        )
    )
)
