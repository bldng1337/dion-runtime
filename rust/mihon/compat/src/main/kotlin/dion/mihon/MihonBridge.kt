package dion.mihon

import android.app.Application
import dion.mihon.android.CustomContext
import dion.mihon.android.FakeApplication
import dion.mihon.dto.*
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
        } catch (e: Exception) {
            logger.error(e) { "Failed to initialize MihonBridge" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            logger.error(e) { "Failed to install extension: $apkPath" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            logger.error(e) { "Failed to load extension: $jarPath" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            logger.error(e) { "Failed to unload extension: $jarPath" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            logger.error(e) { "Failed to unload source: $sourceId" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
                is CatalogueSource -> "manga"
                else -> "unknown"
            }
            json.encodeToString(SourceTypeResult(type))
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
                    val thumbnailHeaders = source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getPopularManga(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
                    val thumbnailHeaders = source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getLatestUpdates(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
                    val thumbnailHeaders = source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getSearchManga(page, query, filters).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
                    val thumbnailHeaders = source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getMangaDetails(manga).toDto(thumbnailHeaders)
                } else {
                    mangaDto
                }
            }
            json.encodeToString(result)
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
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
        } catch (e: Exception) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }
}
