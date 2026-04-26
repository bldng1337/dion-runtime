//! MihonAdapter - Implements the Adapter trait for Mihon/Tachiyomi extensions
//!
//! This adapter loads and executes Mihon/Tachiyomi Android extensions (APK files).
//!
//! # Platform Support
//!
//! - **Desktop**: Embeds a JVM with the compat JAR classpath, converts APK DEX to JAR
//!   via dex2jar, and loads extensions through URLClassLoader.
//!
//! - **Android**: Attaches to the existing ART/Dalvik VM, loads extensions directly
//!   from APK using native PathClassLoader. No compat JAR or dex2jar needed.

use dion_runtime::{
    client_data::AdapterClient,
    data::{
        extension::ExtensionType,
        source::MediaType,
    },
    extension::{Adapter, Extension},
};
use std::collections::{HashMap, HashSet};
use std::path::PathBuf;
use std::sync::Arc;
use tokio::sync::RwLock;
use anyhow::{Context, bail, Result};
use async_trait::async_trait;
use serde::{Deserialize, Serialize};

use crate::jni::{JvmHandle, MihonBridge};
use crate::extension::MihonExtension;

/// Embedded mihon-compat.jar - built by build.rs and embedded at compile time.
/// Only used on desktop platforms; on Android, native class loading is used.
#[cfg(not(target_os = "android"))]
const MIHON_COMPAT_JAR: &[u8] = include_bytes!(concat!(env!("OUT_DIR"), "/mihon-compat.jar"));

/// Metadata stored alongside extension JARs
#[derive(Debug, Clone, Serialize, Deserialize)]
struct ExtensionMeta {
    class_name: String,
    package_name: String,
    version: String,
    nsfw: bool,
}

/// Mihon/Tachiyomi extension adapter for dion-runtime
pub struct MihonAdapter {
    /// Client provided by host application
    client: Box<dyn AdapterClient>,

    /// JVM handle (kept for lifetime management)
    #[allow(dead_code)]
    jvm: Arc<JvmHandle>,

    /// JNI bridge for calling Kotlin code
    bridge: Arc<MihonBridge>,

    /// Map from extension ID to its JAR/APK path (for artifact cleanup on uninstall)
    extension_jar_paths: RwLock<HashMap<String, PathBuf>>,

    /// Base path for extension storage
    base_path: PathBuf,
}

impl MihonAdapter {
    /// Create a new MihonAdapter
    ///
    /// # Arguments
    /// * `client` - AdapterClient implementation from host application
    ///
    /// # Errors
    /// Returns error if:
    /// - Cannot get storage path from client
    /// - JVM initialization fails (desktop: check JAVA_HOME; Android: check ndk_context)
    /// - mihon-compat.jar extraction fails (desktop only)
    pub async fn new(client: Box<dyn AdapterClient>) -> Result<Self> {
        // Get base path from client
        let base_path = PathBuf::from(
            client.get_path().await.context("Failed to get adapter path")?
        );

        // Ensure jars directory exists (used for extension storage on all platforms)
        let jars_dir = base_path.join("jars");
        tokio::fs::create_dir_all(&jars_dir).await
            .context("Failed to create jars directory")?;

        // Initialize JVM (platform-specific)
        let jvm = Arc::new(Self::create_jvm(&base_path).await?);

        let bridge = Arc::new(MihonBridge::new(jvm.clone()));

        // Initialize the bridge with the extensions directory.
        // On Android, this also sets the Android Context via ndk_context.
        let jars_dir_str = jars_dir.to_str()
            .context("Invalid jars directory path")?;
        bridge.initialize(jars_dir_str)
            .context("Failed to initialize MihonBridge")?;

        Ok(Self {
            client,
            jvm,
            bridge,
            extension_jar_paths: RwLock::new(HashMap::new()),
            base_path,
        })
    }

    /// Create the JVM handle, platform-specific.
    ///
    /// - **Desktop**: Creates an embedded JVM with the compat JAR on the classpath.
    ///   The compat JAR is extracted from the binary at runtime.
    ///
    /// - **Android**: Attaches to the existing ART/Dalvik VM via ndk_context.
    ///   No compat JAR is needed because native Android class loading is used.
    #[cfg(not(target_os = "android"))]
    async fn create_jvm(base_path: &PathBuf) -> Result<JvmHandle> {
        let compat_jar = base_path.join("mihon-compat.jar");

        // Extract embedded compat JAR if not present or outdated
        Self::ensure_compat_jar(&compat_jar).await?;

        // Initialize JVM with the compat JAR on the classpath
        JvmHandle::new(&compat_jar).context("Failed to initialize JVM")
    }

    #[cfg(target_os = "android")]
    async fn create_jvm(_base_path: &PathBuf) -> Result<JvmHandle> {
        // On Android, attach to the existing ART/Dalvik VM.
        // The compat JAR is not needed — Android provides native class loading
        // via PathClassLoader and the compat-android AAR handles bridging.
        log::info!("Android platform: attaching to existing JVM (no compat JAR needed)");
        JvmHandle::new()
    }

    /// Find or extract the mihon-compat.jar (desktop only).
    ///
    /// The JAR is embedded in the binary at compile time and extracted at runtime.
    /// The MIHON_COMPAT_JAR environment variable can override this behavior.
    #[cfg(not(target_os = "android"))]
    async fn ensure_compat_jar(target_path: &PathBuf) -> Result<()> {
        // If target already exists and is a valid JAR, use it
        if target_path.exists() {
            let meta = tokio::fs::metadata(target_path).await?;
            if meta.len() > 1000 {  // More than just a placeholder
                return Ok(());
            }
        }

        // Check environment variable override
        if let Ok(env_path) = std::env::var("MIHON_COMPAT_JAR") {
            let path = PathBuf::from(&env_path);
            if path.exists() {
                log::info!("Using mihon-compat.jar from MIHON_COMPAT_JAR: {:?}", path);
                tokio::fs::copy(&path, target_path).await
                    .context("Failed to copy mihon-compat.jar from MIHON_COMPAT_JAR")?;
                return Ok(());
            }
            log::warn!("MIHON_COMPAT_JAR set but file not found: {:?}", path);
        }

        // Verify embedded JAR is valid (starts with ZIP magic bytes PK\x03\x04)
        if MIHON_COMPAT_JAR.len() < 4 || MIHON_COMPAT_JAR[0..4] != [0x50, 0x4B, 0x03, 0x04] {
            bail!(
                "Embedded mihon-compat.jar is not a valid JAR file. \
                 The JAR may not have been built during compilation. \
                 Please ensure Gradle is available and run: \
                 cd rust/mihon/compat && gradle shadowJar, \
                 then rebuild the Rust project."
            );
        }

        // Extract embedded JAR to target path
        log::info!(
            "Extracting embedded mihon-compat.jar ({} bytes) to {:?}",
            MIHON_COMPAT_JAR.len(),
            target_path
        );
        tokio::fs::write(target_path, MIHON_COMPAT_JAR).await
            .context("Failed to write embedded mihon-compat.jar")?;

        Ok(())
    }

    /// Get metadata file path for a JAR
    fn get_meta_path(jar_path: &PathBuf) -> PathBuf {
        jar_path.with_extension("json")
    }

    /// Load metadata for a JAR file
    async fn load_meta(jar_path: &PathBuf) -> Result<Option<ExtensionMeta>> {
        let meta_path = Self::get_meta_path(jar_path);
        if !meta_path.exists() {
            return Ok(None);
        }

        let contents = tokio::fs::read_to_string(&meta_path).await
            .context("Failed to read metadata file")?;
        let meta: ExtensionMeta = serde_json::from_str(&contents)
            .context("Failed to parse metadata file")?;
        Ok(Some(meta))
    }

    /// Save metadata for a JAR file
    async fn save_meta(jar_path: &PathBuf, meta: &ExtensionMeta) -> Result<()> {
        let meta_path = Self::get_meta_path(jar_path);
        let contents = serde_json::to_string_pretty(meta)
            .context("Failed to serialize metadata")?;
        tokio::fs::write(&meta_path, contents).await
            .context("Failed to write metadata file")?;
        Ok(())
    }

    /// Load extension from a JAR file (desktop) or APK file (Android).
    ///
    /// On desktop, `jar_path` points to a converted JAR from dex2jar.
    /// On Android, `jar_path` points directly to the APK file.
    async fn load_extension_from_jar(&self, jar_path: &PathBuf, class_name: &str, meta: Option<&ExtensionMeta>) -> Result<Vec<Box<dyn Extension>>> {
        let jar_path_str = jar_path.to_str()
            .ok_or_else(|| anyhow::anyhow!("Invalid JAR path"))?;

        // Load extension via JNI (platform-specific bridge handles the details)
        let source_ids = self.bridge.load_extension(jar_path_str, class_name)?;

        if source_ids.is_empty() {
            log::warn!("No sources found in extension: {:?}", jar_path);
            return Ok(Vec::new());
        }

        let mut extensions = Vec::new();

        for source_id in source_ids {
            // Get source info
            let source_info = self.bridge.get_source_info(source_id)?;
            let source_type = self.bridge.get_source_type(source_id)?;

            // Build ExtensionData
            let mut media_types = HashSet::new();
            media_types.insert(match source_type.as_str() {
                "manga" => MediaType::Comic,
                "anime" => MediaType::Video,
                _ => MediaType::Unknown,
            });

            let mut extension_types = HashSet::new();
            extension_types.insert(ExtensionType::EntryProvider { has_search: true });

            let ext_data = dion_runtime::data::extension::ExtensionData {
                id: format!("mihon:{}", source_id),
                name: source_info.name.clone(),
                url: source_info.base_url.clone().unwrap_or_default(),
                icon: format!("mihon://icon/{}", source_id),
                desc: None,
                author: Vec::new(),
                tags: Vec::new(),
                lang: vec![source_info.lang.clone()],
                nsfw: meta.map(|m| m.nsfw).unwrap_or(false),
                media_type: media_types,
                extension_type: extension_types,
                repo: None,
                version: meta.map(|m| m.version.clone()).unwrap_or_else(|| "1.0.0".to_string()),
                license: String::new(),
                compatible: true,
            };

            // Get ExtensionClient from host
            let ext_client = self.client
                .get_extension_client(ext_data.clone())
                .await
                .context("Failed to get ExtensionClient")?;

            // Create MihonExtension
            let ext = MihonExtension::new(
                source_id,
                &source_type,
                ext_data,
                ext_client,
                self.bridge.clone(),
            ).await?;

            // Track extension -> jar_path mapping for cleanup during uninstall
            self.extension_jar_paths.write().await.insert(
                format!("mihon:{}", source_id),
                jar_path.clone(),
            );

            extensions.push(Box::new(ext) as Box<dyn Extension>);
        }

        Ok(extensions)
    }
}

#[async_trait]
impl Adapter for MihonAdapter {
    /// Get all installed extensions
    async fn get_extensions(&self) -> Result<Vec<Box<dyn Extension>>> {
        let jars_dir = self.base_path.join("jars");
        let mut extensions = Vec::new();

        // Collect extension candidates: (jar_path, class_name, metadata)
        // Keyed by package_name for deduplication.
        // System-installed extensions are added first (lower priority),
        // then private extensions from jars/ overwrite them (higher priority).
        let mut candidates: HashMap<String, (PathBuf, String, Option<ExtensionMeta>)> = HashMap::new();

        // On Android, discover system-installed extensions first (lower priority).
        // These are APKs installed via the system package manager that declare
        // the "tachiyomi.extension" feature.
        #[cfg(target_os = "android")]
        {
            match self.bridge.get_installed_extensions() {
                Ok(installed) => {
                    log::info!("Found {} system-installed extension(s)", installed.len());
                    for ext in installed {
                        candidates.insert(
                            ext.metadata.package_name.clone(),
                            (PathBuf::from(&ext.jar_path), ext.class_name, None),
                        );
                    }
                }
                Err(e) => {
                    log::warn!("Failed to query system-installed extensions: {:?}", e);
                }
            }
        }

        // Scan jars directory for privately installed extensions (higher priority).
        // These overwrite any system-installed extension with the same package name.
        if jars_dir.exists() {
            let mut entries = tokio::fs::read_dir(&jars_dir).await
                .context("Failed to read jars directory")?;

            while let Some(entry) = entries.next_entry().await? {
                let path = entry.path();
                // On desktop: look for .jar files; on Android: look for .apk files
                let expected_ext = if cfg!(target_os = "android") { "apk" } else { "jar" };
                let is_valid = path.extension().map_or(false, |e| e == expected_ext);

                if is_valid {
                    // Try to load metadata from sidecar file
                    match Self::load_meta(&path).await {
                        Ok(Some(meta)) => {
                            candidates.insert(
                                meta.package_name.clone(),
                                (path, meta.class_name.clone(), Some(meta)),
                            );
                        }
                        Ok(None) => {
                            // Attempt to recover metadata from the artifact directly
                            // rather than skipping and orphaning a valid extension.
                            #[cfg(target_os = "android")]
                            {
                                // On Android, the file is an APK — parse its
                                // AndroidManifest.xml to recover package, class, etc.
                                match crate::apk::MihonExtensionMetadata::from_apk(&path) {
                                    Ok(native_meta) => {
                                        log::info!("Recovered metadata from APK for {:?}", path);
                                        // Auto-save sidecar so we don't have to re-parse next time
                                        let recovered = ExtensionMeta {
                                            class_name: native_meta.entry_class.clone(),
                                            package_name: native_meta.package.clone(),
                                            version: native_meta.version_name.clone(),
                                            nsfw: native_meta.nsfw,
                                        };
                                        if let Err(e) = Self::save_meta(&path, &recovered).await {
                                            log::warn!("Failed to save recovered metadata: {:?}", e);
                                        }
                                        candidates.insert(
                                            recovered.package_name.clone(),
                                            (path, recovered.class_name.clone(), Some(recovered)),
                                        );
                                    }
                                    Err(e) => {
                                        log::warn!(
                                            "No metadata file for {:?} and failed to extract from APK: {:?}",
                                            path, e
                                        );
                                    }
                                }
                            }
                            #[cfg(not(target_os = "android"))]
                            {
                                // On desktop the file is a converted JAR — we cannot
                                // recover the Android manifest metadata from it. This
                                // should only happen if the sidecar was manually deleted
                                // after a proper install.
                                log::warn!("No metadata file for {:?}, skipping (desktop JARs require sidecar metadata)", path);
                            }
                        }
                        Err(e) => {
                            log::error!("Failed to load metadata for {:?}: {:?}", path, e);
                        }
                    }
                }
            }
        }

        // Early return if no candidates found
        if candidates.is_empty() {
            return Ok(extensions);
        }

        // Load each unique extension
        for (_pkg_name, (path, class_name, meta)) in candidates {
            // Ensure the APK file is read-only before loading (Android 14+ W^X enforcement)
            #[cfg(target_os = "android")]
            {
                if let Ok(metadata) = std::fs::metadata(&path) {
                    let mut perms = metadata.permissions();
                    if !perms.readonly() {
                        perms.set_readonly(true);
                        tokio::fs::set_permissions(&path, perms).await.ok();
                    }
                }
            }

            match self.load_extension_from_jar(&path, &class_name, meta.as_ref()).await {
                Ok(exts) => extensions.extend(exts),
                Err(e) => log::error!("Failed to load {:?}: {:?}", path, e),
            }
        }

        Ok(extensions)
    }

    /// Install extension from URL (APK file).
    ///
    /// On desktop, this converts the APK DEX to JAR via dex2jar.
    /// On Android, the APK is used directly — only metadata is extracted.
    async fn install(&self, url: &str) -> Result<Box<dyn Extension>> {
        // Download APK
        let apk_bytes = if url.starts_with("file://") {
            // Local file
            let path = url.strip_prefix("file://").unwrap();
            tokio::fs::read(path).await
                .context("Failed to read local APK")?
        } else {
            // Remote URL
            let response = reqwest::get(url).await
                .context("Failed to download APK")?;
            let status = response.status();
            if !status.is_success() {
                bail!("Failed to download APK: HTTP {}", status);
            }
            response.bytes().await
                .context("Failed to read APK bytes")?
                .to_vec()
        };

        // Write to temp file
        let temp_apk = self.base_path.join(format!(
            "temp_{}.apk",
            std::time::SystemTime::now()
                .duration_since(std::time::UNIX_EPOCH)
                .unwrap_or_default()
                .as_millis()
        ));
        tokio::fs::write(&temp_apk, &apk_bytes).await
            .context("Failed to write temp APK")?;

        // Install extension via JNI bridge.
        // On desktop: APK -> JAR conversion (dex2jar).
        // On Android: metadata extraction only (APK path returned as-is).
        let install_result = self.bridge.install_extension(
            temp_apk.to_str().unwrap(),
        )?;

        // On desktop, the temp APK is converted to a JAR. On Android, the APK is kept.
        // Clean up temp APK only on desktop (on Android, the bridge returns the APK path).
        #[cfg(not(target_os = "android"))]
        {
            tokio::fs::remove_file(&temp_apk).await.ok();
        }

        // The jarPath from install result:
        // - Desktop: path to the converted JAR file
        // - Android: path to the APK file itself
        let jar_path = PathBuf::from(&install_result.jar_path);

        // On Android, copy APK to jars dir for persistence using package name as filename
        // to avoid collisions (temp.apk would be overwritten by each install)
        #[cfg(target_os = "android")]
        {
            let jars_dir = self.base_path.join("jars");
            let apk_name = format!("{}.apk", install_result.metadata.package_name);
            let dest = jars_dir.join(&apk_name);
            if dest != jar_path {
                tokio::fs::copy(&jar_path, &dest).await
                    .context("Failed to copy APK to jars directory")?;
                // Set file read-only to satisfy Android 14+ W^X enforcement
                // for DEX loading. Writable DEX files are rejected by the runtime.
                {
                    use std::os::unix::fs::PermissionsExt;
                    let perms = std::fs::Permissions::from_mode(0o444);
                    tokio::fs::set_permissions(&dest, perms).await.ok();
                }
                tokio::fs::remove_file(&temp_apk).await.ok();
            }
        }

        // Save metadata alongside the JAR/APK using the same package-based naming
        let final_jar_path = {
            #[cfg(not(target_os = "android"))]
            { jar_path.clone() }
            #[cfg(target_os = "android")]
            {
                let jars_dir = self.base_path.join("jars");
                let apk_name = format!("{}.apk", install_result.metadata.package_name);
                jars_dir.join(apk_name)
            }
        };

        let meta = ExtensionMeta {
            class_name: install_result.class_name.clone(),
            package_name: install_result.metadata.package_name.clone(),
            version: install_result.metadata.version_name.clone(),
            nsfw: install_result.metadata.nsfw,
        };
        Self::save_meta(&final_jar_path, &meta).await?;

        // Load the installed extension
        let exts = self.load_extension_from_jar(&final_jar_path, &install_result.class_name, Some(&meta)).await?;

        exts.into_iter()
            .next()
            .ok_or_else(|| anyhow::anyhow!("No sources found in extension"))
    }

    /// Uninstall extension
    async fn uninstall(&self, ext: &Box<dyn Extension>) -> Result<()> {
        let store = ext.get_data().read().await;
        let ext_id = &store.data.id;

        // Extract source ID from extension ID (format: "mihon:{source_id}")
        if let Some(source_id_str) = ext_id.strip_prefix("mihon:") {
            if let Ok(source_id) = source_id_str.parse::<i64>() {
                // Unload the specific source from JVM
                if let Err(e) = self.bridge.unload_source(source_id) {
                    log::warn!("Failed to unload source from JVM: {:?}", e);
                }
            }
        }

        // Determine the JAR/APK path from the extension jar paths cache
        let jar_path = {
            let jar_paths = self.extension_jar_paths.read().await;
            jar_paths.get(ext_id).cloned()
        };

        // Remove from cache
        self.extension_jar_paths.write().await.remove(ext_id);

        // Delete the JAR/APK and its metadata sidecar
        if let Some(jar_path) = jar_path {
            // Unload the entire extension (all sources from the same JAR/APK)
            if let Err(e) = self.bridge.unload_extension(jar_path.to_str().unwrap_or_default()) {
                log::warn!("Failed to unload extension from JVM: {:?}", e);
            }

            // Delete the JAR/APK file
            if jar_path.exists() {
                if let Err(e) = tokio::fs::remove_file(&jar_path).await {
                    log::warn!("Failed to delete extension file {:?}: {:?}", jar_path, e);
                }
            }

            // Delete the metadata sidecar (.json)
            let meta_path = Self::get_meta_path(&jar_path);
            if meta_path.exists() {
                if let Err(e) = tokio::fs::remove_file(&meta_path).await {
                    log::warn!("Failed to delete metadata file {:?}: {:?}", meta_path, e);
                }
            }
        }

        Ok(())
    }

    /// Get extension repository metadata
    async fn get_repo(&self, _url: &str) -> Result<dion_runtime::data::extension_repo::ExtensionRepo> {
        bail!("Repository support not yet implemented")
    }

    /// Get specific remote extension
    async fn get_remote_extension(
        &self,
        _repo: &dion_runtime::data::extension_repo::ExtensionRepo,
        _extension_id: String,
    ) -> Result<Option<dion_runtime::data::extension_repo::RemoteExtension>> {
        Ok(None)
    }

    /// Browse extensions in repository
    async fn browse_repo(
        &self,
        _repo: &dion_runtime::data::extension_repo::ExtensionRepo,
        _page: i32,
    ) -> Result<dion_runtime::data::extension_repo::RemoteExtensionResult> {
        bail!("Repository browsing not yet implemented")
    }
}