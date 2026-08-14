library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("lff_lc", "code", "pbulk_expression"),
    appFiles = c(
        "app.R"#,
        )
)
