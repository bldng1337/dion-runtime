package dion.mihon.dto

import eu.kanade.tachiyomi.animesource.AnimeCatalogueSource
import eu.kanade.tachiyomi.animesource.ConfigurableAnimeSource
import eu.kanade.tachiyomi.animesource.model.*
import eu.kanade.tachiyomi.animesource.online.AnimeHttpSource
import eu.kanade.tachiyomi.source.*
import eu.kanade.tachiyomi.source.model.*
import eu.kanade.tachiyomi.source.online.HttpSource
import kotlinx.serialization.Serializable

// ========== Result Types ==========

@Serializable
data class ErrorResult(
    val error: String,
    val stackTrace: String? = null
)

@Serializable
data class SuccessResult(
    val success: Boolean
)

@Serializable
data class SourceIdsResult(
    val sourceIds: List<Long>
)

@Serializable
data class SourceTypeResult(
    val type: String
)

@Serializable
data class ChapterListResult(
    val chapters: List<ChapterDto>
)

@Serializable
data class PageListResult(
    val pages: List<PageDto>
)

@Serializable
data class PageTextResult(
    val text: String
)

// ========== Install Result ==========

@Serializable
data class InstallResult(
    val jarPath: String,
    val className: String,
    val metadata: ExtensionMetadata,
    /**
     * Absolute path to the extracted extension icon file, or null if the APK
     * contained no extractable raster icon. The host builds a `file://` URL
     * from this path so its image loader can render the icon.
     */
    val iconPath: String? = null
)

@Serializable
data class ExtensionMetadata(
    val packageName: String,
    val versionName: String,
    val versionCode: Int,
    val label: String,
    val nsfw: Boolean,
    val libVersion: String = "1.0"
)

// ========== Source Info ==========

@Serializable
data class SourceInfo(
    val id: Long,
    val name: String,
    val lang: String,
    val baseUrl: String?,
    val supportsLatest: Boolean,
    val isConfigurable: Boolean
) {
    companion object {
        fun from(source: Source): SourceInfo {
            val catalogueSource = source as? CatalogueSource
            val animeCatalogueSource = source as? AnimeCatalogueSource
            val httpSource = source as? HttpSource
            val animeHttpSource = source as? AnimeHttpSource
            return SourceInfo(
                id = source.id,
                name = source.name,
                lang = source.lang,
                baseUrl = httpSource?.baseUrl ?: animeHttpSource?.baseUrl,
                supportsLatest = catalogueSource?.supportsLatest ?: animeCatalogueSource?.supportsLatest ?: false,
                isConfigurable = source is ConfigurableSource || source is ConfigurableAnimeSource
            )
        }
    }
}

// ========== Manga DTOs ==========

@Serializable
data class MangasPageDto(
    val mangas: List<MangaDto>,
    val hasNextPage: Boolean
)

@Serializable
data class MangaDto(
    val url: String,
    val title: String,
    val artist: String? = null,
    val author: String? = null,
    val description: String? = null,
    val genre: String? = null,
    val status: Int = 0,
    val thumbnailUrl: String? = null,
    val thumbnailHeaders: Map<String, String>? = null,
    val initialized: Boolean = false
)

@Serializable
data class ChapterDto(
    val url: String,
    val name: String,
    val dateUpload: Long = 0,
    val chapterNumber: Float = -1f,
    val scanlator: String? = null
)

@Serializable
data class PageDto(
    val index: Int,
    val url: String,
    val imageUrl: String? = null,
    val headers: Map<String, String>? = null
)

// ========== Anime DTOs ==========

@Serializable
data class VideoDto(
    val url: String,
    val quality: String? = null,
    val videoUrl: String? = null,
    val headers: Map<String, String>? = null,
    val subtitleTracks: List<SubtitleTrackDto>? = null
)

@Serializable
data class SubtitleTrackDto(
    val url: String,
    val lang: String
)

@Serializable
data class VideoListResult(
    val videos: List<VideoDto>
)

@Serializable
data class EpisodeListResult(
    val episodes: List<EpisodeDto>
)

@Serializable
data class EpisodeDto(
    val url: String,
    val name: String,
    val dateUpload: Long = 0,
    val episodeNumber: Float = -1f,
    val scanlator: String? = null
)

// ========== Filter DTOs ==========

@Serializable
data class FilterDto(
    val type: String,
    val name: String,
    val state: String = "",
    val values: List<String>? = null
)

// ========== Conversions ==========

fun MangasPage.toDto(thumbnailHeaders: Map<String, String>? = null): MangasPageDto = MangasPageDto(
    mangas = mangas.map { it.toDto(thumbnailHeaders) },
    hasNextPage = hasNextPage
)

fun SManga.toDto(thumbnailHeaders: Map<String, String>? = null): MangaDto = MangaDto(
    url = url,
    title = title,
    artist = artist,
    author = author,
    description = description,
    genre = genre,
    status = status,
    thumbnailUrl = thumbnail_url,
    thumbnailHeaders = thumbnailHeaders,
    initialized = initialized
)

fun MangaDto.toSManga(): SManga = SManga.create().apply {
    url = this@toSManga.url
    title = this@toSManga.title
    artist = this@toSManga.artist
    author = this@toSManga.author
    description = this@toSManga.description
    genre = this@toSManga.genre
    status = this@toSManga.status
    thumbnail_url = this@toSManga.thumbnailUrl
    initialized = this@toSManga.initialized
}

fun SChapter.toDto(): ChapterDto = ChapterDto(
    url = url,
    name = name,
    dateUpload = date_upload,
    chapterNumber = chapter_number,
    scanlator = scanlator
)

fun ChapterDto.toSChapter(): SChapter = SChapter.create().apply {
    url = this@toSChapter.url
    name = this@toSChapter.name
    date_upload = this@toSChapter.dateUpload
    chapter_number = this@toSChapter.chapterNumber
    scanlator = this@toSChapter.scanlator
}

fun Page.toDto(headers: Map<String, String>? = null): PageDto = PageDto(
    index = index,
    url = url,
    imageUrl = imageUrl,
    headers = headers
)

/**
 * Derive the wire type tag for a filter from its runtime type.
 *
 * This deliberately does NOT use `this::class.simpleName`: extensions subclass
 * the base filter types (e.g. `class GenreFilter : AnimeFilter.Select<String>`),
 * and release APKs are minified, so the simple name is the extension's
 * (frequently obfuscated) subclass name — never "Select"/"Text"/etc. The host
 * maps settings by these canonical tags, so a subclass name would surface the
 * filter as a plain text field instead of its real UI kind (e.g. a dropdown).
 */
fun Filter<*>.filterTypeTag(): String = when (this) {
    is Filter.Header -> "Header"
    is Filter.Separator -> "Separator"
    is Filter.Select<*> -> "Select"
    is Filter.Text -> "Text"
    is Filter.CheckBox -> "CheckBox"
    is Filter.TriState -> "TriState"
    is Filter.Sort -> "Sort"
    is Filter.Group<*> -> "Group"
    else -> "Unknown"
}

fun Filter<*>.toDto(): FilterDto = FilterDto(
    type = filterTypeTag(),
    name = name,
    state = when (this) {
        is Filter.Header -> ""
        is Filter.Separator -> ""
        is Filter.Select<*> -> state.toString()
        is Filter.Text -> state
        is Filter.CheckBox -> state.toString()
        is Filter.TriState -> state.toString()
        is Filter.Sort -> {
            val s = state
            if (s != null) "${s.index};${s.ascending}" else ""
        }

        is Filter.Group<*> -> ""
        else -> ""
    },
    values = when (this) {
        is Filter.Select<*> -> values.map { it.toString() }
        is Filter.Sort -> values.toList()
        else -> null
    }
)

/**
 * Serialize a filter into the flat DTO list the host consumes.
 *
 * [Filter.Group] filters (e.g. a "Genres" group of per-genre checkboxes) hold
 * their sub-filters in `state`, so they are flattened: every sub-filter is
 * emitted as its own top-level [FilterDto] and matched back by name in
 * `applyFilterStates`. Without flattening, grouped filters would be invisible
 * to the host's search settings.
 */
fun Filter<*>.flattenDtos(): List<FilterDto> = when (this) {
    is Filter.Group<*> -> state.filterIsInstance<Filter<*>>().flatMap { it.flattenDtos() }
    else -> listOf(toDto())
}

// ========== Anime Conversions ==========

fun AnimesPage.toDto(thumbnailHeaders: Map<String, String>? = null): MangasPageDto = MangasPageDto(
    mangas = animes.map { it.toDto(thumbnailHeaders) },
    hasNextPage = hasNextPage
)

fun SAnime.toDto(thumbnailHeaders: Map<String, String>? = null): MangaDto = MangaDto(
    url = url,
    title = title,
    artist = artist,
    author = author,
    description = description,
    genre = genre,
    status = status,
    thumbnailUrl = thumbnail_url,
    thumbnailHeaders = thumbnailHeaders,
    initialized = initialized
)

fun MangaDto.toSAnime(): SAnime = SAnime.create().apply {
    url = this@toSAnime.url
    title = this@toSAnime.title
    artist = this@toSAnime.artist
    author = this@toSAnime.author
    description = this@toSAnime.description
    genre = this@toSAnime.genre
    status = this@toSAnime.status
    thumbnail_url = this@toSAnime.thumbnailUrl
    initialized = this@toSAnime.initialized
}

fun SEpisode.toDto(): EpisodeDto = EpisodeDto(
    url = url,
    name = name,
    dateUpload = date_upload,
    episodeNumber = episode_number,
    scanlator = scanlator
)

fun EpisodeDto.toSEpisode(): SEpisode = SEpisode.create().apply {
    url = this@toSEpisode.url
    name = this@toSEpisode.name
    date_upload = this@toSEpisode.dateUpload
    episode_number = this@toSEpisode.episodeNumber
    scanlator = this@toSEpisode.scanlator
}

fun Video.toDto(): VideoDto = VideoDto(
    url = url,
    quality = quality,
    videoUrl = videoUrl,
    headers = headers?.toMultimap()?.mapValues { (_, values) -> values.lastOrNull().orEmpty() },
    subtitleTracks = subtitleTracks?.map { it.toDto() }
)

fun Track.toDto(): SubtitleTrackDto = SubtitleTrackDto(
    url = url,
    lang = lang
)

fun AnimeFilter<*>.filterTypeTag(): String = when (this) {
    is AnimeFilter.Header -> "Header"
    is AnimeFilter.Separator -> "Separator"
    is AnimeFilter.Select<*> -> "Select"
    is AnimeFilter.Text -> "Text"
    is AnimeFilter.CheckBox -> "CheckBox"
    is AnimeFilter.TriState -> "TriState"
    is AnimeFilter.Sort -> "Sort"
    is AnimeFilter.Group<*> -> "Group"
    else -> "Unknown"
}

fun AnimeFilter<*>.toDto(): FilterDto = FilterDto(
    type = filterTypeTag(),
    name = name,
    state = when (this) {
        is AnimeFilter.Header -> ""
        is AnimeFilter.Separator -> ""
        is AnimeFilter.Select<*> -> state.toString()
        is AnimeFilter.Text -> state
        is AnimeFilter.CheckBox -> state.toString()
        is AnimeFilter.TriState -> state.toString()
        is AnimeFilter.Sort -> {
            val s = state
            if (s != null) "${s.index};${s.ascending}" else ""
        }

        is AnimeFilter.Group<*> -> ""
        else -> ""
    },
    values = when (this) {
        is AnimeFilter.Select<*> -> values.map { it.toString() }
        is AnimeFilter.Sort -> values.toList()
        else -> null
    }
)

/**
 * Anime counterpart of [Filter.flattenDtos]: flattens [AnimeFilter.Group]
 * sub-filters into top-level DTOs so grouped filters are visible to the host.
 */
fun AnimeFilter<*>.flattenDtos(): List<FilterDto> = when (this) {
    is AnimeFilter.Group<*> -> state.filterIsInstance<AnimeFilter<*>>().flatMap { it.flattenDtos() }
    else -> listOf(toDto())
}
