library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Hb_Rat_Fentanyl_pb", "code"),
    appFiles = c(
        "app.R"
    )
)