local({
    app_dir <- here::here("hb", "Habenula_Visium_HD")
    # Keep the prepared dataset on shared storage rather than in the bundle.
    app_files <- c(
        "app.R", "www", "modeling_results.qs2",
        "sce_pb_shiny.qs2", "sig_genes_shiny.qs2"
    )
    repos <- c(
        BiocManager::repositories(version = "3.22"),
        BPCells = "https://bnprks.r-universe.dev"
    )

    withr::with_options(
        list(repos = repos),
        rsconnect::writeManifest(appDir = app_dir, appFiles = app_files)
    )
})
