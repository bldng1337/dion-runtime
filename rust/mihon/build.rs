//! Build script for mihon-adapter
//!
//! This script builds the mihon-compat.jar using Gradle and places it in OUT_DIR
//! for embedding into the binary via `include_bytes!`.
//!
//! A `cargo:rustc-cfg=mihon_compat_jar_available` flag is set when a real JAR
//! is successfully built. When Gradle is unavailable, a placeholder is written
//! instead, and the flag is NOT set.
//!
//! On Android targets, the compat JAR is not needed (native Android class loading
//! is used instead), so the Gradle build is skipped entirely.

use std::env;
use std::path::Path;
use std::process::Command;

fn main() {
    let out_dir = env::var("OUT_DIR").expect("OUT_DIR not set");
    let manifest_dir = env::var("CARGO_MANIFEST_DIR").expect("CARGO_MANIFEST_DIR not set");
    let target_os = env::var("CARGO_CFG_TARGET_OS").unwrap_or_default();

    let output_jar = Path::new(&out_dir).join("mihon-compat.jar");

    // On Android, the compat JAR is not needed — native Android class loading is used
    // via the compat-android Kotlin library. Skip the Gradle build entirely.
    if target_os == "android" {
        println!("cargo:warning=Android target detected, skipping compat JAR build");
        println!("cargo:rustc-cfg=mihon_android");
        write_placeholder(&output_jar);
        return;
    }

    let compat_dir = Path::new(&manifest_dir).join("compat");

    // Emit rerun-if-changed so cargo re-runs this script if the gradle file appears
    println!("cargo:rerun-if-changed=compat/build.gradle.kts");

    // Only try to build if the compat directory exists and has Gradle files
    if !compat_dir.join("build.gradle.kts").exists() {
        println!("cargo:warning=compat/build.gradle.kts not found, skipping JAR build");
        println!("cargo:warning=The embedded JAR will be a placeholder. Build the JAR with:");
        println!("cargo:warning=  cd rust/mihon/compat && gradle shadowJar");
        write_placeholder(&output_jar);
        return;
    }

    // Check if the JAR was already built (e.g., by running gradle manually)
    let prebuilt_jar = compat_dir
        .join("build")
        .join("libs")
        .join("mihon-compat.jar");

    if prebuilt_jar.exists() && is_valid_jar(&prebuilt_jar) {
        println!("cargo:rerun-if-changed=compat/src");
        println!("cargo:rerun-if-changed=compat/build.gradle.kts");
        println!("cargo:rerun-if-changed={}", prebuilt_jar.display());

        std::fs::copy(&prebuilt_jar, &output_jar)
            .expect("Failed to copy prebuilt mihon-compat.jar to OUT_DIR");

        let size = std::fs::metadata(&output_jar)
            .map(|m| m.len())
            .unwrap_or(0);
        println!("cargo:warning=Using prebuilt mihon-compat.jar ({} bytes)", size);
        return;
    }

    // Rerun if source changes
    println!("cargo:rerun-if-changed=compat/src");
    println!("cargo:rerun-if-changed=compat/build.gradle.kts");

    // Check if Gradle wrapper exists
    let gradle_wrapper = if cfg!(windows) {
        compat_dir.join("gradlew.bat")
    } else {
        compat_dir.join("gradlew")
    };

    let (gradle_cmd, using_wrapper) = if gradle_wrapper.exists() {
        (gradle_wrapper.to_str().unwrap().to_string(), true)
    } else {
        // Fall back to system gradle
        ("gradle".to_string(), false)
    };

    // Try to build the shadow JAR
    let result = Command::new(&gradle_cmd)
        .current_dir(&compat_dir)
        .args(["shadowJar", "--no-daemon", "-q"])
        .output();

    match result {
        Ok(output) if output.status.success() => {
            if prebuilt_jar.exists() && is_valid_jar(&prebuilt_jar) {
                std::fs::copy(&prebuilt_jar, &output_jar)
                    .expect("Failed to copy mihon-compat.jar to OUT_DIR");

                let size = std::fs::metadata(&output_jar)
                    .map(|m| m.len())
                    .unwrap_or(0);
                println!("cargo:rerun-if-changed={}", prebuilt_jar.display());
                println!("cargo:warning=mihon-compat.jar built successfully ({} bytes)", size);
            } else {
                println!(
                    "cargo:warning=Gradle reported success but JAR not found at {:?}",
                    prebuilt_jar
                );
                write_placeholder(&output_jar);
            }
        }
        Ok(output) => {
            let stdout = String::from_utf8_lossy(&output.stdout);
            let stderr = String::from_utf8_lossy(&output.stderr);
            println!("cargo:warning=Gradle build failed:");
            if !stdout.is_empty() {
                println!("cargo:warning=  stdout: {}", stdout.trim());
            }
            if !stderr.is_empty() {
                println!("cargo:warning=  stderr: {}", stderr.trim());
            }
            println!("cargo:warning=The embedded JAR will be a placeholder.");
            println!("cargo:warning=To build manually: cd rust/mihon/compat && {} shadowJar", 
                if using_wrapper { "./gradlew" } else { "gradle" });
            write_placeholder(&output_jar);
        }
        Err(e) => {
            println!("cargo:warning=Failed to run Gradle: {}", e);
            if !using_wrapper {
                println!("cargo:warning=Gradle not found on PATH. Install Gradle or add a Gradle wrapper.");
            }
            println!("cargo:warning=The embedded JAR will be a placeholder.");
            println!("cargo:warning=To build manually: cd rust/mihon/compat && gradle shadowJar");
            write_placeholder(&output_jar);
        }
    }
}

/// Check if a file looks like a valid JAR (ZIP) file by checking magic bytes
fn is_valid_jar(path: &Path) -> bool {
    use std::io::Read;

    if let Ok(metadata) = std::fs::metadata(path) {
        // JAR must be at least 1KB (placeholder is ~11 bytes)
        if metadata.len() < 1024 {
            return false;
        }
        // Check ZIP magic bytes (JARs are ZIP files) — only read 4 bytes
        if let Ok(mut file) = std::fs::File::open(path) {
            let mut buf = [0u8; 4];
            if file.read_exact(&mut buf).is_ok() {
                return buf == [0x50, 0x4B, 0x03, 0x04];
            }
        }
    }
    false
}

/// Write a placeholder file when the real JAR cannot be built
fn write_placeholder(output_path: &Path) {
    // Write a small invalid ZIP-like file that will be detected at runtime
    std::fs::write(output_path, b"placeholder")
        .expect("Failed to write placeholder JAR");
}