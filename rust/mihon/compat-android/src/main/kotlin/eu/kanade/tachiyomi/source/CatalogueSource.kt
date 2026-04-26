package eu.kanade.tachiyomi.source

import eu.kanade.tachiyomi.source.model.FilterList
import eu.kanade.tachiyomi.source.model.MangasPage
import eu.kanade.tachiyomi.source.model.SManga

/**
 * A source that has a catalogue of manga.
 */
interface CatalogueSource : Source {
    /**
     * Whether the source supports latest updates.
     */
    val supportsLatest: Boolean

    /**
     * Returns a page with a list of popular manga.
     */
    suspend fun getPopularManga(page: Int): MangasPage

    /**
     * Returns a page with a list of manga matching the given search query.
     */
    suspend fun getSearchManga(page: Int, query: String, filters: FilterList): MangasPage

    /**
     * Returns a page with a list of latest manga updates.
     */
    suspend fun getLatestUpdates(page: Int): MangasPage

    /**
     * Returns the list of filters for the source.
     */
    fun getFilterList(): FilterList
}
