package eu.kanade.tachiyomi.torrentutils

import eu.kanade.tachiyomi.torrentutils.model.TorrentInfo

/**
 * Compat stub mirroring `eu.kanade.tachiyomi.torrentutils.TorrentUtils` from
 * the Aniyomi extension library.
 *
 * In Aniyomi this object fetches a `.torrent` (from a URL or bytes) and parses
 * it via libtorrent to extract its [TorrentInfo] (info hash, trackers, files).
 * Torrent-based anime extensions (e.g. HentaiTorrent, NyaaTorrent, PTorrent)
 * call `getTorrentInfo` while building an episode's source list.
 *
 * The real implementation requires a BitTorrent client library, which is far
 * outside the scope of this compat layer. This stub makes the method linkable
 * so those extensions can load; it returns an empty [TorrentInfo] instead of
 * performing any network/parse work. Downstream, the extension produces no
 * playable video sources from torrents, which the integration test tolerates
 * (it does not require actual torrent downloading).
 *
 * The signature `getTorrentInfo(String, String)` matches the bytecode call
 * sites in the extensions (two `String` arguments — the torrent URL and an
 * additional request parameter such as a base URL or cookie header).
 */
object TorrentUtils {
    /**
     * Parse a torrent and return its metadata.
     *
     * @return an empty [TorrentInfo] (stub; real parsing is not implemented).
     */
    fun getTorrentInfo(url: String, arg: String): TorrentInfo = TorrentInfo()
}
