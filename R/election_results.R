download_election_results_zip <- function() {
    read_html("https://www.ncsbe.gov/results-data/election-results/historical-election-results-data") %>%
      html_nodes("a") %>%
      html_attr("href") %>%
      str_subset("results_pct_\\d+") %>%
      walk(function(zipfn) {
        destfn <- str_extract(zipfn, "results_pct_\\d+.zip")
        destfn <- file.path("precinct_zip", destfn)
        cat(sprintf("Working on file %s...", destfn))
        if (!file.exists(destfn)) {
          cat("downloading.\n")
          download.file(zipfn, destfn)
        }
        else {
          cat("already have it.\n")
        }
      })
}

get_election_results <- function(fns = dir("precinct_zip",
                                           pattern = "results_pct_\\d+.zip")) {
  fns %>% 
    str_subset("pct_20(12|13|14|15|16|17|18|19|20)") %>%
    map_df(function(fn) {
      cat(sprintf("Working on %s...\n", fn))
      if (str_detect(fn, "20120717|20120508|20121106|20130910|20131008")) {
        res <- read_csv(file.path("precinct_zip", fn)) %>%
                  mutate(election_file = str_extract(fn, "\\d{8}")) %>%
                  rename_all(tolower) %>%
                  rename_all(function(nm) str_replace_all(nm, " ", "_"))
      }
      else {
        res <- read_tsv(file.path("precinct_zip", fn))  %>%
                  mutate(election_file = str_extract(fn, "\\d{8}")) %>%
                  rename_all(tolower) %>%
                  rename_all(function(nm) str_replace_all(nm, " ", "_"))
      }
      res
    }) %>%
    mutate(contest = coalesce(contest, contest_name),
           election_date = coalesce(election_date, 
                                    str_replace(election_file, 
                                                "(\\d{4})(\\d{2})(\\d{2})",
                                                "\\2/\\3/\\1"))) %>%
    select(-data_unavailable, -x15, -x16, -contest_name) 
}
