use std::collections::HashMap;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::{custom_ui::CustomUI, settings::SettingValue, source::EntryDetailed};

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
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ToastKind {
    #[default]
    Info,
    Success,
    Warning,
    Error,
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
    // Navigates to a new view with the given entry.
    NavEntry {
        entry: Box<EntryDetailed>,
    },
    // Shows a transient toast message.
    ShowToast {
        message: String,
        kind: ToastKind,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Interaction {
    Invoke { handler: String, payload: String },
    WriteKey { key: String, value: String },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum SlotValue {
    Setting { value: SettingValue },
    Store { key: String, value: String },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum EventData {
    LoadSlot {
        handler: String,
        static_data: String,
        values: HashMap<String, SlotValue>,
    },
    LoadPage {
        handler: String,
        data: String,
        page: i32,
    },
    Invoke {
        handler: String,
        payload: String,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum EventResult {
    SlotContent {
        customui: CustomUI,
    },
    FeedPage {
        items: Vec<CustomUI>,
        has_more: bool,
    },
}
