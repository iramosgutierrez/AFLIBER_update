source("R/AFLIBER_functions.R")
library(tidyverse)

elim1 <- read_csv("inst/AFLIBER/raw/AFLIBER_v1_Eliminations.csv") |> 
  rename(UTM10x10 = UTM.cell) |> 
  mutate(UTM1x1 = NA,
         Notes = NA)
elim2 <- read_csv("inst/COMPILATION/AFLIBER_v2_Eliminations.csv")

elim <- bind_rows(elim1, elim2) |> 
  distinct()


AFLIBER_distributions_complete <- erase_gridcells(AFLIBER_distributions_complete, elim)
  
  


  
AFLIBER_distributions_complete <- AFLIBER_distributions_complete |> 
  mutate(UTM1x1   = ifelse(Taxon == "Quercus coccifera" & UTM10x10 == "30TVL54", "30TVK6453", UTM1x1),
         UTM10x10 = ifelse(Taxon == "Quercus coccifera" & UTM10x10 == "30TVL54", "30TVK65"  , UTM10x10))
