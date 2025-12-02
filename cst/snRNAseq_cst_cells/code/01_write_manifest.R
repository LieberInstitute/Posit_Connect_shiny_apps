
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("cst", "snRNAseq_cst_cells", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
