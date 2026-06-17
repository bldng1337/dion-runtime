pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}

plugins {
    // Enable auto-provisioning of JVM toolchains (e.g. downloading a JDK 19
    // when only a newer one is installed locally).
    id("org.gradle.toolchains.foojay-resolver-convention") version "0.9.0"
}

rootProject.name = "mihon-compat"
