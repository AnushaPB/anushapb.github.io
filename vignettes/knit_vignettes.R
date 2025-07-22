
# Script to knit RMarkdown files and create Jekyll-ready pages
library(rmarkdown)
library(here)
library(glue)

# Find all .Rmd files in vignettes subdirectories
vignettes <- list.files(
  here("vignettes"),
  pattern = "\\.Rmd$",
  recursive = TRUE,
  full.names = TRUE
)

for (rmd in vignettes) {
  out_dir <- dirname(rmd)
  vignette_name <- basename(out_dir) # folder name = vignette name
  message("Rendering: ", rmd)
  
  # Knit to HTML fragment (no <html>, <head>, etc.)
  render(
    input = rmd,
    output_format = html_document(
      toc = TRUE,
      toc_depth = 2,
      toc_float = TRUE,
      self_contained = FALSE
    ),
    output_file = file.path(out_dir, "vignette-content.html"),
    quiet = TRUE
  )
  
  # Create Jekyll index.md wrapper
  index_md <- file.path(out_dir, "index.md")
  cat(
    glue(
      "---
layout: page
title: \"{gsub('_', ' ', vignette_name)}\"
permalink: /vignettes/{vignette_name}/
---

{{% include_relative vignette-content.html %}}
"
    ),
file = index_md
  )
  message("Created wrapper: ", index_md)
}
