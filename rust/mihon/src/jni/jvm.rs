//! JVM lifecycle management

use anyhow::{bail, Context, Result};
use jni::{InitArgsBuilder, JNIVersion, JavaVM};
use std::path::{Path, PathBuf};

/// Handle to the embedded JVM
pub struct JvmHandle {
    jvm: JavaVM,
}

impl JvmHandle {
    /// Initialize JVM with classpath pointing to mihon-compat.jar
    ///
    /// # Arguments
    /// * `compat_jar_path` - Path to the mihon-compat.jar file
    pub fn new(compat_jar_path: &Path) -> Result<Self> {
        // Build classpath
        let classpath = format!("-Djava.class.path={}", compat_jar_path.display());

        // Ensure we have a valid JAVA_HOME before attempting JVM init.
        // The `jni` crate relies on JAVA_HOME to locate jvm.dll/jvm.so.
        ensure_java_home()?;

        let jvm_args = InitArgsBuilder::new()
            .version(JNIVersion::V8)
            .option(&classpath)
            // Increase heap size for extensions
            .option("-Xmx512m")
            .build()
            .context("Failed to build JVM args")?;

        let jvm = JavaVM::new(jvm_args).context(
            "Failed to create JVM. Ensure a JDK/JRE with a JVM library is installed \
             and JAVA_HOME points to it.",
        )?;

        Ok(Self { jvm })
    }

    /// Get JNIEnv for current thread (attaches if needed)
    /// Returns an AttachGuard that will detach when dropped
    pub fn attach_current_thread(&self) -> Result<jni::AttachGuard<'_>> {
        self.jvm
            .attach_current_thread()
            .context("Failed to attach thread to JVM")
    }

    /// Check if current thread is attached
    pub fn is_attached(&self) -> bool {
        self.jvm.get_env().is_ok()
    }
}

// JVM is Send + Sync (thread-safe)
unsafe impl Send for JvmHandle {}
unsafe impl Sync for JvmHandle {}

/// Validate JAVA_HOME and search for a valid JVM installation if needed.
///
/// This function ensures that the `JAVA_HOME` environment variable either:
/// 1. Already points to a valid JDK/JRE with a JVM library, or
/// 2. Is updated to point to a discovered JDK/JRE installation.
///
/// The `jni` crate uses `JAVA_HOME` internally to locate the JVM shared library
/// (`jvm.dll` on Windows, `libjvm.so` on Linux, `libjvm.dylib` on macOS).
fn ensure_java_home() -> Result<()> {
    // Check if current JAVA_HOME is valid
    if let Ok(java_home) = std::env::var("JAVA_HOME") {
        let java_home_path = PathBuf::from(&java_home);
        if find_jvm_library(&java_home_path).is_some() {
            log::debug!("JAVA_HOME is valid: {}", java_home);
            return Ok(());
        }
        log::warn!(
            "JAVA_HOME is set to '{}' but no JVM library found there, searching for alternative installations...",
            java_home
        );
    }

    // Search for a valid Java installation
    if let Some(found_home) = search_java_installations() {
        log::info!("Found Java installation at: {:?}", found_home);
        std::env::set_var("JAVA_HOME", &found_home);
        return Ok(());
    }

    bail!(
        "No valid Java installation found.\n\
         Please install a JDK/JRE and set the JAVA_HOME environment variable."
    )
}

/// Search common installation directories for a valid JDK/JRE.
///
/// Returns the JAVA_HOME path if a valid JVM library is found.
fn search_java_installations() -> Option<PathBuf> {
    let candidates = discover_java_candidates();

    for candidate in candidates {
        if find_jvm_library(&candidate).is_some() {
            return Some(candidate);
        }
    }

    None
}

/// Generate a list of candidate Java installation directories to search.
fn discover_java_candidates() -> Vec<PathBuf> {
    let mut candidates = Vec::new();

    if cfg!(windows) {
        // Program Files directories
        let program_files = std::env::var("ProgramFiles").unwrap_or_else(|_| r"C:\Program Files".into());
        let program_files_x86 =
            std::env::var("ProgramFiles(x86)").unwrap_or_else(|_| r"C:\Program Files (x86)".into());

        let base_dirs = [&program_files, &program_files_x86];

        // Known Java vendor directories
        let vendors = [
            "Eclipse Adoptium",
            "AdoptOpenJDK",
            "Java",
            "Microsoft",
            "Zulu",
            "Amazon Corretto",
            "BellSoft",
            "Red Hat",
            "Semeru",
            "GraalVM",
        ];

        for base in &base_dirs {
            let base_path = PathBuf::from(base);
            for vendor in &vendors {
                let vendor_dir = base_path.join(vendor);
                if vendor_dir.exists() {
                    if let Ok(entries) = std::fs::read_dir(&vendor_dir) {
                        for entry in entries.flatten() {
                            let path = entry.path();
                            if path.is_dir() {
                                candidates.push(path);
                            }
                        }
                    }
                }
            }
        }

        // Also check common standalone paths
        candidates.push(PathBuf::from(r"C:\Java"));
        candidates.push(PathBuf::from(r"C:\Program Files\Java"));

        // Check PATH for java.exe to locate installation
        if let Ok(path_var) = std::env::var("PATH") {
            for path_entry in path_var.split(';') {
                let java_exe = PathBuf::from(path_entry).join("java.exe");
                if java_exe.exists() {
                    // java.exe is typically in bin/, so go up one level for JAVA_HOME
                    if let Some(parent) = java_exe.parent().and_then(|p| p.parent()) {
                        candidates.push(parent.to_path_buf());
                    }
                }
            }
        }
    } else if cfg!(target_os = "macos") {
        // macOS typical locations
        candidates.push(PathBuf::from("/Library/Java/JavaVirtualMachines"));
        let home_java = PathBuf::from("/usr/local/opt/openjdk");
        candidates.push(home_java);

        // Check /usr/libexec/java_home output
        if let Ok(output) = std::process::Command::new("/usr/libexec/java_home")
            .arg("-fallback")
            .output()
        {
            if output.status.success() {
                let home = String::from_utf8_lossy(&output.stdout).trim().to_string();
                if !home.is_empty() {
                    candidates.push(PathBuf::from(home));
                }
            }
        }

        // Homebrew locations
        candidates.push(PathBuf::from("/opt/homebrew/opt/openjdk"));
        candidates.push(PathBuf::from("/usr/local/opt/openjdk"));
    } else {
        // Linux typical locations
        candidates.push(PathBuf::from("/usr/lib/jvm"));
        candidates.push(PathBuf::from("/usr/local/lib/jvm"));
        candidates.push(PathBuf::from("/opt/java"));
        candidates.push(PathBuf::from("/opt/jdk"));
        candidates.push(PathBuf::from("/opt/openjdk"));

        // Check PATH for java to locate installation
        if let Ok(path_var) = std::env::var("PATH") {
            for path_entry in path_var.split(':') {
                let java_bin = PathBuf::from(path_entry).join("java");
                if java_bin.exists() {
                    if let Some(parent) = java_bin.parent().and_then(|p| p.parent()) {
                        candidates.push(parent.to_path_buf());
                    }
                }
            }
        }
    }

    candidates
}

/// Search for the JVM shared library within a given Java home directory.
///
/// Returns the path to the JVM library if found.
fn find_jvm_library(java_home: &Path) -> Option<PathBuf> {
    if !java_home.exists() {
        return None;
    }

    // Relative paths to search for the JVM library within a JDK/JRE installation
    let search_paths = if cfg!(windows) {
        vec![
            PathBuf::from("bin/server/jvm.dll"),
            PathBuf::from("bin/client/jvm.dll"),
            PathBuf::from("jre/bin/server/jvm.dll"),
            PathBuf::from("jre/bin/client/jvm.dll"),
        ]
    } else if cfg!(target_os = "macos") {
        vec![
            PathBuf::from("lib/server/libjvm.dylib"),
            PathBuf::from("jre/lib/server/libjvm.dylib"),
            PathBuf::from("lib/jli/libjli.dylib"),
            PathBuf::from("Contents/Home/lib/server/libjvm.dylib"),
        ]
    } else {
        vec![
            PathBuf::from("lib/server/libjvm.so"),
            PathBuf::from("lib/client/libjvm.so"),
            PathBuf::from("jre/lib/server/libjvm.so"),
            PathBuf::from("jre/lib/client/libjvm.so"),
            PathBuf::from("lib/jvm/server/libjvm.so"),
            PathBuf::from("lib/jvm/client/libjvm.so"),
        ]
    };

    for search_path in &search_paths {
        let full_path = java_home.join(search_path);
        if full_path.exists() {
            log::debug!("Found JVM library at: {:?}", full_path);
            return Some(full_path);
        }
    }

    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_discover_java_candidates_returns_paths() {
        // Just verify the function doesn't panic and returns something
        let candidates = discover_java_candidates();
        // On any system, we should at least have attempted some paths
        // (they may not exist, but the function should not panic)
        println!("Found {} candidate Java paths", candidates.len());
    }

    #[test]
    fn test_find_jvm_library_with_nonexistent_path() {
        let result = find_jvm_library(Path::new("/nonexistent/path/that/does/not/exist"));
        assert!(result.is_none());
    }
}
