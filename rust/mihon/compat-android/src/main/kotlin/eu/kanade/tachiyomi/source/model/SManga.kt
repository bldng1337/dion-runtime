package eu.kanade.tachiyomi.source.model

import kotlinx.serialization.json.JsonObject

/**
 * Model for manga in the source.
 *
 * Mirrors the tsundoku source-api `SManga` shape so novel (and manga/anime)
 * extensions compiled against it link and dispatch correctly. The `altTitles`
 * and `memo` fields carry default values for binary compatibility with older
 * extensions that predate them.
 */
@Suppress("PropertyName")
interface SManga {
    var url: String
    var title: String
    var artist: String?
    var author: String?
    var description: String?
    var genre: String?
    var status: Int
    var thumbnail_url: String?
    var initialized: Boolean
    var update_strategy: UpdateStrategy

    /**
     * Alternative titles for this manga/novel.
     * Extensions should set this when alt titles are available from the source.
     * Default implementation returns empty list for backward compatibility.
     */
    var altTitles: List<String>
        get() = emptyList()
        set(_) {}

    /**
     * Extra metadata associated with the manga. The JSON object is not visible
     * to users and intended for internal or source-specific purposes.
     */
    var memo: JsonObject

    fun getGenres(): List<String>? {
        if (genre.isNullOrBlank()) return null
        // Split on comma (with or without space), semicolon, or pipe - common genre separators
        return genre?.split(Regex("[,;|]+"))?.map { it.trim() }?.filterNot { it.isBlank() }?.distinct()
    }

    companion object {
        const val UNKNOWN = 0
        const val ONGOING = 1
        const val COMPLETED = 2
        const val LICENSED = 3
        const val PUBLISHING_FINISHED = 4
        const val CANCELLED = 5
        const val ON_HIATUS = 6

        fun create(): SManga = SMangaImpl()
    }
}

class SMangaImpl : SManga {
    override var url: String = ""
    override var title: String = ""
    override var artist: String? = null
    override var author: String? = null
    override var description: String? = null
    override var genre: String? = null
    override var status: Int = SManga.UNKNOWN
    override var thumbnail_url: String? = null
    override var initialized: Boolean = false
    override var update_strategy: UpdateStrategy = UpdateStrategy.ALWAYS_UPDATE
    override var altTitles: List<String> = emptyList()
    override var memo: JsonObject = JsonObject(emptyMap())
}
