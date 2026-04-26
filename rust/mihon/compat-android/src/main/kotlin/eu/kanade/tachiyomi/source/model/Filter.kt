package eu.kanade.tachiyomi.source.model

/**
 * Filter types for manga searching.
 */
sealed class Filter<T>(val name: String, var state: T) {
    open class Header(name: String) : Filter<Unit>(name, Unit)
    open class Separator(name: String = "") : Filter<Unit>(name, Unit)
    abstract class Select<V>(name: String, val values: Array<V>, state: Int = 0) : Filter<Int>(name, state)
    abstract class Text(name: String, state: String = "") : Filter<String>(name, state)
    abstract class CheckBox(name: String, state: Boolean = false) : Filter<Boolean>(name, state)
    abstract class TriState(name: String, state: Int = STATE_IGNORE) : Filter<Int>(name, state) {
        companion object {
            const val STATE_IGNORE = 0
            const val STATE_INCLUDE = 1
            const val STATE_EXCLUDE = 2
        }
    }
    abstract class Group<V>(name: String, state: List<V>) : Filter<List<V>>(name, state)
    abstract class Sort(name: String, val values: Array<String>, state: Selection? = null) : Filter<Sort.Selection?>(name, state) {
        data class Selection(val index: Int, val ascending: Boolean)
    }
}

/**
 * A list of filters.
 * This is a data class that wraps a list of filters and delegates to it.
 */
data class FilterList(val list: List<Filter<*>>) : List<Filter<*>> by list {
    
    constructor(vararg fs: Filter<*>) : this(if (fs.isNotEmpty()) fs.asList() else emptyList())
    
    override fun equals(other: Any?): Boolean {
        return false
    }
    
    override fun hashCode(): Int {
        return list.hashCode()
    }
}
