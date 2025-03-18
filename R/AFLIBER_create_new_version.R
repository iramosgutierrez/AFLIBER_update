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


source(here::here("R/AFLIBER_merge_novelties.R"))
 

#Error erasing at the end!

#4.  Amend Reference errors
source("R/Compilation_functions.R")
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

AFLIBER_novelties <- AFLIBER_novelties |> 
  mutate(References =gsub(" ", " ", References)) |> 
  left_join(refs) |> 
rename(Reference_old = References,
       References = Reference_ok) |> 
  select(Taxon,
         UTM1x1,
         UTM10x10,
         References) 

refs_char <- sort(unique(AFLIBER_novelties$References))
old_sources <- readr::read_csv("inst/AFLIBER/raw/AFLIBER_v1_DataSources.csv", 
                               locale = locale(encoding = "Latin1"),
                               show_col_types = F)

new_sources <- data.frame(matrix(ncol = 4,nrow = length(refs_char)))
colnames(new_sources) <- colnames(old_sources)
new_sources$REFERENCE <- refs_char
new_sources$CITATION <- refs_char

given.refs <-old_sources$`NUMERIC REFERENCE`
given.refs <- given.refs[-which(given.refs == 999)]
lastref <- max(given.refs)

for(i in 1:length(refs_char)){
  ref.i <- refs_char[i]
  
  if(ref.i %in% old_sources$REFERENCE){
    ref.n <- old_sources$`NUMERIC REFERENCE`[old_sources$REFERENCE == ref.i]
    new_sources$`NUMERIC REFERENCE`[i] <- ref.n
  }else{
    ref.n <- lastref+1
    new_sources$`NUMERIC REFERENCE`[i] <- ref.n
    lastref <- ref.n
  }
  
  occs <- nrow( AFLIBER_novelties[AFLIBER_novelties$References == ref.i,])
  new_sources[i, "NUMBER OF OCCURRENCES"] <- occs
  }

new_sources <- new_sources |> 
  arrange(desc(`NUMBER OF OCCURRENCES`))
  
# write_csv(new_sources, "AFLIBER_v2.0.0/AFLIBER_DataSources.csv")



# Convert long to compressed References column
refs2join <- new_sources |> 
  select(References = REFERENCE,
         ref.n = `NUMERIC REFERENCE`)


AFLIBER_novelties_num <- AFLIBER_novelties |> 
  left_join(refs2join) |> 
  mutate(ref.n =as.character(ref.n)) |> 
  select(Taxon,
         UTM1x1,
         UTM10x10,
         References = ref.n)


AFLIBER_distributions_complete <- bind_rows(AFLIBER_distributions_old, AFLIBER_novelties_num) |> 
  group_by(Taxon, UTM10x10, UTM1x1) |> 
  summarise(References = paste0(sort(unique(as.numeric(References))), collapse = "_"))
beepr::beep(2)

# Erase detected errors posteriorly

source("R/AFLIBER_corrections.R")




# write_csv(AFLIBER_distributions_complete, "AFLIBER_v2.0.0/AFLIBER_Distributions.csv")

#  create maps

afliber_old <- read_csv("inst/AFLIBER/raw/AFLIBER_Distributions.csv", show_col_types = F)
afliber_new <- read_csv("AFLIBER_v2.0.0/AFLIBER_Distributions.csv",   show_col_types = F)

spp <- unique(afliber_new$Taxon)
grid <- terra::vect("data-raw/Iberian_Peninsula_10x10_Grid/Iberian_Peninsula_10x10_Grid.shp")
provs <- terra::vect("E:/UNI/4. DOCTORADO/1. AFLIBER/0. GARANTIA JUVENIL (antes en 'UNI')/ARCHIVOS GIS/provincias/PROVINCIAS_PIB+BAL.shp")

for(sp in spp[-c(1:2834)]){ # la cosa va por "Helictochloa bromoides bromoides"[2835]
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



