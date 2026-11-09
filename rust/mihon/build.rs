//! Build script for mihon-adapter
//!
//! This script builds the mihon-compat.jar using Gradle and places it in OUT_DIR
//! for embedding into the binary via `include_bytes!`.
//!
//! A `cargo:rustc-cfg=mihon_compat_jar_available` flag is set when a real JAR
//! is successfully built.
//!
//! On desktop targets the JAR is required: a placeholder would compile fine and
//! only fail at adapter startup, so any failure to produce a valid JAR aborts
//! the build with an actionable error instead of embedding a placeholder.
//!
//! On Android targets, the compat JAR is not needed (native Android class loading
//! is used instead), so the Gradle build is skipped entirely.

use std::env;
use std::io::Read;
use std::path::Path;
use std::process::Command;

fn main() {
    // Declare the custom cfg set below so rustc's `unexpected_cfgs` lint knows
    // about it (instead of warning at every use site).
    println!("cargo::rustc-check-cfg=cfg(mihon_compat_jar_available)");
    println!("cargo::rustc-check-cfg=cfg(mihon_android)");

    let out_dir = env::var("OUT_DIR").expect("OUT_DIR not set");
    let manifest_dir = env::var("CARGO_MANIFEST_DIR").expect("CARGO_MANIFEST_DIR not set");
    let target_os = env::var("CARGO_CFG_TARGET_OS").unwrap_or_default();

    // Compile the extension-store protobuf schema with protox (pure Rust, no
    // protoc install needed). prost generates decode types into OUT_DIR,
    // included by `src/repo.rs`. Runs on every target, including Android.
    let proto_dir = Path::new(&manifest_dir).join("proto");
    let fds = protox::compile(
        [proto_dir.join("extension_store.proto")],
        [proto_dir.clone()],
    )
    .expect("failed to compile extension_store.proto");
    prost_build::Config::new()
        .compile_fds(fds)
        .expect("prost failed to generate extension store types");
    println!("cargo:rerun-if-changed=proto/extension_store.proto");

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

    // Emit rerun-if-changed so cargo re-runs this script if the gradle setup
    // changes. The prebuilt-JAR path is tracked even when the file does not
    // exist yet, so a JAR appearing later (e.g. after a manual gradle run)
    // triggers a rebuild instead of leaving a stale placeholder embedded.
    println!("cargo:rerun-if-changed=compat/src");
    println!("cargo:rerun-if-changed=compat/build.gradle.kts");
    println!("cargo:rerun-if-changed=compat/settings.gradle.kts");
    println!("cargo:rerun-if-changed=compat/gradle.properties");
    println!("cargo:rerun-if-changed=compat/gradlew");
    println!("cargo:rerun-if-changed=compat/gradlew.bat");
    println!("cargo:rerun-if-changed=compat/gradle/wrapper/gradle-wrapper.properties");
    println!("cargo:rerun-if-changed=compat/gradle/wrapper/gradle-wrapper.jar");
    println!("cargo:rerun-if-changed=compat/build/libs/mihon-compat.jar");

    // Only try to build if the compat directory exists and has Gradle files
    if !compat_dir.join("build.gradle.kts").exists() {
        fail_build(
            "compat/build.gradle.kts not found; cannot build mihon-compat.jar.\n\
             The compat Gradle project is required for desktop builds.\n\
             Restore rust/mihon/compat (including build.gradle.kts) and rebuild.",
        );
    }

    // Check if the JAR was already built (e.g., by running gradle manually)
    let prebuilt_jar = compat_dir
        .join("build")
        .join("libs")
        .join("mihon-compat.jar");

    if prebuilt_jar.exists() && is_valid_jar(&prebuilt_jar) {
        std::fs::copy(&prebuilt_jar, &output_jar)
            .expect("Failed to copy prebuilt mihon-compat.jar to OUT_DIR");

        let size = std::fs::metadata(&output_jar).map(|m| m.len()).unwrap_or(0);
        println!(
            "cargo:warning=Using prebuilt mihon-compat.jar ({} bytes)",
            size
        );
        emit_jar_digest(&output_jar);
        println!("cargo:rustc-cfg=mihon_compat_jar_available");
        return;
    }

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

                let size = std::fs::metadata(&output_jar).map(|m| m.len()).unwrap_or(0);
                println!("cargo:rerun-if-changed={}", prebuilt_jar.display());
                println!(
                    "cargo:warning=mihon-compat.jar built successfully ({} bytes)",
                    size
                );
                emit_jar_digest(&output_jar);
                println!("cargo:rustc-cfg=mihon_compat_jar_available");
            } else {
                fail_build(&format!(
                    "Gradle reported success but mihon-compat.jar was not found at {}.\n\
                     Inspect the shadowJar task output: cd rust/mihon/compat && {} shadowJar",
                    prebuilt_jar.display(),
                    gradle_hint_command(using_wrapper),
                ));
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
            fail_build(&format!(
                "Gradle failed to build mihon-compat.jar (see warnings above).\n\
                 Common cause: the JDK in JAVA_HOME is not supported by the Gradle \
                 version pinned in rust/mihon/compat/gradle/wrapper/gradle-wrapper.properties \
                 (Java 25 needs Gradle >= 9.1.0).\n\
                 To reproduce with full output: cd rust/mihon/compat && {} shadowJar",
                gradle_hint_command(using_wrapper),
            ));
        }
        Err(e) => {
            let mut hint = format!("Failed to run Gradle: {}", e);
            if !using_wrapper {
                hint.push_str(
                    "\nGradle was not found on PATH and the wrapper is missing; \
                     install Gradle or restore compat/gradlew.",
                );
            }
            hint.push_str(&format!(
                "\nDesktop builds require mihon-compat.jar; reproduce with: \
                 cd rust/mihon/compat && {} shadowJar",
                gradle_hint_command(using_wrapper),
            ));
            fail_build(&hint);
        }
    }
}

/// Shell command prefix to reproduce a Gradle build failure manually.
fn gradle_hint_command(using_wrapper: bool) -> &'static str {
    if using_wrapper {
        "./gradlew"
    } else {
        "gradle"
    }
}

/// Abort the build: on desktop there is no useful fallback for a missing
/// compat JAR. A placeholder would compile fine and only blow up at adapter
/// startup with a confusing error, so failing here keeps the problem at the
/// point where it can actually be fixed.
fn fail_build(message: &str) -> ! {
    eprintln!();
    eprintln!("error: failed to build mihon-adapter: {message}");
    std::process::exit(1);
}

/// Check if a file looks like a valid JAR (ZIP) file by checking magic bytes
fn is_valid_jar(path: &Path) -> bool {
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
    std::fs::write(output_path, b"placeholder").expect("Failed to write placeholder JAR");
    // No valid JAR available: emit zero values so the runtime staleness
    // check does not treat a stale cached JAR as current.
    emit_no_jar_digest();
}

/// Compute a FNV-1a 64-bit checksum over the given bytes.
///
/// This is not cryptographically secure, but it is fully deterministic and
/// collision-resistant enough to detect when an embedded JAR has been replaced
/// with a different build (the runtime use case for `ensure_compat_jar`).
fn fnv1a_64(data: &[u8]) -> u64 {
    let mut hash: u64 = 0xcbf29ce484222325;
    for &b in data {
        hash ^= u64::from(b);
        hash = hash.wrapping_mul(0x100000001b3);
    }
    hash
}

/// Emit the embedded JAR's length + checksum as compile-time env vars so the
/// runtime can detect whether the on-disk cached JAR is stale.
fn emit_jar_digest(jar_path: &Path) {
    let (len, checksum) = match std::fs::read(jar_path) {
        Ok(bytes) => (bytes.len(), fnv1a_64(&bytes)),
        Err(_) => {
            emit_no_jar_digest();
            return;
        }
    };
    println!("cargo:rustc-env=MIHON_COMPAT_JAR_LEN={}", len);
    println!(
        "cargo:rustc-env=MIHON_COMPAT_JAR_CHECKSUM={:016x}",
        checksum
    );
}

/// Emit digest values indicating no valid embedded JAR is available.
fn emit_no_jar_digest() {
    println!("cargo:rustc-env=MIHON_COMPAT_JAR_LEN=0");
    println!("cargo:rustc-env=MIHON_COMPAT_JAR_CHECKSUM=0");
}
