

if(!file.exists("AFLIBER_v2.0.0/AFLIBER_Species_list.csv")){
AFLIBER_specieslist_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Species_list.csv", locale = locale(encoding = "Latin1"))

# AFLIBER_newtaxa <- readr::read_csv("inst/AFLIBER/raw/NewTaxa.csv", locale = locale(encoding = "Latin1"))

powonames <- rWCVPdata::wcvp_names


AFLIBER_specieslist_new <- AFLIBER_specieslist_old  |> 
  # bind_rows(AFLIBER_newtaxa)
  # removing deprecated names
  mutate(GBIF_id = sapply(Scientific_Name, get_gbif_id))

AFLIBER_specieslist_new <- AFLIBER_specieslist_new |> 
  mutate(POW_Name = sapply(Taxon, get_POWO_name, powonames = powonames))

# readr::write_csv(AFLIBER_specieslist_new, "AFLIBER_v2.0.0/AFLIBER_Species_list.csv")
}else{
  AFLIBER_specieslist_new <- read_csv("AFLIBER_v2.0.0/AFLIBER_Species_list.csv")
}


