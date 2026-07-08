package eu.kanade.tachiyomi.source.model

import kotlinx.serialization.json.JsonObject

/**
 * Model for a chapter of manga.
 *
 * Mirrors the tsundoku source-api `SChapter` shape so novel (and manga/anime)
 * extensions compiled against it link and dispatch correctly. The `locked`,
 * `read`, `last_page_read`, and `memo` fields are present for binary
 * compatibility; source implementations should not set `read`/`last_page_read`
 * (they are populated by the host only when delivering chapters to
 * `SourceTracker` callbacks, which the bridge never invokes).
 */
@Suppress("PropertyName")
interface SChapter {
    var url: String
    var name: String
    var date_upload: Long
    var chapter_number: Float
    var scanlator: String?

    /**
     * Whether the chapter is locked (e.g. behind a paywall on the source site).
     */
    var locked: Boolean

    /**
     * Local read state. Source implementations should NOT set this — it is
     * populated by the app only when delivering SChapter instances to
     * SourceTracker callbacks.
     */
    var read: Boolean
        get() = false
        set(_) {}

    /**
     * Local last-page-read position. Source implementations should NOT set
     * this — it is populated by the app only when delivering SChapter
     * instances to SourceTracker callbacks.
     */
    var last_page_read: Int
        get() = 0
        set(_) {}

    /**
     * Extra metadata associated with the chapter. The JSON object is not
     * visible to users and intended for internal or source-specific purposes.
     */
    var memo: JsonObject

    fun copyFrom(other: SChapter) {
        name = other.name
        url = other.url
        date_upload = other.date_upload
        chapter_number = other.chapter_number
        scanlator = other.scanlator
        locked = other.locked
        memo = other.memo
    }

    companion object {
        fun create(): SChapter = SChapterImpl()
    }
}

class SChapterImpl : SChapter {
    override var url: String = ""
    override var name: String = ""
    override var date_upload: Long = 0
    override var chapter_number: Float = -1f
    override var scanlator: String? = null
    override var locked: Boolean = false
    override var memo: JsonObject = JsonObject(emptyMap())
}
