//! Persistent per-extension caches exposed to JS extensions through the
//! `cache` module.
//!
//! Every cache lives in its own directory under `<extension data dir>/cache/`
//! so caches are isolated per extension (the data dir is chosen by the host
//! and is private to the extension) and survive VM restarts. Each cache keeps
//! an `index.json` describing its entries (expiry, recency, size) and one
//! file per entry, named by a deterministic hash of the key.
//!
//! Two policies are exposed to JS:
//! - KV caches: optional per-cache default TTL, no capacity eviction.
//! - LRU caches: additionally evict the least recently used entries when
//!   `max_entries`/`max_bytes` is exceeded.

use std::{
    collections::HashMap,
    hash::{Hash, Hasher},
    path::{Path, PathBuf},
    sync::{Arc, Mutex},
    time::{Duration, SystemTime, UNIX_EPOCH},
};

use anyhow::{Result, anyhow, bail};
use serde::{Deserialize, Serialize};

const INDEX_FILE: &str = "index.json";
const ENTRIES_DIR: &str = "entries";
const INDEX_VERSION: u32 = 1;

/// Longest cache name / key we accept, keeping index.json bounded.
const MAX_NAME_LEN: usize = 64;
const MAX_KEY_LEN: usize = 1024;

#[derive(Debug, Clone, Copy, Default)]
pub struct CachePolicy {
    /// Applied when `set` is called without an explicit ttl.
    pub default_ttl: Option<Duration>,
    /// LRU limit by number of live entries.
    pub max_entries: Option<usize>,
    /// LRU limit by the summed on-disk size of live entries.
    pub max_bytes: Option<u64>,
}

#[derive(Debug, Clone)]
pub enum CacheValue {
    Json(serde_json::Value),
    Binary(Vec<u8>),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
struct CacheEntryMeta {
    hash: String,
    binary: bool,
    size: u64,
    /// Epoch milliseconds at which the entry becomes invalid.
    expires_at_ms: Option<u64>,
    /// Recency tick driving LRU eviction; strictly increasing per cache,
    /// so operation order decides ties even within one millisecond.
    last_access: u64,
}

#[derive(Debug, Serialize, Deserialize)]
struct IndexSnapshot {
    version: u32,
    entries: HashMap<String, CacheEntryMeta>,
}

/// Owns the cache root directory and hands out shared handles per cache name.
/// Opened twice with the same name, both handles share one index (the policy
/// of the latest `open` wins, it is re-applied on the next eviction pass).
#[derive(Debug)]
pub struct CacheManager {
    root: PathBuf,
    handles: Mutex<HashMap<String, Arc<CacheInner>>>,
}

impl CacheManager {
    /// `base_dir` is the extension's private data directory; caches are
    /// created below `<base_dir>/cache`.
    pub fn new(base_dir: PathBuf) -> Self {
        Self {
            root: base_dir.join("cache"),
            handles: Mutex::new(HashMap::new()),
        }
    }

    pub fn open(&self, name: &str, policy: CachePolicy) -> Result<Arc<CacheInner>> {
        validate_name(name)?;
        let mut handles = self
            .handles
            .lock()
            .map_err(|_| anyhow!("Cache handle registry lock is poisoned"))?;
        if let Some(existing) = handles.get(name) {
            *existing
                .policy
                .lock()
                .map_err(|_| anyhow!("Cache policy lock is poisoned"))? = policy;
            return Ok(existing.clone());
        }
        let inner = Arc::new(CacheInner {
            dir: self.root.join(name),
            policy: Mutex::new(policy),
            index: Mutex::new(None),
            clock: std::sync::atomic::AtomicU64::new(0),
        });
        handles.insert(name.to_string(), inner.clone());
        Ok(inner)
    }
}

#[derive(Debug)]
pub struct CacheInner {
    dir: PathBuf,
    policy: Mutex<CachePolicy>,
    /// Lazily loaded index; `None` until the first operation.
    index: Mutex<Option<HashMap<String, CacheEntryMeta>>>,
    /// Monotonic recency ticks (see `CacheEntryMeta::last_access`).
    clock: std::sync::atomic::AtomicU64,
}

impl CacheInner {
    pub async fn set(&self, key: &str, value: CacheValue, ttl: Option<Duration>) -> Result<()> {
        if ttl.is_some_and(|ttl| ttl.is_zero()) {
            bail!("cache ttl must be greater than zero");
        }
        validate_key(key)?;
        self.ensure_loaded().await?;

        let payload = match &value {
            CacheValue::Json(v) => serde_json::to_vec(v)?,
            CacheValue::Binary(bytes) => bytes.clone(),
        };
        write_atomic(&self.entry_path(key), &payload).await?;

        let now = now_ms();
        let expires_at = ttl
            .or(self.policy()?.default_ttl)
            .map(|d| now + duration_to_ms(d));
        let meta = CacheEntryMeta {
            hash: key_hash(key),
            binary: matches!(value, CacheValue::Binary(_)),
            size: payload.len() as u64,
            expires_at_ms: expires_at,
            last_access: self.next_tick(),
        };

        let (evictions, snapshot) = self.with_index(|index| {
            index.insert(key.to_string(), meta);
            let evictions = self.collect_evictions_locked(index, key);
            (evictions, snapshot_of(index))
        })?;
        self.write_index(&snapshot).await?;
        self.remove_entry_files(evictions).await;
        Ok(())
    }

    /// Returns the value for `key`, or `None` if missing or expired.
    /// With `update_recency` this is an LRU access (`peek` skips it).
    pub async fn get(&self, key: &str, update_recency: bool) -> Result<Option<CacheValue>> {
        validate_key(key)?;
        self.ensure_loaded().await?;

        let meta = self.with_index(|index| index.get(key).cloned())?;
        let Some(meta) = meta else {
            return Ok(None);
        };
        if is_expired(&meta) {
            self.delete(key).await?;
            return Ok(None);
        }
        let bytes = match tokio::fs::read(self.entry_path(key)).await {
            Ok(bytes) => bytes,
            // Index and file are out of sync (e.g. externally deleted):
            // treat the entry as absent instead of failing every access.
            Err(_) => {
                self.delete(key).await?;
                return Ok(None);
            }
        };
        let value = if meta.binary {
            CacheValue::Binary(bytes)
        } else {
            CacheValue::Json(serde_json::from_slice(&bytes)?)
        };
        if update_recency {
            let tick = self.next_tick();
            let snapshot = self.with_index(|index| {
                if let Some(meta) = index.get_mut(key) {
                    meta.last_access = tick;
                }
                snapshot_of(index)
            })?;
            self.write_index(&snapshot).await?;
        }
        Ok(Some(value))
    }

    /// Whether a live (non-expired) entry exists. Does not touch recency.
    pub async fn has(&self, key: &str) -> Result<bool> {
        validate_key(key)?;
        self.ensure_loaded().await?;
        let meta = self.with_index(|index| index.get(key).cloned())?;
        match meta {
            Some(meta) if !is_expired(&meta) => Ok(true),
            Some(_) => {
                self.delete(key).await?;
                Ok(false)
            }
            None => Ok(false),
        }
    }

    pub async fn delete(&self, key: &str) -> Result<()> {
        validate_key(key)?;
        self.ensure_loaded().await?;
        let removed = self.with_index(|index| index.remove(key))?;
        if let Some(meta) = removed {
            let snapshot = self.with_index(|index| snapshot_of(index))?;
            self.write_index(&snapshot).await?;
            delete_quietly(self.entries_dir().join(meta.hash)).await;
        }
        Ok(())
    }

    /// Live keys, purging expired entries on the way.
    pub async fn keys(&self) -> Result<Vec<String>> {
        self.purge_expired().await?;
        self.with_index(|index| index.keys().cloned().collect())
    }

    /// Number of live entries, purging expired entries on the way.
    pub async fn size(&self) -> Result<usize> {
        self.purge_expired().await?;
        self.with_index(|index| index.len())
    }

    pub async fn clear(&self) -> Result<()> {
        tokio::fs::remove_dir_all(&self.dir).await.ok();
        *self
            .index
            .lock()
            .map_err(|_| anyhow!("Cache index lock is poisoned"))? = None;
        self.ensure_dirs().await?;
        self.write_index(&IndexSnapshot {
            version: INDEX_VERSION,
            entries: HashMap::new(),
        })
        .await?;
        self.with_index(|index| *index = HashMap::new())?;
        Ok(())
    }

    /// Drops expired entries (files and index rows).
    async fn purge_expired(&self) -> Result<()> {
        self.ensure_loaded().await?;
        let expired: Vec<String> = self.with_index(|index| {
            index
                .iter()
                .filter(|(_, meta)| is_expired(meta))
                .map(|(key, _)| key.clone())
                .collect()
        })?;
        for key in expired {
            self.delete(&key).await?;
        }
        Ok(())
    }

    async fn ensure_loaded(&self) -> Result<()> {
        if self
            .index
            .lock()
            .map_err(|_| anyhow!("Cache index lock is poisoned"))?
            .is_some()
        {
            return Ok(());
        }
        self.ensure_dirs().await?;
        let snapshot: IndexSnapshot = match tokio::fs::read(self.dir.join(INDEX_FILE)).await {
            Ok(bytes) if bytes.is_empty() => IndexSnapshot::default(),
            Ok(bytes) => serde_json::from_slice(&bytes)
                .map_err(|e| anyhow!("Failed to parse cache index: {e}"))?,
            Err(_) => IndexSnapshot::default(),
        };
        *self
            .index
            .lock()
            .map_err(|_| anyhow!("Cache index lock is poisoned"))? = Some(snapshot.entries);
        Ok(())
    }

    async fn ensure_dirs(&self) -> Result<()> {
        tokio::fs::create_dir_all(self.entries_dir()).await?;
        Ok(())
    }

    /// Runs `f` on the loaded index. A `None` index (reached only when an
    /// operation skipped `ensure_loaded`, e.g. after `clear`) is treated as
    /// empty; single-threaded VM access means no interleaving in between.
    fn with_index<R>(
        &self,
        f: impl FnOnce(&mut HashMap<String, CacheEntryMeta>) -> R,
    ) -> Result<R> {
        let mut guard = self
            .index
            .lock()
            .map_err(|_| anyhow!("Cache index lock is poisoned"))?;
        Ok(f(guard.get_or_insert_with(HashMap::new)))
    }

    fn policy(&self) -> Result<CachePolicy> {
        let guard = self
            .policy
            .lock()
            .map_err(|_| anyhow!("Cache policy lock is poisoned"))?;
        Ok(*guard)
    }

    /// Next strictly-increasing recency tick; wall-clock nanoseconds,
    /// bumped past any previously handed-out tick so ties within one
    /// instant still follow operation order.
    fn next_tick(&self) -> u64 {
        use std::sync::atomic::Ordering;
        let now = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap_or_default()
            .as_nanos() as u64;
        loop {
            let current = self.clock.load(Ordering::Relaxed);
            let next = now.max(current.saturating_add(1));
            if self
                .clock
                .compare_exchange(current, next, Ordering::Relaxed, Ordering::Relaxed)
                .is_ok()
            {
                return next;
            }
        }
    }

    /// Removes entries over the configured limits, least recently used
    /// first, never evicting `keep`. Returns the evicted `(key, hash)` pairs.
    fn collect_evictions_locked(
        &self,
        index: &mut HashMap<String, CacheEntryMeta>,
        keep: &str,
    ) -> Vec<(String, String)> {
        let policy = self.policy().unwrap_or_default();
        let mut evicted = Vec::new();

        if let Some(max_entries) = policy.max_entries {
            while index.len() > max_entries {
                let victim = index
                    .iter()
                    .filter(|(key, _)| key.as_str() != keep)
                    .min_by_key(|(_, meta)| meta.last_access)
                    .map(|(key, meta)| (key.clone(), meta.hash.clone()));
                match victim {
                    Some((key, hash)) => {
                        index.remove(&key);
                        evicted.push((key, hash));
                    }
                    None => break,
                }
            }
        }
        if let Some(max_bytes) = policy.max_bytes {
            let total: u64 = index.values().map(|meta| meta.size).sum();
            if total > max_bytes {
                let mut order: Vec<(String, u64, u64)> = index
                    .iter()
                    .filter(|(key, _)| key.as_str() != keep)
                    .map(|(key, meta)| (key.clone(), meta.last_access, meta.size))
                    .collect();
                order.sort_by_key(|(_, access, _)| *access);
                let mut total = total;
                for (key, _, size) in order {
                    if total <= max_bytes {
                        break;
                    }
                    total -= size;
                    if let Some(meta) = index.remove(&key) {
                        evicted.push((key, meta.hash));
                    }
                }
            }
        }
        evicted
    }

    async fn remove_entry_files(&self, entries: Vec<(String, String)>) {
        for (_, hash) in entries {
            delete_quietly(self.entries_dir().join(hash)).await;
        }
    }

    async fn write_index(&self, snapshot: &IndexSnapshot) -> Result<()> {
        let bytes = serde_json::to_vec(snapshot)?;
        write_atomic(&self.dir.join(INDEX_FILE), &bytes).await
    }

    fn entries_dir(&self) -> PathBuf {
        self.dir.join(ENTRIES_DIR)
    }

    fn entry_path(&self, key: &str) -> PathBuf {
        self.entries_dir().join(key_hash(key))
    }
}

impl Default for IndexSnapshot {
    fn default() -> Self {
        Self {
            version: INDEX_VERSION,
            entries: HashMap::new(),
        }
    }
}

fn snapshot_of(index: &HashMap<String, CacheEntryMeta>) -> IndexSnapshot {
    IndexSnapshot {
        version: INDEX_VERSION,
        entries: index.clone(),
    }
}

fn is_expired(meta: &CacheEntryMeta) -> bool {
    meta.expires_at_ms
        .is_some_and(|expires_at| now_ms() >= expires_at)
}

fn validate_name(name: &str) -> Result<()> {
    if name.is_empty()
        || name.len() > MAX_NAME_LEN
        || name == "."
        || name == ".."
        || !name
            .chars()
            .all(|c| c.is_ascii_alphanumeric() || matches!(c, '.' | '-' | '_'))
    {
        bail!("cache name must be 1-{MAX_NAME_LEN} characters of [A-Za-z0-9._-]");
    }
    Ok(())
}

fn validate_key(key: &str) -> Result<()> {
    if key.is_empty() || key.len() > MAX_KEY_LEN {
        bail!("cache key must be 1-{MAX_KEY_LEN} bytes");
    }
    Ok(())
}

/// Deterministic across runs (fixed-key SipHash), so entries survive VM
/// restarts. Collisions only matter within a single cache directory.
fn key_hash(key: &str) -> String {
    let mut hasher = std::collections::hash_map::DefaultHasher::new();
    key.hash(&mut hasher);
    format!("{:016x}", hasher.finish())
}

fn now_ms() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis() as u64
}

fn duration_to_ms(duration: Duration) -> u64 {
    // Round sub-millisecond TTLs up so they still expire.
    duration.as_millis().max(1) as u64
}

async fn write_atomic(path: &Path, bytes: &[u8]) -> Result<()> {
    let tmp = path.with_extension("tmp");
    tokio::fs::write(&tmp, bytes).await?;
    if let Err(first) = tokio::fs::rename(&tmp, path).await {
        // Renaming over an existing file can fail; fall back to
        // remove + rename.
        tokio::fs::remove_file(path).await.ok();
        tokio::fs::rename(&tmp, path).await.map_err(|second| {
            anyhow!(
                "Failed to store cache file {}: {first} / {second}",
                tmp.display()
            )
        })?;
    }
    Ok(())
}

async fn delete_quietly(path: PathBuf) {
    tokio::fs::remove_file(&path).await.ok();
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::atomic::{AtomicU64, Ordering};

    struct TempDir(PathBuf);
    impl Drop for TempDir {
        fn drop(&mut self) {
            std::fs::remove_dir_all(&self.0).ok();
        }
    }

    static COUNTER: AtomicU64 = AtomicU64::new(0);

    fn temp_dir() -> TempDir {
        let dir = std::env::temp_dir().join(format!(
            "dion-cache-test-{}-{}",
            std::process::id(),
            COUNTER.fetch_add(1, Ordering::Relaxed)
        ));
        std::fs::create_dir_all(&dir).unwrap();
        TempDir(dir)
    }

    fn json(value: &str) -> CacheValue {
        CacheValue::Json(serde_json::from_str(value).unwrap())
    }

    #[tokio::test]
    async fn kv_set_get_delete() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager.open("kv", CachePolicy::default()).unwrap();

        assert!(cache.get("missing", true).await.unwrap().is_none());
        cache.set("a", json(r#"{"x":1}"#), None).await.unwrap();
        match cache.get("a", true).await.unwrap().unwrap() {
            CacheValue::Json(v) => assert_eq!(v, serde_json::json!({"x": 1})),
            other => panic!("expected json, got {other:?}"),
        }
        assert!(cache.has("a").await.unwrap());
        assert_eq!(cache.size().await.unwrap(), 1);
        assert_eq!(cache.keys().await.unwrap(), vec!["a".to_string()]);

        cache.delete("a").await.unwrap();
        assert!(cache.get("a", true).await.unwrap().is_none());
        assert_eq!(cache.size().await.unwrap(), 0);
    }

    #[tokio::test]
    async fn ttl_expires() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager
            .open(
                "ttl",
                CachePolicy {
                    default_ttl: Some(Duration::from_millis(40)),
                    ..Default::default()
                },
            )
            .unwrap();

        cache.set("gone", json("1"), None).await.unwrap();
        cache
            .set("stay", json("2"), Some(Duration::from_secs(60)))
            .await
            .unwrap();
        cache
            .set("quick", json("3"), Some(Duration::from_millis(1)))
            .await
            .unwrap();
        tokio::time::sleep(Duration::from_millis(60)).await;

        assert!(cache.get("gone", true).await.unwrap().is_none());
        assert!(!cache.has("gone").await.unwrap());
        assert!(cache.get("quick", true).await.unwrap().is_none());
        assert!(cache.get("stay", true).await.unwrap().is_some());
        assert_eq!(cache.keys().await.unwrap(), vec!["stay".to_string()]);
    }

    #[tokio::test]
    async fn lru_evicts_by_entries() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager
            .open(
                "lru",
                CachePolicy {
                    max_entries: Some(2),
                    ..Default::default()
                },
            )
            .unwrap();

        cache.set("a", json("1"), None).await.unwrap();
        cache.set("b", json("2"), None).await.unwrap();
        cache.set("c", json("3"), None).await.unwrap();
        assert!(!cache.has("a").await.unwrap(), "oldest evicted");
        assert!(cache.has("b").await.unwrap());
        assert!(cache.has("c").await.unwrap());

        // Access b so c becomes the least recently used entry.
        cache.get("b", true).await.unwrap();
        cache.set("d", json("4"), None).await.unwrap();
        assert!(!cache.has("c").await.unwrap(), "lru order honored");
        assert!(cache.has("b").await.unwrap());
        assert!(cache.has("d").await.unwrap());
    }

    #[tokio::test]
    async fn peek_does_not_update_recency() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager
            .open(
                "peek",
                CachePolicy {
                    max_entries: Some(2),
                    ..Default::default()
                },
            )
            .unwrap();

        cache.set("a", json("1"), None).await.unwrap();
        cache.set("b", json("2"), None).await.unwrap();
        cache.get("a", false).await.unwrap();
        cache.set("c", json("3"), None).await.unwrap();
        assert!(
            !cache.has("a").await.unwrap(),
            "peek must not refresh recency"
        );
    }

    #[tokio::test]
    async fn lru_evicts_by_bytes() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager
            .open(
                "bytes",
                CachePolicy {
                    max_bytes: Some(2),
                    ..Default::default()
                },
            )
            .unwrap();

        cache
            .set("big1", CacheValue::Binary(vec![0u8; 2]), None)
            .await
            .unwrap();
        // big1 (2 bytes) + big2 (2 bytes) > 2 → big1 evicted.
        cache
            .set("big2", CacheValue::Binary(vec![0u8; 2]), None)
            .await
            .unwrap();
        assert!(!cache.has("big1").await.unwrap());
        assert!(cache.has("big2").await.unwrap());
    }

    #[tokio::test]
    async fn persists_across_reopen() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        manager
            .open("persist", CachePolicy::default())
            .unwrap()
            .set("k", json(r#""hello""#), None)
            .await
            .unwrap();

        // A fresh manager (as after a VM restart) sees the same entry.
        let manager2 = CacheManager::new(tmp.0.clone());
        let cache = manager2.open("persist", CachePolicy::default()).unwrap();
        match cache.get("k", true).await.unwrap().unwrap() {
            CacheValue::Json(v) => assert_eq!(v, serde_json::json!("hello")),
            other => panic!("expected json, got {other:?}"),
        }
    }

    #[tokio::test]
    async fn shared_handle_between_opens() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let a = manager.open("shared", CachePolicy::default()).unwrap();
        a.set("k", json("1"), None).await.unwrap();
        let b = manager.open("shared", CachePolicy::default()).unwrap();
        assert!(b.get("k", true).await.unwrap().is_some());
    }

    #[tokio::test]
    async fn binary_roundtrip() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager.open("bin", CachePolicy::default()).unwrap();
        let bytes = vec![0u8, 1, 2, 255, 254, 0, 128];
        cache
            .set("blob", CacheValue::Binary(bytes.clone()), None)
            .await
            .unwrap();
        match cache.get("blob", true).await.unwrap().unwrap() {
            CacheValue::Binary(got) => assert_eq!(got, bytes),
            other => panic!("expected binary, got {other:?}"),
        }
    }

    #[tokio::test]
    async fn clear_removes_everything() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        let cache = manager.open("clear", CachePolicy::default()).unwrap();
        cache.set("a", json("1"), None).await.unwrap();
        cache.set("b", json("2"), None).await.unwrap();
        cache.clear().await.unwrap();
        assert_eq!(cache.size().await.unwrap(), 0);
        assert!(cache.get("a", true).await.unwrap().is_none());
        cache.set("c", json("3"), None).await.unwrap();
        assert!(cache.get("c", true).await.unwrap().is_some());
    }

    #[tokio::test]
    async fn rejects_invalid_names_keys_and_ttl() {
        let tmp = temp_dir();
        let manager = CacheManager::new(tmp.0.clone());
        assert!(manager.open("sub/dir", CachePolicy::default()).is_err());
        assert!(manager.open("", CachePolicy::default()).is_err());
        assert!(manager.open("..", CachePolicy::default()).is_err());

        let cache = manager.open("valid", CachePolicy::default()).unwrap();
        assert!(cache.set("", json("1"), None).await.is_err());
        assert!(cache.set(&"k".repeat(1025), json("1"), None).await.is_err());
        assert!(
            cache
                .set("k", json("1"), Some(Duration::ZERO))
                .await
                .is_err()
        );
    }
}
