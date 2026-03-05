server <- function(input, output, session) {}
ui <- fluidPage(singleton(tags$head(tags$script('window.location.replace("https://interactive.libd.org/DLPFC_asd_raw/");'))))
shinyApp(ui = ui, server = server)
