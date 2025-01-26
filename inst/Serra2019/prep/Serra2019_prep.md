Serra2019
================
Ignacio Ramos-Gutiérrez
2025-01-13

Data origin reference: La flora del Paisaje Protegido de las sierras del
Maigmó y del Sit. ISBN: 8495254697.

Primary data compiler: Lluis Serra Laliga

Other data compilers:

## Notes

-   

## Packages

``` r
library(here)
library(tidyverse)
library(tidylog)
library(terra)

source(here::here("R/AFLIBER_functions.R"))
```

## Load dataset

``` r
citationkey <- "Serra2019"
# dt_raw <- readr::read_csv(here(paste0("inst/",citationkey,"/raw/XXXXXX.csv")))
dt_raw <- readxl::read_excel(here(paste0("inst/",citationkey,"/raw/flora paisaje protegido maigmó_sit_SERRA_2019.xlsx")))
```

    ## Warning: Expecting logical in E21060 / R21060C5: got 'Petrer'

    ## Warning: Expecting logical in F21060 / R21060C6: got 'Molí de la Reixa'

    ## Warning: Expecting logical in E21061 / R21061C5: got 'Petrer'

    ## Warning: Expecting logical in F21061 / R21061C6: got 'Molí de la Reixa'

    ## Warning: Expecting logical in E21062 / R21062C5: got 'Petrer'

    ## Warning: Expecting logical in F21062 / R21062C6: got 'El Pantanet'

    ## Warning: Expecting logical in E21063 / R21063C5: got 'Petrer'

    ## Warning: Expecting logical in F21063 / R21063C6: got 'Rambla de Xoli'

    ## Warning: Expecting logical in E21064 / R21064C5: got 'Petrer'

    ## Warning: Expecting logical in F21064 / R21064C6: got 'Moli de la Reixa'

    ## Warning: Expecting logical in E21065 / R21065C5: got 'Petrer'

    ## Warning: Expecting logical in F21065 / R21065C6: got 'Serra del Cid,
    ## Chaparrales'

    ## Warning: Expecting logical in E21066 / R21066C5: got 'Petrer'

    ## Warning: Expecting logical in F21066 / R21066C6: got 'els pins Donzells'

    ## Warning: Expecting logical in E21067 / R21067C5: got 'Petrer'

    ## Warning: Expecting logical in F21067 / R21067C6: got 'Rambla de Puça'

    ## Warning: Expecting logical in E21068 / R21068C5: got 'Petrer'

    ## Warning: Expecting logical in F21068 / R21068C6: got 'Arenal de l'Almorxó'

    ## Warning: Expecting logical in E21069 / R21069C5: got 'Petrer'

    ## Warning: Expecting logical in F21069 / R21069C6: got 'Molí de la Reixa'

    ## Warning: Expecting logical in E21070 / R21070C5: got 'Tibi'

    ## Warning: Expecting logical in F21070 / R21070C6: got 'Serra del Maigmó, Coll
    ## d'Eixau'

    ## Warning: Expecting logical in E21071 / R21071C5: got 'Petrer'

    ## Warning: Expecting logical in F21071 / R21071C6: got 'El Jaquetó'

    ## Warning: Expecting logical in E21072 / R21072C5: got 'Petrer'

    ## Warning: Expecting logical in F21072 / R21072C6: got 'El Jaquetó'

    ## Warning: Expecting logical in E21073 / R21073C5: got 'Castalla'

    ## Warning: Expecting logical in F21073 / R21073C6: got 'Serra del Frare, Alt del
    ## Frare'

    ## Warning: Expecting logical in E21074 / R21074C5: got 'Castalla'

    ## Warning: Expecting logical in F21074 / R21074C6: got 'Sierra maigmó, El
    ## Despeñador'

    ## Warning: Expecting logical in E21075 / R21075C5: got 'Castalla'

    ## Warning: Expecting logical in F21075 / R21075C6: got 'Serra del Frare, El
    ## Despenyador'

    ## Warning: Expecting logical in E21076 / R21076C5: got 'Tibi'

    ## Warning: Expecting logical in F21076 / R21076C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21077 / R21077C5: got 'Tibi'

    ## Warning: Expecting logical in F21077 / R21077C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21078 / R21078C5: got 'Castalla'

    ## Warning: Expecting logical in F21078 / R21078C6: got 'Serra del Frare,
    ## Despenyador'

    ## Warning: Expecting logical in E21079 / R21079C5: got 'Tibi'

    ## Warning: Expecting logical in F21079 / R21079C6: got 'Serra del Maigmó, Coll
    ## d'Exau'

    ## Warning: Expecting logical in E21080 / R21080C5: got 'Petrer'

    ## Warning: Expecting logical in F21080 / R21080C6: got 'Serra del Sit, la Cilla
    ## del Sit'

    ## Warning: Expecting logical in E21081 / R21081C5: got 'Castalla'

    ## Warning: Expecting logical in F21081 / R21081C6: got 'Serra de l'Arguenya, pr.
    ## la Replana'

    ## Warning: Expecting logical in E21082 / R21082C5: got 'Castalla'

    ## Warning: Expecting logical in F21082 / R21082C6: got 'Serra del Frare, El
    ## Despenyador'

    ## Warning: Expecting logical in E21083 / R21083C5: got 'Castalla'

    ## Warning: Expecting logical in F21083 / R21083C6: got 'Serra del Frare, El
    ## Despenyador'

    ## Warning: Expecting logical in E21084 / R21084C5: got 'Petrer'

    ## Warning: Expecting logical in F21084 / R21084C6: got 'Serra del Cid, Silla del
    ## Cid'

    ## Warning: Expecting logical in E21085 / R21085C5: got 'Petrer'

    ## Warning: Expecting logical in F21085 / R21085C6: got 'Barranc d'Escurina'

    ## Warning: Expecting logical in E21086 / R21086C5: got 'Castalla'

    ## Warning: Expecting logical in F21086 / R21086C6: got 'Serra del Frare, baix
    ## Penyes del Soldat'

    ## Warning: Expecting logical in E21087 / R21087C5: got 'Castalla'

    ## Warning: Expecting logical in F21087 / R21087C6: got 'Serra del Frare, Peña de
    ## Hilario'

    ## Warning: Expecting logical in E21088 / R21088C5: got 'Petrer'

    ## Warning: Expecting logical in F21088 / R21088C6: got 'Serra del Sit, la Cilla
    ## del Sit'

    ## Warning: Expecting logical in E21089 / R21089C5: got 'Petrer'

    ## Warning: Expecting logical in F21089 / R21089C6: got 'Serra del Sit, la Cilla
    ## del Sit'

    ## Warning: Expecting logical in E21090 / R21090C5: got 'Petrer'

    ## Warning: Expecting logical in F21090 / R21090C6: got 'Sierra del Cid, antenas
    ## TV'

    ## Warning: Expecting logical in E21091 / R21091C5: got 'Sax'

    ## Warning: Expecting logical in F21091 / R21091C6: got 'Sierra del Puntal, pr. la
    ## Casica Vieja'

    ## Warning: Expecting logical in E21092 / R21092C5: got 'Sax'

    ## Warning: Expecting logical in F21092 / R21092C6: got 'bco. del Rincón del Moro'

    ## Warning: Expecting logical in E21093 / R21093C5: got 'Tibi'

    ## Warning: Expecting logical in F21093 / R21093C6: got 'Serra del Maigmó, Coll
    ## d'Exau'

    ## Warning: Expecting logical in E21094 / R21094C5: got 'Petrer'

    ## Warning: Expecting logical in F21094 / R21094C6: got 'Serra del Maigmó, Lomas
    ## de Pusa'

    ## Warning: Expecting logical in E21095 / R21095C5: got 'Petrer'

    ## Warning: Expecting logical in F21095 / R21095C6: got 'Serra del Maigmó, Llomes
    ## de Pusa'

    ## Warning: Expecting logical in E21096 / R21096C5: got 'Tibi'

    ## Warning: Expecting logical in F21096 / R21096C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21097 / R21097C5: got 'Tibi'

    ## Warning: Expecting logical in F21097 / R21097C6: got 'Serra del Maigmó, pr. Alt
    ## de Guisop'

    ## Warning: Expecting logical in E21098 / R21098C5: got 'Petrer'

    ## Warning: Expecting logical in F21098 / R21098C6: got 'Cases de Caprala'

    ## Warning: Expecting logical in E21099 / R21099C5: got 'Agost'

    ## Warning: Expecting logical in F21099 / R21099C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21100 / R21100C5: got 'Petrer'

    ## Warning: Expecting logical in F21100 / R21100C6: got 'Camino de Madrid'

    ## Warning: Expecting logical in E21101 / R21101C5: got 'Sax'

    ## Warning: Expecting logical in F21101 / R21101C6: got 'Casa El Puntal'

    ## Warning: Expecting logical in E21102 / R21102C5: got 'Petrer'

    ## Warning: Expecting logical in F21102 / R21102C6: got 'pr. Molí de la Pólvora'

    ## Warning: Expecting logical in E21103 / R21103C5: got 'Petrer'

    ## Warning: Expecting logical in F21103 / R21103C6: got 'Molí del Salt'

    ## Warning: Expecting logical in E21104 / R21104C5: got 'Petrer'

    ## Warning: Expecting logical in F21104 / R21104C6: got 'Serra del Sit, Lloma
    ## Rasa'

    ## Warning: Expecting logical in E21105 / R21105C5: got 'Petrer'

    ## Warning: Expecting logical in F21105 / R21105C6: got 'Serra del Cavall'

    ## Warning: Expecting logical in E21106 / R21106C5: got 'Petrer'

    ## Warning: Expecting logical in F21106 / R21106C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21107 / R21107C5: got 'Petrer'

    ## Warning: Expecting logical in F21107 / R21107C6: got 'Serra del Sit'

    ## Warning: Expecting logical in E21108 / R21108C5: got 'Petrer'

    ## Warning: Expecting logical in F21108 / R21108C6: got 'L'Almorxó'

    ## Warning: Expecting logical in E21109 / R21109C5: got 'Castalla'

    ## Warning: Expecting logical in F21109 / R21109C6: got 'Serra de Castalla,pr.
    ## Coll de l'Arguenya'

    ## Warning: Expecting logical in E21110 / R21110C5: got 'Castalla'

    ## Warning: Expecting logical in F21110 / R21110C6: got 'Serra de Castalla, Les
    ## Fermoses'

    ## Warning: Expecting logical in E21111 / R21111C5: got 'Petrer'

    ## Warning: Expecting logical in F21111 / R21111C6: got 'Sierra del Cid'

    ## Warning: Expecting logical in E21112 / R21112C5: got 'Petrer'

    ## Warning: Expecting logical in F21112 / R21112C6: got 'pr. Molí de la Pólvora'

    ## Warning: Expecting logical in E21113 / R21113C5: got 'Tibi'

    ## Warning: Expecting logical in F21113 / R21113C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21114 / R21114C5: got 'Petrer'

    ## Warning: Expecting logical in F21114 / R21114C6: got 'pr. El Tros'

    ## Warning: Expecting logical in E21115 / R21115C5: got 'Tibi'

    ## Warning: Expecting logical in F21115 / R21115C6: got 'Serra del Maigmó, Alt de
    ## les Ximeneies'

    ## Warning: Expecting logical in E21116 / R21116C5: got 'Petrer'

    ## Warning: Expecting logical in F21116 / R21116C6: got 'Serra del Cavall, pr.
    ## casa del Pino'

    ## Warning: Expecting logical in E21117 / R21117C5: got 'Castalla'

    ## Warning: Expecting logical in F21117 / R21117C6: got 'pr. mas de Sant Rafael'

    ## Warning: Expecting logical in E21118 / R21118C5: got 'Castalla'

    ## Warning: Expecting logical in F21118 / R21118C6: got 'Serra del Maigmó, pr.
    ## Xorret de Catí'

    ## Warning: Expecting logical in E21119 / R21119C5: got 'Castalla'

    ## Warning: Expecting logical in F21119 / R21119C6: got 'Serra de l'Arguenya, pr.
    ## Carrión'

    ## Warning: Expecting logical in E21120 / R21120C5: got 'Tibi'

    ## Warning: Expecting logical in F21120 / R21120C6: got 'Serra del Maigmó, camí de
    ## les Planisses'

    ## Warning: Expecting logical in E21121 / R21121C5: got 'Petrer'

    ## Warning: Expecting logical in F21121 / R21121C6: got 'Serra del Maigmó, el
    ## Calafate, Sol. Matá'

    ## Warning: Expecting logical in E21122 / R21122C5: got 'Petrer'

    ## Warning: Expecting logical in F21122 / R21122C6: got 'Serra del Maigmó, pr.
    ## Catí'

    ## Warning: Expecting logical in E21123 / R21123C5: got 'Petrer'

    ## Warning: Expecting logical in F21123 / R21123C6: got 'Serra del Cavall'

    ## Warning: Expecting logical in E21124 / R21124C5: got 'Petrer'

    ## Warning: Expecting logical in F21124 / R21124C6: got 'Rambla de Puça, molí de
    ## la Reixa'

    ## Warning: Expecting logical in E21125 / R21125C5: got 'Petrer'

    ## Warning: Expecting logical in F21125 / R21125C6: got 'Serra del Cid, Racó del
    ## Xoli'

    ## Warning: Expecting logical in E21126 / R21126C5: got 'Castalla'

    ## Warning: Expecting logical in F21126 / R21126C6: got 'Puntal de Amorós'

    ## Warning: Expecting logical in E21127 / R21127C5: got 'Petrer'

    ## Warning: Expecting logical in F21127 / R21127C6: got 'pr. El Tros'

    ## Warning: Expecting logical in E21128 / R21128C5: got 'Castalla'

    ## Warning: Expecting logical in F21128 / R21128C6: got 'Serra del Maigmó,
    ## Planisses'

    ## Warning: Expecting logical in E21129 / R21129C5: got 'Castalla'

    ## Warning: Expecting logical in F21129 / R21129C6: got 'Serra del Maigmó, pr.
    ## Casa Planisses'

    ## Warning: Expecting logical in E21130 / R21130C5: got 'Castalla'

    ## Warning: Expecting logical in F21130 / R21130C6: got 'Serra de l'Arguenya, la
    ## Serratella'

    ## Warning: Expecting logical in E21131 / R21131C5: got 'Petrer'

    ## Warning: Expecting logical in F21131 / R21131C6: got 'Caprala, Ombria de
    ## Marcos'

    ## Warning: Expecting logical in E21132 / R21132C5: got 'Castalla'

    ## Warning: Expecting logical in F21132 / R21132C6: got 'Serra de l'Arguenya, font
    ## de la Carrasca'

    ## Warning: Expecting logical in E21133 / R21133C5: got 'Petrer'

    ## Warning: Expecting logical in F21133 / R21133C6: got 'Rincón Bello'

    ## Warning: Expecting logical in E21134 / R21134C5: got 'Petrer'

    ## Warning: Expecting logical in F21134 / R21134C6: got 'Rambla de Caprala'

    ## Warning: Expecting logical in E21135 / R21135C5: got 'Petrer'

    ## Warning: Expecting logical in F21135 / R21135C6: got 'Serra del Cid, Xaparrals'

    ## Warning: Expecting logical in E21136 / R21136C5: got 'Castalla'

    ## Warning: Expecting logical in F21136 / R21136C6: got 'Montes de Carrión'

    ## Warning: Expecting logical in E21137 / R21137C5: got 'Petrer'

    ## Warning: Expecting logical in F21137 / R21137C6: got 'Sierra del Cid'

    ## Warning: Expecting logical in E21138 / R21138C5: got 'Tibi'

    ## Warning: Expecting logical in F21138 / R21138C6: got 'Serra del Maigmó, Balcó
    ## d'Alacant'

    ## Warning: Expecting logical in E21139 / R21139C5: got 'Petrer'

    ## Warning: Expecting logical in F21139 / R21139C6: got 'Serra del Cid'

    ## Warning: Expecting logical in E21140 / R21140C5: got 'Petrer'

    ## Warning: Expecting logical in F21140 / R21140C6: got 'els pins Donzells'

    ## Warning: Expecting logical in E21141 / R21141C5: got 'Tibi'

    ## Warning: Expecting logical in F21141 / R21141C6: got 'Serra del Maigmó, pr. Alt
    ## de Guisop'

    ## Warning: Expecting logical in E21142 / R21142C5: got 'Petrer'

    ## Warning: Expecting logical in F21142 / R21142C6: got 'Serra del Maigmó, pr.
    ## Catí'

    ## Warning: Expecting logical in E21143 / R21143C5: got 'Petrer'

    ## Warning: Expecting logical in F21143 / R21143C6: got 'pr. Casa de Pusa'

    ## Warning: Expecting logical in E21144 / R21144C5: got 'Petrer'

    ## Warning: Expecting logical in F21144 / R21144C6: got 'El Ginebre'

    ## Warning: Expecting logical in E21145 / R21145C5: got 'Petrer'

    ## Warning: Expecting logical in F21145 / R21145C6: got 'El Calafate'

    ## Warning: Expecting logical in E21146 / R21146C5: got 'Petrer'

    ## Warning: Expecting logical in F21146 / R21146C6: got 'Serra del Cavall'

    ## Warning: Expecting logical in E21147 / R21147C5: got 'Castalla'

    ## Warning: Expecting logical in F21147 / R21147C6: got 'Serra de Castalla'

    ## Warning: Expecting logical in E21148 / R21148C5: got 'Petrer'

    ## Warning: Expecting logical in F21148 / R21148C6: got 'pr. Arenal de l'Almorxó'

    ## Warning: Expecting logical in E21149 / R21149C5: got 'Petrer'

    ## Warning: Expecting logical in F21149 / R21149C6: got 'L'Almorxó'

    ## Warning: Expecting logical in E21150 / R21150C5: got 'Petrer'

    ## Warning: Expecting logical in F21150 / R21150C6: got 'Ombria de l'Arenal de
    ## l'Almorxó'

    ## Warning: Expecting logical in E21151 / R21151C5: got 'Petrer'

    ## Warning: Expecting logical in F21151 / R21151C6: got 'Serra del Sit, Colada del
    ## Cid'

    ## Warning: Expecting logical in E21152 / R21152C5: got 'Petrer'

    ## Warning: Expecting logical in F21152 / R21152C6: got 'Serra del Cid, hacia
    ## Silla del Cid'

    ## Warning: Expecting logical in E21153 / R21153C5: got 'Petrer'

    ## Warning: Expecting logical in F21153 / R21153C6: got 'Serra del Cavall, pr.
    ## casa del Pino'

    ## Warning: Expecting logical in E21154 / R21154C5: got 'Tibi'

    ## Warning: Expecting logical in F21154 / R21154C6: got 'Serra del Maigmó,
    ## Torrossella'

    ## Warning: Expecting logical in E21155 / R21155C5: got 'Petrer'

    ## Warning: Expecting logical in F21155 / R21155C6: got 'Serra del Cavall'

    ## Warning: Expecting logical in E21156 / R21156C5: got 'Petrer'

    ## Warning: Expecting logical in F21156 / R21156C6: got 'L'Almadrava'

    ## Warning: Expecting logical in E21157 / R21157C5: got 'Tibi'

    ## Warning: Expecting logical in F21157 / R21157C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21158 / R21158C5: got 'Petrer'

    ## Warning: Expecting logical in F21158 / R21158C6: got 'El Calafate'

    ## Warning: Expecting logical in F21159 / R21159C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21160 / R21160C5: got 'Tibi'

    ## Warning: Expecting logical in F21160 / R21160C6: got 'Serra del Maigmó,
    ## Planisses'

    ## Warning: Expecting logical in E21161 / R21161C5: got 'Petrer'

    ## Warning: Expecting logical in F21161 / R21161C6: got 'Caprala'

    ## Warning: Expecting logical in E21162 / R21162C5: got 'Petrer'

    ## Warning: Expecting logical in F21162 / R21162C6: got 'Rambla de l'Almadrava'

    ## Warning: Expecting logical in E21163 / R21163C5: got 'Castalla'

    ## Warning: Expecting logical in F21163 / R21163C6: got 'Serra de l'Arguenya, la
    ## Algueqa'

    ## Warning: Expecting logical in E21164 / R21164C5: got 'Castalla'

    ## Warning: Expecting logical in F21164 / R21164C6: got 'pedania de la Serratella'

    ## Warning: Expecting logical in E21165 / R21165C5: got 'Petrer'

    ## Warning: Expecting logical in F21165 / R21165C6: got 'Lloma Badà'

    ## Warning: Expecting logical in E21166 / R21166C5: got 'Petrer'

    ## Warning: Expecting logical in F21166 / R21166C6: got 'Serra del Sit, Cova de la
    ## Figuera'

    ## Warning: Expecting logical in E21167 / R21167C5: got 'Castalla'

    ## Warning: Expecting logical in F21167 / R21167C6: got 'Tossal de Pellicer'

    ## Warning: Expecting logical in E21168 / R21168C5: got 'Petrer'

    ## Warning: Expecting logical in F21168 / R21168C6: got 'Sierra del Cid'

    ## Warning: Expecting logical in E21169 / R21169C5: got 'Petrer'

    ## Warning: Expecting logical in F21169 / R21169C6: got 'Les Salinetes'

    ## Warning: Expecting logical in E21170 / R21170C5: got 'Sax'

    ## Warning: Expecting logical in F21170 / R21170C6: got 'Serra de l'Arguenya, el
    ## Cantalar'

    ## Warning: Expecting logical in E21171 / R21171C5: got 'Petrer'

    ## Warning: Expecting logical in F21171 / R21171C6: got 'Racó del Xoli'

    ## Warning: Expecting logical in E21172 / R21172C5: got 'Petrer'

    ## Warning: Expecting logical in F21172 / R21172C6: got 'Serra del Maigmó, Llomes
    ## de Puça'

    ## Warning: Expecting logical in E21173 / R21173C5: got 'Petrer'

    ## Warning: Expecting logical in F21173 / R21173C6: got 'pr. Molí de la Pólvora'

    ## Warning: Expecting logical in E21174 / R21174C5: got 'Tibi'

    ## Warning: Expecting logical in F21174 / R21174C6: got 'Serra del Maigmó, pr. Alt
    ## de Guisop'

    ## Warning: Expecting logical in E21175 / R21175C5: got 'Petrer'

    ## Warning: Expecting logical in F21175 / R21175C6: got 'Serra del Maigmó, el
    ## Calafate, Sol. Matá'

    ## Warning: Expecting logical in E21176 / R21176C5: got 'Petrer'

    ## Warning: Expecting logical in F21176 / R21176C6: got 'pr. Molí de la Pólvora'

    ## Warning: Expecting logical in E21177 / R21177C5: got 'Petrer'

    ## Warning: Expecting logical in F21177 / R21177C6: got 'Caprala'

    ## Warning: Expecting logical in E21178 / R21178C5: got 'Petrer'

    ## Warning: Expecting logical in F21178 / R21178C6: got 'pr. Collado de Benisa'

    ## Warning: Expecting logical in E21179 / R21179C5: got 'Petrer'

    ## Warning: Expecting logical in F21179 / R21179C6: got 'crta. Petrer - Racó del
    ## Xoli'

    ## Warning: Expecting logical in E21180 / R21180C5: got 'Castalla'

    ## Warning: Expecting logical in F21180 / R21180C6: got 'pr. Carrión'

    ## Warning: Expecting logical in E21181 / R21181C5: got 'Castalla'

    ## Warning: Expecting logical in F21181 / R21181C6: got 'Serra del Maigmó,
    ## urbanització Catí'

    ## Warning: Expecting logical in E21182 / R21182C5: got 'Tibi'

    ## Warning: Expecting logical in F21182 / R21182C6: got 'Serra del Maigmó, bc.
    ## Corral Covatelles'

    ## Warning: Expecting logical in E21183 / R21183C5: got 'Sax'

    ## Warning: Expecting logical in F21183 / R21183C6: got 'Casa El Puntal'

    ## Warning: Expecting logical in E21184 / R21184C5: got 'Tibi'

    ## Warning: Expecting logical in F21184 / R21184C6: got 'Serra del Maigmó, Cantal
    ## del Pixador'

    ## Warning: Expecting logical in E21185 / R21185C5: got 'Petrer'

    ## Warning: Expecting logical in F21185 / R21185C6: got 'Lloma Badada'

    ## Warning: Expecting logical in E21186 / R21186C5: got 'Castalla'

    ## Warning: Expecting logical in F21186 / R21186C6: got 'Serra de castalla, la
    ## Caseta Leal'

    ## Warning: Expecting logical in E21187 / R21187C5: got 'Tibi'

    ## Warning: Expecting logical in F21187 / R21187C6: got 'Serra del Maigmó, camí de
    ## les Planisses'

    ## Warning: Expecting logical in E21188 / R21188C5: got 'Petrer'

    ## Warning: Expecting logical in F21188 / R21188C6: got 'pr. casa de Valero'

    ## Warning: Expecting logical in E21189 / R21189C5: got 'Petrer'

    ## Warning: Expecting logical in F21189 / R21189C6: got 'Serra del Maigmó, pr.
    ## Catí'

    ## Warning: Expecting logical in E21190 / R21190C5: got 'Petrer'

    ## Warning: Expecting logical in F21190 / R21190C6: got 'pr. Molí de la Pólvora'

    ## Warning: Expecting logical in E21191 / R21191C5: got 'Petrer'

    ## Warning: Expecting logical in F21191 / R21191C6: got 'Serra del Cid, Casa
    ## Forestal'

    ## Warning: Expecting logical in E21192 / R21192C5: got 'Petrer'

    ## Warning: Expecting logical in F21192 / R21192C6: got 'Catí, pr Residencia TVE'

    ## Warning: Expecting logical in E21193 / R21193C5: got 'Petrer'

    ## Warning: Expecting logical in F21193 / R21193C6: got 'Serra del Cid, Silla del
    ## Cid'

    ## Warning: Expecting logical in E21194 / R21194C5: got 'Petrer'

    ## Warning: Expecting logical in F21194 / R21194C6: got 'La Almadraba'

    ## Warning: Expecting logical in E21195 / R21195C5: got 'Petrer'

    ## Warning: Expecting logical in F21195 / R21195C6: got 'Caprala'

    ## Warning: Expecting logical in E21196 / R21196C5: got 'Petrer'

    ## Warning: Expecting logical in F21196 / R21196C6: got 'Rambla de Puça, Molí de
    ## la Reixa'

    ## Warning: Expecting logical in E21197 / R21197C5: got 'Petrer'

    ## Warning: Expecting logical in F21197 / R21197C6: got 'Rambla de Puça'

    ## Warning: Expecting logical in E21198 / R21198C5: got 'Petrer'

    ## Warning: Expecting logical in F21198 / R21198C6: got 'Molí del Salt'

    ## Warning: Expecting logical in E21199 / R21199C5: got 'Petrer'

    ## Warning: Expecting logical in F21199 / R21199C6: got 'Barranc del Xoli'

    ## Warning: Expecting logical in E21200 / R21200C5: got 'Petrer'

    ## Warning: Expecting logical in F21200 / R21200C6: got 'Rambla de Caprala'

    ## Warning: Expecting logical in E21201 / R21201C5: got 'Petrer'

    ## Warning: Expecting logical in F21201 / R21201C6: got 'pr. Arenal de l'Almorxó'

    ## Warning: Expecting logical in E21202 / R21202C5: got 'Castalla'

    ## Warning: Expecting logical in F21202 / R21202C6: got 'Puntal de Amorós'

    ## Warning: Expecting logical in E21203 / R21203C5: got 'Tibi'

    ## Warning: Expecting logical in F21203 / R21203C6: got 'Serra del Maigmó'

    ## Warning: Expecting logical in E21204 / R21204C5: got 'Petrer'

    ## Warning: Expecting logical in F21204 / R21204C6: got 'L'Almadrava'

    ## Warning: Expecting logical in E21205 / R21205C5: got 'Petrer'

    ## Warning: Expecting logical in F21205 / R21205C6: got 'pr. Serra del Palomaret'

    ## Warning: Expecting logical in E21206 / R21206C5: got 'Castalla'

    ## Warning: Expecting logical in F21206 / R21206C6: got 'Serra de l'Arguenya, La
    ## Serratella'

    ## Warning: Expecting logical in E21207 / R21207C5: got 'Petrer'

    ## Warning: Expecting logical in F21207 / R21207C6: got 'Lloma Badà'

    ## Warning: Expecting logical in E21208 / R21208C5: got 'Castalla'

    ## Warning: Expecting logical in F21208 / R21208C6: got 'Serra de l'Arguenya, La
    ## Serratella'

    ## Warning: Expecting logical in E21209 / R21209C5: got 'Castalla'

    ## Warning: Expecting logical in F21209 / R21209C6: got 'Serra de l'Arguenya, La
    ## Serratella'

    ## Warning: Expecting logical in E21210 / R21210C5: got 'Petrer'

    ## Warning: Expecting logical in F21210 / R21210C6: got 'Serra del Cavall, pr.
    ## casa del Pino'

    ## Warning: Expecting logical in E21211 / R21211C5: got 'Castalla'

    ## Warning: Expecting logical in F21211 / R21211C6: got 'Serra del Frare, el
    ## Portell de Catí'

    ## Warning: Expecting logical in E21212 / R21212C5: got 'Castalla'

    ## Warning: Expecting logical in F21212 / R21212C6: got 'Rambla de Puça'

    ## Warning: Expecting logical in E21213 / R21213C5: got 'Castalla'

    ## Warning: Expecting logical in F21213 / R21213C6: got 'Racó de Pallisser'

    ## Warning: Expecting logical in E21214 / R21214C5: got 'Castalla'

    ## Warning: Expecting logical in F21214 / R21214C6: got 'pr. Corral de la casa de
    ## Castalla'

    ## Warning: Expecting logical in E21215 / R21215C5: got 'Petrer'

    ## Warning: Expecting logical in F21215 / R21215C6: got 'Caprala'

    ## Warning: Expecting logical in E21216 / R21216C5: got 'Petrer'

    ## Warning: Expecting logical in F21216 / R21216C6: got 'Lloma Badada'

    ## Warning: Expecting logical in E21217 / R21217C5: got 'Petrer'

    ## Warning: Expecting logical in F21217 / R21217C6: got 'Caprala, Ombria de
    ## Marcos'

    ## Warning: Expecting logical in E21218 / R21218C5: got 'Castalla'

    ## Warning: Expecting logical in F21218 / R21218C6: got 'Serra del Maigmó, pr.
    ## casa Planisses'

    ## Warning: Expecting logical in E21219 / R21219C5: got 'Tibi'

    ## Warning: Expecting logical in F21219 / R21219C6: got 'Serra del Maigmó, pr.
    ## casa Planisses'

    ## Warning: Expecting logical in E21220 / R21220C5: got 'Petrer'

    ## Warning: Expecting logical in F21220 / R21220C6: got 'El Calafate'

    ## Warning: Expecting logical in E21221 / R21221C5: got 'Petrer'

    ## Warning: Expecting logical in F21221 / R21221C6: got 'El Catxuli'

    ## Warning: Expecting logical in E21222 / R21222C5: got 'Petrer'

    ## Warning: Expecting logical in F21222 / R21222C6: got 'Serra del Frare, solana'

    ## Warning: Expecting logical in E21223 / R21223C5: got 'Petrer'

    ## Warning: Expecting logical in F21223 / R21223C6: got 'pr. casa de Valero'

    ## Warning: Expecting logical in E21224 / R21224C5: got 'Castalla'

    ## Warning: Expecting logical in F21224 / R21224C6: got 'Serra de l'Arguenya, pr.
    ## mas de Torrià'

    ## Warning: Expecting logical in E21225 / R21225C5: got 'Petrer'

    ## Warning: Expecting logical in F21225 / R21225C6: got 'Casa dels Pins'

    ## Warning: Expecting logical in E21226 / R21226C5: got 'Petrer'

    ## Warning: Expecting logical in F21226 / R21226C6: got 'l'Almorxó'

    ## Warning: Expecting logical in E21227 / R21227C5: got 'Petrer'

    ## Warning: Expecting logical in F21227 / R21227C6: got 'Serra del Cid, Rincón
    ## Bello'

    ## Warning: Expecting logical in E21228 / R21228C5: got 'Castalla'

    ## Warning: Expecting logical in F21228 / R21228C6: got 'Serra del Maigmó, Caseta
    ## Leal'

    ## Warning: Expecting logical in E21229 / R21229C5: got 'Castalla'

    ## Warning: Expecting logical in F21229 / R21229C6: got 'Serra del Frare, El
    ## Despenyador'

    ## Warning: Expecting logical in E21230 / R21230C5: got 'Castalla'

    ## Warning: Expecting logical in F21230 / R21230C6: got 'pr. corral de la casa de
    ## Castalla'

    ## Warning: Expecting logical in E21231 / R21231C5: got 'Petrer'

    ## Warning: Expecting logical in F21231 / R21231C6: got 'El Calafate, l'Alaig'

    ## Warning: Expecting logical in E21232 / R21232C5: got 'Petrer'

    ## Warning: Expecting logical in F21232 / R21232C6: got 'El Calafate'

    ## Warning: Expecting logical in E21233 / R21233C5: got 'Petrer'

    ## Warning: Expecting logical in F21233 / R21233C6: got 'Serra del Cid, Xaparrals'

    ## Warning: Expecting logical in E21234 / R21234C5: got 'Petrer'

    ## Warning: Expecting logical in F21234 / R21234C6: got 'pr. Los Castellarets'

    ## Warning: Expecting logical in E21235 / R21235C5: got 'Castalla'

    ## Warning: Expecting logical in F21235 / R21235C6: got 'Serra del Frare, El
    ## Despenyador'

    ## Warning: Expecting logical in E21236 / R21236C5: got 'Petrer'

    ## Warning: Expecting logical in F21236 / R21236C6: got 'Serra del Cid, Silla del
    ## Cid'

    ## Warning: Expecting logical in E21237 / R21237C5: got 'Petrer'

    ## Warning: Expecting logical in F21237 / R21237C6: got 'Serra del Sit, Cova
    ## Perico'

    ## Warning: Expecting logical in E21238 / R21238C5: got 'Sax'

    ## Warning: Expecting logical in F21238 / R21238C6: got 'Casa de Puchera'

    ## Warning: Expecting logical in E21239 / R21239C5: got 'Castalla'

    ## Warning: Expecting logical in F21239 / R21239C6: got 'Serra de Castalla, Hoyo
    ## de Puça'

    ## Warning: Expecting logical in E21240 / R21240C5: got 'Petrer'

    ## Warning: Expecting logical in F21240 / R21240C6: got 'El Arenal'

    ## Warning: Expecting logical in E21241 / R21241C5: got 'Petrer'

    ## Warning: Expecting logical in F21241 / R21241C6: got 'Caprala'

    ## Warning: Expecting logical in E21242 / R21242C5: got 'Petrer'

    ## Warning: Expecting logical in F21242 / R21242C6: got 'El Pantanet'

    ## Warning: Expecting logical in E21243 / R21243C5: got 'Tibi'

    ## Warning: Expecting logical in F21243 / R21243C6: got 'Serra del Maigmó, Alt de
    ## les Ximeneies'

    ## Warning: Expecting logical in E21244 / R21244C5: got 'Petrer'

    ## Warning: Expecting logical in F21244 / R21244C6: got 'Caprala'

    ## Warning: Expecting logical in E21245 / R21245C5: got 'Petrer'

    ## Warning: Expecting logical in F21245 / R21245C6: got 'Caprala'

    ## Warning: Expecting logical in E21246 / R21246C5: got 'Castalla'

    ## Warning: Expecting logical in E21247 / R21247C5: got 'Petrer'

    ## Warning: Expecting logical in F21247 / R21247C6: got 'l'Avaiol'

    ## Warning: Expecting logical in E21248 / R21248C5: got 'Petrer'

    ## Warning: Expecting logical in F21248 / R21248C6: got 'Caprala'

    ## Warning: Expecting logical in E21249 / R21249C5: got 'Castalla'

    ## Warning: Expecting logical in F21249 / R21249C6: got 'Serra de l'Arguenya, pr.
    ## mas de Torrià'

    ## Warning: Expecting logical in E21250 / R21250C5: got 'Castalla'

    ## Warning: Expecting logical in F21250 / R21250C6: got 'El Arenal'

    ## Warning: Expecting logical in E21251 / R21251C5: got 'Petrer'

    ## Warning: Expecting logical in F21251 / R21251C6: got 'El Calafate, l'Alaig'

    ## Warning: Expecting logical in E21252 / R21252C5: got 'Petrer'

    ## Warning: Expecting logical in F21252 / R21252C6: got 'El Tros'

    ## Warning: Expecting logical in E21253 / R21253C5: got 'Petrer'

    ## Warning: Expecting logical in F21253 / R21253C6: got 'El Tros'

## Modify dataset

``` r
#modify variables
dt_modif <- dt_raw |> 
  rename(Taxon = ESPECIE,
         UTM1x1 = UTM1,
         UTM10x10 = UTM) |> 
  mutate(UTM1x1 = str_trim(UTM1x1)) |> 
  mutate(UTM10x10 = str_trim(UTM10x10)) |> 
  filter(substr(UTM1x1,1,3) == substr(UTM10x10,1,3)) |> 

  mutate(UTM1x1 = ifelse(is.na(UTM1x1) ,
                            UTM1x1, paste0("30S",UTM1x1))) |> 
  mutate(UTM10x10 = ifelse(is.na(UTM10x10) ,
                             UTM10x10, paste0("30S",UTM10x10))) |> 
  
  mutate(Taxon = gsub(" subsp. ", " ", Taxon)) |> 
  mutate(Taxon = str_trim(Taxon)) |> 
  
mutate(References = "Serra Laliga, L. 2019. La flora del Paisaje Protegido de las sierras del Maigmó y del Sit") |> 
  
  distinct(Taxon,
         UTM10x10, 
         UTM1x1, 
         References)
```

    ## rename: renamed 3 variables (Taxon, UTM10x10, UTM1x1)
    ## mutate: no changes
    ## mutate: no changes
    ## filter: removed 6 rows (<1%), 21,246 rows remaining
    ## mutate: changed 21,246 values (100%) of 'UTM1x1' (0 new NAs)
    ## mutate: changed 21,246 values (100%) of 'UTM10x10' (0 new NAs)
    ## mutate: changed 7,114 values (33%) of 'Taxon' (0 new NAs)
    ## mutate: no changes
    ## mutate: new variable 'References' (character) with one unique value and 0% NA
    ## distinct: removed 188 rows (1%), 21,058 rows remaining

## Prepare dataset

``` r
dt_modif$id <- 1:nrow(dt_modif)

# #check allowed values
# check_taxa(dt_modif)  #see incorrect taxa
# check_cells(dt_modif)  #see incorrect cells

dt_check_vals <- dt_modif |> 
clean_values()
```

    ## There are 154 non-valid taxa Erasing them.

    ## mutate: no changes
    ## All 10x10 cells are valid

``` r
# Create dataset to compile
dt_include<- dt_check_vals |> 
  distinct(Taxon,
           UTM10x10, 
           UTM1x1, 
           References,
           id)
```

    ## distinct: no rows removed

``` r
dt_save <- dt_modif |> 
  filter(!id %in% dt_include$id)
```

    ## filter: removed 18,339 rows (87%), 2,719 rows remaining

``` r
readr::write_csv(select(dt_include, -matches("id") ),
                 here(paste0("inst/",citationkey,"/data/", citationkey,".csv")))
```

    ## select: dropped one variable (id)

``` r
readr::write_csv(select(dt_save, -matches("id") ),
                 here(paste0("inst/",citationkey,"/data/", citationkey,"_notused.csv")))
```

    ## select: dropped one variable (id)

## Session info

``` r
sessioninfo::session_info()
```

    ## ─ Session info ───────────────────────────────────────────────────────────────
    ##  setting  value
    ##  version  R version 4.4.1 (2024-06-14 ucrt)
    ##  os       Windows 10 x64 (build 19045)
    ##  system   x86_64, mingw32
    ##  ui       RTerm
    ##  language (EN)
    ##  collate  Spanish_Spain.utf8
    ##  ctype    Spanish_Spain.utf8
    ##  tz       Europe/Madrid
    ##  date     2025-01-13
    ##  pandoc   2.18 @ C:/Program Files/RStudio/bin/quarto/bin/tools/ (via rmarkdown)
    ## 
    ## ─ Packages ───────────────────────────────────────────────────────────────────
    ##  package     * version date (UTC) lib source
    ##  bit           4.5.0   2024-09-20 [1] CRAN (R 4.4.1)
    ##  bit64         4.0.5   2020-08-30 [1] CRAN (R 4.4.1)
    ##  cellranger    1.1.0   2016-07-27 [1] CRAN (R 4.4.1)
    ##  cli           3.6.3   2024-06-21 [1] CRAN (R 4.4.1)
    ##  clisymbols    1.2.0   2017-05-21 [1] CRAN (R 4.4.1)
    ##  codetools     0.2-20  2024-03-31 [2] CRAN (R 4.4.1)
    ##  colorspace    2.1-1   2024-07-26 [1] CRAN (R 4.4.1)
    ##  crayon        1.5.3   2024-06-20 [1] CRAN (R 4.4.1)
    ##  data.table    1.16.0  2024-08-27 [1] CRAN (R 4.4.1)
    ##  digest        0.6.37  2024-08-19 [1] CRAN (R 4.4.1)
    ##  dplyr       * 1.1.4   2023-11-17 [1] CRAN (R 4.4.1)
    ##  evaluate      1.0.0   2024-09-17 [1] CRAN (R 4.4.1)
    ##  fansi         1.0.6   2023-12-08 [1] CRAN (R 4.4.1)
    ##  fastmap       1.2.0   2024-05-15 [1] CRAN (R 4.4.1)
    ##  forcats     * 1.0.0   2023-01-29 [1] CRAN (R 4.4.1)
    ##  generics      0.1.3   2022-07-05 [1] CRAN (R 4.4.1)
    ##  ggplot2     * 3.5.1   2024-04-23 [1] CRAN (R 4.4.1)
    ##  glue          1.7.0   2024-01-09 [1] CRAN (R 4.4.1)
    ##  gtable        0.3.5   2024-04-22 [1] CRAN (R 4.4.1)
    ##  here        * 1.0.1   2020-12-13 [1] CRAN (R 4.4.1)
    ##  hms           1.1.3   2023-03-21 [1] CRAN (R 4.4.1)
    ##  htmltools     0.5.8.1 2024-04-04 [1] CRAN (R 4.4.1)
    ##  httr          1.4.7   2023-08-15 [1] CRAN (R 4.4.1)
    ##  jsonlite      1.8.9   2024-09-20 [1] CRAN (R 4.4.1)
    ##  knitr         1.48    2024-07-07 [1] CRAN (R 4.4.1)
    ##  lazyeval      0.2.2   2019-03-15 [1] CRAN (R 4.4.1)
    ##  lifecycle     1.0.4   2023-11-07 [1] CRAN (R 4.4.1)
    ##  lubridate   * 1.9.3   2023-09-27 [1] CRAN (R 4.4.1)
    ##  magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.4.1)
    ##  munsell       0.5.1   2024-04-01 [1] CRAN (R 4.4.1)
    ##  oai           0.4.0   2022-11-10 [1] CRAN (R 4.4.1)
    ##  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.4.1)
    ##  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.4.1)
    ##  plyr          1.8.9   2023-10-02 [1] CRAN (R 4.4.1)
    ##  purrr       * 1.0.2   2023-08-10 [1] CRAN (R 4.4.1)
    ##  R6            2.5.1   2021-08-19 [1] CRAN (R 4.4.1)
    ##  Rcpp          1.0.13  2024-07-17 [1] CRAN (R 4.4.1)
    ##  readr       * 2.1.5   2024-01-10 [1] CRAN (R 4.4.1)
    ##  readxl        1.4.3   2023-07-06 [1] CRAN (R 4.4.1)
    ##  rgbif       * 3.8.0   2024-05-23 [1] CRAN (R 4.4.1)
    ##  rlang         1.1.4   2024-06-04 [1] CRAN (R 4.4.1)
    ##  rmarkdown     2.28    2024-08-17 [1] CRAN (R 4.4.1)
    ##  rprojroot     2.0.4   2023-11-05 [1] CRAN (R 4.4.1)
    ##  rstudioapi    0.16.0  2024-03-24 [1] CRAN (R 4.4.1)
    ##  scales        1.3.0   2023-11-28 [1] CRAN (R 4.4.1)
    ##  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.4.1)
    ##  stringi       1.8.4   2024-05-06 [1] CRAN (R 4.4.0)
    ##  stringr     * 1.5.1   2023-11-14 [1] CRAN (R 4.4.1)
    ##  terra       * 1.7-78  2024-05-22 [1] CRAN (R 4.4.1)
    ##  tibble      * 3.2.1   2023-03-20 [1] CRAN (R 4.4.1)
    ##  tidylog     * 1.1.0   2024-05-08 [1] CRAN (R 4.4.1)
    ##  tidyr       * 1.3.1   2024-01-24 [1] CRAN (R 4.4.1)
    ##  tidyselect    1.2.1   2024-03-11 [1] CRAN (R 4.4.1)
    ##  tidyverse   * 2.0.0   2023-02-22 [1] CRAN (R 4.4.1)
    ##  timechange    0.3.0   2024-01-18 [1] CRAN (R 4.4.1)
    ##  tzdb          0.4.0   2023-05-12 [1] CRAN (R 4.4.1)
    ##  utf8          1.2.4   2023-10-22 [1] CRAN (R 4.4.1)
    ##  vctrs         0.6.5   2023-12-01 [1] CRAN (R 4.4.1)
    ##  vroom         1.6.5   2023-12-05 [1] CRAN (R 4.4.1)
    ##  whisker       0.4.1   2022-12-05 [1] CRAN (R 4.4.1)
    ##  withr         3.0.1   2024-07-31 [1] CRAN (R 4.4.1)
    ##  xfun          0.47    2024-08-17 [1] CRAN (R 4.4.1)
    ##  xml2          1.3.6   2023-12-04 [1] CRAN (R 4.4.1)
    ##  yaml          2.3.10  2024-07-26 [1] CRAN (R 4.4.1)
    ## 
    ##  [1] C:/Users/media/AppData/Local/R/win-library/4.4
    ##  [2] C:/Program Files/R/R-4.4.1/library
    ## 
    ## ──────────────────────────────────────────────────────────────────────────────
