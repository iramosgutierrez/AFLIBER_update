setwd(RIRG::thiswd())
library(tidyverse)

taxa <- read.csv("Taxa_Flora-On.csv")

spp <- unique(stringr::word(taxa$Taxon, 1,2))



tab <- sp.tab <- read.csv(paste0("https://flora-on.pt/",gsub(" ", "_", spp[1]),".csv"), sep=";" )[0,]

for(i in 1:length(spp)){
  RIRG::progressbar(i, length(spp))

sp.tab <- read.csv(paste0("https://flora-on.pt/",gsub(" ", "_", spp[i]),".csv"), sep=";" )

if(ncol(tab) != ncol(sp.tab)){
  warning("taxon ", spp[i], " has a different number of columns")
  next}

tab <- rbind(tab, sp.tab)
}
# "Ornithogalum baeticum"
# Vicia sativa 
# Centaurium grandiflorum 
# Linaria viscosa
# Viola arvensis

# readr::write_csv(tab, "flora_on_complete.csv")

tab <- readr::read_csv("flora_on_complete.csv") |> 
  filter(!is.na(Ano) & !is.na(Mês)) |> 
  mutate(Dia = ifelse(is.na(Dia), 1, Dia)) |> 
  mutate(Date = as.Date(paste0(Ano, "/", Mês, "/", Dia), format = "%Y/%m/%d"))  |> 
  filter(Date > as.Date("2020/01/21", format = "%Y/%m/%d")) |>
  
  mutate(UTM10x10 = paste0(Zona.UTM, Quadrícula)) |> 
  select(Taxon, UTM10x10) |> 
  unique()

readr::write_csv(tab, "Flora_on_clean(2025_02_18).csv")


