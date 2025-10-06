use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::{
    action::UIAction,
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
    TimeStamp {
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
    Feed {
        event: String,
        data: String,
    },
    Button {
        label: String,
        #[cfg_attr(feature = "type", specta(optional))]
        on_click: Option<Box<UIAction>>,
    },
    InlineSetting {
        setting_id: String,
        setting_kind: SettingKind,
        #[cfg_attr(feature = "type", specta(optional))]
        on_commit: Option<Box<UIAction>>,
    },
    Slot {
        id: String,
        child: Box<CustomUI>,
    },
    Column {
        children: Vec<CustomUI>,
    },
    Row {
        children: Vec<CustomUI>,
    },
}
