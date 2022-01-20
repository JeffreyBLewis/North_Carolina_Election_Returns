library(targets)
library(tarchetypes)
library(tidyverse)

purrr::walk(dir("R", pattern="\\.R$", full.names = TRUE), ~ source(.))
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "rvest"))
list(
  tar_target(
    download_status_er,
    download_election_results_zip(),
  ),
  tar_target(
    election_results,
    get_election_results()
  ),
  tar_target(
    precinct_data_csv,
    { 
      csv_fn <- "csv/NC_precinct_level_election_returns.csv.gz"
      write_csv(election_results, csv_fn)
      csv_fn 
    },
    format = "file"
  )
)
    