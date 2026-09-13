package eu.kanade.tachiyomi.source

import eu.kanade.tachiyomi.source.model.FilterList
import eu.kanade.tachiyomi.source.model.MangasPage
import eu.kanade.tachiyomi.source.model.Page
import eu.kanade.tachiyomi.source.model.RefreshContext
import eu.kanade.tachiyomi.source.model.SChapter
import eu.kanade.tachiyomi.source.model.SManga
import eu.kanade.tachiyomi.source.model.SMangaUpdate

/**
 * A source that has a catalogue of manga.
 */
interface CatalogueSource : Source {
    /**
     * Whether the source supports latest updates.
     */
    override val supportsLatest: Boolean

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

    /**
     * Get the updated details for a manga.
     */
    suspend fun getMangaDetails(manga: SManga): SManga

    /**
     * Get all the available chapters for a manga.
     */
    suspend fun getChapterList(manga: SManga): List<SChapter>

    /**
     * Get all the available chapters for a manga with a refresh context.
     *
     * Default implementation ignores the context and falls back to the plain
     * [getChapterList]. Novel sources compiled against the tsundoku source-api
     * override this 2-arg overload, so it must exist on the interface for their
     * override to dispatch correctly.
     */
    suspend fun getChapterList(manga: SManga, context: RefreshContext): List<SChapter> {
        return getChapterList(manga)
    }

    /**
     * Combined update of an entry and its chapter/episode list, matching the
     * upstream source-api. Newer keiyoushi template sources override this
     * instead of the deprecated per-call parse helpers, so hosts must route
     * detail/chapter refreshes through it.
     */
    suspend fun getMangaUpdate(
        manga: SManga,
        chapters: List<SChapter>,
        fetchDetails: Boolean,
        fetchChapters: Boolean,
    ): SMangaUpdate {
        val updatedManga = if (fetchDetails) getMangaDetails(manga) else null
        val updatedChapters = if (fetchChapters) getChapterList(manga) else null
        return SMangaUpdate(updatedManga ?: manga, updatedChapters ?: chapters)
    }

    /**
     * Get the list of pages a chapter has. Pages should be returned
     * in the expected order; the index is ignored.
     */
    suspend fun getPageList(chapter: SChapter): List<Page>
}
