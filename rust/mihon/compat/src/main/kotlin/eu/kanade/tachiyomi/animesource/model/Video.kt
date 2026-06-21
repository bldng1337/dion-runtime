package eu.kanade.tachiyomi.animesource.model

import android.net.Uri
import okhttp3.Headers

/**
 * Model for a video stream of an anime episode.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.Video` from the Aniyomi
 * extension API. Aniyomi's Video class exposes multiple constructors; the
 * 6-arg form `(url, quality, videoUrl, headers, subtitleTracks, audioTracks)`
 * is the one most modern extractors call, so it must be present with exactly
 * that signature or extensions fail at link time with `NoSuchMethodError`.
 *
 * @param url Stream/page URL of the video.
 * @param quality Human-readable quality label (e.g. "1080p").
 * @param videoUrl Direct URL to the video stream. May be null if it still
 *     needs to be resolved (some extensions populate it lazily).
 * @param headers Optional HTTP headers to send when fetching the stream.
 * @param subtitleTracks Subtitle tracks attached to this video.
 * @param audioTracks Audio tracks attached to this video.
 */
open class Video(
    val url: String,
    val quality: String?,
    videoUrl: String?,
    val headers: Headers? = null,
    val subtitleTracks: List<Track>? = null,
    val audioTracks: List<Track>? = null,
) {
    /**
     * Convenience constructor used by many legacy extensions.
     */
    constructor(url: String, quality: String?, videoUrl: String?) : this(
        url,
        quality,
        videoUrl,
        null,
        null,
        null,
    )

    /**
     * Constructor for extensions compiled against newer Aniyomi `Video` that adds a
     * `videoUrlUri` parameter (position 4, before `headers`).
     *
     * Without this, such extensions fail at link time with `NoSuchMethodError` on
     * `Video.<init>(String, String, String, Uri, Headers, int, DefaultConstructorMarker)`.
     * Declaring `headers` with a default makes Kotlin emit exactly that synthetic
     * default-aware constructor signature, satisfying the bytecode call site.
     */
    constructor(
        url: String,
        quality: String?,
        videoUrl: String?,
        videoUrlUri: Uri?,
        headers: Headers? = null,
    ) : this(url, quality, videoUrl, headers, null, null) {
        this.videoUrlUri = videoUrlUri
    }

    /**
     * The resolved, directly playable video URL.
     *
     * In Aniyomi this is a `@Synchronized` mutable property. We mirror that
     * here so extensions that reassign it (e.g. during `videoListParse`)
     * continue to work.
     */
    @get:Synchronized
    @set:Synchronized
    var videoUrl: String? = videoUrl

    /**
     * Parsed [Uri] form of [videoUrl], as exposed by newer Aniyomi `Video`.
     * Populated by the `(url, quality, videoUrl, videoUrlUri, headers)` constructor;
     * `null` for legacy callers.
     */
    var videoUrlUri: Uri? = null

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is Video) return false
        return url == other.url &&
            quality == other.quality &&
            videoUrl == other.videoUrl &&
            headers == other.headers
    }

    override fun hashCode(): Int {
        var result = url.hashCode()
        result = 31 * result + (quality?.hashCode() ?: 0)
        result = 31 * result + (videoUrl?.hashCode() ?: 0)
        result = 31 * result + (headers?.hashCode() ?: 0)
        return result
    }

    override fun toString(): String {
        return "Video(url=$url, quality=$quality, videoUrl=$videoUrl)"
    }

    companion object
}
