library(rsconnect)
library(here)

writeManifest(
    appDir = here("hb", "Habenula_multiome"),
    appFiles = "app.R"
)
