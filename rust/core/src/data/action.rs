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
    // Opens the given URL in a browser or webview.
    OpenBrowser {
        url: String,
    },
    // Opens a popup with the given title, content, and actions.
    Popup {
        title: String,
        content: Box<CustomUI>,
        actions: Vec<PopupAction>,
    },
    // Navigates to a new view with the given title and content.
    Nav {
        title: String,
        content: Box<CustomUI>,
    },
    // Pops the current view and returns to the previous one
    PopView,
    // Triggers an event with the given name and data.
    TriggerEvent {
        event: String,
        data: String,
    },
    // Navigates to a new view with the given entry.
    NavEntry {
        entry: Box<EntryDetailed>,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum UIAction {
    Action {
        action: Box<Action>,
    },
    // Swaps the content of a Slot element with the given target ID, event name, and data.
    SwapContent {
        targetid: String,
        event: String,
        data: String,
        #[cfg_attr(feature = "type", specta(optional))]
        placeholder: Option<Box<CustomUI>>,
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
    Trigger {
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
    DoAction {
        action: Box<Action>,
    },
    Return,
}
