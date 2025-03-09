source("R/AFLIBER_functions.R")

AFLIBER_distributions_complete <- AFLIBER_distributions_complete |> 
  
    erase_gridcell(taxon = "Ornithogalum reverchonii", grid10 = c("30SVF06", "30SVF28")) |> 
    erase_gridcell(taxon = "Ornithogalum reverchonii", grid1 = c("30SVF0069", "30SVF9969", "30SWH0411")) |> 
    
    erase_gridcell(taxon = "Woodwardia radicans"          , grid10 =  "29TQH11" ) |> 
    erase_gridcell(taxon = "Aconitum napellus castellanum", grid10 =  "30TUK46" ) |> 
    erase_gridcell(taxon = "Draba hispanica lebrunii"	    , grid10 =  "29TQH26" ) |> 
    erase_gridcell(taxon = "Draba hispanica lebrunii"	    , grid10 =  "30TUN53" ) |> 
    erase_gridcell(taxon = "Draba hispanica lebrunii"	    , grid10 =  "30TUN63" ) |> 
    erase_gridcell(taxon = "Petrocoptis pyrenaica viscosa", grid10 =  "29TQH26" ) |> 
    erase_gridcell(taxon = "Petrocoptis pyrenaica viscosa", grid10 =  "30TTN55" ) |> 
    erase_gridcell(taxon = "Echium cantabricum"  	        , grid10 =  "30TUN58" ) |> 
    erase_gridcell(taxon = "Echium cantabricum"  	        , grid10 =  "30TUN75" ) |> 
    erase_gridcell(taxon = "Genista sanabrensis" 	        , grid10 =  "29TQG16" ) |> 
    erase_gridcell(taxon = "Genista sanabrensis" 	        , grid10 =  "29TPG84" ) |> 
    erase_gridcell(taxon = "Genista sanabrensis" 	        , grid10 =  "30TTN61" ) |> 
    erase_gridcell(taxon = "Armeria rothmaleri"  	        , grid10 =  "29TQH14" ) |> 
    
    erase_gridcell(taxon = "Viola cazorlensis"         , grid10 = "30SVG09" ) |> 
    erase_gridcell(taxon = "Gyrocaryum oppositifolium" , grid10 = "30STG69" ) |> 
    
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TPG89") |> 
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TPH90") |> 
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TPH91") |> 
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TQH00") |> 
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TQH15") |> 
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TQH16") |> 
    erase_gridcell(taxon = "Geranium dolomiticum", grid10 = "29TQH25") |> 
    
    erase_gridcell(taxon = "Astragalus gines-lopezii" , grid10 = "30TUK08") |> 
    erase_gridcell(taxon = "Astragalus gines-lopezii" , grid10 = "30TUK09") |> 
    erase_gridcell(taxon = "Epipogium aphyllum"       , grid10 = "31TBG95") |> 
    erase_gridcell(taxon = "Epipogium aphyllum"       , grid10 = "31TBG53") |> 
    erase_gridcell(taxon = "Erodium paularense"       , grid10 = "30TVL22") |> 
    erase_gridcell(taxon = "Erodium paularense"       , grid10 = "30TVL25") |> 
    erase_gridcell(taxon = "Erodium paularense"       , grid10 = "30TVL32") |> 
    erase_gridcell(taxon = "Erodium paularense"       , grid10 = "30TWK06") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "30TXL99") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "30TXM90") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "30TYM02") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "30TYM44") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "31TBF47") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "30TYL43") |> 
    erase_gridcell(taxon = "Ferula loscosii"          , grid10 = "30TYL47") |> 
    erase_gridcell(taxon = "Geranium dolomiticum"     , grid10 = "29TPG89") |>
    erase_gridcell(taxon = "Geranium dolomiticum"     , grid10 = "29TPH91") |>
    erase_gridcell(taxon = "Geranium dolomiticum"     , grid10 = "29TQH00") |>
    erase_gridcell(taxon = "Geranium dolomiticum"     , grid10 = "29TQH15") |>
    erase_gridcell(taxon = "Geranium dolomiticum"     , grid10 = "29TQH16") |>
    erase_gridcell(taxon = "Geranium dolomiticum"     , grid10 = "29TQH25") |>
    erase_gridcell(taxon = "Pilularia minuta"         , grid10 = "29TPG25") |> 
    erase_gridcell(taxon = "Viola cazorlensis"        , grid10 = "30SVG09") 
  
AFLIBER_distributions_complete <- AFLIBER_distributions_complete |> 
  mutate(UTM1x1 =   ifelse(Taxon == "Quercus coccifera" & UTM10x10 == "30TVL54", "30TVK6453", UTM1x1),
         UTM10x10 = ifelse(Taxon == "Quercus coccifera" & UTM10x10 == "30TVL54", "30TVK65"  , UTM10x10))
