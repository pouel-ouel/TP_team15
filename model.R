## Création du modèle
library(data.table)

variables <- readRDS("./data/variables.rds")
variables <- as.data.table(variables)

variables[, `:=`("log_budget" = log(budget),
                 "log_revenue" = log(revenue))]

# Comme toutes les indicatrices de la colonne "Autres_genres" sont à 0, on l'enlève

# --- IA : Claude a été utilisé pour proposer ce bloc ---
# Utilisation : générer le modèle et lister les coefficients
# Vérification : résultats vérifiés par l'équipe

exclusions <- c("log_revenue", "revenue", "budget", "title", "release_date",
                "original_language", "genres", "production_companies",
                "Autres_genres", "Autres_original_language")

predicteurs <- setdiff(names(variables), exclusions)
formule <- as.formula(paste("log_revenue ~",
                            paste0("`", predicteurs, "`", collapse = " + ")))
modele  <- lm(formule, data = variables)
summary(modele)

# --- Fin du bloc d'aide par l'IA ---
