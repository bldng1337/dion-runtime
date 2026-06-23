package eu.kanade.tachiyomi.torrentutils.model

/**
 * Compat stub mirroring `eu.kanade.tachiyomi.torrentutils.model.TorrentFile`
 * from the Aniyomi extension library.
 *
 * Describes a single file inside a parsed `.torrent`. In Aniyomi these objects
 * are produced by libtorrent via [eu.kanade.tachiyomi.torrentutils.TorrentUtils];
 * this stub exists only so that torrent-based extensions can load and link.
 * Instances are never populated here (the stub parser returns no data), so the
 * defaults are empty/zero.
 *
 * @param indexFile Zero-based index of the file within the torrent.
 * @param path Relative path of the file inside the torrent.
 * @param size Size of the file in bytes.
 */
class TorrentFile(
    val indexFile: Int = 0,
    val path: String = "",
    val size: Long = 0L,
)
