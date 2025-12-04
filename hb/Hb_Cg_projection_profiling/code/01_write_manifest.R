
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Hb_Cg_projection_profiling", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
