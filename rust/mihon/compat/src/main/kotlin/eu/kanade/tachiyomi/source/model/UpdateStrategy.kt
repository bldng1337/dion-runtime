package eu.kanade.tachiyomi.source.model

/**
 * Update strategy for a manga.
 *
 * Mirrors `eu.kanade.tachiyomi.source.model.UpdateStrategy` from the Tachiyomi
 * extension API. Extensions reference this enum (e.g. set it on `SManga` during
 * `mangaDetailsParse`), so it must be present and resolvable on the classpath.
 *
 * The enum values match the modern Mihon API names: `ALWAYS_UPDATE` (renamed
 * from the legacy `ALWAYS`) and `ONLY_FETCH_ONCE`.
 */
enum class UpdateStrategy {
    /** Always update this manga when checking for library updates. */
    ALWAYS_UPDATE,

    /** Only fetch the chapter list once; never automatically refresh it. */
    ONLY_FETCH_ONCE,
}
