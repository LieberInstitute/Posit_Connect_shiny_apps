manifest_files <- list.files(here::here(), pattern = "*write_manifest.R", recursive = TRUE)
sapply(manifest_files, function(x) {
    message("re-writing manifest file ", x)
    source(here::here(x), echo = TRUE)
})
