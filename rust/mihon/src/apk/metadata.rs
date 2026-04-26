//! Mihon/Tachiyomi extension metadata extraction from APK files

use anyhow::{bail, Context, Result};
use std::io::Read;
use std::path::Path;
use zip::ZipArchive;

use super::manifest::BinaryXmlParser;

/// Metadata extracted from a Mihon/Tachiyomi extension APK
#[derive(Debug, Clone)]
pub struct MihonExtensionMetadata {
    /// Package name (e.g., "eu.kanade.tachiyomi.extension.all.batoto")
    pub package: String,

    /// Version string (e.g., "1.4.60")
    pub version_name: String,

    /// Version code (e.g., 60)
    pub version_code: u32,

    /// Display label (e.g., "Tachiyomi: Bato.to")
    pub label: String,

    /// Entry point class (e.g., ".BatoToFactory" or full class name)
    pub entry_class: String,

    /// NSFW flag from meta-data
    pub nsfw: bool,

    /// Library version for compatibility checking
    pub lib_version: Option<f64>,
}

impl MihonExtensionMetadata {
    /// Parse metadata from an APK file
    pub fn from_apk(path: &Path) -> Result<Self> {
        let file = std::fs::File::open(path).context("Failed to open APK file")?;

        let mut archive = ZipArchive::new(file).context("Failed to read APK as ZIP")?;

        // Extract AndroidManifest.xml
        let mut manifest_entry = archive
            .by_name("AndroidManifest.xml")
            .context("AndroidManifest.xml not found in APK")?;

        let mut manifest_data = Vec::new();
        manifest_entry
            .read_to_end(&mut manifest_data)
            .context("Failed to read AndroidManifest.xml")?;

        // Parse binary XML
        let mut parser = BinaryXmlParser::new();
        let doc = parser
            .parse(&manifest_data)
            .context("Failed to parse AndroidManifest.xml")?;

        let root = doc
            .root
            .as_ref()
            .ok_or_else(|| anyhow::anyhow!("Empty manifest"))?;

        if root.name != "manifest" {
            bail!("Expected manifest root element, got: {}", root.name);
        }

        // Extract package info
        let package = root
            .attributes
            .get("package")
            .cloned()
            .ok_or_else(|| anyhow::anyhow!("Missing package attribute"))?;

        let version_code = root
            .attributes
            .get("versionCode")
            .map(|s| s.parse::<u32>().unwrap_or(0))
            .unwrap_or(0);

        let version_name = root
            .attributes
            .get("versionName")
            .cloned()
            .unwrap_or_else(|| version_code.to_string());

        // Find application element
        let app_elements: Vec<_> = root
            .children
            .iter()
            .filter(|c| c.name == "application")
            .collect();

        let app = app_elements
            .first()
            .ok_or_else(|| anyhow::anyhow!("No application element found"))?;

        let label = app
            .attributes
            .get("label")
            .cloned()
            .unwrap_or_else(|| package.clone());

        // Extract meta-data
        let mut entry_class = String::new();
        let mut nsfw = false;
        let mut lib_version = None;

        for child in &app.children {
            if child.name == "meta-data" {
                let name = child
                    .attributes
                    .get("name")
                    .map(|s| s.as_str())
                    .unwrap_or("");
                let value = child
                    .attributes
                    .get("value")
                    .map(|s| s.as_str())
                    .unwrap_or("");

                match name {
                    "tachiyomi.extension.class" => {
                        entry_class = if value.starts_with('.') {
                            format!("{}{}", package, value)
                        } else {
                            value.to_string()
                        };
                    }
                    "tachiyomi.extension.nsfw" => {
                        nsfw = value == "1" || value == "true";
                    }
                    "tachiyomi.extension.lib.version" => {
                        lib_version = value.parse().ok();
                    }
                    _ => {}
                }
            }
        }

        if entry_class.is_empty() {
            bail!("Missing tachiyomi.extension.class meta-data");
        }

        Ok(Self {
            package,
            version_name,
            version_code,
            label,
            entry_class,
            nsfw,
            lib_version,
        })
    }

    /// Validate extension is compatible with our runtime
    pub fn is_compatible(&self) -> bool {
        // Check lib_version is within supported range
        // Suwayomi uses: LIB_VERSION_MIN = 1.3, LIB_VERSION_MAX = 1.5
        match self.lib_version {
            Some(v) => v >= 1.3 && v <= 1.5,
            None => true, // Assume compatible if not specified
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    #[ignore] // TODO: Fix binary XML parser - Kotlin-based parsing works, this is for future native support
    fn test_metadata_extraction() {
        // This test requires the test.apk file
        let apk_path = std::path::Path::new("testdata/test.apk");
        if apk_path.exists() {
            let metadata = MihonExtensionMetadata::from_apk(apk_path).unwrap();
            println!("Package: {}", metadata.package);
            println!(
                "Version: {} ({})",
                metadata.version_name, metadata.version_code
            );
            println!("Label: {}", metadata.label);
            println!("Entry class: {}", metadata.entry_class);
            println!("NSFW: {}", metadata.nsfw);
            println!("Lib version: {:?}", metadata.lib_version);
            println!("Compatible: {}", metadata.is_compatible());
        }
    }
}
