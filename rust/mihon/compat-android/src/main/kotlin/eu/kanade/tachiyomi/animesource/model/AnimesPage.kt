package eu.kanade.tachiyomi.animesource.model

/**
 * Model for a page of anime results.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.AnimesPage` from the Aniyomi
 * extension API.
 */
data class AnimesPage(
    val animes: List<SAnime>,
    val hasNextPage: Boolean,
)
