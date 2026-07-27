library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("test-deploy-apps", "new-test", "code"),
    appFiles = c(
        "app.R",
        withr::with_dir(
            here::here("test-deploy-apps", "new-test", "code"),
            dir("www", full.names = TRUE)
        )
    )
)
