library(terra)
library(ggplot2)
library(tidyterra)


grid <- terra::vect("data-raw/Iberian_Peninsula_10x10_Grid/Iberian_Peninsula_10x10_Grid.shp")

AFLIBER_distributions_old <- AFLIBER_distributions_old |> 
  group_by(Taxon, UTM10x10, UTM1x1) |> 
  summarise(References = paste0(sort(unique(as.numeric(References))), collapse = "_"))

rich.old <- AFLIBER_distributions_old |> 
  distinct(Taxon, UTM10x10) |> 
  group_by(UTM10x10) |> 
  summarise(rich.old = n()) |> 
  rename(MGRS_10km = UTM10x10)

rich.new <- AFLIBER_distributions_complete |> 
  distinct(Taxon, UTM10x10) |> 
  group_by(UTM10x10) |> 
  summarise(rich.new = n())|> 
  rename(MGRS_10km = UTM10x10)

rich.values <- full_join(rich.old, rich.new) |> 
  mutate(rich.old = if_else(is.na(rich.old), 0, rich.old)) |> 
  mutate(rich.diff = rich.new - rich.old) |> 
  mutate(rich.diff = if_else(rich.diff<0, 0, rich.diff))


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


diff <- ggplot(grid.united, aes(fill = rich.diff))+
  geom_spatvector(colour = "#00000033")+
  scale_fill_binned(name ="novelties", palette = spectral, 
                    breaks =c(1, 10, 20, 50, 100, 150, 200))+
  labs(title = "Increase in number of AFLIBER occurrences")+
  theme(panel.background = element_rect(fill = "aliceblue"))

