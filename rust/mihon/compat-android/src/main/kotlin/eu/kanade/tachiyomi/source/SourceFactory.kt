package eu.kanade.tachiyomi.source

/**
 * A factory for creating multiple sources from a single extension.
 */
interface SourceFactory {
    /**
     * Creates the list of sources.
     */
    fun createSources(): List<Source>
}
