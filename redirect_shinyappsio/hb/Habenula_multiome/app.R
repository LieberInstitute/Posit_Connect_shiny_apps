server <- function(input, output, session) {}
ui <- fluidPage(singleton(tags$head(tags$script('window.location.replace("https://interactive.libd.org/Habenula_multiome/");'))))
shinyApp(ui = ui, server = server)
