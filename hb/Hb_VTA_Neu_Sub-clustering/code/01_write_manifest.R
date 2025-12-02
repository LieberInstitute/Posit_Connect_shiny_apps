
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Hb_VTA_Neu_Sub-clustering", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
