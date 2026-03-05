library("rsconnect")
library("here")

source(here::here("redirect_shinyappsio", "token.R"))

#source("token.R")

options(repos = BiocManager::repositories())
rsconnect::deployApp(
    appFiles = "app.R",
    appName = "LC-NIA_spatial",
    account = "libd",
    server = "shinyapps.io"
)
