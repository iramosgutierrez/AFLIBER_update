AFLIBER data

AFLIBER_v2_Species_list.csv is the result of the compilation of 6,471 native species and subspecies (5,691 species after collapsing subspecies), of which 2,156 are endemic to the study area.
AFLIBER_v2_Species_list.csv Columns:	
	-Taxon: Genus, species and subspecies (if applicable) epithets.
	-Scientific_Name: Accepted scientific name.
	-Endemic: Endemism of the Balearic Islands and / or the Iberian Peninsula (incl. French northern Pyrenean slope).
	-Genus: Adopted taxonomical category.
	-Species: Adopted taxonomical category.
	-Subspecies: Adopted taxonomical category.
	-Class: Taxonomical category according to the National Center for Biotechnology Information (www.ncbi.nlm.nih.gov/guide/taxonomy/).
	-Order: Taxonomical category (according NCBI).
	-Family: Taxonomical category (according NCBI).
	-GBIF_id: Taxonomic numeric identifier in the Global Biodiversity Information Facility (https://www.gbif.org/)
	-POW_Name: Accepted taxonomic name in Plants of the World online (www.plantsoftheworldonline.org)


AFLIBER_v2_Distributions.csv comprises 1,942,750 unique (i.e. non-duplicated) records from a total of 3,129,863 distributional records of vascular taxa at the 10-km side grid-cell resolution.
AFLIBER_v2_Distributions.csv Variables:
	-Taxon: Genus, species and subspecies (if applicable) epithets.
	-UTM10x10: UTM 10 km side grid cell where the taxon is recorded
	-References: Sources from which the occurrence data were obtained. Numerical references correspond to those shown in AFLIBER_v2_DataSources.csv.


AFLIBER_v2_DataSources.csv shows all the XXX datasets compiled, along with some complemetary information.
AFLIBER_v2_DataSources.csv  Columns
	-Taxon:Numeric_reference: Numeric reference used in the Distributions’ "References" column.
	-Reference: Name of the dataset.
	-Citation: Citation for the dataset.
	- Number_occurrences: Number of occurrences incorporated to the latest version.

AFLIBER_v2_Eliminations.csv is a compilation of occurrences which have been disregarded in the process of data curation.
AFLIBER_v2_Eliminations.csv Columns
	-Taxon: Genus, species and subspecies (if applicable) epithets.
	-UTM10x10: UTM 10 km side grid cell where the taxon had been mistakenly recorded.



AFLIBER_v2_update.zip comprises a series of scripts used to update the AFLIBER dataset step by step.