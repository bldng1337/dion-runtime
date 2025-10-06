use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::{custom_ui::CustomUI, source::EntryDetailed};

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct PopupAction {
    pub label: String,
    pub onclick: Box<Action>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Action {
    OpenBrowser {
        url: String,
    },
    Popup {
        title: String,
        content: CustomUI,
        actions: Vec<PopupAction>,
    },
    Nav {
        title: String,
        content: CustomUI,
    },
    TriggerEvent {
        event: String,
        data: String,
    },
    NavEntry {
        entry: EntryDetailed,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum UIAction {
    Action {
        action: Action,
    },
    SwapContent {
        targetid: String,
        event: String,
        data: String,
        #[cfg_attr(feature = "type", specta(optional))]
        placeholder: Option<CustomUI>,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum EventData {
    SwapContent {
        event: String,
        targetid: String,
        data: String,
    },
    FeedUpdate {
        event: String,
        data: String,
        page: i32,
    },
    Action {
        event: String,
        data: String,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum EventResult {
    SwapContent {
        customui: CustomUI,
    },
    FeedUpdate {
        customui: Vec<CustomUI>,
        #[cfg_attr(feature = "type", specta(optional))]
        hasnext: Option<bool>,
        #[cfg_attr(feature = "type", specta(optional))]
        length: Option<i32>,
    },
}
