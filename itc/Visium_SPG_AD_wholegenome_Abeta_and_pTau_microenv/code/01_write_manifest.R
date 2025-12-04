library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("itc", "Visium_SPG_AD_wholegenome_Abeta_and_pTau_microenv", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("itc", "Visium_SPG_AD_wholegenome_Abeta_and_pTau_microenv", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
