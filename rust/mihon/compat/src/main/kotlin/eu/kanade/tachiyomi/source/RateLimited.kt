package eu.kanade.tachiyomi.source

/**
 * A source that declares its own request-pacing requirements.
 *
 * Mirrors `eu.kanade.tachiyomi.source.RateLimited` from the tsundoku/mihon
 * source API. Purely informational for the host; desktop compat does not
 * enforce the pacing itself.
 */
interface RateLimited {
    /**
     * The minimum delay (in milliseconds) this source needs between requests.
     */
    val minimumDelayMillis: Long

    /**
     * The delay (in milliseconds) this source's author recommends between requests.
     */
    val recommendedDelayMillis: Long
        get() = minimumDelayMillis

    /**
     * How many requests this source can tolerate in a quick burst before
     * [recommendedDelayMillis] needs to be enforced.
     */
    val recommendedPermits: Int
        get() = 1
}
