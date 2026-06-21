package eu.kanade.tachiyomi.animesource.model

/**
 * Model for a subtitle or audio track associated with a [Video].
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.Track` from the Aniyomi
 * extension API. Some video sources attach a list of tracks to a Video so the
 * player can pick a language/subtitle. We provide a minimal implementation so
 * extensions that construct Track instances keep linking.
 *
 * @param url URL of the track file.
 * @param lang Human-readable language label (e.g. "English").
 */
open class Track(
    val url: String,
    val lang: String,
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is Track) return false
        return url == other.url && lang == other.lang
    }

    override fun hashCode(): Int {
        var result = url.hashCode()
        result = 31 * result + lang.hashCode()
        return result
    }

    companion object
}
