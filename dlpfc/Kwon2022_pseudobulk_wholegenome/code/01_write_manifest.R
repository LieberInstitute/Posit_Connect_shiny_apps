library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("dlpfc", "Kwon2022_pseudobulk_wholegenome", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
