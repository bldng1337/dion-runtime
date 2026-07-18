use std::collections::HashMap;

use serde_json::Value;
use tokio::sync::RwLock;

#[derive(Debug, Default)]
pub struct SignalStore {
    inner: RwLock<HashMap<String, Value>>,
}

impl SignalStore {
    pub fn new() -> Self {
        Self::default()
    }

    pub async fn write(&self, key: String, value: Value) -> Option<Value> {
        self.inner.write().await.insert(key, value)
    }

    #[allow(dead_code)]
    pub async fn get(&self, key: &str) -> Option<Value> {
        self.inner.read().await.get(key).cloned()
    }

    #[allow(dead_code)]
    pub async fn snapshot(&self) -> HashMap<String, Value> {
        self.inner.read().await.clone()
    }
}
