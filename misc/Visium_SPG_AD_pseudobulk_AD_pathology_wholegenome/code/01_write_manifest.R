
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("misc", "Visium_SPG_AD_pseudobulk_AD_pathology_wholegenome", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
