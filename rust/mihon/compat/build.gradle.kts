plugins {
    kotlin("jvm") version "1.9.24"
    kotlin("plugin.serialization") version "1.9.24"
    id("com.gradleup.shadow") version "9.0.0-beta12"
}

group = "dion.mihon"
version = "0.1.0"

repositories {
    mavenCentral()
    google()
    maven("https://jitpack.io")
}

dependencies {
    // Kotlin
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.24")
    implementation("org.jetbrains.kotlin:kotlin-reflect:1.9.24")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.8.1")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.3")
    
    // APK parsing
    implementation("net.dongliu:apk-parser:2.6.10")
    
    // DEX to JAR conversion (for loading Android extensions)
    implementation("de.femtopedia.dex2jar:dex-translator:2.4.34")
    implementation("de.femtopedia.dex2jar:dex-tools:2.4.34")
    
    // ASM for bytecode manipulation (required by dex2jar)
    implementation("org.ow2.asm:asm:9.7")
    
    // HTTP client (OkHttp - required by Mihon extensions)
    implementation("com.squareup.okhttp3:okhttp:5.0.0-alpha.14")
    implementation("com.squareup.okio:okio:3.9.0")
    
    // HTML parsing (JSoup - required by most extensions)
    implementation("org.jsoup:jsoup:1.17.2")
    
    // ICU for Android-compatible date parsing
    implementation("com.ibm.icu:icu4j:75.1")
    
    // RxJava (some extensions use it)
    implementation("io.reactivex:rxjava:1.3.8")
    
    // Injekt - dependency injection used by Mihon extensions
    implementation("com.github.mihonapp:injekt:91edab2317")
    
    // Android stubs - we provide our own minimal stubs
    // Note: robolectric's android-all has too many abstract methods
    // Instead, we'll create minimal stubs for what extensions actually need
    
    // Logging
    implementation("org.slf4j:slf4j-api:2.0.12")
    implementation("ch.qos.logback:logback-classic:1.5.3")
    implementation("io.github.oshai:kotlin-logging-jvm:6.0.3")
    
    // Preferences (for SharedPreferences implementation)
    implementation("com.russhwolf:multiplatform-settings-jvm:1.1.1")
    implementation("com.russhwolf:multiplatform-settings-serialization-jvm:1.1.1")
}

tasks.shadowJar {
    archiveBaseName.set("mihon-compat")
    archiveClassifier.set("")
    archiveVersion.set("")
    
    // Merge service files
    mergeServiceFiles()
}

// Integration test task
tasks.register<JavaExec>("integrationTest") {
    group = "verification"
    description = "Run integration test with test APK"
    
    classpath = sourceSets.main.get().runtimeClasspath
    mainClass.set("IntegrationTestKt")
    
    workingDir = projectDir
    
    // Ensure the JAR is built first
    dependsOn(tasks.classes)
}

tasks.build {
    dependsOn(tasks.shadowJar)
}

kotlin {
    jvmToolchain(19)
}
