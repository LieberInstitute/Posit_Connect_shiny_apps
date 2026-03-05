server <- function(input, output, session) {}
ui <- fluidPage(singleton(tags$head(tags$script('window.location.replace("https://interactive.libd.org/snRNA_NAC");'))))
shinyApp(ui = ui, server = server)