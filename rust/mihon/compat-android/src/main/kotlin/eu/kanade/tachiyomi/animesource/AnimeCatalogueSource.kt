package eu.kanade.tachiyomi.animesource

import eu.kanade.tachiyomi.animesource.model.AnimeFilterList
import eu.kanade.tachiyomi.animesource.model.AnimesPage

/**
 * A source that has a catalogue of anime.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.AnimeCatalogueSource` from the
 * Aniyomi extension API.
 */
interface AnimeCatalogueSource : AnimeSource {
    /**
     * Whether the source supports latest updates.
     */
    val supportsLatest: Boolean

    /**
     * Returns a page with a list of popular anime.
     */
    suspend fun getPopularAnime(page: Int): AnimesPage

    /**
     * Returns a page with a list of anime matching the given search query.
     */
    suspend fun getSearchAnime(page: Int, query: String, filters: AnimeFilterList): AnimesPage

    /**
     * Returns a page with a list of latest anime updates.
     */
    suspend fun getLatestUpdates(page: Int): AnimesPage

    /**
     * Returns the list of filters for the source.
     */
    fun getFilterList(): AnimeFilterList
}
