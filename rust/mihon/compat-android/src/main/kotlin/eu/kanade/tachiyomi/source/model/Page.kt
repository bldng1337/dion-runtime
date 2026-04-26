package eu.kanade.tachiyomi.source.model

import android.net.Uri
import eu.kanade.tachiyomi.network.ProgressListener
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference

/**
 * Model for a page of a manga chapter.
 * Matches the Mihon source-api Page class for extension compatibility.
 */
open class Page(
    val index: Int,
    val url: String = "",
    var imageUrl: String? = null,
    var uri: Uri? = null,
) : ProgressListener {

    val number: Int
        get() = index + 1

    private val _status = AtomicReference(State.QUEUE)
    var status: State
        get() = _status.get()
        set(value) {
            _status.set(value)
        }

    private val _progress = AtomicInteger(0)
    var progress: Int
        get() = _progress.get()
        set(value) {
            _progress.set(value)
        }

    override fun update(bytesRead: Long, contentLength: Long, done: Boolean) {
        progress = if (contentLength > 0) {
            (100 * bytesRead / contentLength).toInt()
        } else {
            -1
        }
    }

    enum class State {
        QUEUE,
        LOAD_PAGE,
        DOWNLOAD_IMAGE,
        READY,
        ERROR,
    }
}