categories_ind <- function(categories, films, seuil = 0) {

    films <- as.data.table(films)
    group_categories <- c()

    # --- IA : Claude a été utilisé pour proposer ce bloc ---
    # Utilisation : séparation des différentes catégories de genres
    # Vérification : résultats vérifiés par l'équipe

    unique_categories <- unique(unlist(strsplit(films[[categories]], ", ")))

    # --- Fin du bloc d'aide par l'IA ---

    # Garder les catégories qui dépassent le seuil du nombre de films
    # Regrouper les autres dans une catégorie à part

    for(i in seq_along(unique_categories)) {

        if(sum(unlist(strsplit(films[[categories]], ", "))
               %in% unique_categories[i]) >= seuil) {

            group_categories[i] <- unique_categories[i]
        }
    }

    # Enlever les NA qui se sont introduit dans le vecteur

    group_categories <- group_categories[!is.na(group_categories)]

    other_categories <- unique_categories[which(unique_categories %notin% group_categories)]

    # Créer les colonnes des indicatrices pour chaque modalité de catégorie

    for(i in seq_along(group_categories)) {

        films[, group_categories[i] :=
                  as.numeric(grepl(group_categories[i], films[[categories]]))]

    }

    films[, paste0("Autres_", categories) :=
              as.numeric(strsplit(films[[categories]], ", ") %in% other_categories)]


    # Retour d'un data table avec les caractéristiques principales
    # ainsi que les indicatrices de la catégorie en argument

    films

}
