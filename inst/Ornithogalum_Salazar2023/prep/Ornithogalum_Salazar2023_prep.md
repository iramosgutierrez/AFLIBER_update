Ornithogalum_Salazar2023
================
Ignacio Ramos-Gutiérrez
2025-01-11

Data origin reference: Several

Primary data compiler: Carlos Salazar, Amanda Tercero-Araque

Other data compilers:

## Notes

-   Several errors to eliminate!

## Packages

``` r
library(here)
library(tidyverse)
library(tidylog)
library(terra)

source(here::here("R/AFLIBER_functions.R"))
```

## Load dataset

``` r
citationkey <- "Ornithogalum_Salazar2023"
# dt_raw <- readr::read_csv(here(paste0("inst/",citationkey,"/raw/XXXXXX.csv")))
dt_raw <- readxl::read_excel(here(paste0("inst/",citationkey,"/raw/Ornithogalum reverchonii UTM.xlsx")), sheet = "Nuevas")
```

## Modify dataset

``` r
#modify variables
dt_modif <- dt_raw |> 
  rename(cUTM = `cUTM 10 x 10 km ó 1 x 1 km`)|> 
  mutate(cUTM = gsub("30UF", "30SUF", cUTM)) |> 
  mutate(UTM10x10 = case_when(nchar(cUTM)==7 ~ cUTM, 
                              nchar(cUTM)==9 ~ paste0(substr(cUTM, 1,6),substr(cUTM, 8,8)))) |> 
  mutate(UTM1x1 = case_when(nchar(cUTM)==9 ~ cUTM)) |> 
  rename(References = `Referencia o pliegos`) |> 
  

    select(Taxon,
           UTM10x10, 
           UTM1x1, 
           References)
```

    ## rename: renamed one variable (cUTM)
    ## mutate: changed 3 values (5%) of 'cUTM' (0 new NAs)
    ## mutate: new variable 'UTM10x10' (character) with 15 unique values and 0% NA
    ## mutate: new variable 'UTM1x1' (character) with 40 unique values and 25% NA
    ## rename: renamed one variable (References)
    ## select: dropped one variable (cUTM)

## Prepare dataset

``` r
dt_modif$id <- 1:nrow(dt_modif)

# #check allowed values
# check_taxa(dt_modif)  #see incorrect taxa
# check_cells(dt_modif)  #see incorrect cells

dt_check_vals <- dt_modif |> 
clean_values()
```

    ## All taxa are valid

    ## mutate: no changes
    ## All 10x10 cells are valid

``` r
# Create dataset to compile
dt_include<- dt_check_vals |> 
  distinct(Taxon,
           UTM10x10, 
           UTM1x1, 
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

    ## ─ Session info ───────────────────────────────────────────────────────────────
    ##  setting  value
    ##  version  R version 4.4.1 (2024-06-14 ucrt)
    ##  os       Windows 10 x64 (build 19045)
    ##  system   x86_64, mingw32
    ##  ui       RTerm
    ##  language (EN)
    ##  collate  Spanish_Spain.utf8
    ##  ctype    Spanish_Spain.utf8
    ##  tz       Europe/Madrid
    ##  date     2025-01-11
    ##  pandoc   2.18 @ C:/Program Files/RStudio/bin/quarto/bin/tools/ (via rmarkdown)
    ## 
    ## ─ Packages ───────────────────────────────────────────────────────────────────
    ##  package     * version date (UTC) lib source
    ##  bit           4.5.0   2024-09-20 [1] CRAN (R 4.4.1)
    ##  bit64         4.0.5   2020-08-30 [1] CRAN (R 4.4.1)
    ##  cellranger    1.1.0   2016-07-27 [1] CRAN (R 4.4.1)
    ##  cli           3.6.3   2024-06-21 [1] CRAN (R 4.4.1)
    ##  clisymbols    1.2.0   2017-05-21 [1] CRAN (R 4.4.1)
    ##  codetools     0.2-20  2024-03-31 [2] CRAN (R 4.4.1)
    ##  colorspace    2.1-1   2024-07-26 [1] CRAN (R 4.4.1)
    ##  crayon        1.5.3   2024-06-20 [1] CRAN (R 4.4.1)
    ##  data.table    1.16.0  2024-08-27 [1] CRAN (R 4.4.1)
    ##  digest        0.6.37  2024-08-19 [1] CRAN (R 4.4.1)
    ##  dplyr       * 1.1.4   2023-11-17 [1] CRAN (R 4.4.1)
    ##  evaluate      1.0.0   2024-09-17 [1] CRAN (R 4.4.1)
    ##  fansi         1.0.6   2023-12-08 [1] CRAN (R 4.4.1)
    ##  fastmap       1.2.0   2024-05-15 [1] CRAN (R 4.4.1)
    ##  forcats     * 1.0.0   2023-01-29 [1] CRAN (R 4.4.1)
    ##  generics      0.1.3   2022-07-05 [1] CRAN (R 4.4.1)
    ##  ggplot2     * 3.5.1   2024-04-23 [1] CRAN (R 4.4.1)
    ##  glue          1.7.0   2024-01-09 [1] CRAN (R 4.4.1)
    ##  gtable        0.3.5   2024-04-22 [1] CRAN (R 4.4.1)
    ##  here        * 1.0.1   2020-12-13 [1] CRAN (R 4.4.1)
    ##  hms           1.1.3   2023-03-21 [1] CRAN (R 4.4.1)
    ##  htmltools     0.5.8.1 2024-04-04 [1] CRAN (R 4.4.1)
    ##  httr          1.4.7   2023-08-15 [1] CRAN (R 4.4.1)
    ##  jsonlite      1.8.9   2024-09-20 [1] CRAN (R 4.4.1)
    ##  knitr         1.48    2024-07-07 [1] CRAN (R 4.4.1)
    ##  lazyeval      0.2.2   2019-03-15 [1] CRAN (R 4.4.1)
    ##  lifecycle     1.0.4   2023-11-07 [1] CRAN (R 4.4.1)
    ##  lubridate   * 1.9.3   2023-09-27 [1] CRAN (R 4.4.1)
    ##  magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.4.1)
    ##  munsell       0.5.1   2024-04-01 [1] CRAN (R 4.4.1)
    ##  oai           0.4.0   2022-11-10 [1] CRAN (R 4.4.1)
    ##  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.4.1)
    ##  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.4.1)
    ##  plyr          1.8.9   2023-10-02 [1] CRAN (R 4.4.1)
    ##  purrr       * 1.0.2   2023-08-10 [1] CRAN (R 4.4.1)
    ##  R6            2.5.1   2021-08-19 [1] CRAN (R 4.4.1)
    ##  Rcpp          1.0.13  2024-07-17 [1] CRAN (R 4.4.1)
    ##  readr       * 2.1.5   2024-01-10 [1] CRAN (R 4.4.1)
    ##  readxl        1.4.3   2023-07-06 [1] CRAN (R 4.4.1)
    ##  rgbif       * 3.8.0   2024-05-23 [1] CRAN (R 4.4.1)
    ##  rlang         1.1.4   2024-06-04 [1] CRAN (R 4.4.1)
    ##  rmarkdown     2.28    2024-08-17 [1] CRAN (R 4.4.1)
    ##  rprojroot     2.0.4   2023-11-05 [1] CRAN (R 4.4.1)
    ##  rstudioapi    0.16.0  2024-03-24 [1] CRAN (R 4.4.1)
    ##  scales        1.3.0   2023-11-28 [1] CRAN (R 4.4.1)
    ##  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.4.1)
    ##  stringi       1.8.4   2024-05-06 [1] CRAN (R 4.4.0)
    ##  stringr     * 1.5.1   2023-11-14 [1] CRAN (R 4.4.1)
    ##  terra       * 1.7-78  2024-05-22 [1] CRAN (R 4.4.1)
    ##  tibble      * 3.2.1   2023-03-20 [1] CRAN (R 4.4.1)
    ##  tidylog     * 1.1.0   2024-05-08 [1] CRAN (R 4.4.1)
    ##  tidyr       * 1.3.1   2024-01-24 [1] CRAN (R 4.4.1)
    ##  tidyselect    1.2.1   2024-03-11 [1] CRAN (R 4.4.1)
    ##  tidyverse   * 2.0.0   2023-02-22 [1] CRAN (R 4.4.1)
    ##  timechange    0.3.0   2024-01-18 [1] CRAN (R 4.4.1)
    ##  tzdb          0.4.0   2023-05-12 [1] CRAN (R 4.4.1)
    ##  utf8          1.2.4   2023-10-22 [1] CRAN (R 4.4.1)
    ##  vctrs         0.6.5   2023-12-01 [1] CRAN (R 4.4.1)
    ##  vroom         1.6.5   2023-12-05 [1] CRAN (R 4.4.1)
    ##  whisker       0.4.1   2022-12-05 [1] CRAN (R 4.4.1)
    ##  withr         3.0.1   2024-07-31 [1] CRAN (R 4.4.1)
    ##  xfun          0.47    2024-08-17 [1] CRAN (R 4.4.1)
    ##  xml2          1.3.6   2023-12-04 [1] CRAN (R 4.4.1)
    ##  yaml          2.3.10  2024-07-26 [1] CRAN (R 4.4.1)
    ## 
    ##  [1] C:/Users/media/AppData/Local/R/win-library/4.4
    ##  [2] C:/Program Files/R/R-4.4.1/library
    ## 
    ## ──────────────────────────────────────────────────────────────────────────────
