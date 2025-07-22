# Simple script to knit all Rmds to index.html
library(rmarkdown)
library(here)

# Find all .Rmd files in vignettes subdirectories
vignettes <- list.files(
  here("vignettes"),
  pattern = "\\.Rmd$",
  recursive = TRUE,
  full.names = TRUE
)

# Render each Rmd to index.html in its folder
for (rmd in vignettes) {
  out_dir <- dirname(rmd)
  message("Rendering: ", rmd)
  render(
    input = rmd,
    output_format = html_document(
      toc = TRUE,
      toc_depth = 2,
      toc_float = TRUE,
      theme = "cosmo",
      self_contained = TRUE
    ),
    output_file = file.path(out_dir, "index.html"),
    quiet = TRUE
  )
}

