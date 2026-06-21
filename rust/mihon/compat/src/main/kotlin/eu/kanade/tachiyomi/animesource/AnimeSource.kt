package eu.kanade.tachiyomi.animesource

import eu.kanade.tachiyomi.source.Source

/**
 * A basic interface for creating an anime source.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.AnimeSource` from the Aniyomi
 * extension API. Anime sources are still [Source]s (they share the id/name/lang
 * contract), but the catalogue/HTTP variants expose anime-specific methods.
 */
interface AnimeSource : Source
