package eu.kanade.tachiyomi.animesource.online

import eu.kanade.tachiyomi.animesource.AnimeCatalogueSource
import eu.kanade.tachiyomi.animesource.model.*
import eu.kanade.tachiyomi.network.GET
import eu.kanade.tachiyomi.network.NetworkHelper
import eu.kanade.tachiyomi.network.asObservableSuccess
import okhttp3.Headers
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import rx.Observable
import tachiyomi.core.common.util.lang.awaitSingle
import uy.kohesive.injekt.injectLazy
import java.net.URI
import java.net.URISyntaxException
import java.security.MessageDigest

/**
 * A simple implementation for anime sources from a website.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.online.AnimeHttpSource` from the
 * Aniyomi extension API. This is the base class that most Aniyomi anime
 * extensions extend; the request/parse hooks map 1:1 to the manga
 * [eu.kanade.tachiyomi.source.online.HttpSource] equivalents but operate on
 * [SAnime]/[SEpisode]/[Video] instead of SManga/SChapter/Page.
 */
@Suppress("unused", "MemberVisibilityCanBePrivate")
abstract class AnimeHttpSource : AnimeCatalogueSource {

    /**
     * Network helper for making HTTP requests.
     */
    protected val network: NetworkHelper by injectLazy()

    /**
     * Base url of the website without the trailing slash, e.g. "https://mysite.com".
     */
    abstract val baseUrl: String

    /**
     * Version id used to generate the source id. Increments when URLs become
     * incompatible.
     */
    open val versionId = 1

    override val id by lazy { generateId(name, lang, versionId) }

    val headers: Headers by lazy { headersBuilder().build() }

    open val client: OkHttpClient
        get() = network.client

    protected fun generateId(name: String, lang: String, versionId: Int): Long {
        val key = "${name.lowercase()}/$lang/$versionId"
        val bytes = MessageDigest.getInstance("MD5").digest(key.toByteArray())
        return (0..7).map { bytes[it].toLong() and 0xff shl 8 * (7 - it) }
            .reduce(Long::or) and Long.MAX_VALUE
    }

    protected open fun headersBuilder() = Headers.Builder().apply {
        add("User-Agent", DEFAULT_USER_AGENT)
    }

    override fun toString() = "$name (${lang.uppercase()})"

    // ========== Popular Anime ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getPopularAnime"))
    open fun fetchPopularAnime(page: Int): Observable<AnimesPage> {
        return client.newCall(popularAnimeRequest(page))
            .asObservableSuccess()
            .map { response -> popularAnimeParse(response) }
    }

    @Suppress("DEPRECATION")
    override suspend fun getPopularAnime(page: Int): AnimesPage {
        return fetchPopularAnime(page).awaitSingle()
    }

    protected abstract fun popularAnimeRequest(page: Int): Request

    protected abstract fun popularAnimeParse(response: Response): AnimesPage

    // ========== Search Anime ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getSearchAnime"))
    open fun fetchSearchAnime(
        page: Int,
        query: String,
        filters: AnimeFilterList,
    ): Observable<AnimesPage> {
        return Observable.defer {
            try {
                client.newCall(searchAnimeRequest(page, query, filters)).asObservableSuccess()
            } catch (e: NoClassDefFoundError) {
                throw RuntimeException(e)
            }
        }.map { response -> searchAnimeParse(response) }
    }

    @Suppress("DEPRECATION")
    override suspend fun getSearchAnime(
        page: Int,
        query: String,
        filters: AnimeFilterList,
    ): AnimesPage {
        return fetchSearchAnime(page, query, filters).awaitSingle()
    }

    protected abstract fun searchAnimeRequest(
        page: Int,
        query: String,
        filters: AnimeFilterList,
    ): Request

    protected abstract fun searchAnimeParse(response: Response): AnimesPage

    // ========== Latest Updates ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getLatestUpdates"))
    open fun fetchLatestUpdates(page: Int): Observable<AnimesPage> {
        return client.newCall(latestUpdatesRequest(page))
            .asObservableSuccess()
            .map { response -> latestUpdatesParse(response) }
    }

    @Suppress("DEPRECATION")
    override suspend fun getLatestUpdates(page: Int): AnimesPage {
        return fetchLatestUpdates(page).awaitSingle()
    }

    protected abstract fun latestUpdatesRequest(page: Int): Request

    protected abstract fun latestUpdatesParse(response: Response): AnimesPage

    // ========== Anime Details ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getAnimeDetails"))
    open fun fetchAnimeDetails(anime: SAnime): Observable<SAnime> {
        return client.newCall(animeDetailsRequest(anime))
            .asObservableSuccess()
            .map { response -> animeDetailsParse(response).apply { initialized = true } }
    }

    @Suppress("DEPRECATION")
    open suspend fun getAnimeDetails(anime: SAnime): SAnime {
        return fetchAnimeDetails(anime).awaitSingle()
    }

    open fun animeDetailsRequest(anime: SAnime): Request {
        return GET(baseUrl + anime.url, headers)
    }

    protected abstract fun animeDetailsParse(response: Response): SAnime

    // ========== Episode List ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getEpisodeList"))
    open fun fetchEpisodeList(anime: SAnime): Observable<List<SEpisode>> {
        return client.newCall(episodeListRequest(anime))
            .asObservableSuccess()
            .map { response -> episodeListParse(response) }
    }

    @Suppress("DEPRECATION")
    open suspend fun getEpisodeList(anime: SAnime): List<SEpisode> {
        return fetchEpisodeList(anime).awaitSingle()
    }

    protected open fun episodeListRequest(anime: SAnime): Request {
        return GET(baseUrl + anime.url, headers)
    }

    protected abstract fun episodeListParse(response: Response): List<SEpisode>

    // ========== Video List ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getVideoList"))
    open fun fetchVideoList(episode: SEpisode): Observable<List<Video>> {
        return client.newCall(videoListRequest(episode))
            .asObservableSuccess()
            .map { response -> videoListParse(response) }
    }

    @Suppress("DEPRECATION")
    open suspend fun getVideoList(episode: SEpisode): List<Video> {
        return fetchVideoList(episode).awaitSingle()
    }

    protected open fun videoListRequest(episode: SEpisode): Request {
        return GET(baseUrl + episode.url, headers)
    }

    protected abstract fun videoListParse(response: Response): List<Video>

    // ========== Video URL ==========

    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getVideoUrl"))
    open fun fetchVideoUrl(video: Video): Observable<String> {
        return client.newCall(videoUrlRequest(video))
            .asObservableSuccess()
            .map { response -> videoUrlParse(response) }
    }

    @Suppress("DEPRECATION")
    open suspend fun getVideoUrl(video: Video): String {
        return fetchVideoUrl(video).awaitSingle()
    }

    protected open fun videoUrlRequest(video: Video): Request {
        return GET(video.url, headers)
    }

    protected open fun videoUrlParse(response: Response): String {
        throw UnsupportedOperationException("Not implemented")
    }

    // ========== URL helpers ==========

    fun SEpisode.setUrlWithoutDomain(url: String) {
        this.url = getUrlWithoutDomain(url)
    }

    fun SAnime.setUrlWithoutDomain(url: String) {
        this.url = getUrlWithoutDomain(url)
    }

    private fun getUrlWithoutDomain(orig: String): String {
        return try {
            val uri = URI(orig.replace(" ", "%20"))
            var out = uri.path
            if (uri.query != null) {
                out += "?" + uri.query
            }
            if (uri.fragment != null) {
                out += "#" + uri.fragment
            }
            out
        } catch (e: URISyntaxException) {
            orig
        }
    }

    open fun getAnimeUrl(anime: SAnime): String {
        return animeDetailsRequest(anime).url.toString()
    }

    open fun getEpisodeUrl(episode: SEpisode): String {
        return videoListRequest(episode).url.toString()
    }

    open fun prepareNewEpisode(episode: SEpisode, anime: SAnime) {}

    override fun getFilterList(): AnimeFilterList = AnimeFilterList()

    companion object {
        const val DEFAULT_USER_AGENT =
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }
}
