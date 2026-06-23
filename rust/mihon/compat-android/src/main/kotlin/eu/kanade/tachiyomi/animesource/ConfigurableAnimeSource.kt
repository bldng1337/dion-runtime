package eu.kanade.tachiyomi.animesource

/**
 * A source that has configurable preferences.
 *
 * Mirrors the Aniyomi `ConfigurableAnimeSource` interface. On Android the
 * preference-screen setup is handled by the host app, so (like the manga
 * [eu.kanade.tachiyomi.source.ConfigurableSource]) this is a marker interface
 * only.
 */
interface ConfigurableAnimeSource : AnimeSource
