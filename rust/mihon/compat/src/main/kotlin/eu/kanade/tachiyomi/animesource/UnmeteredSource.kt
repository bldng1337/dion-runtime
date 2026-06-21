package eu.kanade.tachiyomi.animesource

/**
 * Minimal stub for `eu.kanade.tachiyomi.animesource.UnmeteredSource`.
 *
 * In the Aniyomi app this is a marker interface implemented by anime sources
 * whose requests should not count against a user's metered-network budget
 * (e.g. self-hosted sources like Jellyfin, DebridIndex). Some anime extensions'
 * source classes implement it directly, so it must be present on the classpath
 * for those classes to load. It carries no methods.
 */
interface UnmeteredSource
