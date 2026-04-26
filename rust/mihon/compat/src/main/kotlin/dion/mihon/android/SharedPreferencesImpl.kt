package dion.mihon.android

import android.content.SharedPreferences
import com.russhwolf.settings.ExperimentalSettingsApi
import com.russhwolf.settings.PropertiesSettings
import com.russhwolf.settings.Settings
import com.russhwolf.settings.serialization.decodeValue
import com.russhwolf.settings.serialization.decodeValueOrNull
import com.russhwolf.settings.serialization.encodeValue
import io.github.oshai.kotlinlogging.KotlinLogging
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.SetSerializer
import kotlinx.serialization.builtins.serializer
import java.io.File
import java.util.Properties
import kotlin.io.path.Path
import kotlin.io.path.createParentDirectories
import kotlin.io.path.deleteIfExists
import kotlin.io.path.exists
import kotlin.io.path.inputStream
import kotlin.io.path.outputStream

/**
 * A file-backed SharedPreferences implementation for desktop platforms.
 * Based on Suwayomi's JavaSharedPreferences implementation.
 */
@OptIn(ExperimentalSerializationApi::class, ExperimentalSettingsApi::class)
class SharedPreferencesImpl(
    private val settingsDir: File,
    key: String,
) : SharedPreferences {
    companion object {
        private val logger = KotlinLogging.logger {}
    }

    private val file = Path(
        settingsDir.absolutePath,
        "${SafePath.buildValidFilename(key)}.xml",
    )
    
    private val properties = Properties().also { properties ->
        try {
            if (file.exists()) {
                file.inputStream().use { properties.loadFromXML(it) }
            }
        } catch (e: Exception) {
            logger.error(e) { "Error loading settings from $key" }
        }
    }
    
    private val preferences = PropertiesSettings(
        properties,
        onModify = { props ->
            try {
                if (props.isEmpty) {
                    file.deleteIfExists()
                } else {
                    file.createParentDirectories()
                    file.outputStream().use {
                        props.storeToXML(it, null)
                    }
                }
            } catch (e: Exception) {
                logger.error(e) { "Error saving settings in $key" }
            }
        },
    )
    
    private val listeners = mutableMapOf<SharedPreferences.OnSharedPreferenceChangeListener, (String) -> Unit>()

    override fun getAll(): MutableMap<String, *> = 
        preferences.keys.associateWith { preferences.getStringOrNull(it) }.toMutableMap()

    override fun getString(key: String, defValue: String?): String? =
        if (defValue != null) {
            preferences.getString(key, defValue)
        } else {
            preferences.getStringOrNull(key)
        }

    override fun getStringSet(key: String, defValues: Set<String>?): Set<String>? {
        try {
            return if (defValues != null) {
                preferences.decodeValue(SetSerializer(String.serializer()), key, defValues)
            } else {
                preferences.decodeValueOrNull(SetSerializer(String.serializer()), key)
            }
        } catch (_: SerializationException) {
            throw ClassCastException("$key was not a StringSet")
        }
    }

    override fun getInt(key: String, defValue: Int): Int = 
        preferences.getInt(key, defValue)

    override fun getLong(key: String, defValue: Long): Long = 
        preferences.getLong(key, defValue)

    override fun getFloat(key: String, defValue: Float): Float = 
        preferences.getFloat(key, defValue)

    override fun getBoolean(key: String, defValue: Boolean): Boolean = 
        preferences.getBoolean(key, defValue)

    override fun contains(key: String): Boolean = key in preferences.keys

    override fun edit(): SharedPreferences.Editor = Editor(preferences) { key ->
        listeners.forEach { (_, listener) ->
            listener(key)
        }
    }

    class Editor(
        private val preferences: Settings,
        private val notify: (String) -> Unit,
    ) : SharedPreferences.Editor {
        private val actions = mutableListOf<Action>()

        private sealed class Action {
            data class Add(val key: String, val value: Any) : Action()
            data class Remove(val key: String) : Action()
            data object Clear : Action()
        }

        override fun putString(key: String, value: String?): SharedPreferences.Editor {
            actions += if (value != null) {
                Action.Add(key, value)
            } else {
                Action.Remove(key)
            }
            return this
        }

        override fun putStringSet(key: String, values: MutableSet<String>?): SharedPreferences.Editor {
            actions += if (values != null) {
                Action.Add(key, values)
            } else {
                Action.Remove(key)
            }
            return this
        }

        override fun putInt(key: String, value: Int): SharedPreferences.Editor {
            actions += Action.Add(key, value)
            return this
        }

        override fun putLong(key: String, value: Long): SharedPreferences.Editor {
            actions += Action.Add(key, value)
            return this
        }

        override fun putFloat(key: String, value: Float): SharedPreferences.Editor {
            actions += Action.Add(key, value)
            return this
        }

        override fun putBoolean(key: String, value: Boolean): SharedPreferences.Editor {
            actions += Action.Add(key, value)
            return this
        }

        override fun remove(key: String): SharedPreferences.Editor {
            actions += Action.Remove(key)
            return this
        }

        override fun clear(): SharedPreferences.Editor {
            actions.add(Action.Clear)
            return this
        }

        override fun commit(): Boolean {
            addToPreferences()
            return true
        }

        override fun apply() {
            addToPreferences()
        }

        @Suppress("UNCHECKED_CAST")
        private fun addToPreferences() {
            actions.forEach { action ->
                when (action) {
                    is Action.Add -> {
                        when (val value = action.value) {
                            is Set<*> -> preferences.encodeValue(
                                SetSerializer(String.serializer()), 
                                action.key, 
                                value as Set<String>
                            )
                            is String -> preferences.putString(action.key, value)
                            is Int -> preferences.putInt(action.key, value)
                            is Long -> preferences.putLong(action.key, value)
                            is Float -> preferences.putFloat(action.key, value)
                            is Double -> preferences.putDouble(action.key, value)
                            is Boolean -> preferences.putBoolean(action.key, value)
                        }
                        notify(action.key)
                    }
                    is Action.Remove -> {
                        preferences.remove(action.key)
                        // Set<String> are stored like:
                        // key.0 = value1
                        // key.1 = value2
                        // key.size = 2
                        preferences.keys.forEach { key ->
                            if (key.startsWith(action.key + ".")) {
                                preferences.remove(key)
                            }
                        }
                        notify(action.key)
                    }
                    Action.Clear -> {
                        preferences.clear()
                    }
                }
            }
        }
    }

    override fun registerOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener) {
        val javaListener: (String) -> Unit = {
            listener.onSharedPreferenceChanged(this, it)
        }
        listeners[listener] = javaListener
    }

    override fun unregisterOnSharedPreferenceChangeListener(listener: SharedPreferences.OnSharedPreferenceChangeListener) {
        listeners.remove(listener)
    }

    fun deleteAll(): Boolean {
        preferences.clear()
        return true
    }
}
