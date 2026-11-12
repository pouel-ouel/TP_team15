data <- read.csv("C:/Users/xavie/Documents/universite/Session 3/Modeles lineaires/TMDB_movie_dataset_v11.csv")
library("dplyr")
library("tidyr")
## Filtrage des données du data set

data_clean <- data %>% filter(if_all(where(is.numeric), ~ . != 0))

## Vérification de la distribution du revenue et du budget
summary(data_clean$budget)
summary(data_clean$revenue)

## Il y a un revenue négatif, on enlève donc ceux avec un revenu négatif

data_clean1 <- data_clean %>% filter(revenue >= 0)

## Il y a beaucoup de films ayant un budget de 1$, qui est une donnée entrée
## lorsque le budget était inconnu, soit l'équivalent d'un 0

data_clean2 <- data_clean1 %>% filter(budget > 10)

## Il y a plusieurs films que le budget = revenue, ce qui est encore une fois
## une façon de marquer une donnée manquante

data_clean3 <- data_clean2 %>% filter(budget != revenue)

## Il y a des films ayant un revenue anormalement plus élevé que leur budget
## (d'ordre de 10 000 fois plus élevé), on les retire

data_clean4 <- data_clean3 %>% filter(revenue < budget * 1e5)

## On enlève les films ayant très peu de votes, ce qui nous empêcherais
## d'utiliser la variable de note moyenne
data_clean5 <- data_clean4 %>% filter(vote_count > 30)

## On enlèves les colonnes inutiles
data_clean5 <- select(data_clean5, -id, -status, -adult, -backdrop_path, 
                      -homepage, -imdb_id, -original_title, -overview, 
                      -poster_path, -tagline, -production_countries, 
                      -spoken_languages, -keywords)
## Nombre de films enlevés ou suspectés par étape de filtrage

#1 Retrait lors du nettoyage des zéros
nrow(data) - nrow(data_clean)
#2 Retrait du film ayant un revenu négatif
nrow(data_clean) - nrow(data_clean1)
#3 Retrait des films ayant un budget irréaliste (Inférieurs à 10)
nrow(data_clean1) - nrow(data_clean2)
#4 Retrait de films ayant des données de revenu et budget suspects
nrow(data_clean2) - nrow(data_clean3)
#5 Retrait de films ayant une donnée de revenue enregistrée de façon erronée
nrow(data_clean3) - nrow(data_clean4)
#6 Retrait de films ayant un nombre de vote trop faible
nrow(data_clean4) - nrow(data_clean5)


# Création du jeu de données à analyser 
film <- data_clean5

# Statistiques descriptives
summary(film)
summary(film)

# Corrélation des données (Commande inspiré de l'IA)

cor(log(film$budget), log(film$revenue))

## ANALYSE GRAPHIQUE

# Nuage de point de notre jeu de données (Voir la relation avec un modèle
# linéaire simple avec comme variable descriptive le budget)

plot(log(film$budget), log(film$revenue))
