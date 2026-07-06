package eu.kanade.tachiyomi.source.model

/**
 * Context provided to a source when fetching chapter list for an existing manga.
 * Contains read-only information about the current state that sources can use
 * to optimize requests and avoid unnecessary network calls.
 *
 * Mirrors `eu.kanade.tachiyomi.source.model.RefreshContext` from the tsundoku
 * source-api so novel extensions compiled against it link and dispatch
 * correctly. The bridge always passes dummy values (mangaId=0, empty existing
 * chapters, lastFetchTime=0, forceRefresh=true) since the host drives discrete
 * browse/detail/source calls rather than delta refreshes.
 *
 * @since 1.6.0
 */
data class RefreshContext(
    /**
     * The internal ID of the manga being refreshed.
     */
    val mangaId: Long,

    /**
     * List of chapters that currently exist locally for this manga, ordered by sourceOrder.
     */
    val existingChapters: List<SChapter>,

    /**
     * Unix timestamp (milliseconds) of when this manga was last successfully refreshed.
     */
    val lastFetchTime: Long,

    /**
     * When true, the caller requests a full re-fetch regardless of cached state.
     * Extensions should skip any count-based short-circuit logic.
     */
    val forceRefresh: Boolean = false,
)
