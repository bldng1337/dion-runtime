use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::{
    action::Interaction,
    settings::SettingKind,
    source::{Entry, Link, TextStyle},
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
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EdgeInsets {
    #[cfg_attr(feature = "type", specta(optional))]
    pub left: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub top: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub right: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub bottom: Option<f32>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ColorToken {
    #[default]
    Primary,
    OnPrimary,
    PrimaryContainer,
    OnPrimaryContainer,
    Secondary,
    OnSecondary,
    Surface,
    OnSurface,
    SurfaceContainer,
    SurfaceContainerHighest,
    Error,
    OnError,
    Disabled,
    Shadow,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ContainerType {
    #[default]
    Ghost,
    Filled,
    Outlined,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ButtonType {
    #[default]
    Filled,
    Ghost,
    Elevated,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum MainAxisAlignment {
    #[default]
    Start,
    Center,
    End,
    SpaceBetween,
    SpaceAround,
    SpaceEvenly,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum CrossAxisAlignment {
    #[default]
    Start,
    Center,
    End,
    Stretch,
    Baseline,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum MainAxisSize {
    #[default]
    Min,
    Max,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum WrapAlignment {
    #[default]
    Start,
    Center,
    End,
    SpaceBetween,
    SpaceAround,
    SpaceEvenly,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum StackFit {
    #[default]
    Loose,
    Expand,
    Passthrough,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum Alignment {
    #[default]
    Center,
    TopLeft,
    TopCenter,
    TopRight,
    CenterLeft,
    CenterRight,
    BottomLeft,
    BottomCenter,
    BottomRight,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct DropdownItem {
    pub value: String,
    pub label: String,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum CustomUI {
    Text {
        text: String,
        #[cfg_attr(feature = "type", specta(optional))]
        style: Option<TextStyle>,
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
        #[cfg_attr(feature = "type", specta(optional))]
        on_click: Option<Box<Interaction>>,
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
        #[cfg_attr(feature = "type", specta(optional))]
        button_type: Option<ButtonType>,
        #[cfg_attr(feature = "type", specta(optional))]
        color: Option<ColorToken>,
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
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        main_axis_alignment: Option<MainAxisAlignment>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        cross_axis_alignment: Option<CrossAxisAlignment>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        main_axis_size: Option<MainAxisSize>,
        #[serde(default = "default_true")]
        scrollable: bool,
    },
    Row {
        children: Vec<CustomUI>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        main_axis_alignment: Option<MainAxisAlignment>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        cross_axis_alignment: Option<CrossAxisAlignment>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        main_axis_size: Option<MainAxisSize>,
        #[serde(default = "default_true")]
        scrollable: bool,
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
    // --- Layout primitives ---
    Padding {
        padding: EdgeInsets,
        child: Box<CustomUI>,
    },
    Container {
        child: Box<CustomUI>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        container_type: Option<ContainerType>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        color: Option<ColorToken>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        border_color: Option<ColorToken>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        padding: Option<EdgeInsets>,
        #[cfg_attr(feature = "type", specta(optional))]
        width: Option<f32>,
        #[cfg_attr(feature = "type", specta(optional))]
        height: Option<f32>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        alignment: Option<Alignment>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        emphasized: Option<bool>,
    },
    Clickable {
        child: Box<CustomUI>,
        #[cfg_attr(feature = "type", specta(optional))]
        on_click: Option<Box<Interaction>>,
        #[cfg_attr(feature = "type", specta(optional))]
        on_long_click: Option<Box<Interaction>>,
    },
    Expanded {
        child: Box<CustomUI>,
        #[serde(default = "default_one_i32")]
        flex: i32,
    },
    SizedBox {
        #[cfg_attr(feature = "type", specta(optional))]
        width: Option<f32>,
        #[cfg_attr(feature = "type", specta(optional))]
        height: Option<f32>,
        #[cfg_attr(feature = "type", specta(optional))]
        child: Option<Box<CustomUI>>,
    },
    Spacer {
        #[serde(default = "default_one_i32")]
        flex: i32,
    },
    Wrap {
        children: Vec<CustomUI>,
        #[cfg_attr(feature = "type", specta(optional))]
        spacing: Option<f32>,
        #[cfg_attr(feature = "type", specta(optional))]
        run_spacing: Option<f32>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        alignment: Option<WrapAlignment>,
    },
    Center {
        child: Box<CustomUI>,
    },
    Align {
        alignment: Alignment,
        child: Box<CustomUI>,
    },
    Stack {
        children: Vec<CustomUI>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        alignment: Option<Alignment>,
        #[serde(default)]
        #[cfg_attr(feature = "type", specta(optional))]
        fit: Option<StackFit>,
    },
    Divider,
    // --- Dion-themed container widgets ---
    ListTile {
        #[cfg_attr(feature = "type", specta(optional))]
        leading: Option<Box<CustomUI>>,
        #[cfg_attr(feature = "type", specta(optional))]
        title: Option<Box<CustomUI>>,
        #[cfg_attr(feature = "type", specta(optional))]
        subtitle: Option<Box<CustomUI>>,
        #[cfg_attr(feature = "type", specta(optional))]
        trailing: Option<Box<CustomUI>>,
        #[cfg_attr(feature = "type", specta(optional))]
        on_click: Option<Box<Interaction>>,
        #[cfg_attr(feature = "type", specta(optional))]
        on_long_click: Option<Box<Interaction>>,
    },
    Badge {
        child: Box<CustomUI>,
        #[cfg_attr(feature = "type", specta(optional))]
        color: Option<ColorToken>,
    },
    // --- Display primitives ---
    FoldableText {
        text: String,
        #[serde(default = "default_three_i32")]
        max_lines: i32,
        #[cfg_attr(feature = "type", specta(optional))]
        style: Option<TextStyle>,
        #[serde(default = "default_true")]
        animate: bool,
    },
    StarDisplay {
        // 0.0 - 1.0 fraction of stars filled.
        fill: f32,
        #[serde(default = "default_five_i32")]
        max_stars: i32,
    },
    Dropdown {
        items: Vec<DropdownItem>,
        #[cfg_attr(feature = "type", specta(optional))]
        initial_value: Option<String>,
        #[cfg_attr(feature = "type", specta(optional))]
        on_change: Option<Box<Interaction>>,
    },
}

fn default_true() -> bool {
    true
}

fn default_one_i32() -> i32 {
    1
}

fn default_three_i32() -> i32 {
    3
}

fn default_five_i32() -> i32 {
    5
}
