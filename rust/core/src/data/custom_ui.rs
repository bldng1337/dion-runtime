use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::{
    action::Interaction,
    settings::SettingKind,
    source::{Entry, Link},
};

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum TimestampType {
    #[default]
    Relative,
    Absolute,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
pub enum SubscriptionSource {
    Store,
    Setting { kind: SettingKind },
    EntrySetting,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Subscription {
    pub source: SubscriptionSource,
    // Key to subscribe to.
    pub key: String,
    // Which field of the handler's state this value maps to.
    pub state_key: String,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum CustomUI {
    Text {
        text: String,
    },
    Image {
        image: Link,
        #[cfg_attr(feature = "type", specta(optional))]
        width: Option<i32>,
        #[cfg_attr(feature = "type", specta(optional))]
        height: Option<i32>,
    },
    Link {
        link: String,
        #[cfg_attr(feature = "type", specta(optional))]
        label: Option<String>,
    },
    Timestamp {
        timestamp: String,
        #[serde(default)]
        display: TimestampType,
    },
    EntryCard {
        entry: Entry,
    },
    Card {
        image: Link,
        top: Box<CustomUI>,
        bottom: Box<CustomUI>,
    },
    Spinner,
    Feed {
        handler: String,
        data: String,
    },
    Button {
        label: String,
        #[cfg_attr(feature = "type", specta(optional))]
        on_click: Option<Box<Interaction>>,
    },
    InlineSetting {
        setting_id: String,
        setting_kind: SettingKind,
        #[cfg_attr(feature = "type", specta(optional))]
        on_commit: Option<Box<Interaction>>,
    },
    Slot {
        handler: String,
        child: Box<CustomUI>,
        // JSON blob of fields captured at build time (entryId, mediaType, ...).
        static_data: String,
        subscriptions: Vec<Subscription>,
    },
    Column {
        children: Vec<CustomUI>,
    },
    Row {
        children: Vec<CustomUI>,
    },
    TextInput {
        #[cfg_attr(feature = "type", specta(optional))]
        on_change: Option<Box<Interaction>>,
        #[cfg_attr(feature = "type", specta(optional))]
        debounce_ms: Option<i32>,
        #[cfg_attr(feature = "type", specta(optional))]
        initial: Option<String>,
        #[cfg_attr(feature = "type", specta(optional))]
        on_commit: Option<Box<Interaction>>,
    },
}
