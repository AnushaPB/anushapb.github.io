library(rmarkdown)
library(here)

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
  
  # Knit to HTML fragment
  render(
    input = rmd,
    output_format = html_fragment(
      toc = TRUE,
      toc_depth = 2
    ),
    output_file = file.path(out_dir, "vignette-content.html"),
    quiet = TRUE
  )
  
  # Create Jekyll index.md wrapper
  index_md <- file.path(out_dir, "index.md")
  wrapper_content <- paste(
    "---",
    "layout: page",
    sprintf("title: \"%s\"", gsub('_', ' ', vignette_name)),
    sprintf("permalink: /vignettes/%s/", vignette_name),
    "---",
    "",
    "{% include_relative vignette-content.html %}",
    sep = "\n"
  )
  writeLines(wrapper_content, index_md)
  message("Created wrapper: ", index_md)
}

