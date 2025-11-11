citationkey
================
Ignacio Ramos-Gutiérrez
2025-11-11

Data origin reference: Several

Primary data compiler: Carlos Salazar Martín, Manuel Marquerie

Other data compilers: Ignacio Ramos Gutiérrez

## Notes

- 

## Packages

``` r
library(here)
library(tidyverse)
library(tidylog)
```

    ## Warning: package 'tidylog' was built under R version 4.5.2

``` r
library(terra)

source(here::here("R/AFLIBER_functions.R"))
```

## Load dataset

``` r
citationkey <- "newtaxa_occurrences"
# dt_raw <- readr::read_csv(here(paste0("inst/",citationkey,"/raw/XXXXXX.csv")))
dt_raw <- readxl::read_excel(here(paste0("inst/",citationkey,"/raw/occurrences_novedades_tax.xlsx")))
```

## Modify dataset

``` r
#modify variables
dt_modif <- dt_raw |>

    select(Taxon = Species,
           UTM10x10 = UTM,
           References = Referencia) |>
  
  mutate(UTM10x10 = ifelse(UTM10x10 == "29TPE90", "29SPE90", UTM10x10))
```

    ## select: renamed 3 variables (Taxon, UTM10x10, References) and dropped one variable
    ## mutate: changed one value (1%) of 'UTM10x10' (0 new NAs)

## Prepare dataset

``` r
dt_modif$id <- 1:nrow(dt_modif)

#check allowed values
# check_taxa(dt_modif)  #see incorrect taxa
# check_cells(dt_modif)  #see incorrect cells

dt_check_vals <- dt_modif 
# |>
# clean_values()


# Create dataset to compile
dt_include<- dt_check_vals |> 
  distinct(Taxon,
           UTM10x10, 
           References,
           id)
```

    ## distinct: no rows removed

``` r
dt_save <- dt_modif |> 
  filter(!id %in% dt_include$id)
```

    ## filter: removed all rows (100%)

``` r
readr::write_csv(select(dt_include, -matches("id") ),
                 here(paste0("inst/",citationkey,"/data/", citationkey,".csv")))
```

    ## select: dropped one variable (id)

``` r
readr::write_csv(select(dt_save, -matches("id") ),
                 here(paste0("inst/",citationkey,"/data/", citationkey,"_notused.csv")))
```

    ## select: dropped one variable (id)

## Session info

``` r
sessioninfo::session_info()
```

    ## Warning in system2("quarto", "-V", stdout = TRUE, env = paste0("TMPDIR=", :
    ## running command '"quarto"
    ## TMPDIR=C:/Users/IR.5053485/AppData/Local/Temp/RtmpUjdIov/file4a98db86c68 -V'
    ## had status 1

    ## ─ Session info ───────────────────────────────────────────────────────────────
    ##  setting  value
    ##  version  R version 4.5.1 (2025-06-13 ucrt)
    ##  os       Windows 11 x64 (build 26200)
    ##  system   x86_64, mingw32
    ##  ui       RTerm
    ##  language (EN)
    ##  collate  English_United Kingdom.utf8
    ##  ctype    English_United Kingdom.utf8
    ##  tz       Europe/Madrid
    ##  date     2025-11-11
    ##  pandoc   3.6.3 @ C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown)
    ##  quarto   NA @ C:\\PROGRA~1\\RStudio\\RESOUR~1\\app\\bin\\quarto\\bin\\quarto.exe
    ## 
    ## ─ Packages ───────────────────────────────────────────────────────────────────
    ##  package      * version date (UTC) lib source
    ##  bit            4.6.0   2025-03-06 [1] CRAN (R 4.5.1)
    ##  bit64          4.6.0-1 2025-01-16 [1] CRAN (R 4.5.1)
    ##  cellranger     1.1.0   2016-07-27 [1] CRAN (R 4.5.1)
    ##  cli            3.6.5   2025-04-23 [1] CRAN (R 4.5.1)
    ##  clisymbols     1.2.0   2017-05-21 [1] CRAN (R 4.5.2)
    ##  codetools      0.2-20  2024-03-31 [2] CRAN (R 4.5.1)
    ##  crayon         1.5.3   2024-06-20 [1] CRAN (R 4.5.1)
    ##  data.table     1.17.8  2025-07-10 [1] CRAN (R 4.5.1)
    ##  digest         0.6.37  2024-08-19 [1] CRAN (R 4.5.1)
    ##  dplyr        * 1.1.4   2023-11-17 [1] CRAN (R 4.5.1)
    ##  evaluate       1.0.5   2025-08-27 [1] CRAN (R 4.5.1)
    ##  farver         2.1.2   2024-05-13 [1] CRAN (R 4.5.1)
    ##  fastmap        1.2.0   2024-05-15 [1] CRAN (R 4.5.1)
    ##  forcats      * 1.0.1   2025-09-25 [1] CRAN (R 4.5.1)
    ##  generics       0.1.4   2025-05-09 [1] CRAN (R 4.5.1)
    ##  ggplot2      * 4.0.0   2025-09-11 [1] CRAN (R 4.5.1)
    ##  glue           1.8.0   2024-09-30 [1] CRAN (R 4.5.1)
    ##  gtable         0.3.6   2024-10-25 [1] CRAN (R 4.5.1)
    ##  here         * 1.0.2   2025-09-15 [1] CRAN (R 4.5.1)
    ##  hms            1.1.3   2023-03-21 [1] CRAN (R 4.5.1)
    ##  htmltools      0.5.8.1 2024-04-04 [1] CRAN (R 4.5.1)
    ##  httr           1.4.7   2023-08-15 [1] CRAN (R 4.5.1)
    ##  jsonlite       2.0.0   2025-03-27 [1] CRAN (R 4.5.1)
    ##  knitr          1.50    2025-03-16 [1] CRAN (R 4.5.1)
    ##  lazyeval       0.2.2   2019-03-15 [1] CRAN (R 4.5.1)
    ##  lifecycle      1.0.4   2023-11-07 [1] CRAN (R 4.5.1)
    ##  lubridate    * 1.9.4   2024-12-08 [1] CRAN (R 4.5.1)
    ##  magrittr       2.0.4   2025-09-12 [1] CRAN (R 4.5.1)
    ##  oai            0.4.0   2022-11-10 [1] CRAN (R 4.5.1)
    ##  pillar         1.11.1  2025-09-17 [1] CRAN (R 4.5.1)
    ##  pkgconfig      2.0.3   2019-09-22 [1] CRAN (R 4.5.1)
    ##  plyr           1.8.9   2023-10-02 [1] CRAN (R 4.5.1)
    ##  purrr        * 1.1.0   2025-07-10 [1] CRAN (R 4.5.1)
    ##  R6             2.6.1   2025-02-15 [1] CRAN (R 4.5.1)
    ##  RColorBrewer   1.1-3   2022-04-03 [1] CRAN (R 4.5.0)
    ##  Rcpp           1.1.0   2025-07-02 [1] CRAN (R 4.5.1)
    ##  readr        * 2.1.5   2024-01-10 [1] CRAN (R 4.5.1)
    ##  readxl         1.4.5   2025-03-07 [1] CRAN (R 4.5.1)
    ##  rgbif        * 3.8.3   2025-09-04 [1] CRAN (R 4.5.1)
    ##  rlang          1.1.6   2025-04-11 [1] CRAN (R 4.5.1)
    ##  rmarkdown      2.30    2025-09-28 [1] CRAN (R 4.5.1)
    ##  rprojroot      2.1.1   2025-08-26 [1] CRAN (R 4.5.1)
    ##  rstudioapi     0.17.1  2024-10-22 [1] CRAN (R 4.5.1)
    ##  S7             0.2.0   2024-11-07 [1] CRAN (R 4.5.1)
    ##  scales         1.4.0   2025-04-24 [1] CRAN (R 4.5.1)
    ##  sessioninfo    1.2.3   2025-02-05 [1] CRAN (R 4.5.1)
    ##  stringi        1.8.7   2025-03-27 [1] CRAN (R 4.5.0)
    ##  stringr      * 1.5.2   2025-09-08 [1] CRAN (R 4.5.1)
    ##  terra        * 1.8-70  2025-09-27 [1] CRAN (R 4.5.1)
    ##  tibble       * 3.3.0   2025-06-08 [1] CRAN (R 4.5.1)
    ##  tidylog      * 1.1.0   2024-05-08 [1] CRAN (R 4.5.2)
    ##  tidyr        * 1.3.1   2024-01-24 [1] CRAN (R 4.5.1)
    ##  tidyselect     1.2.1   2024-03-11 [1] CRAN (R 4.5.1)
    ##  tidyverse    * 2.0.0   2023-02-22 [1] CRAN (R 4.5.1)
    ##  timechange     0.3.0   2024-01-18 [1] CRAN (R 4.5.1)
    ##  tzdb           0.5.0   2025-03-15 [1] CRAN (R 4.5.1)
    ##  vctrs          0.6.5   2023-12-01 [1] CRAN (R 4.5.1)
    ##  vroom          1.6.6   2025-09-19 [1] CRAN (R 4.5.1)
    ##  whisker        0.4.1   2022-12-05 [1] CRAN (R 4.5.1)
    ##  withr          3.0.2   2024-10-28 [1] CRAN (R 4.5.1)
    ##  xfun           0.53    2025-08-19 [1] CRAN (R 4.5.1)
    ##  xml2           1.4.0   2025-08-20 [1] CRAN (R 4.5.1)
    ##  yaml           2.3.10  2024-07-26 [1] CRAN (R 4.5.0)
    ## 
    ##  [1] C:/Users/IR.5053485/AppData/Local/R/win-library/4.5
    ##  [2] C:/Program Files/R/R-4.5.1/library
    ##  * ── Packages attached to the search path.
    ## 
    ## ──────────────────────────────────────────────────────────────────────────────
