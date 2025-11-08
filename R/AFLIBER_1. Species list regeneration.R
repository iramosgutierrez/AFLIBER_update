

AFLIBER_specieslist_old <- read_csv(here("inst/AFLIBER/raw/AFLIBER_Species_list.csv"), show_col_types = F)

taxa_to_erase <- read_csv("inst/COMPILATION/AFLIBER_v2_Taxonomic_novelties.csv") |> 
  filter(Action == "ERASE") 

taxa_to_add   <- read_csv("inst/COMPILATION/AFLIBER_v2_Taxonomic_novelties.csv") |> 
  filter(Action == "ADD") |>  
  select(-c(Action, Reference))


AFLIBER_specieslist_new <- AFLIBER_specieslist_old |> 
  filter(!Taxon %in% taxa_to_erase$Taxon) |> 
  rbind(taxa_to_add)
