library("rsconnect")
library("here")

source(here::here("redirect_shinyappsio", "token.R"))

#source("token.R")

options(repos = BiocManager::repositories())
rsconnect::deployApp(
    appFiles = "app.R",
    appName = "DLPFC_ASD_postQC",
    account = "libd",
    server = "shinyapps.io"
)
