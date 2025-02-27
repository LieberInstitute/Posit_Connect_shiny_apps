library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("spatialDLPFC_mdd_bpd", "code", "02_sparseMatrix_in_memory_version"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("spatialDLPFC_mdd_bpd", "code", "02_sparseMatrix_in_memory_version"),
            dir("www", full.names = TRUE)
        )
    )
)
