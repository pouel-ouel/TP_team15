## Traitement des données catégorielles
library(data.table)

source("./clean_data.R")
source("./categories_ind.R")

films <- read.csv("data/films.rds")

## Genres ---
data_genres <- categories_ind("genres", films)

## Compagnie de production ---
data_prod <- categories_ind("production_companies", films)

# Il y a 8 000 catégories différentes WTF
# Que faire avec les catégories qui ont une variable ou très peu? Les enlever?

## Langue originale ---
data_langue <- categories_ind("original_language", films)

## IA ---
install.packages("ISOcodes")
library(ISOcodes)

langues <- ISO_639_2[!is.na(ISO_639_2$Alpha_2), c("Alpha_2", "Name")]
names(langues) <- c("original_language", "langue_nom")

data_langue <- merge(data_langue, langues, by = "original_language", all.x = TRUE)

data_langue$langue_nom[data_langue$original_language == "cn"] <- "Cantonese"
data_langue$langue_nom <- sub(";.*", "", data_langue$langue_nom)
# ---

