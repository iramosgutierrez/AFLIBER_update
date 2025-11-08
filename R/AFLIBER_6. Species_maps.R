


afliber_old <- read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", show_col_types = F)
afliber_new <- read_csv("AFLIBER_v2.0.0/AFLIBER_Distributions.csv",   show_col_types = F)

spp <- unique(afliber_new$Taxon)
grid <- terra::vect("data-raw/Iberian_Peninsula_10x10_Grid/Iberian_Peninsula_10x10_Grid.shp")
provs <- terra::vect("E:/UNI/4. DOCTORADO/1. AFLIBER/0. GARANTIA JUVENIL (antes en 'UNI')/ARCHIVOS GIS/provincias/PROVINCIAS_PIB+BAL.shp")


saving_dir <- "../GitHub/maps/maps_v3.nov/"
# done <- list.files(saving_dir, ".png") |> 
#   gsub(pattern ="_", replacement = " ")|> 
#   gsub(pattern =".png", replacement = "")
# spp <- spp[!spp %in% done]
# saving_dir <- "../GitHub/maps/maps_v3.2/"
for(sp in spp){ # sp = "Acer pseudoplatanus"
  RIRG::progressbar(
    which(spp == sp),
    length(spp),
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
    # next
  }
  
  png(paste0(saving_dir, gsub(" ", "_", sp), ".png"),height = 150, width = 180, units="mm", res =300)
  par(bg="aliceblue")
  terra::plot(provs, border ="lightgrey", col="white", main = sp)
  if(length(bothtype.cells)>0){
    terra::plot(grid[grid$MGRS_10km %in% bothtype.cells], add = T, col ="#95b34f", border = "#95b34faa")
  }
  if(length(only.new.cells)>0){
    terra::plot(grid[grid$MGRS_10km %in% only.new.cells], add = T, col ="#528fcc", border = "#528fccaa")
  }
  if(length(only.old.cells)>0){
    terra::plot(grid[grid$MGRS_10km %in% only.old.cells], add = T, col ="#c92020", border = "#c92020aa")
  }
  dev.off()
  
}


# Maps to check
library(leaflet)

sp <- "Campanula patula"
{
rmarkdown::render(input = "E:/UNI/4. DOCTORADO/99. OTROS/2021_10_07 AFLIBER 2.0/GitHub/maps/maps_v2.Rmd",
                  output_dir = paste0(saving_dir, "interactive"),
                  output_file = paste0(gsub(" ", "_", sp), "_AFLIBER2"),
                  params = list(species = sp),
                  quiet = T
)
beepr::beep(2)
}
