package eu.kanade.tachiyomi.source

/**
 * Minimal stub for `eu.kanade.tachiyomi.source.UnmeteredSource`.
 *
 * In the Tachiyomi/Mihon app this is a marker interface implemented by sources
 * whose requests should not count against a user's metered-network budget (e.g.
 * self-hosted sources like Komga, LANraragi). Some extensions' source classes
 * implement it directly, so it must be present on the classpath for those
 * classes to load. It carries no methods.
 */
interface UnmeteredSource
