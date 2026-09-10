//! Filesystem access for JS extensions through the `filesystem` module.
//!
//! All access is permission-gated: an extension may freely use its own
//! private data directory (the host-chosen `get_path()` location), and any
//! path outside it requires a granted `Permission::Storage` covering the
//! path (read or write). When access is missing the runtime prompts through
//! the host client once per directory root, so a single approval unlocks a
//! whole directory tree — this matches the directory-picker setting flow
//! (`SettingsUI::Directory`): the user picks a directory, the extension then
//! accesses files below it after one prompt (or after the host grants the
//! storage permission itself).
//!
//! Paths are lexically normalized and, when they already exist, resolved
//! through `canonicalize`, so `..` segments and symlinks cannot escape a
//! granted root. Windows verbatim (`\\?\`) prefixes produced by
//! `canonicalize` are stripped before comparisons.

use std::path::{MAIN_SEPARATOR, Path, PathBuf};
use std::sync::Arc;

use anyhow::{Result, bail};

use crate::extension::container::InnerExtension;
use dion_runtime::data::permission::Permission;
use dion_runtime::store::permission::PermissionStore;

/// Lexically normalizes a user/JS supplied path: resolves `.` and `..`
/// without touching the filesystem, collapses duplicate separators, and
/// strips Windows extended-length (`\\?\`, `\\.\`, `\\?\UNC\`) prefixes.
/// Absolute paths stay absolute; relative paths stay relative (with `..`
/// retained at their front).
pub(crate) fn normalize_path(input: &str) -> PathBuf {
    let trimmed = input.trim();
    if trimmed.is_empty() {
        return PathBuf::new();
    }

    let stripped = strip_extended_prefix(trimmed);
    let is_sep = |c: char| c == '/' || c == '\\';
    let chars: Vec<char> = stripped.chars().collect();
    let mut idx = 0usize;
    let mut prefix = String::new();
    let mut absolute = false;

    if chars.len() >= 2 && chars[1] == ':' && chars[0].is_ascii_alphabetic() {
        // Drive letter; drive-relative paths (C:foo) are treated as rooted
        // (C:\foo) so checks and the actual operation always agree.
        prefix.push(chars[0].to_ascii_uppercase());
        prefix.push(':');
        idx = 2;
        absolute = true;
    } else if chars.len() >= 2 && is_sep(chars[0]) && is_sep(chars[1]) {
        // UNC \\server\share — kept as a verbatim-style prefix.
        idx = 2;
        let server = take_component(&chars, &mut idx, is_sep);
        let Some(server) = server else {
            return PathBuf::from(stripped);
        };
        let share = take_component(&chars, &mut idx, is_sep);
        let Some(share) = share else {
            return PathBuf::from(stripped);
        };
        prefix = format!("\\\\{server}\\{share}");
        absolute = true;
    } else if !chars.is_empty() && is_sep(chars[0]) {
        absolute = true;
    }

    let mut components: Vec<String> = Vec::new();
    while let Some(component) = take_component(&chars, &mut idx, is_sep) {
        match component.as_str() {
            "." => {}
            ".." => match components.last() {
                Some(last) if last != ".." => {
                    components.pop();
                }
                _ if !absolute => components.push("..".to_string()),
                _ => {}
            },
            _ => components.push(component),
        }
    }

    let mut out = prefix;
    if absolute && out.is_empty() {
        out.push(MAIN_SEPARATOR);
    }
    if !components.is_empty() {
        if !out.is_empty() && !out.ends_with(MAIN_SEPARATOR) {
            out.push(MAIN_SEPARATOR);
        }
        out.push_str(&components.join(std::path::MAIN_SEPARATOR_STR));
    }
    if out.is_empty() {
        out.push('.');
    }
    PathBuf::from(out)
}

fn take_component(
    chars: &[char],
    idx: &mut usize,
    is_sep: impl Fn(char) -> bool,
) -> Option<String> {
    while *idx < chars.len() && is_sep(chars[*idx]) {
        *idx += 1;
    }
    let start = *idx;
    while *idx < chars.len() && !is_sep(chars[*idx]) {
        *idx += 1;
    }
    if start == *idx {
        None
    } else {
        Some(chars[start..*idx].iter().collect())
    }
}

fn strip_extended_prefix(input: &str) -> String {
    if let Some(rest) = input.strip_prefix(r"\\?\UNC\") {
        return format!(r"\\{rest}");
    }
    if let Some(rest) = input.strip_prefix(r"\\?\") {
        return rest.to_string();
    }
    if let Some(rest) = input.strip_prefix(r"\\.\") {
        return rest.to_string();
    }
    input.to_string()
}

/// Removes the `\\?\` prefix that `canonicalize` produces on Windows so the
/// result is comparable with (and presentable as) user-facing paths.
pub(crate) fn strip_verbatim(path: PathBuf) -> PathBuf {
    #[cfg(windows)]
    {
        let text = path.as_os_str().to_string_lossy();
        if let Some(rest) = text.strip_prefix(r"\\?\UNC\") {
            return PathBuf::from(format!(r"\\{rest}"));
        }
        if let Some(rest) = text.strip_prefix(r"\\?\") {
            return PathBuf::from(rest);
        }
    }
    path
}

/// Whether `child` is `base` itself or below it.
pub(crate) fn is_under(child: &Path, base: &Path) -> bool {
    child.starts_with(base)
}

/// Resolves a normalized target for an access check: when the target (or its
/// nearest existing ancestor) can be canonicalized, symlinks are resolved so
/// they cannot point outside a granted root; otherwise the lexical form is
/// used.
pub(crate) async fn resolve_for_access(target: &Path) -> PathBuf {
    if let Ok(canon) = tokio::fs::canonicalize(target).await {
        return strip_verbatim(canon);
    }
    if let (Some(parent), Some(name)) = (target.parent(), target.file_name())
        && let Ok(canon_parent) = tokio::fs::canonicalize(parent).await
    {
        return strip_verbatim(canon_parent).join(name);
    }
    target.to_path_buf()
}

/// Validates a raw JS path and returns its normalized form.
pub(crate) fn prepare_path(raw: &str) -> Result<PathBuf> {
    if raw.trim().starts_with("content://") {
        bail!(
            "content:// URIs are not supported by the filesystem module; \
             use a filesystem path (the host's directory picker can \
             provide one)"
        );
    }
    let normalized = normalize_path(raw);
    if normalized.as_os_str().is_empty() || normalized == Path::new(".") {
        bail!("path must not be empty");
    }
    Ok(normalized)
}

/// Checks (and if needed prompts for) storage access to `raw_path` and
/// returns the resolved path the operation should use.
///
/// `write` selects read vs write permission. `dir_target` marks operations
/// whose target is a directory itself (readDir/createDir/removeDir): they
/// request the directory; file operations request the containing directory,
/// so one approval covers a whole tree.
pub(crate) async fn ensure_access(
    ext: &Arc<InnerExtension>,
    raw_path: &str,
    write: bool,
    dir_target: bool,
    action: &str,
) -> Result<PathBuf> {
    let normalized = prepare_path(raw_path)?;
    let resolved = resolve_for_access(&normalized).await;

    if is_under(&resolved, &ext.data_dir) {
        return Ok(resolved);
    }

    let permission_root = if dir_target {
        resolved.clone()
    } else {
        resolved
            .parent()
            .map(|p| p.to_path_buf())
            .unwrap_or_else(|| resolved.clone())
    };
    let permission = Permission::Storage {
        path: permission_root.to_string_lossy().into_owned(),
        write,
    };

    let granted = ext
        .store
        .read()
        .await
        .permission
        .has_permission(&permission);
    if granted {
        return Ok(resolved);
    }

    // Prompt WITHOUT holding the store lock: the host prompt may re-enter
    // the runtime and would deadlock on the RwLock.
    let ext_name = ext.store.read().await.data.name.clone();
    let message = format!(
        "Extension \"{ext_name}\" wants to {action} {}",
        resolved.to_string_lossy()
    );
    let granted = ext
        .client
        .request_permission(&permission, Some(message))
        .await?;
    if !granted {
        bail!(
            "Storage permission for {} was denied",
            resolved.to_string_lossy()
        );
    }
    {
        let mut store = ext.store.write().await;
        store.permission.grant(permission);
    }
    let snapshot = ext.store.read().await.permission.get_permissions().clone();
    if let Err(err) = PermissionStore::persist(&snapshot, ext.client.as_ref()).await {
        log::warn!("Failed to persist granted permissions: {err:?}");
    }
    Ok(resolved)
}

/// Joins path fragments (as the JS `joinPaths` helper) and normalizes the
/// result.
pub(crate) fn join_paths(parts: &[String]) -> Result<String> {
    let mut combined = PathBuf::new();
    for part in parts {
        if part.trim().is_empty() {
            continue;
        }
        combined.push(part.trim());
    }
    let normalized = normalize_path(&combined.to_string_lossy());
    if normalized.as_os_str().is_empty() {
        bail!("joinPaths requires at least one non-empty part");
    }
    Ok(normalized.to_string_lossy().into_owned())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn norm(input: &str) -> String {
        normalize_path(input).to_string_lossy().into_owned()
    }

    #[test]
    fn normalizes_dot_and_dotdot() {
        let sep = MAIN_SEPARATOR;
        assert_eq!(norm("/a/b/../c"), format!("{sep}a{sep}c"));
        assert_eq!(norm("/a/./b"), format!("{sep}a{sep}b"));
        assert_eq!(norm("/a//b///c"), format!("{sep}a{sep}b{sep}c"));
        assert_eq!(norm("/../a"), format!("{sep}a"));
        assert_eq!(norm("a/../.."), "..");
        assert_eq!(norm(""), "");
    }

    #[test]
    fn normalizes_windows_prefixes() {
        let sep = MAIN_SEPARATOR;
        assert_eq!(norm(r"C:\a\..\b"), format!("C:{sep}b"));
        assert_eq!(norm(r"\\?\C:\a\b"), format!("C:{sep}a{sep}b"));
        assert_eq!(norm(r"C:/a/b"), format!("C:{sep}a{sep}b"));
    }

    #[test]
    fn is_under_checks() {
        let base = normalize_path("/data/ext");
        assert!(is_under(&normalize_path("/data/ext/sub/file.txt"), &base));
        assert!(is_under(&normalize_path("/data/ext"), &base));
        assert!(!is_under(&normalize_path("/data/ext-other/file"), &base));
        assert!(!is_under(&normalize_path("/data"), &base));
    }

    #[test]
    fn content_uri_rejected() {
        assert!(prepare_path("content://com.android/tree").is_err());
        assert!(prepare_path("").is_err());
        assert!(prepare_path("  ").is_err());
    }

    #[cfg(unix)]
    #[tokio::test]
    async fn resolve_follows_symlinks() {
        let base = std::env::temp_dir().join(format!("dion-fs-test-{}", std::process::id()));
        std::fs::create_dir_all(base.join("inside")).unwrap();
        std::fs::create_dir_all(base.join("outside")).unwrap();
        std::os::unix::fs::symlink(base.join("outside"), base.join("inside/link")).unwrap();
        std::fs::write(base.join("outside/secret.txt"), b"x").unwrap();

        let resolved = resolve_for_access(&base.join("inside/link/secret.txt")).await;
        assert!(resolved.starts_with(base.join("outside")));
        std::fs::remove_dir_all(&base).ok();
    }

    #[tokio::test]
    async fn resolve_missing_file_uses_parent() {
        let base = std::env::temp_dir().join(format!("dion-fs-test-parent-{}", std::process::id()));
        std::fs::create_dir_all(&base).unwrap();
        let canonical_parent = strip_verbatim(tokio::fs::canonicalize(&base).await.unwrap());
        let resolved = resolve_for_access(&base.join("new.txt")).await;
        assert_eq!(resolved, canonical_parent.join("new.txt"));
        std::fs::remove_dir_all(&base).ok();
    }

    #[test]
    fn join_paths_works() {
        let joined = join_paths(&[
            "/a/b".to_string(),
            "c".to_string(),
            "..".to_string(),
            "d".to_string(),
        ])
        .unwrap();
        let sep = MAIN_SEPARATOR;
        assert_eq!(joined, format!("{sep}a{sep}b{sep}d"));
        assert!(join_paths(&[" ".to_string()]).is_err());
    }

    #[test]
    fn strip_verbatim_is_identity_off_windows() {
        let path = PathBuf::from("/a/b");
        assert_eq!(strip_verbatim(path.clone()), path);
    }
}
