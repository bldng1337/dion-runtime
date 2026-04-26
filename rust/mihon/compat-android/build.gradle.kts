plugins {
    id("com.android.library") version "8.7.3"
    kotlin("android") version "1.9.24"
    kotlin("plugin.serialization") version "1.9.24"
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
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.8.1")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.3")

    // HTTP client (OkHttp - required by Mihon extensions)
    implementation("com.squareup.okhttp3:okhttp:5.0.0-alpha.14")

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
