library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hb", "Habenula_Visium_Sp09", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("hb", "Habenula_Visium_Sp09", "code"),
            dir("www", full.names = TRUE)
        ),
        withr::with_dir(
            here::here("hb", "Habenula_Visium_Sp09", "code"),
            dir("clusters_BayesSpace", full.names = TRUE)
        )
    )
)
