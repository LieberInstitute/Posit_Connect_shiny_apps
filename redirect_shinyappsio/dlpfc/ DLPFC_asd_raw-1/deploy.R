library("rsconnect")
library("here")

source(here::here("redirect_shinyappsio", "token.R"))

#source("token.R")

options(repos = BiocManager::repositories())
rsconnect::deployApp(
    appFiles = "app.R",
    appName = "DLPFC_asd_raw-1",
    account = "libd",
    server = "shinyapps.io"
)
