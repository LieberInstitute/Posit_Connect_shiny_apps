local({
    app_dir <- here::here("nac", "StrataMap_10_2026_cell")
    # Keep the prepared dataset on shared storage rather than in the bundle.
    app_files <- c(
        "app.R", "www", "modeling_results_cell.qs2",
        "spe_pb_cell.qs2", "sig_genes_cell.qs2"
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
