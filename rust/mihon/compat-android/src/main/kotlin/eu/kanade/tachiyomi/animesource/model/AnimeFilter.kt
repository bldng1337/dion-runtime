package eu.kanade.tachiyomi.animesource.model

/**
 * Filter types for anime searching.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.AnimeFilter` from the Aniyomi
 * extension API. Anime sources define their search filters as subclasses of
 * these [AnimeFilter] variants; the extension API is structurally identical to
 * the manga `eu.kanade.tachiyomi.source.model.Filter` hierarchy but lives in a
 * separate package so anime sources can be type-checked against it
 * independently.
 */
sealed class AnimeFilter<T>(val name: String, var state: T) {
    open class Header(name: String) : AnimeFilter<Unit>(name, Unit)
    open class Separator(name: String = "") : AnimeFilter<Unit>(name, Unit)
    abstract class Select<V>(name: String, val values: Array<V>, state: Int = 0) : AnimeFilter<Int>(name, state)
    abstract class Text(name: String, state: String = "") : AnimeFilter<String>(name, state)
    abstract class CheckBox(name: String, state: Boolean = false) : AnimeFilter<Boolean>(name, state)
    abstract class TriState(name: String, state: Int = STATE_IGNORE) : AnimeFilter<Int>(name, state) {
        fun isIncluded(): Boolean = state == STATE_INCLUDE
        fun isExcluded(): Boolean = state == STATE_EXCLUDE
        fun isIgnored(): Boolean = state == STATE_IGNORE
        companion object {
            const val STATE_IGNORE = 0
            const val STATE_INCLUDE = 1
            const val STATE_EXCLUDE = 2
        }
    }
    abstract class Group<V>(name: String, state: List<V>) : AnimeFilter<List<V>>(name, state)
    abstract class Sort(name: String, val values: Array<String>, state: Selection? = null) :
        AnimeFilter<Sort.Selection?>(name, state) {
        data class Selection(val index: Int, val ascending: Boolean)
    }
}

/**
 * A list of anime filters.
 *
 * Mirrors `eu.kanade.tachiyomi.animesource.model.AnimeFilterList` from the
 * Aniyomi extension API. [AnimeCatalogueSource.getSearchAnime] accepts this
 * wrapper (not a bare List) so that filters can be matched by name.
 */
data class AnimeFilterList(val list: List<AnimeFilter<*>>) : List<AnimeFilter<*>> by list {

    constructor(vararg fs: AnimeFilter<*>) : this(if (fs.isNotEmpty()) fs.asList() else emptyList())

    override fun equals(other: Any?): Boolean {
        return false
    }

    override fun hashCode(): Int {
        return list.hashCode()
    }
}
