library(data.table)

# Data de toutes variables en jeu
variables <- readRDS("./data/variables.rds")
variables <- as.data.table(variables)

# Transformation logarithmique des montants d'argent
variables[, `:=`("log_budget" = log(budget),
                 "log_revenue" = log(revenue))]

# --- IA : Claude a été utilisé pour proposer ce bloc ---
# Utilisation : générer le modèle et lister les coefficients
# Vérification : résultats vérifiés par l'équipe

# Comme toutes les indicatrices de la colonne "Autres_genres" sont à 0, on l'enlève

# Comme l'addition des indicatrices des colonnes de langues valent toujours 1,
# on peut exprimer "Autres_original_language" comme 1 - la somme
# des autres indicatrices, donc cette colonne n'ajoute aucune information,
# c'est pourquoi on l'enlève du modèle

exclusions <- c("log_revenue", "revenue", "budget", "title", "release_date",
                "original_language", "genres", "production_companies",
                "Autres_genres", "Autres_original_language")

# Garder seulement les variables nécessaires
predicteurs <- setdiff(names(variables), exclusions)

# Exprimer le modèle du logarithme du revenue en fonction des autres variables
formule <- as.formula(paste("log_revenue ~",
                            paste0("`", predicteurs, "`", collapse = " + ")))

# Informations importantes du modèle
model  <- lm(formule, data = variables)
summary(model)

# --- Fin du bloc d'aide par l'IA ---

## Regarder les 4 graphiques pour l'analyse et les commenter
# 1. Linéarité et homoscédasticité (résidus en fonction des valeurs prédites)
# 2. Normalité des résidus (quantiles normaux des résidus en fonction des valeurs prédites)
# 3. Homoscédasticité (racine carrés de la valeur absolue des résidus en fonction des valeurs prédites)
# 4. Résidus vs levier

# La théorie est principalement dans le cours 7

plot(model)
