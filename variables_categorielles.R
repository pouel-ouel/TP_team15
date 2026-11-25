## Traitement des données catégorielles
library(data.table)

source("./categories_ind.R")

films <- readRDS("./data/films.rds")

## Genres ---

data_genres <- categories_ind("genres", films, 50)

## Compagnie de production ---

data_prod <- categories_ind("production_companies", films, 100)

## Langue originale ---

data_langues <- categories_ind("original_language", films, 50)

# --- IA : Claude a été utilisé pour proposer ce bloc ---
# Utilisation : association des codes de langues en noms complets
# Vérification : résultats vérifiés par l'équipe

noms_langues <- c(en = "English", ko = "Korean", fr = "French", ja = "Japanese",
                  it = "Italian", es = "Spanish", hi = "Hindi", zh = "Chinese",
                  ru = "Russian")

anciens <- intersect(names(noms_langues), names(data_langues))
setnames(data_langues, anciens, noms_langues[anciens])

# --- Fin du bloc d'aide par l'IA ---

caracteristiques <- names(films)

variables <- merge.data.frame(data_genres,
                              data_prod,
                              by = caracteristiques)

variables <- merge.data.frame(variables,
                              data_langues,
                              by = caracteristiques)

saveRDS(variables, "./data/variables.rds")

