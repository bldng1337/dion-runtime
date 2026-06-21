package eu.kanade.tachiyomi.animesource

import androidx.preference.PreferenceScreen

/**
 * A source that may be configured by the user via a preference screen.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.ConfigurableAnimeSource` from the
 * Aniyomi extension API.
 */
interface ConfigurableAnimeSource : AnimeSource {
    fun setupPreferenceScreen(screen: PreferenceScreen)
}
