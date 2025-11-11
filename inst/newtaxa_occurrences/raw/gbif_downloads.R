
library(rgbif)
library(terra)



provs <- vect(".../PROVINCIAS_PIB+BAL.shp")
provs <-terra::project(provs, "epsg:4326")

grid <- vect(".../Iberian_Peninsula_10x10_Grid.shp")

extent.1 <- terra::ext(provs[1,])
xm1 <- extent.1[1]
xM1 <- extent.1[2]
ym1 <- extent.1[3]
yM1 <- extent.1[4]


gbifkey <- 6312882 # Festuca paniculata longiglumis
gbifkey <- 5289948 # Digitaria debilis

  lookup_settings <- pred_and(
    pred("taxonKey", gbifkey),
    pred_within(paste0("POLYGON((",
                       xm1, " ", ym1, ", ",
                       xm1, " ", yM1, ", ",
                       xM1, " ", yM1, ", ",
                       xM1, " ", ym1, ", ",
                       xm1, " ", ym1,
                       "))"))
  )
  
  download <- rgbif::occ_download(
    lookup_settings,
    user = gbif_user,
    pwd = gbif_password,
    email = gbif_email
  )
  
  occ_download_wait(download)
  # occurrences <- occ_download_get("0023012-251025141854904")|> # Festuca paniculata longiglumis
  occurrences <- occ_download_get("0027230-251025141854904")|> # Digitaria debilis
    occ_download_import()
  
  occurrences_spat <- occurrences |> 
    filter(coordinateUncertaintyInMeters < 1000) |> 
    vect(geom = c("decimalLongitude", "decimalLatitude")) |> 
    set.crs("epsg:4326") |> 
    project(grid)
  
provs_ind <- provs[provs$COD_BUSQ %in% c("SPAIN_Cc", "PORT_E", "PORT_Mi", "SPAIN_Ge", "SPAIN_H", "SPAIN_L")] |> #for digitaria debilis
  project(grid)

inside <- terra::relate(occurrences_spat, buffer(provs_ind, 1000), relation = "intersects") |> 
  as.data.frame() |> 
  mutate(id = row_number()) |> 
  filter(if_any(starts_with("V"), ~ .x == TRUE))

occurrences_spat <- occurrences_spat[inside$id,]
  
  touch <- terra::relate(grid, occurrences_spat, relation = "intersects") |> 
    as.data.frame() |> 
    mutate(id = grid$MGRS_10km) |> 
    filter(if_any(starts_with("V"), ~ .x == TRUE))
  
data.frame(taxon = "Digitaria debilis", grids = touch$id, "reference" = "Global Biodiversity Information Facility") |> 
  write.table("clipboard", row.names = F, col.names = F, sep ="\t")
  

  
