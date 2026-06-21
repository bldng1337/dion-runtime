package eu.kanade.tachiyomi.animesource.model

/**
 * Model for an episode of an anime.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.SEpisode` from the Aniyomi
 * extension API. Extensions reference this interface (and its Companion) to
 * construct episode metadata, so it must be present at this exact package
 * path on the classpath.
 */
interface SEpisode {
    var url: String
    var name: String
    var date_upload: Long
    var episode_number: Float
    var scanlator: String?

    companion object {
        fun create(): SEpisode = SEpisodeImpl()
    }
}

class SEpisodeImpl : SEpisode {
    override var url: String = ""
    override var name: String = ""
    override var date_upload: Long = 0
    override var episode_number: Float = -1f
    override var scanlator: String? = null
}
