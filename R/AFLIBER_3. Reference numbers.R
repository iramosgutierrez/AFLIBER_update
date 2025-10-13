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
