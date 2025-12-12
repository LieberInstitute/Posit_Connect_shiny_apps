
library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("LS", "bulkseq_lateral_septum", "code"),
    appFiles = c(
        "app.R",
        "initial.R"
    )
)
