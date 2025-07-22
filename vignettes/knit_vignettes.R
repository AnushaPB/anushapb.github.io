# Script to knit rmarkdown files so that they are named index.html
library(rmarkdown)
library(here)

vignettes <- list.files(here("vignettes"), pattern = "\\.Rmd$", recursive = TRUE, full.names = TRUE)

for (rmd in vignettes) {
  out_dir <- dirname(rmd)
  message("Rendering: ", rmd)
  render(rmd, output_file = file.path(out_dir, "index.html"))
}
