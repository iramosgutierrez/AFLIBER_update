library(terra)
library(ggplot2)
library(tidyterra)


grid <- terra::vect("data-raw/Iberian_Peninsula_10x10_Grid/Iberian_Peninsula_10x10_Grid.shp")

AFLIBER_distributions_old <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", 
                                             locale = locale(encoding = "Latin1"),
                                             show_col_types = FALSE) |> 
  rename(UTM10x10 = UTM.cell) 

AFLIBER_distributions_new <-  readr::read_csv("AFLIBER_v2.0.0/AFLIBER_v2_Distributions.csv")




rich.old <- AFLIBER_distributions_old |> 
  distinct(Taxon, UTM10x10) |> 
  group_by(UTM10x10) |> 
  summarise(rich.old = n()) |> 
  rename(MGRS_10km = UTM10x10)

rich.new <- AFLIBER_distributions_new |> 
  distinct(Taxon, UTM10x10) |> 
  group_by(UTM10x10) |> 
  summarise(rich.new = n())|> 
  rename(MGRS_10km = UTM10x10)

old_occs <- paste0(AFLIBER_distributions_old$Taxon,"-", AFLIBER_distributions_old$UTM10x10)
rich.nov <- AFLIBER_distributions_new |> 
  filter(!paste0(Taxon,"-",UTM10x10) %in% old_occs) |> 
  distinct(Taxon, UTM10x10) |> 
  group_by(UTM10x10) |> 
  summarise(rich.nov = n())|> 
  rename(MGRS_10km = UTM10x10)

rich.values <- full_join(rich.old, rich.new) |> 
  full_join(rich.nov) |> 
  mutate(rich.old = if_else(is.na(rich.old), 0, rich.old)) |> 
  mutate(rich.nov = if_else(is.na(rich.nov), 0, rich.nov)) 


grid.united <- terra::merge(grid, rich.values) 

spectral <- colorRampPalette(rev(c("#b31517", "#d7191c", "#fdae61", "#ffffbf", "#abdda4", "#2b83ba")))

old <- ggplot(grid.united, aes(fill = rich.old))+
  geom_spatvector(colour = "#00000033")+
  scale_fill_binned(name = "richness", palette = spectral, 
                    breaks =c(10, 20, 50, 100, 200, 500, 1000, 1200))+
  labs(title = "Number of species per 10x10 grid (AFLIBER 1)")+
  theme(panel.background = element_rect(fill = "aliceblue"))


new <- ggplot(grid.united, aes(fill = rich.new))+
  geom_spatvector(colour = "#00000033")+
  scale_fill_binned(name = "richness", palette = spectral, 
                    breaks =c(10, 20, 50, 100, 200, 500, 1000, 1200))+
  labs(title = "Number of species per 10x10 grid (AFLIBER 2)")+
  theme(panel.background = element_rect(fill = "aliceblue"))


diff <- ggplot(grid.united, aes(fill = rich.nov))+
  geom_spatvector(colour = "#00000033")+
  scale_fill_binned(name ="novelties", palette = spectral, 
                    breaks =c(1, 10, 20, 50, 100, 150, 200))+
  labs(title = "Increase in number of AFLIBER occurrences")+
  theme(panel.background = element_rect(fill = "aliceblue"))

