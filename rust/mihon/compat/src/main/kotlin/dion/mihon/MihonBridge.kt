package dion.mihon

import android.app.Application
import android.content.Context
import dion.mihon.android.CustomContext
import dion.mihon.android.FakeApplication
import dion.mihon.dto.*
import eu.kanade.tachiyomi.animesource.AnimeCatalogueSource
import eu.kanade.tachiyomi.animesource.online.AnimeHttpSource
import eu.kanade.tachiyomi.network.NetworkHelper
import eu.kanade.tachiyomi.source.*
import eu.kanade.tachiyomi.source.model.*
import eu.kanade.tachiyomi.source.online.*
import io.github.oshai.kotlinlogging.KotlinLogging
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import uy.kohesive.injekt.Injekt
import uy.kohesive.injekt.api.addSingleton
import uy.kohesive.injekt.api.get
import java.io.File

/**
 * Bridge class providing JNI-callable static methods for Rust.
 * All methods accept/return JSON strings for simplicity.
 */
object MihonBridge {
    private val logger = KotlinLogging.logger {}

    private val json = Json {
        ignoreUnknownKeys = true
        encodeDefaults = true
        isLenient = true
    }

    private var extensionLoader: ExtensionLoader? = null
    private val sourceManager = SourceManager()

    /**
     * Format a bridge error message, prefixing the throwable's class name.
     *
     * Bridge methods are the JNI boundary: they `catch (e: Throwable)` so that
     * `Error` subtypes (NoSuchMethodError, NoClassDefFoundError, LinkageError,
     * ...) are captured and reported instead of escaping to the JNI layer as an
     * opaque "Java exception was thrown". Including the fully-qualified class
     * name in the message lets the Rust caller — and the integration test's
     * `tolerate_only_network_errors` — classify the failure, e.g. flag a
     * `NoSuchMethodError` as a compat bug rather than silently tolerating it.
     * (`e.message` alone almost never contains the exception's class name, so
     * without this prefix the code-error indicators in the test could never
     * match.)
     */
    private fun formatError(e: Throwable): String =
        e.javaClass.name + ": " + (e.message ?: "Unknown error")

    /**
     * Initialize the bridge with extensions directory
     * @param extensionsDir Directory for storing converted JARs
     */
    @JvmStatic
    fun initialize(extensionsDir: String): String {
        return try {
            logger.info { "Initializing MihonBridge with extensions dir: $extensionsDir" }

            val extDir = File(extensionsDir)
            extensionLoader = ExtensionLoader(extDir)

            // Initialize Injekt with an Application singleton
            // Extensions use Injekt.get<Application>() to get SharedPreferences
            initializeInjekt(extDir)

            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to initialize MihonBridge" }
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Initialize Injekt dependency injection with required singletons.
     *
     * Mihon extensions use Injekt.get<Application>() to access SharedPreferences.
     * We register a FakeApplication that wraps our CustomContext.
     */
    private fun initializeInjekt(extensionsDir: File) {
        logger.debug { "Initializing Injekt with FakeApplication" }

        // Create a CustomContext for the global application
        val dataDir = File(extensionsDir, "data")
        dataDir.mkdirs()
        val context = CustomContext.getOrCreate("dion.mihon.global", dataDir)

        // Create and register the FakeApplication
        val app = FakeApplication(context)
        Injekt.addSingleton<Application>(app)

        // Create and register NetworkHelper
        // Extensions use network.client for HTTP requests
        val networkHelper = NetworkHelper(context)
        Injekt.addSingleton(networkHelper)

        // Register Json instance for extensions that use Injekt.get<Json>()
        // Configuration matches the expected defaults from extensions-lib 16+
        val extensionJson = Json {
            ignoreUnknownKeys = true
            explicitNulls = false
        }
        Injekt.addSingleton(extensionJson)

        logger.info { "Injekt initialized with FakeApplication, NetworkHelper, and Json (dataDir: $dataDir)" }
    }

    private fun getLoader(): ExtensionLoader {
        return extensionLoader ?: throw IllegalStateException("MihonBridge not initialized. Call initialize() first.")
    }

    // ========== Extension Lifecycle ==========

    /**
     * Install extension: Convert APK to JAR
     * @param apkPath Path to the APK file
     * @return JSON: InstallResult { jarPath, className, metadata }
     */
    @JvmStatic
    fun installExtension(apkPath: String): String {
        return try {
            logger.info { "Installing extension from: $apkPath" }
            val result = getLoader().install(apkPath)
            json.encodeToString(result)
        } catch (e: Throwable) {
            logger.error(e) { "Failed to install extension: $apkPath" }
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Load extension from JAR file
     * @param jarPath Path to the JAR file
     * @param className Entry point class name
     * @return JSON: SourceIdsResult { sourceIds: List<Long> }
     */
    @JvmStatic
    fun loadExtension(jarPath: String, className: String): String {
        return try {
            logger.info { "Loading extension: $jarPath (class: $className)" }
            val sources = getLoader().load(jarPath, className)
            sources.forEach { sourceManager.register(it) }
            logger.info { "Loaded ${sources.size} source(s) with IDs: ${sources.map { it.id }}" }
            json.encodeToString(SourceIdsResult(sources.map { it.id }))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to load extension: $jarPath" }
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Unload extension JAR and remove all its sources
     * @param jarPath Path to the JAR file
     */
    @JvmStatic
    fun unloadExtension(jarPath: String): String {
        return try {
            logger.info { "Unloading extension: $jarPath" }
            getLoader().unload(jarPath)
            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to unload extension: $jarPath" }
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Unload a specific source
     * @param sourceId Source ID to unload
     */
    @JvmStatic
    fun unloadSource(sourceId: Long): String {
        return try {
            logger.debug { "Unloading source: $sourceId" }
            sourceManager.unregister(sourceId)
            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to unload source: $sourceId" }
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    // ========== Source Info ==========

    /**
     * Get source metadata
     * @return JSON: SourceInfo { id, name, lang, baseUrl, supportsLatest, isConfigurable }
     */
    @JvmStatic
    fun getSourceInfo(sourceId: Long): String {
        return try {
            val source = sourceManager.get(sourceId)
                ?: return json.encodeToString(ErrorResult("Source not found: $sourceId"))
            json.encodeToString(SourceInfo.from(source))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get source type (manga or anime)
     * @return JSON: "manga" | "anime" | "unknown"
     */
    @JvmStatic
    fun getSourceType(sourceId: Long): String {
        return try {
            val source = sourceManager.get(sourceId)
                ?: return json.encodeToString(ErrorResult("Source not found: $sourceId"))
            val type = when (source) {
                is AnimeCatalogueSource -> "anime"
                is CatalogueSource -> "manga"
                else -> "unknown"
            }
            json.encodeToString(SourceTypeResult(type))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get filter list for source
     * @return JSON: List<FilterDto>
     */
    @JvmStatic
    fun getFilterList(sourceId: Long): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val filters = source.getFilterList()
            json.encodeToString(filters.map { it.toDto() })
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get the configurable preferences for a source by invoking its
     * `setupPreferenceScreen` and reading back the registered preferences.
     *
     * Works for both manga ([ConfigurableSource]) and anime
     * ([ConfigurableAnimeSource]) sources; `setupPreferenceScreen` is located
     * reflectively. Returns an empty list for non-configurable sources.
     *
     * @return JSON: PreferenceListResult { preferences: [...] }
     */
    @JvmStatic
    fun getPreferenceList(sourceId: Long): String {
        return try {
            val source = sourceManager.get(sourceId)
                ?: throw IllegalArgumentException("Source not found: $sourceId")
            val context = Injekt.get<Application>()
            val prefs = buildPreferenceList(context, source)
            json.encodeToString(PreferenceListResult(prefs))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Apply preference values to the source's backing SharedPreferences so the
     * source observes them on its next operation.
     *
     * The concrete SharedPreferences file a source reads from is source
     * specific, but the overwhelming convention (Mihon's `HttpSource` and most
     * extensions) is `"source_$id"`, with the app package name as a fallback
     * (used by `PreferenceManager.getDefaultSharedPreferences`). We write to
     * both so the value lands wherever the source looks it up.
     *
     * @param prefsJson JSON: List<PreferenceDto> (only `key` and `value` are
     *                  read; everything else is ignored)
     */
    @JvmStatic
    fun applyPreferences(sourceId: Long, prefsJson: String): String {
        return try {
            val app = Injekt.get<Application>()
            val updates = json.decodeFromString<List<PreferenceDto>>(prefsJson)
            val targets = listOfNotNull(
                "source_$sourceId",
                app.packageName,
            ).toSet()

            for (name in targets) {
                val sp = app.getSharedPreferences(name, Context.MODE_PRIVATE)
                val editor = sp.edit()
                for (pref in updates) {
                    when (val v = pref.value) {
                        is PrefValue.Bool -> editor.putBoolean(pref.key, v.data)
                        is PrefValue.Str -> editor.putString(pref.key, v.data)
                        is PrefValue.Num -> editor.putFloat(pref.key, v.data)
                        is PrefValue.StrList ->
                            editor.putStringSet(pref.key, v.data.toMutableSet())
                    }
                }
                editor.apply()
            }
            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    // ========== Manga Source Methods ==========

    /**
     * Get popular manga list
     * @return JSON: MangasPageDto { mangas, hasNextPage }
     */
    @JvmStatic
    fun getPopular(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val result = runBlocking {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getPopularManga(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get latest manga updates
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun getLatest(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            if (!source.supportsLatest) {
                return json.encodeToString(ErrorResult("Source does not support latest"))
            }
            val result = runBlocking {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getLatestUpdates(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Search manga
     * @param filtersJson JSON-encoded filter state (empty string for defaults)
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun search(sourceId: Long, page: Int, query: String, filtersJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val filters = source.getFilterList()
            if (filtersJson.isNotEmpty()) {
                try {
                    val filterStates = json.decodeFromString<List<FilterDto>>(filtersJson)
                    applyFilterStates(filters, filterStates)
                } catch (e: Exception) {
                    logger.warn(e) { "Failed to parse filtersJson, using default filters" }
                }
            }
            val result = runBlocking {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getSearchManga(page, query, filters).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get manga details
     * @param mangaJson JSON: MangaDto (must have url field)
     * @return JSON: MangaDto (with all fields populated)
     */
    @JvmStatic
    fun getDetails(sourceId: Long, mangaJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val mangaDto = json.decodeFromString<MangaDto>(mangaJson)
            val manga = mangaDto.toSManga()
            val result = runBlocking {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getMangaDetails(manga).toDto(thumbnailHeaders)
                } else {
                    mangaDto
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get chapter list for manga
     * @param mangaJson JSON: MangaDto
     * @return JSON: List<ChapterDto>
     */
    @JvmStatic
    fun getChapterList(sourceId: Long, mangaJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val mangaDto = json.decodeFromString<MangaDto>(mangaJson)
            val manga = mangaDto.toSManga()
            val result = runBlocking {
                if (source is HttpSource) {
                    source.getChapterList(manga).map { it.toDto() }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(ChapterListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get page list for chapter
     * @param chapterJson JSON: ChapterDto
     * @return JSON: List<PageDto>
     */
    @JvmStatic
    fun getPageList(sourceId: Long, chapterJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val chapterDto = json.decodeFromString<ChapterDto>(chapterJson)
            val chapter = chapterDto.toSChapter()
            val result = runBlocking {
                if (source is HttpSource) {
                    source.getPageList(chapter).map { page ->
                        page.toDto(headers = source.imageRequestHeaders(page))
                    }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(PageListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    // ========== Anime Source Methods ==========

    /**
     * Get popular anime list
     * @return JSON: MangasPageDto { mangas, hasNextPage }
     */
    @JvmStatic
    fun getPopularAnime(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val result = runBlocking {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders = source.headers.toMultimap()
                        .mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getPopularAnime(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get latest anime updates
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun getLatestAnime(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            if (!source.supportsLatest) {
                return json.encodeToString(ErrorResult("Source does not support latest"))
            }
            val result = runBlocking {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders = source.headers.toMultimap()
                        .mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getLatestUpdates(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Search anime
     * @param filtersJson JSON-encoded filter state (empty string for defaults)
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun searchAnime(sourceId: Long, page: Int, query: String, filtersJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val filters = source.getFilterList()
            if (filtersJson.isNotEmpty()) {
                try {
                    val filterStates = json.decodeFromString<List<FilterDto>>(filtersJson)
                    applyAnimeFilterStates(filters, filterStates)
                } catch (e: Exception) {
                    logger.warn(e) { "Failed to parse filtersJson, using default filters" }
                }
            }
            val result = runBlocking {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders = source.headers.toMultimap()
                        .mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getSearchAnime(page, query, filters).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get anime details
     * @param animeJson JSON: MangaDto (must have url field)
     * @return JSON: MangaDto (with all fields populated)
     */
    @JvmStatic
    fun getAnimeDetails(sourceId: Long, animeJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val animeDto = json.decodeFromString<MangaDto>(animeJson)
            val anime = animeDto.toSAnime()
            val result = runBlocking {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders = source.headers.toMultimap()
                        .mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getAnimeDetails(anime).toDto(thumbnailHeaders)
                } else {
                    animeDto
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get episode list for anime
     * @param animeJson JSON: MangaDto
     * @return JSON: EpisodeListResult { episodes: [...] }
     */
    @JvmStatic
    fun getEpisodeList(sourceId: Long, animeJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val animeDto = json.decodeFromString<MangaDto>(animeJson)
            val anime = animeDto.toSAnime()
            val result = runBlocking {
                if (source is AnimeHttpSource) {
                    source.getEpisodeList(anime).map { it.toDto() }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(EpisodeListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }

    /**
     * Get video list for episode
     * @param episodeJson JSON: EpisodeDto
     * @return JSON: VideoListResult { videos: [...] }
     */
    @JvmStatic
    fun getVideoList(sourceId: Long, episodeJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val episodeDto = json.decodeFromString<EpisodeDto>(episodeJson)
            val episode = episodeDto.toSEpisode()
            val result = runBlocking {
                if (source is AnimeHttpSource) {
                    source.getVideoList(episode).map { it.toDto() }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(VideoListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(formatError(e), e.stackTraceToString()))
        }
    }
}
