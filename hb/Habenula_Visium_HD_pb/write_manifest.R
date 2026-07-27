library(rsconnect)
library(here)
library(withr)

writeManifest(
    appDir = here("hb", "Habenula_Visium_HD_pb"),
    appFiles = "app.R"
)
