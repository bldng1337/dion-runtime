use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum EntryActivity {
    EpisodeActivity { progress: i32 },
}
