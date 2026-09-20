# Consumer rules for apps embedding the Mihon extension adapter.
#
# Extensions are Kotlin/Java artifacts loaded at runtime through
# ChildFirstPathClassLoader, which resolves every class an extension
# references against the host APK (system -> extension dex -> app). R8 only
# sees statically-reachable host code, so anything extensions bind to by
# name must survive shrinking un-renamed. These rules travel with the
# plugin (consumerProguardFiles) so every consumer gets them without
# copying anything into its own proguard file.

# The native library (librdion_runtime.so) looks up and caches the
# `dion.mihon.AndroidMihonBridge` Kotlin object via JNI during
# System.loadLibrary. R8 cannot see JNI references.
-keep class dion.mihon.** { *; }

# Mihon/Aniyomi source-api stubs, implemented by extensions and resolved
# by their original fully-qualified names — a binary contract.
-keep class eu.kanade.tachiyomi.** { *; }

# Bridge helpers outside the eu.kanade namespace that kept source classes
# reference (RxExtensionsKt.awaitSingle) — some extensions call them too.
-keep class tachiyomi.core.common.** { *; }

# androidx.preference backs `setupPreferenceScreen` of ConfigurableSource
# extensions: they were compiled against the real library and bind to its
# classes by name at runtime, so it must survive shrinking un-renamed.
-keep class androidx.preference.** { *; }

# Rhino-backed QuickJs bridge. Extensions evaluate JS via
# app.cash.quickjs.QuickJs but no adapter code references it statically,
# so without a keep rule R8 strips it and those extensions die with
# NoClassDefFoundError on first use.
-keep class app.cash.quickjs.** { *; }

# === Dynamically-loaded extension dependencies ===
# Extension bytecode links against these libraries by their original
# names; keeping them wholesale prevents R8 from inlining facade classes
# away (e.g. kotlin.collections.CollectionsKt) or renaming the API.

# Kotlin standard library / coroutines / serialization (+ okio bridge).
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

# OkHttp + Okio: requests go through HttpSource/NetworkHelper, and
# extensions reference okhttp3/okio types directly (Request, Response,
# interceptors, Buffer, ...).
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# zstd-kmp (okhttp-zstd's dependency for `Content-Encoding: zstd`). Only
# JniZstdKt and JniZstdDecompressor are referenced statically (from
# okhttp3.zstd.Zstd); the rest of the package — e.g. ZstdCompressor — is
# bound from libzstd-kmp.so via JNI FindClass during JniZstdKt.<clinit>.
# R8 cannot see those references and strips the classes, and the pending
# ClassNotFoundException then aborts the process (SIGABRT) on the first
# zstd-compressed response. The library ships no consumer rules of its own.
-keep class com.squareup.zstd.** { *; }

# JSoup — the vast majority of manga extensions parse HTML with it.
-keep class org.jsoup.** { *; }

# RxJava 1.x — a number of older extensions build fetch pipelines with it.
-keep class rx.** { *; }

# Injekt is used reflectively by Mihon extensions.
-keep class uy.kohesive.injekt.** { *; }

# Logging facades referenced by extension code by name.
-keep class io.github.oshai.kotlinlogging.** { *; }
-keep class org.slf4j.** { *; }

# kotlinx.serialization serializers used by the dto classes: the bridge
# serializes results to JSON that native code parses.
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.**
-keepclassmembers class **$$serializer { *; }
-keepclasseswithmembers class * {
    kotlinx.serialization.KSerializer serializer(...);
}

# === Optional classes referenced by kept library code ===
# Keeping okhttp3.** wholesale turns every OkHttp class into an R8 root,
# including the internal platform integrations for optional TLS providers.
# Those provider classes are optional at runtime and absent from the
# compile classpath; R8 full mode treats the references as hard errors.
# This is the rule set from OkHttp's R8 documentation.
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# OkHttp's GraalVM native-image integration (okhttp3.internal.graal.*).
-dontwarn com.oracle.svm.core.annotate.**
-dontwarn org.graalvm.nativeimage.**
-dontwarn java.lang.Module

# kotlin-logging references the optional kotlinx-coroutines-slf4j module.
-dontwarn kotlinx.coroutines.slf4j.**

# Rhino (backing the QuickJs bridge) inspects bean properties through
# java.desktop's java.beans API, which does not exist on Android. The
# references sit behind reflective JSON-converter lambdas that extensions
# never hit through the bridge.
-dontwarn java.beans.**
