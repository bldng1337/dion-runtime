package eu.kanade.tachiyomi.source

import eu.kanade.tachiyomi.source.model.Page

/**
 * A basic interface for creating a source.
 */
interface Source {
    /**
     * Id for the source. Must be unique.
     */
    val id: Long

    /**
     * Name of the source.
     */
    val name: String

    /**
     * Language of the source.
     */
    val lang: String
        get() = ""

    /**
     * Whether this source provides novel (text-based) content instead of manga
     * (image-based). Novel sources return text content via [fetchPageText].
     *
     * Defaulted (not abstract) so manga/anime extensions compiled against an
     * older source-api — where this property did not exist — don't crash with
     * AbstractMethodError. Novel sources override it to `true`.
     */
    val isNovelSource: Boolean
        get() = false

    /**
     * Fetches the text content for a novel page. Only meaningful when
     * [isNovelSource] is true; manga/anime sources never call this. A novel
     * chapter is a single [Page] whose text is returned here, so the one
     * content fetch happens in this method.
     *
     * The returned string may be HTML, Markdown, or plain text; the host
     * auto-detects the format at render time.
     */
    suspend fun fetchPageText(page: Page): String =
        throw UnsupportedOperationException("Not a novel source")
}
