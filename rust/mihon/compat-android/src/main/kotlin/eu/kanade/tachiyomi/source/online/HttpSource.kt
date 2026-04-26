package eu.kanade.tachiyomi.source.online

import eu.kanade.tachiyomi.network.GET
import eu.kanade.tachiyomi.network.NetworkHelper
import eu.kanade.tachiyomi.network.asObservableSuccess
import eu.kanade.tachiyomi.source.CatalogueSource
import eu.kanade.tachiyomi.source.model.*
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
 * A simple implementation for sources from a website.
 * This is the base class that most Mihon/Tachiyomi extensions extend.
 */
@Suppress("unused", "MemberVisibilityCanBePrivate")
abstract class HttpSource : CatalogueSource {

    /**
     * Network helper for making HTTP requests.
     * Extensions can access this to get the shared OkHttpClient with cookies.
     */
    protected val network: NetworkHelper by injectLazy()

    /**
     * Base url of the website without the trailing slash, like: http://mysite.com
     */
    abstract val baseUrl: String

    /**
     * Version id used to generate the source id. If the site completely changes and urls are
     * incompatible, you may increase this value and it'll be considered as a new source.
     */
    open val versionId = 1

    /**
     * ID of the source. By default it uses a generated id using the first 16 characters (64 bits)
     * of the MD5 of the string `"${name.lowercase()}/$lang/$versionId"`.
     */
    override val id by lazy { generateId(name, lang, versionId) }

    /**
     * Headers used for requests.
     */
    val headers: Headers by lazy { headersBuilder().build() }

    /**
     * Default network client for doing requests.
     * Uses the network helper's client by default.
     */
    open val client: OkHttpClient
        get() = network.client

    /**
     * Generates a unique ID for the source based on the provided name, lang and versionId.
     */
    protected fun generateId(name: String, lang: String, versionId: Int): Long {
        val key = "${name.lowercase()}/$lang/$versionId"
        val bytes = MessageDigest.getInstance("MD5").digest(key.toByteArray())
        return (0..7).map { bytes[it].toLong() and 0xff shl 8 * (7 - it) }
            .reduce(Long::or) and Long.MAX_VALUE
    }

    /**
     * Headers builder for requests. Implementations can override this method for custom headers.
     */
    protected open fun headersBuilder() = Headers.Builder().apply {
        add("User-Agent", DEFAULT_USER_AGENT)
    }

    /**
     * Visible name of the source.
     */
    override fun toString() = "$name (${lang.uppercase()})"

    // ========== Popular Manga ==========

    /**
     * Returns an observable containing a page with a list of manga.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getPopularManga"))
    open fun fetchPopularManga(page: Int): Observable<MangasPage> {
        return client.newCall(popularMangaRequest(page))
            .asObservableSuccess()
            .map { response ->
                popularMangaParse(response)
            }
    }

    /**
     * Suspend version of fetchPopularManga.
     * Uses fetchPopularManga().awaitSingle() to allow extensions to override fetchPopularManga.
     */
    @Suppress("DEPRECATION")
    override suspend fun getPopularManga(page: Int): MangasPage {
        return fetchPopularManga(page).awaitSingle()
    }

    /**
     * Returns the request for the popular manga given the page.
     */
    protected abstract fun popularMangaRequest(page: Int): Request

    /**
     * Parses the response from the site and returns a [MangasPage] object.
     */
    protected abstract fun popularMangaParse(response: Response): MangasPage

    // ========== Search Manga ==========

    /**
     * Returns an observable containing a page with a list of manga.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getSearchManga"))
    open fun fetchSearchManga(page: Int, query: String, filters: FilterList): Observable<MangasPage> {
        return Observable.defer {
            try {
                client.newCall(searchMangaRequest(page, query, filters)).asObservableSuccess()
            } catch (e: NoClassDefFoundError) {
                // RxJava doesn't handle Errors, which tends to happen during global searches
                // if an old extension using non-existent classes is still around
                throw RuntimeException(e)
            }
        }.map { response ->
            searchMangaParse(response)
        }
    }

    /**
     * Suspend version of fetchSearchManga.
     * Uses fetchSearchManga().awaitSingle() to allow extensions to override fetchSearchManga.
     */
    @Suppress("DEPRECATION")
    override suspend fun getSearchManga(page: Int, query: String, filters: FilterList): MangasPage {
        return fetchSearchManga(page, query, filters).awaitSingle()
    }

    /**
     * Returns the request for the search manga given the page.
     */
    protected abstract fun searchMangaRequest(page: Int, query: String, filters: FilterList): Request

    /**
     * Parses the response from the site and returns a [MangasPage] object.
     */
    protected abstract fun searchMangaParse(response: Response): MangasPage

    // ========== Latest Updates ==========

    /**
     * Returns an observable containing a page with a list of latest manga updates.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getLatestUpdates"))
    open fun fetchLatestUpdates(page: Int): Observable<MangasPage> {
        return client.newCall(latestUpdatesRequest(page))
            .asObservableSuccess()
            .map { response ->
                latestUpdatesParse(response)
            }
    }

    /**
     * Suspend version of fetchLatestUpdates.
     * Uses fetchLatestUpdates().awaitSingle() to allow extensions to override fetchLatestUpdates.
     */
    @Suppress("DEPRECATION")
    override suspend fun getLatestUpdates(page: Int): MangasPage {
        return fetchLatestUpdates(page).awaitSingle()
    }

    /**
     * Returns the request for latest manga given the page.
     */
    protected abstract fun latestUpdatesRequest(page: Int): Request

    /**
     * Parses the response from the site and returns a [MangasPage] object.
     */
    protected abstract fun latestUpdatesParse(response: Response): MangasPage

    // ========== Manga Details ==========

    /**
     * Returns an observable with the updated details for a manga.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getMangaDetails"))
    open fun fetchMangaDetails(manga: SManga): Observable<SManga> {
        return client.newCall(mangaDetailsRequest(manga))
            .asObservableSuccess()
            .map { response ->
                mangaDetailsParse(response).apply { initialized = true }
            }
    }

    /**
     * Suspend version: Get the updated details for a manga.
     * Uses fetchMangaDetails().awaitSingle() to allow extensions to override fetchMangaDetails.
     */
    @Suppress("DEPRECATION")
    suspend fun getMangaDetails(manga: SManga): SManga {
        return fetchMangaDetails(manga).awaitSingle()
    }

    /**
     * Returns the request for the details of a manga.
     */
    open fun mangaDetailsRequest(manga: SManga): Request {
        return GET(baseUrl + manga.url, headers)
    }

    /**
     * Parses the response from the site and returns the details of a manga.
     */
    protected abstract fun mangaDetailsParse(response: Response): SManga

    // ========== Chapter List ==========

    /**
     * Returns an observable with the list of chapters for a manga.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getChapterList"))
    open fun fetchChapterList(manga: SManga): Observable<List<SChapter>> {
        return client.newCall(chapterListRequest(manga))
            .asObservableSuccess()
            .map { response ->
                chapterListParse(response)
            }
    }

    /**
     * Suspend version: Get all the available chapters for a manga.
     * Uses fetchChapterList().awaitSingle() to allow extensions to override fetchChapterList.
     */
    @Suppress("DEPRECATION")
    suspend fun getChapterList(manga: SManga): List<SChapter> {
        return fetchChapterList(manga).awaitSingle()
    }

    /**
     * Returns the request for updating the chapter list.
     */
    protected open fun chapterListRequest(manga: SManga): Request {
        return GET(baseUrl + manga.url, headers)
    }

    /**
     * Parses the response from the site and returns a list of chapters.
     */
    protected abstract fun chapterListParse(response: Response): List<SChapter>

    // ========== Page List ==========

    /**
     * Returns an observable with the page list for a chapter.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getPageList"))
    open fun fetchPageList(chapter: SChapter): Observable<List<Page>> {
        return client.newCall(pageListRequest(chapter))
            .asObservableSuccess()
            .map { response ->
                pageListParse(response)
            }
    }

    /**
     * Suspend version: Get the list of pages a chapter has.
     * Uses fetchPageList().awaitSingle() to allow extensions to override fetchPageList.
     */
    @Suppress("DEPRECATION")
    suspend fun getPageList(chapter: SChapter): List<Page> {
        return fetchPageList(chapter).awaitSingle()
    }

    /**
     * Returns the request for getting the page list.
     */
    protected open fun pageListRequest(chapter: SChapter): Request {
        return GET(baseUrl + chapter.url, headers)
    }

    /**
     * Parses the response from the site and returns a list of pages.
     */
    protected abstract fun pageListParse(response: Response): List<Page>

    // ========== Image URL ==========

    /**
     * Returns an observable with the page containing the source url of the image.
     */
    @Deprecated("Use the non-RxJava API instead", replaceWith = ReplaceWith("getImageUrl"))
    open fun fetchImageUrl(page: Page): Observable<String> {
        return client.newCall(imageUrlRequest(page))
            .asObservableSuccess()
            .map { response ->
                imageUrlParse(response)
            }
    }

    /**
     * Suspend version: Get the image URL for a page.
     * Uses fetchImageUrl().awaitSingle() to allow extensions to override fetchImageUrl.
     */
    @Suppress("DEPRECATION")
    open suspend fun getImageUrl(page: Page): String {
        return fetchImageUrl(page).awaitSingle()
    }

    /**
     * Returns the request for getting the url to the source image.
     */
    protected open fun imageUrlRequest(page: Page): Request {
        return GET(page.url, headers)
    }

    /**
     * Parses the response from the site and returns the absolute url to the source image.
     */
    protected open fun imageUrlParse(response: Response): String {
        throw UnsupportedOperationException("Not implemented")
    }

    // ========== Image Request ==========

    /**
     * Returns the request for getting the source image.
     */
    protected open fun imageRequest(page: Page): Request {
        return GET(page.imageUrl!!, headers)
    }

    /**
     * Returns headers used for the page image request.
     * Uses [imageRequest] so extension overrides are respected.
     */
    fun imageRequestHeaders(page: Page): Map<String, String> {
        val imagePage = if (page.imageUrl.isNullOrBlank()) {
            val fallbackImageUrl = page.url
            if (fallbackImageUrl.isBlank()) {
                return emptyMap()
            }
            Page(
                index = page.index,
                url = page.url,
                imageUrl = fallbackImageUrl,
                uri = page.uri,
            )
        } else {
            page
        }

        val request = runCatching { imageRequest(imagePage) }
            .getOrElse { return headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() } }

        val requestHeaders = request.headers
        return requestHeaders.names().associateWith { name ->
            requestHeaders[name].orEmpty()
        }
    }

    /**
     * Returns the response of the source image.
     */
    open suspend fun getImage(page: Page): Response {
        return client.newCall(imageRequest(page)).execute()
    }

    // ========== URL Helpers ==========

    /**
     * Assigns the url of the chapter without the scheme and domain.
     */
    fun SChapter.setUrlWithoutDomain(url: String) {
        this.url = getUrlWithoutDomain(url)
    }

    /**
     * Assigns the url of the manga without the scheme and domain.
     */
    fun SManga.setUrlWithoutDomain(url: String) {
        this.url = getUrlWithoutDomain(url)
    }

    /**
     * Returns the url of the given string without the scheme and domain.
     */
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

    /**
     * Returns the url of the provided manga.
     */
    open fun getMangaUrl(manga: SManga): String {
        return mangaDetailsRequest(manga).url.toString()
    }

    /**
     * Returns the url of the provided chapter.
     */
    open fun getChapterUrl(chapter: SChapter): String {
        return pageListRequest(chapter).url.toString()
    }

    /**
     * Called before inserting a new chapter into database.
     */
    open fun prepareNewChapter(chapter: SChapter, manga: SManga) {}

    /**
     * Returns the list of filters for the source.
     */
    override fun getFilterList(): FilterList = FilterList()

    companion object {
        const val DEFAULT_USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }
}
