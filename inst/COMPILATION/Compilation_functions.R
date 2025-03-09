gr_mod <- function(x){
  x <- gsub("\\(", "\\\\(", x)
  x <- gsub("\\)", "\\\\)", x)
  return(x)
}  
substitute_refs <- function(data, dictionary, col.patt, col.sub, exact.col){
  
  pattern <- dictionary[,col.patt,T]
  substit <- dictionary[,col.sub,T]
  exact.val <- as.logical(dictionary[,exact.col,T])
  
  if(isTRUE(exact.val)){
    g1 <- which(data$References == pattern)
    if(length(g1) == 0){stop("No rows found")}
    data2 <- data |> 
      mutate(Reference_ok =ifelse(References == pattern, substit, Reference_ok))
    
    msg <-  substr(pattern, 1, 40)
    if(nchar(msg)<40){msg <- stringr::str_pad(string = msg,side = "right", width = 43, pad = " ")}else{msg <- paste0(msg, "...")}
    
    cat("\n", msg, " | ", paste0(length(g1), " rows changed"))
    # Sys.sleep(1)
    
  }
  
  if(isFALSE(exact.val)){
    g1 <- (grep(gr_mod(pattern), x = data$References))
    if(length(g1) == 0){stop("No rows found")}
    data2 <- data |> 
      mutate(Reference_ok =ifelse(grepl(pattern = gr_mod(pattern), References), substit, Reference_ok))
    g2 <- (grep(gr_mod(substit), x = data2$Reference_ok))
    
    msg <-  substr(pattern, 1, 40)
    if(nchar(msg)<40){msg <- stringr::str_pad(string = msg,side = "right", width = 43, pad = " ")}else{msg <- paste0(msg, "...")}
    
    cat("\n", msg, " | ", paste0(length(g2), " rows changed"))
    # Sys.sleep(1)
    
  }
  
  return(data2)
}
