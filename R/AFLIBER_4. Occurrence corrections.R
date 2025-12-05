source("R/AFLIBER_functions.R")
library(tidyverse)

elim1 <- read_csv("inst/AFLIBER/raw/AFLIBER_v1_Eliminations.csv") |> 
  rename(UTM10x10 = UTM.cell) |> 
  mutate(UTM1x1 = NA,
         Notes = NA)
elim2a <- read_csv("inst/COMPILATION/AFLIBER_v2.1_Eliminations.csv")#errors detected during re-compilation time
elim2b <- read_csv("inst/COMPILATION/AFLIBER_v2.2_Revision_elim.csv")#errors detected in revision process
elim <- bind_rows(elim1, elim2a, elim2b) |> 
  distinct()

elim |> 
  select(Taxon, UTM10x10) |> 
  distinct() |> 
  write_csv("AFLIBER_v2.0.0/AFLIBER_v2_Eliminations.csv")

AFLIBER_distributions_complete <- erase_gridcells(AFLIBER_distributions_complete, elim)
  
  
#Manual corrections
AFLIBER_distributions_complete <- AFLIBER_distributions_complete |> 
  mutate(#UTM1x1   = ifelse(Taxon == "Quercus coccifera" & UTM10x10 == "30TVL54", "30TVK6453", UTM1x1),
         UTM10x10 = ifelse(Taxon == "Quercus coccifera" & UTM10x10 == "30TVL54", "30TVK65"  , UTM10x10)) |> 
  
  mutate(Taxon = ifelse(Taxon == "Hedera helix helix", "Hedera helix", Taxon),
         Taxon = ifelse(Taxon == "Hedera helix rhizomatifera", "Hedera helix", Taxon),
         Taxon = ifelse(Taxon == "Hedera maderensis iberica", "Hedera iberica", Taxon)) |> 
  
  filter(Taxon %in% AFLIBER_specieslist_new$Taxon)


# MGRS1x1 corrections

AFLIBER_distributions_final <- AFLIBER_distributions_complete |> 
  ungroup() |> 
  
  # mutate(extr10 = ifelse(is.na(UTM1x1), 
  #                        NA, 
  #                        paste0(substr(UTM1x1, 1, 6), substr(UTM1x1, 8, 8)))) |> 
  # # filter(is.na(UTM1x1) | UTM10x10 == extr10) |> 
  # mutate(UTM1x1 = ifelse(!is.na(UTM1x1) & UTM10x10 == extr10, UTM1x1, NA)) |> 
  # select(-extr10, -UTM1x1) |> 
  distinct()

         
         

