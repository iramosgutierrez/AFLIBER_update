library(here)
library(tidyverse)




#1.  Species List re-generation

AFLIBER_specieslist_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Species_list.csv", locale = locale(encoding = "Latin1"))

# AFLIBER_newtaxa <- readr::read_csv("inst/AFLIBER/raw/NewTaxa.csv", locale = locale(encoding = "Latin1"))

powonames <- rWCVPdata::wcvp_names

AFLIBER_specieslist_new <- AFLIBER_specieslist_old  |> 
  # bind_rows(AFLIBER_newtaxa)
  # removing deprecated names
  mutate(GBIF_id = sapply(AFLIBER_specieslist_new$Scientific_Name, get_gbif_id))

AFLIBER_specieslist_new <- AFLIBER_specieslist_new |> 
  mutate(POW_Name = sapply(AFLIBER_specieslist_new$Taxon, get_POWO_name, powonames = powonames))



#2. Distribution dataset compilation

AFLIBER_distributions_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", locale = locale(encoding = "Latin1")) |> 
  separate_longer_delim(References, delim = "_") |> 
  rename(UTM10x10 = UTM.cell) |> 
  mutate(UTM1x1 = NA) |> 
  select(Taxon,
         UTM1x1,
         UTM10x10,
         References)


citkeys <- list.dirs("inst", full.names = F, recursive = F) 
citkeys <- citkeys[!citkeys %in% c("AFLIBER", "ERRORS")]

AFLIBER_novelties <- data.frame(Taxon      = NULL,
                                UTM1x1     = NULL,
                                UTM10x10   = NULL,
                                References = NULL,
                                branch = NULL)

for(citkey in citkeys){
  newdata <- readr::read_csv(paste0("inst/", citkey, "/data/", citkey, ".csv"), show_col_types = F) |> 
    mutate(branch=citkey)

  if(citkey == "Mateo2024"){
    newdata <- newdata |>
      mutate(References = "Mateo24")
  }
  AFLIBER_novelties <- AFLIBER_novelties |> 
    bind_rows(newdata)
}

AFLIBER_novelties [is.na(AFLIBER_novelties$References),]
refs <- AFLIBER_novelties |> 
  distinct(References, branch)



