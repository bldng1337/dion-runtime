package eu.kanade.tachiyomi.animesource.model

/**
 * Update strategy for an anime.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.AnimeUpdateStrategy`
 * from the Aniyomi extension API.
 *
 * NOTE: Aniyomi uses `ALWAYS_UPDATE` here, which differs from the manga
 * [eu.kanade.tachiyomi.source.model.UpdateStrategy.ALWAYS] constant. The
 * enum ordinal names must match exactly or extensions fail at link time
 * with `NoSuchFieldError`.
 */
enum class AnimeUpdateStrategy {
    ALWAYS_UPDATE,
    ONLY_FETCH_ONCE,
}
