package eu.kanade.tachiyomi.animesource

/**
 * A factory for creating multiple anime sources from a single extension.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.AnimeSourceFactory` from the
 * Aniyomi extension API. Anime extensions expose an `AnimeSourceFactory`
 * (rather than a manga [eu.kanade.tachiyomi.source.SourceFactory]) whose
 * `createSources()` returns one or more [AnimeSource]s.
 */
interface AnimeSourceFactory {
    /**
     * Creates the list of anime sources.
     */
    fun createSources(): List<AnimeSource>
}
