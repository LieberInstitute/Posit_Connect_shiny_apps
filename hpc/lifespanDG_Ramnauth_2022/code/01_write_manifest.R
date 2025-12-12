library("rsconnect")
library("here")
library("withr")

rsconnect::writeManifest(
    appDir = here::here("hpc", "lifespanDG_Ramnauth_2022", "code"),
    appFiles = c(
        "app.R"
    )
)
