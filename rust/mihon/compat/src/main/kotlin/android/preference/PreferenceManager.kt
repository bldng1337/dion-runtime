package android.preference

import android.content.Context

/**
 * PreferenceManager stub for Android compatibility.
 * Returns default shared preferences for a context.
 */
class PreferenceManager {
    companion object {
        @JvmStatic
        fun getDefaultSharedPreferences(context: Context) =
            context.getSharedPreferences(
                context.applicationInfo.packageName,
                Context.MODE_PRIVATE,
            )!!
    }
}
