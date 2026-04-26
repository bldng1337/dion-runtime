package com.flutter_rust_bridge.rdion_runtime

import android.content.ContentProvider
import android.content.ContentValues
import android.database.Cursor
import android.net.Uri

/**
 * A [ContentProvider] that pre-loads the `rdion_runtime` native library via
 * [System.loadLibrary] so that `JNI_OnLoad` is invoked by the JVM.
 *
 * This is required because the Rust native library uses `ndk_context` which
 * needs a `JavaVM*` pointer. That pointer is only populated when
 * `JNI_OnLoad` fires, which only happens when the library is loaded through
 * the JVM's `System.loadLibrary` — not when the Dart VM loads the `.so`
 * directly via `dlopen` (which is what `DynamicLibrary.open` does).
 *
 * Content providers are initialized by the Android framework during
 * [android.app.Application.attachBaseContext], which happens **before** any
 * Activity is created and **before** the Flutter engine starts. This guarantees
 * that `JNI_OnLoad` (and therefore `ndk_context` initialization) has completed
 * by the time Dart's FFI layer calls `DynamicLibrary.open`.
 */
class RdionRuntimePlugin : ContentProvider() {

    override fun onCreate(): Boolean {
        System.loadLibrary("rdion_runtime")
        return true
    }

    override fun query(
        uri: Uri,
        projection: Array<out String>?,
        selection: String?,
        selectionArgs: Array<out String>?,
        sortOrder: String?,
    ): Cursor? = null

    override fun getType(uri: Uri): String? = null

    override fun insert(uri: Uri, values: ContentValues?): Uri? = null

    override fun delete(uri: Uri, selection: String?, selectionArgs: Array<out String>?): Int = 0

    override fun update(
        uri: Uri,
        values: ContentValues?,
        selection: String?,
        selectionArgs: Array<out String>?,
    ): Int = 0
}