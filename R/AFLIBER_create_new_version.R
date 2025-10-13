library(here)
library(tidyverse)


source(here::here("R/AFLIBER_functions.R"))
#1.  Species List re-generation

source(here::here("R/AFLIBER_1. Species list regeneration.R"))



#2. Distribution dataset compilation


source(here::here("R/AFLIBER_2. merge_novelties.R"))
 

#Error erasing at the end!

#3.  Amend Reference errors

source(here::here("R/AFLIBER_3. Reference numbers.R"))




#4. Erase errors
source("R/AFLIBER_4. Occurrence corrections")




# write_csv(AFLIBER_distributions_complete, "AFLIBER_v2.0.0/AFLIBER_Distributions.csv")

#  create maps####

afliber_old <- read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", show_col_types = F)
afliber_new <- read_csv("AFLIBER_v2.0.0/AFLIBER_Distributions.csv",   show_col_types = F)

spp <- unique(afliber_new$Taxon)
grid <- terra::vect("data-raw/Iberian_Peninsula_10x10_Grid/Iberian_Peninsula_10x10_Grid.shp")
provs <- terra::vect("E:/UNI/4. DOCTORADO/1. AFLIBER/0. GARANTIA JUVENIL (antes en 'UNI')/ARCHIVOS GIS/provincias/PROVINCIAS_PIB+BAL.shp")

for(sp in spp){ # la cosa va por "Helictochloa bromoides bromoides"[2835]
  RIRG::progressbar(
    which(spp == sp)-2834,
    length(spp)-2834,
    units = "mins"
  )
  old.cells <- unique(afliber_old$UTM.cell[afliber_old$Taxon == sp])
  new.cells <- unique(afliber_new$UTM10x10[afliber_new$Taxon == sp])
  
  all.cells <- unique(c(old.cells, new.cells))
  
  only.old.cells <- all.cells[! (all.cells %in% new.cells)]
  only.new.cells <- all.cells[! (all.cells %in% old.cells)]
  bothtype.cells <-  all.cells[(all.cells %in% new.cells) & (all.cells %in% old.cells)]
  
  
  # write.table(only.new.cells, "clipboard", sep="\t", row.names = F, col.names = F)
  
  if(length(only.new.cells)== 0  & length(only.old.cells) == 0){
    # cat(paste0("Skipping: ", sp))
    next
  }

  png(paste0("AFLIBER_v2.0.0/maps_v1.2/", gsub(" ", "_", sp), ".png"),height = 150, width = 150,
       units="mm", res =300)
   par(bg="aliceblue")
  terra::plot(provs, border ="lightgrey", col="white")
  if(length(bothtype.cells)>0){
  terra::plot(grid[grid$MGRS_10km %in% bothtype.cells], add = T, col ="#c4e082", border = "#c4e082aa")
  }
  if(length(only.new.cells)>0){
  terra::plot(grid[grid$MGRS_10km %in% only.new.cells], add = T, col ="#528fcc", border = "transparent")
  }
  if(length(only.old.cells)>0){
  terra::plot(grid[grid$MGRS_10km %in% only.old.cells], add = T, col ="#c92020", border = "transparent")
  }
  dev.off()

}


# Maps to check
library(leaflet)
library(terra)


spp <- list.files("../GitHub/maps/maps_v1.2_JCM", pattern = ".png") |> 
  gsub(pattern = ".png", replacement = "") |> 
  gsub(pattern = "_", replacement = " ")
spp


# work.packages <- list(
#   "id" = 1,
#   "description" = paste0("description_", 1),
#   "species" = spp[1:5]
# )


for(i in 1:length(spp)){
RIRG::progressbar(i, length(spp), , "mins")

# if(!file.exists(paste0("E:/UNI/4. DOCTORADO/99. OTROS/2021_10_07 AFLIBER 2.0/GitHub/maps/maps_v2/", gsub(" ", "_", spp[i]), "_AFLIBER2.html"))){
rmarkdown::render(input = "E:/UNI/4. DOCTORADO/99. OTROS/2021_10_07 AFLIBER 2.0/GitHub/maps/maps_v2.Rmd",
                  output_dir = "E:/UNI/4. DOCTORADO/99. OTROS/2021_10_07 AFLIBER 2.0/GitHub/maps/maps_v2",
                  output_file = paste0(gsub(" ", "_", spp[i]), "_AFLIBER2"),
                  params = list(species = spp[i]),
                  quiet = T
)
# }
}

