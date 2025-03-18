# AFLIBER_update


## Steps for new version creation:


### Species List re-generation(needed for taxonomic checks afterwards)
-  Import taxa from previous version
-  Include new taxa in species list
-  Remove deprecated names
-  Re-run GBIF and POWO accepted names


### Distribution dataset compilation
-  Compile new occurrences form raw and generate new datasets; store discards for later checks.
-  Rename after new taxonomic framework (if species have been synonymized)


### Erase detected errors
-  Remove reported database errors


### Create reference table
-  Create new numeric references
-  Convert long to compressed References column


### (optional) Re-run maps to check

- Create maps for all species with changes




## Semantic versioning

- First figure stands for MAJOR versions (e.g. including new fields, as can be UTM1x1)
- Second figure stands for MINOR versions (e.g. including new databases)
- Third figure stands for patches (e.g. minor error corrections, small datasets included)