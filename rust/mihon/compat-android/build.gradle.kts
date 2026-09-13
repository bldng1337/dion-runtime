plugins {
    id("com.android.library") version "8.7.3"
    kotlin("android") version "2.1.20"
    kotlin("plugin.serialization") version "2.1.20"
}

group = "dion.mihon"
version = "0.1.0"

repositories {
    mavenCentral()
    google()
    maven("https://jitpack.io")
}

android {
    namespace = "dion.mihon.android"
    compileSdk = 35

    defaultConfig {
        minSdk = 26
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

kotlin {
    jvmToolchain(25)
}

dependencies {
    // Kotlin
    implementation(kotlin("stdlib"))
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.11.0")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.11.0")

    // HTTP client (OkHttp - required by Mihon extensions).
    // 5.x stable line: current keiyoushi extensions reference OkHttp 5
    // compression classes (okhttp3.CompressionInterceptor, Gzip,
    // brotli.Brotli, zstd.Zstd) from the host classloader. The plain JVM jars
    // are used instead of the `okhttp` module's `okhttp-android` AAR variant,
    // whose AAR metadata demands compileSdk 37 (this module compiles against
    // 35); they run fine on ART.
    implementation("com.squareup.okhttp3:okhttp-jvm:5.5.0")
    // brotli/zstd's Gradle module metadata still depend on the `okhttp`
    // module (whose Android variant is rejected above); exclude it so only
    // okhttp-jvm is resolved.
    implementation("com.squareup.okhttp3:okhttp-brotli:5.5.0") {
        exclude(group = "com.squareup.okhttp3", module = "okhttp")
    }
    implementation("com.squareup.okhttp3:okhttp-zstd:5.5.0") {
        exclude(group = "com.squareup.okhttp3", module = "okhttp")
    }

    // HTML parsing (JSoup - required by most extensions)
    implementation("org.jsoup:jsoup:1.17.2")

    // RxJava (some extensions use it)
    implementation("io.reactivex:rxjava:1.3.8")

    // Injekt - dependency injection used by Mihon extensions
    implementation("com.github.mihonapp:injekt:91edab2317")

    // Logging
    implementation("org.slf4j:slf4j-api:2.0.12")
    implementation("io.github.oshai:kotlin-logging-jvm:6.0.3")
}
