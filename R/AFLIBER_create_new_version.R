library(here)
library(tidyverse)


source(here::here("R/AFLIBER_functions.R"))

#1.  Species List re-generation

AFLIBER_specieslist_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Species_list.csv", locale = locale(encoding = "Latin1"))

# AFLIBER_newtaxa <- readr::read_csv("inst/AFLIBER/raw/NewTaxa.csv", locale = locale(encoding = "Latin1"))

powonames <- rWCVPdata::wcvp_names


AFLIBER_specieslist_new <- AFLIBER_specieslist_old  |> 
  # bind_rows(AFLIBER_newtaxa)
  # removing deprecated names
  mutate(GBIF_id = sapply(Scientific_Name, get_gbif_id))
  
AFLIBER_specieslist_new <- AFLIBER_specieslist_new |> 
  mutate(POW_Name = sapply(Taxon, get_POWO_name, powonames = powonames))

readr::write_csv(AFLIBER_specieslist_new, "AFLIBER_v2.0.0/AFLIBER_Species_list.csv")



#2. Distribution dataset compilation

# Load old dataset
AFLIBER_distributions_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", locale = locale(encoding = "Latin1")) |> 
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
                                References = NULL,
                                branch = NULL)

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



 # Amend Reference errors
source("inst/COMPILATION/Compilation_functions.R")
refs <- AFLIBER_novelties |> 
  distinct(References)

ref_dictionary <- readxl::read_excel(here::here("inst/COMPILATION/reference_correction_subtitutions.xlsx"))|> 
  mutate(ref_grep_pattern =gsub(" ", " ", ref_grep_pattern),
         substitution =gsub(" ", " ", substitution))

refs <- refs |> 
  mutate(Reference_ok =NA) |> 
  mutate(References =gsub(" ", " ", References),
         Reference_ok =gsub(" ", " ", Reference_ok))


for(i in 1:nrow(ref_dictionary)){
  
  refs <- substitute_refs(data = refs, 
                          dictionary = ref_dictionary[i,], 
                          col.patt ="ref_grep_pattern",
                          col.sub  ="substitution",
                          exact.col ="exact"
  )
}
refs <- refs |> 
  mutate(Reference_ok = ifelse(is.na(Reference_ok), References, Reference_ok)) |> 
  distinct()

 AFLIBER_novelties |> 
  left_join(refs) |> 
  select(-References) |> 
  rename(References = Reference_ok) |> 
  select(Taxon,
         UTM1x1,
         UTM10x10,
         References)

