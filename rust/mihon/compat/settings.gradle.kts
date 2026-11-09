pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

plugins {
    // Enable auto-provisioning of JVM toolchains (e.g. downloading the JDK 21
    // build toolchain when only a newer JDK is installed locally). 1.0.0 is
    // required for Gradle 9; 0.x versions misbehave on it.
    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
}

rootProject.name = "mihon-compat"
