server <- function(input, output, session) {}
ui <- fluidPage(singleton(tags$head(tags$script('window.location.replace("https://interactive.libd.org/DLPFC_ASD_postQC_Sp12/");'))))
shinyApp(ui = ui, server = server)
