function(input, output, session) {
    posit_connect_file <- "/r_data/lcollado/Posit_Connect_shiny_apps/dlpfc/DLPFC_MBv_companion/MBv-shiny_pseudobulk-spe_both-annotations.rds"

    if (file.exists(posit_connect_file)) {
        ## Location for the https://conn1.libd.org/ server
        spe <- readRDS(posit_connect_file)
    } else {
        spe <- readRDS(here::here("dlpfc", "DLPFC_MBv_companion", "processed-data", "MBv-shiny_pseudobulk-spe_both-annotations.rds"))
    }

  output$whole.tissue  <- renderPlot({
    if(input$gene_name=="" | is.null(input$gene_name)) {
      EMPTY("whole-tissue")
    } else {
      WHOLE_TISSUE(spe, input$gene_name)
    }
  })

  output$domain.sp <- renderPlot({
    if(input$gene_name=="" | is.null(input$gene_name)) {
      EMPTY("domain-restricted")
    } else {
      DOMAIN_RESTRICTED(spe, input$gene_name, "domain-SP")
    }
  })

  output$domain.ct <- renderPlot({
    if(input$gene_name=="" | is.null(input$gene_name)) {
      EMPTY("domain-restricted")
    } else {
      DOMAIN_RESTRICTED(spe, input$gene_name, "domain-CT")
    }
  })

}
