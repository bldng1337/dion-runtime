package eu.kanade.tachiyomi.source.model

/**
 * Model for a page of manga results.
 */
data class MangasPage(
    val mangas: List<SManga>,
    val hasNextPage: Boolean
)
