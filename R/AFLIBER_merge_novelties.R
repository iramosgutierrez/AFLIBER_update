source(here::here("R/AFLIBER_functions.R"))

# Load old dataset
AFLIBER_distributions_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", 
                                             locale = locale(encoding = "Latin1"),
                                             show_col_types = FALSE) |> 
  separate_longer_delim(References, delim = "_") |> 
  rename(UTM10x10 = UTM.cell) |> 
  mutate(UTM1x1 = NA) |> 
  select(Taxon,
         UTM1x1,
         UTM10x10,
         References)


# Merge new datasets
citkeys <- list.dirs("inst", full.names = F, recursive = F) 
citkeys <- citkeys[!citkeys %in% c("AFLIBER", "ERRORS", "COMPILATION")]

AFLIBER_novelties <- data.frame(Taxon      = NULL,
                                UTM1x1     = NULL,
                                UTM10x10   = NULL,
                                References = NULL#,
                                # branch = NULL
                                )

for(citkey in citkeys){
  newdata <- readr::read_csv(paste0("inst/", citkey, "/data/", citkey, ".csv"), show_col_types = F) |> 
    mutate(branch=citkey)
  
  if(citkey == "Mateo2024"){
    newdata <- newdata |>
      mutate(References = "Mateo, G. (2024). Personal Database.")
  }
  AFLIBER_novelties <- AFLIBER_novelties |> 
    bind_rows(newdata)
}

AFLIBER_novelties [is.na(AFLIBER_novelties$References),]

rm(citkey, citkeys, newdata)
