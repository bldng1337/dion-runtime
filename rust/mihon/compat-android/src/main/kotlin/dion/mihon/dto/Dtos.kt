package dion.mihon.dto

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

// ========== Install Result ==========

@Serializable
data class InstallResult(
    val jarPath: String,
    val className: String,
    val metadata: ExtensionMetadata
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
            val httpSource = source as? HttpSource
            return SourceInfo(
                id = source.id,
                name = source.name,
                lang = source.lang,
                baseUrl = httpSource?.baseUrl,
                supportsLatest = catalogueSource?.supportsLatest ?: false,
                isConfigurable = source is ConfigurableSource
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

// ========== Filter DTOs ==========

@Serializable
data class FilterDto(
    val type: String,
    val name: String,
    val state: String = ""
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

fun Filter<*>.toDto(): FilterDto = FilterDto(
    type = this::class.simpleName ?: "Unknown",
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
    }
)
