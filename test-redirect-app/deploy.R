library("rsconnect")

source("token.R")

options(repos = BiocManager::repositories())
rsconnect::deployApp(
    appFiles = "app.R",
    appName = "test_redirect",
    account = "libd",
    server = "shinyapps.io"
)