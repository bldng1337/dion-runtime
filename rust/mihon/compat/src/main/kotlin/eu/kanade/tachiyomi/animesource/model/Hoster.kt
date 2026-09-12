package eu.kanade.tachiyomi.animesource.model

/**
 * A video hoster for an episode, used by the Anikku/yuzono extensions-lib 16
 * "hoster" API: a source returns the list of hosters for an episode and the
 * videos are then resolved per hoster.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.Hoster` from Anikku's
 * source-api. The serializable companion of the original is omitted — it only
 * matters for host<->app IPC, not for running the extension.
 */
open class Hoster(
    val hosterUrl: String = "",
    val hosterName: String = "",
    val videoList: List<Video>? = null,
    val internalData: String = "",
) {
    @Volatile
    var status: State = State.IDLE

    enum class State {
        IDLE,
        LOADING,
        READY,
        ERROR,
    }

    fun copy(
        hosterUrl: String = this.hosterUrl,
        hosterName: String = this.hosterName,
        videoList: List<Video>? = this.videoList,
        internalData: String = this.internalData,
    ): Hoster {
        return Hoster(hosterUrl, hosterName, videoList, internalData)
    }

    companion object {
        const val NO_HOSTER_LIST = "no_hoster_list"

        /**
         * Wraps a plain video list as a single pseudo-hoster, for sources that
         * resolve videos directly without a hoster indirection.
         */
        fun List<Video>.toHosterList(): List<Hoster> {
            return listOf(
                Hoster(
                    hosterUrl = "",
                    hosterName = NO_HOSTER_LIST,
                    videoList = this,
                ),
            )
        }
    }
}
