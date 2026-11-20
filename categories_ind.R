categories_ind <- function(categories, films) {

    films <- as.data.table(films)

    # --- IA : Claude a été utilisé pour proposer ce bloc ---
    # Utilisation : séparation des différentes catégories de genres
    # Vérification : résultats vérifiés par l'équipe

    unique_categories <- unique(unlist(strsplit(films[[categories]], ", ")))

    # --- Fin du bloc d'aide par l'IA ---

    for(i in seq_along(unique_categories)) {

        films[, unique_categories[i] := as.numeric(grepl(unique_categories[i], films[[categories]]))]

    }

    films

}
