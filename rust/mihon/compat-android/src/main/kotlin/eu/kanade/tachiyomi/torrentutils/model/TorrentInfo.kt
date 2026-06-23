package eu.kanade.tachiyomi.torrentutils.model

/**
 * Compat stub mirroring `eu.kanade.tachiyomi.torrentutils.model.TorrentInfo`
 * from the Aniyomi extension library.
 *
 * Holds the parsed metadata of a `.torrent` (info hash, tracker list, and the
 * contained files). In Aniyomi instances are produced by
 * [eu.kanade.tachiyomi.torrentutils.TorrentUtils.getTorrentInfo]; this stub
 * exists only so torrent-based extensions can load and link. The stub parser
 * never populates real data, so the defaults are empty.
 *
 * @param hash Info-hash (SHA-1) of the torrent.
 * @param files Files contained in the torrent.
 * @param trackers Tracker announce URLs.
 */
class TorrentInfo(
    val hash: String = "",
    val files: List<TorrentFile> = emptyList(),
    val trackers: List<String> = emptyList(),
)
