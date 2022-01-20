North Carolina precinct-level election returns
================
Jeff Lewis
20 January 2022

\[This is a preliminary work in progress. Use at your own risk.\]

## Overview

This repository contains code to download and parse precinct-level
election returns from the state of North Carolina. The code is written
in [`R`](https://www.r-project.org/) and uses the
[`targets`](https://books.ropensci.org/targets/) pipeline toolkit to
manage the production of the data.

The all of parsed and de-normalized are contained in the file
`csv/NC_precinct_level_election_returns.csv.gz` in this repository.

The following two commands can be used to re-ingest and re-parse the
original source files found on the North Carolina State Board of
Elections’
[webpages](https://www.ncsbe.gov/results-data/election-results/historical-election-results-data).

``` r
source("_targets.R")
tar_make()
```

## Variables and unit of analysis

The variables contained in the data are as follows:

    ## Rows: 2,349,743
    ## Columns: 21
    ## $ county           <chr> "ALAMANCE", "ALAMANCE", "ALAMANCE", "ALAMANCE", "ALAM…
    ## $ precinct         <chr> "01_PATTERSON", "02_COBLE", "035_BOONE 5", "03C_CENTR…
    ## $ contest_type     <chr> "S", "S", "S", "S", "S", "S", "S", "S", "S", "S", "S"…
    ## $ runoff_status    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ recount_status   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ contest          <chr> "PRESIDENTIAL PREFERENCE - DEM", "PRESIDENTIAL PREFER…
    ## $ choice           <chr> "Barack Obama", "Barack Obama", "Barack Obama", "Bara…
    ## $ winner_status    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
    ## $ party            <chr> "DEM", "DEM", "DEM", "DEM", "DEM", "DEM", "DEM", "DEM…
    ## $ election_day     <dbl> 109, 99, 188, 200, 262, 145, 318, 158, 197, 90, 190, …
    ## $ one_stop         <dbl> 30, 35, 72, 44, 70, 13, 93, 29, 21, 22, 38, 109, 71, …
    ## $ absentee_by_mail <dbl> 0, 0, 12, 2, 2, 6, 4, 1, 0, 1, 1, 1, 5, 1, 2, 0, 2, 3…
    ## $ provisional      <dbl> 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1,…
    ## $ total_votes      <dbl> 139, 134, 272, 246, 334, 164, 415, 189, 218, 113, 229…
    ## $ district         <chr> "Not Found", "Not Found", "Not Found", "Not Found", "…
    ## $ election_file    <chr> "20120508", "20120508", "20120508", "20120508", "2012…
    ## $ election_date    <chr> "05/08/2012", "05/08/2012", "05/08/2012", "05/08/2012…
    ## $ contest_group_id <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    ## $ choice_party     <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    ## $ vote_for         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    ## $ real_precinct    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…

Each row shows the number of votes cast in the given precinct in the
given contest for the given candidate. The votes for each candidate cast
by each mode of voting are reported in separate variables
(`election_day`, `one_stop`, `absentee_by_mail`, and `provisional`) as
well as in total (`total_votes`). Overall, the data contain 2,349,743
records across 29 elections, 6,814 contests, and 19,654 precincts.

The variable `vote_for` indicates (when available) the number of
candidates in the given contest that a voter could select.

## Elections Covered

The elections included in the dataset are the following:

| Election Date | Records |
|:--------------|--------:|
| 2020-11-03    |  257721 |
| 2020-06-23    |     698 |
| 2020-03-03    |  344473 |
| 2019-11-05    |   33787 |
| 2019-10-08    |    6359 |
| 2019-09-10    |    4587 |
| 2019-07-09    |     566 |
| 2019-05-14    |    2382 |
| 2019-04-30    |    7050 |
| 2018-11-06    |  183723 |
| 2018-06-26    |      70 |
| 2018-05-08    |   49607 |
| 2017-11-07    |   40181 |
| 2017-10-10    |   10936 |
| 2017-09-12    |    3380 |
| 2016-11-08    |  252826 |
| 2016-06-07    |   26589 |
| 2016-03-15    |  249340 |
| 2015-11-03    |   33641 |
| 2015-10-06    |    6551 |
| 2015-09-15    |    3687 |
| 2014-11-04    |  223976 |
| 2014-07-15    |    2542 |
| 2014-05-06    |  102968 |
| 2013-10-08    |    8051 |
| 2013-09-10    |    3389 |
| 2012-11-06    |  208920 |
| 2012-07-17    |   33410 |
| 2012-05-08    |  248333 |
