
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
  occurrences <- occ_download_get("0023012-251025141854904")|> 
    occ_download_import()
  
  occurrences_spat <- occurrences |> 
    filter(coordinateUncertaintyInMeters < 1000) |> 
    vect(geom = c("decimalLongitude", "decimalLatitude")) |> 
    set.crs("epsg:4326") |> 
    project(grid)
  

  
  touch <- terra::relate(grid, occurrences_spat, relation = "intersects") |> 
    as.data.frame() |> 
    mutate(id = grid$MGRS_10km) |> 
    filter(if_any(starts_with("V"), ~ .x == TRUE))
  
  
touch$id
  

  
