package eu.kanade.tachiyomi.animesource.model

/**
 * Model for anime in the source.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.SAnime` from the Aniyomi
 * extension API. Extensions reference this interface (and its Companion) to
 * construct and populate anime metadata, so it must be present at this exact
 * package path on the classpath.
 */
interface SAnime {
    var url: String
    var title: String
    var artist: String?
    var author: String?
    var description: String?
    var genre: String?
    var status: Int
    var thumbnail_url: String?
    var initialized: Boolean
    var update_strategy: AnimeUpdateStrategy

    companion object {
        const val UNKNOWN = 0
        const val ONGOING = 1
        const val COMPLETED = 2
        const val LICENSED = 3
        const val PUBLISHING_FINISHED = 4
        const val CANCELLED = 5
        const val ON_HIATUS = 6

        fun create(): SAnime = SAnimeImpl()
    }
}

class SAnimeImpl : SAnime {
    override var url: String = ""
    override var title: String = ""
    override var artist: String? = null
    override var author: String? = null
    override var description: String? = null
    override var genre: String? = null
    override var status: Int = SAnime.UNKNOWN
    override var thumbnail_url: String? = null
    override var initialized: Boolean = false
    override var update_strategy: AnimeUpdateStrategy = AnimeUpdateStrategy.ALWAYS_UPDATE
}
