server <- function(input, output, session) {}
ui <- fluidPage(singleton(tags$head(tags$script('window.location.replace("https://interactive.libd.org/LC-NIA_spatial/");'))))
shinyApp(ui = ui, server = server)
