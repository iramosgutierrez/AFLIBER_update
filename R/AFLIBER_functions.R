
require(rgbif)

# Iberian Grid cells allowed values
valid.cells <- read.csv(here::here("data-raw/validcells_10.csv"))[,1]
valid.taxa  <- read.csv(here::here("data-raw/AFLIBER_Species_list.csv"))[,"Taxon",drop=T]


progressbar <- function( curr.iter,tot.iter, ini.iter=1, units="mins", msg=NULL){
  
  curr.iter <- curr.iter - ini.iter +1
  tot.iter <- tot.iter - ini.iter +1
  if(units=="secs"){d <-0}else if(units=="hours"){d <- 2} else{d <- 1}
  
  if(curr.iter==1 & !is.null(msg)){cat(msg, "\n")}
  
  if(curr.iter==1){
    st <<- Sys.time()
    cat(paste0("0%       25%       50%       75%       100%", "\n",
               "|---------|---------|---------|---------|", "\n"))
  }
  
  v<- seq(from=0, to=40, by=40/tot.iter)
  v<- diff(ceiling(v))
  v <- cumsum(v)
  txt <- strrep("*", times=v[curr.iter])
  txt <- stringr::str_pad(txt, width = 45, side="right", pad=" ")
  ct <-Sys.time()
  et  <- as.numeric(difftime(ct, st, units=units))/curr.iter*(tot.iter-curr.iter)
  et <- round(et, digits=d)
  txt.end <- paste0(txt, "ETC: ", et, " ", units)
  if(curr.iter == ini.iter){txt.end <- paste0(txt, "ETC: ");maxnchar <<- nchar(txt.end)}
  if(curr.iter == tot.iter){txt.end <- paste0("*", txt, "DONE")}
  
  if(nchar(txt.end)>maxnchar){maxnchar <<- nchar(txt.end)}
  txt.end <- stringr::str_pad(txt.end, width = maxnchar, side="right", pad=" ")
  
  cat("\r")
  cat(txt.end)
  
  if(curr.iter == tot.iter){cat("\n")}
  if(curr.iter == tot.iter){ rm(list=c("st", "maxnchar"),envir =  .GlobalEnv)}
}



check_cells <- function(dt, erase = F){
  
  invalid.values <- dt[!(dt$UTM10x10 %in% valid.cells),]
  
  dt <- dt |> 
    mutate(UTM10x10 = ifelse(UTM10x10 == "29SPE83", "29SPE83",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SPE93", "29SPE93",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SQE03", "29SQE03",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SQE13", "29SQE13",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SQE23", "29SQE23",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SQE33", "29SQE33",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SQE43", "29SQE43",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29SQE53", "29SQE53",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE02", "29TNE02",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE12", "29TNE12",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE22", "29TNE22",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE32", "29TNE32",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE42", "29TNE42",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE52", "29TNE52",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE62", "29TNE62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE72", "29TNE72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE82", "29TNE82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TNE92", "29TNE92",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE02", "29TPE02",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE12", "29TPE12",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE22", "29TPE22",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE32", "29TPE32",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE42", "29TPE42",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE52", "29TPE52",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE62", "29TPE62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE72", "29TPE72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "29TPE82", "29TPE82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30STK43", "30STK43",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30STK53", "30STK53",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30STK63", "30STK63",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30STK73", "30STK73",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30STK83", "30STK83",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30STK93", "30STK93",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SUK03", "30SUK03",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SUK13", "30SUK13",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SXK83", "30SXK83",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SXK93", "30SXK93",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SYK03", "30SYK03",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SYK13", "30SYK13",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SYK23", "30SYK23",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SYK33", "30SYK33",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SYK43", "30SYK43",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30SYK53", "30SYK53",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK12", "30TUK12",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK22", "30TUK22",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK32", "30TUK32",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK42", "30TUK42",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK52", "30TUK52",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK62", "30TUK62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK72", "30TUK72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK82", "30TUK82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TUK92", "30TUK92",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK02", "30TVK02",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK12", "30TVK12",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK22", "30TVK22",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK32", "30TVK32",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK42", "30TVK42",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK52", "30TVK52",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK62", "30TVK62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK72", "30TVK72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK82", "30TVK82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TVK92", "30TVK92",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK02", "30TWK02",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK12", "30TWK12",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK22", "30TWK22",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK32", "30TWK32",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK42", "30TWK42",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK52", "30TWK52",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK62", "30TWK62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK72", "30TWK72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK82", "30TWK82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TWK92", "30TWK92",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK02", "30TXK02",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK12", "30TXK12",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK22", "30TXK22",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK32", "30TXK32",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK42", "30TXK42",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK52", "30TXK52",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK62", "30TXK62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK72", "30TXK72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "30TXK82", "30TXK82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "31SBE43", "31SBE43",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "31TEE62", "31TEE62",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "31TEE72", "31TEE72",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "31TEE82", "31TEE82",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "31TEE92", "31TEE92",UTM10x10),
           UTM10x10 = ifelse(UTM10x10 == "31TFE02", "31TFE02",UTM10x10))
      
    
  
  if(nrow(invalid.values) ==0){message("All 10x10 cells are valid")}
  
  if(nrow(invalid.values) > 0 & isFALSE(erase)){
    stop("There are ", nrow(invalid.values), " non-valid cells. Check grid cells:\n",
         paste0(unique(invalid.values$UTM10x10), collapse = "\n"))
    }
  
  if(nrow(invalid.values) > 0 & isTRUE(erase)){
    message("There are ", nrow(invalid.values), " non-valid cells. Erasing them.")
    dt <- dt[(dt$UTM10x10 %in% valid.cells),]
  }
  
  return(dt)
}

check_taxa <- function(dt, erase = F){
  invalid.values <- dt[!(dt$Taxon %in% valid.taxa),]
  
  if(nrow(invalid.values) ==0){message("All taxa are valid")}
  
  if(nrow(invalid.values) > 0 & isFALSE(erase)){
    stop("There are ", length(unique(invalid.values$Taxon)), " non-valid taxa Check:\n",
         paste0(unique(invalid.values$Taxon), collapse = "\n"))
  }
  
  if(nrow(invalid.values) > 0 & isTRUE(erase)){
    message("There are ", length(unique(invalid.values$Taxon)), " non-valid taxa Erasing them.")
    dt <- dt[(dt$Taxon %in% valid.taxa),]
  }
  
  return(dt)
}

clean_values <- function(dt){
  
  ret_dt <- dt |> 
    check_taxa(erase = T) |> 
    check_cells(erase = T)
}


erase_gridcell <- function(dt, taxon, grid1 = NULL, grid10 = NULL){
  if(!taxon %in% dt$Taxon){stop(taxon , " is not in the given dataset")}
  if(is.null(grid1) & is.null(grid10)){stop("please specify a grid value")}
  if(!is.null(grid1) & !is.null(grid10)){stop("please select a unique resolution")}
  
  in.r <- nrow(dt)
  if(!is.null(grid1)){
    if(any(nchar(grid1) !=9)){stop("Some 1x1 grid cells do not have 9 characters")}
    
    dt_ret <- dt[!(dt$Taxon == taxon & dt$UTM1x1 %in% grid1),]
  }
  
  if(!is.null(grid10)){
    if(any(nchar(grid10) !=7)){stop("Some 10x10 grid cells do not have 7 characters")}
    
    dt_ret <- dt[!(dt$Taxon == taxon & dt$UTM10x10 %in% grid10),]
  }
  
  end.r <- nrow(dt_ret)
  print(paste0(in.r-end.r, " rows removed"))
  return(dt_ret)
}

amend_gridcell <- function(dt, taxon, oldgrid1 = NULL, newgrid1 = NULL, oldgrid10 = NULL, newgrid10 = NULL){
  
}



#' @export
create_new_version <- function(){
  datasets <- list.dirs("inst", recursive = F, full.names = F)
  datasets <- datasets[datasets != c("materials")]
  
  if(!file.exists("ABRYIBERcsv")){
    ABRYIBER <- data.frame()
  }else{
    ABRYIBER <- readr::read_csv(ABRYIBER.csv)
  }
  
  for(i in 1:length(datasets)){
  citationkey.i <- datasets[i]
  dataset.i <- readr::read_csv(paste0("inst/", citationkey.i, "/", citationkey.i, ".csv"))
  ABRYIBER <- rbind(ABRYIBER, dataset.i)
  }
  
  version <- readLines ("NEWS.md")
  
  # breakFun(version)
  # cat(paste0(lapply(version, FUN=function(x) breakFun(x)), collapse=""))
  # 
  vers <- version[2] 
  while(grepl(" #", vers)){
    vers <- gsub(" #", "#", vers)
    }
  v.num <- stringr::str_count(vers, '\\w+')
  v.num <- stringr::word(vers, start = v.num+1, sep=" ")
  v.num.new <- as.numeric(v.num)+1
  
  
  cat("", "\n", "# ABRYIBER version ", v.num.new, "\n\n",
      "* Released on: ", format(Sys.Date(), "%_Y-%m-%d"),". ", nrow(ABRYIBER), " rows.\n",
      paste0(version, "\n"), file = "NEWS.md")
  
  # readr::write_csv(ABRYIBER, "ABRYIBER.csv")
  return(ABRYIBER)
  
}


