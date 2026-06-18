package eu.kanade.tachiyomi

/**
 * Minimal stub for `eu.kanade.tachiyomi.AppInfo`.
 *
 * In the Tachiyomi/Mihon app this is a Kotlin `object` exposing the host app's
 * version metadata (name/code). A few extensions (e.g. cubari) read
 * [versionName] at source creation time — typically to build a user-agent or a
 * `X-App-Version` header — so the object must be present and resolvable on the
 * classpath. The desktop runtime reports generic values.
 */
object AppInfo {
    /**
     * The host application's version name (e.g. "1.0.0").
     *
     * Exposed as a `val` so its getter (`getVersionName()`) matches the instance
     * method that extensions call via `AppInfo.INSTANCE.getVersionName()`.
     */
    val versionName: String = "0.1.0"

    /**
     * The host application's version code as a string.
     *
     * Exposed as a `val` so its getter (`getVersionCode()`) matches the instance
     * method that extensions call via `AppInfo.INSTANCE.getVersionCode()`.
     */
    val versionCode: String = "1"
}
