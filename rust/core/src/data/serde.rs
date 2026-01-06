#[cfg(test)]
mod test {
    use std::collections::{HashMap, HashSet};

    use crate::data::{
        action::{Action, EventData, EventResult, PopupAction, UIAction},
        activity::EntryActivity,
        auth::{Account, AuthCreds, AuthData},
        custom_ui::{CustomUI, TimestampType},
        extension::{ExtensionData, ExtensionType, SourceOpenType},
        extension_manager::ExtensionManagerData,
        extension_repo::{ExtensionRepo, RemoteExtension, RemoteExtensionResult},
        permission::Permission,
        settings::{DropdownOption, Setting, SettingKind, SettingValue, SettingsUI},
        source::{
            Entry, EntryDetailed, EntryDetailedResult, EntryId, EntryList, Episode, EpisodeId,
            ImageListAudio, Link, MediaType, Paragraph, ReleaseStatus, Source, SourceResult,
            SourceType, StreamSource, Subtitles,
        },
    };

    use serde_json::{self, to_string_pretty};
    use std::fs;

    const PATH: &str = "../../tests/jsondata";

    // ============================================================================
    // ACTION MODULE GENERATORS
    // ============================================================================

    fn generate_link() -> Link {
        Link {
            url: "https://example.com".to_string(),
            header: Some(HashMap::from([(
                "User-Agent".to_string(),
                "Mozilla/5.0".to_string(),
            )])),
        }
    }

    fn generate_link_simple() -> Link {
        Link {
            url: "https://simple.com".to_string(),
            header: None,
        }
    }

    fn generate_custom_ui_text() -> CustomUI {
        CustomUI::Text {
            text: "Test text".to_string(),
        }
    }

    fn generate_custom_ui_button() -> CustomUI {
        CustomUI::Button {
            label: "Test Button".to_string(),
            on_click: Some(Box::new(UIAction::Action {
                action: Box::new(Action::OpenBrowser {
                    url: "https://example.com".to_string(),
                }),
            })),
        }
    }

    fn generate_all_popup_actions() -> Vec<PopupAction> {
        vec![
            PopupAction {
                label: "Open Link".to_string(),
                onclick: Box::new(Action::OpenBrowser {
                    url: "https://example.com".to_string(),
                }),
            },
            PopupAction {
                label: "Show Popup".to_string(),
                onclick: Box::new(Action::Popup {
                    title: "Test Popup".to_string(),
                    content: Box::new(generate_custom_ui_text()),
                    actions: vec![],
                }),
            },
            PopupAction {
                label: "Navigate".to_string(),
                onclick: Box::new(Action::Nav {
                    title: "Test Nav".to_string(),
                    content: Box::new(generate_custom_ui_text()),
                }),
            },
            PopupAction {
                label: "Trigger Event".to_string(),
                onclick: Box::new(Action::TriggerEvent {
                    event: "test_event".to_string(),
                    data: "test_data".to_string(),
                }),
            },
        ]
    }

    fn generate_all_actions() -> Vec<Action> {
        vec![
            Action::OpenBrowser {
                url: "https://example.com".to_string(),
            },
            Action::Popup {
                title: "Test Popup".to_string(),
                content: Box::new(generate_custom_ui_text()),
                actions: vec![],
            },
            Action::Popup {
                title: "Popup with Actions".to_string(),
                content: Box::new(generate_custom_ui_button()),
                actions: generate_all_popup_actions(),
            },
            Action::Nav {
                title: "Test Nav".to_string(),
                content: Box::new(generate_custom_ui_text()),
            },
            Action::TriggerEvent {
                event: "test_event".to_string(),
                data: "test_data".to_string(),
            },
        ]
    }

    fn generate_all_ui_actions() -> Vec<UIAction> {
        vec![
            UIAction::Action {
                action: Box::new(Action::OpenBrowser {
                    url: "https://example.com".to_string(),
                }),
            },
            UIAction::Action {
                action: Box::new(Action::TriggerEvent {
                    event: "trigger_event".to_string(),
                    data: "trigger_data".to_string(),
                }),
            },
            UIAction::SwapContent {
                targetid: "target_1".to_string(),
                event: "swap_event".to_string(),
                data: "swap_data".to_string(),
                placeholder: None,
            },
            UIAction::SwapContent {
                targetid: "target_2".to_string(),
                event: "swap_event_2".to_string(),
                data: "swap_data_2".to_string(),
                placeholder: Some(Box::new(generate_custom_ui_text())),
            },
        ]
    }

    fn generate_all_event_data() -> Vec<EventData> {
        vec![
            EventData::SwapContent {
                event: "swap_event".to_string(),
                targetid: "target_1".to_string(),
                data: "swap_data".to_string(),
            },
            EventData::FeedUpdate {
                event: "feed_event".to_string(),
                data: "feed_data".to_string(),
                page: 1,
            },
            EventData::FeedUpdate {
                event: "feed_event_2".to_string(),
                data: "feed_data_2".to_string(),
                page: 2,
            },
            EventData::Action {
                event: "action_event".to_string(),
                data: "action_data".to_string(),
            },
        ]
    }

    fn generate_all_event_results() -> Vec<EventResult> {
        vec![
            EventResult::SwapContent {
                customui: generate_custom_ui_text(),
            },
            EventResult::SwapContent {
                customui: generate_custom_ui_button(),
            },
            EventResult::FeedUpdate {
                customui: vec![generate_custom_ui_text()],
                hasnext: Some(true),
                length: Some(1),
            },
            EventResult::FeedUpdate {
                customui: vec![generate_custom_ui_text(), generate_custom_ui_button()],
                hasnext: Some(false),
                length: Some(2),
            },
            EventResult::FeedUpdate {
                customui: vec![],
                hasnext: None,
                length: None,
            },
        ]
    }

    // ============================================================================
    // ACTIVITY MODULE GENERATORS
    // ============================================================================

    fn generate_all_entry_activities() -> Vec<EntryActivity> {
        vec![
            EntryActivity::EpisodeActivity { progress: 0 },
            EntryActivity::EpisodeActivity { progress: 50 },
            EntryActivity::EpisodeActivity { progress: 100 },
        ]
    }

    // ============================================================================
    // AUTH MODULE GENERATORS
    // ============================================================================

    fn generate_all_auth_data() -> Vec<AuthData> {
        vec![
            AuthData::Cookie {
                loginpage: "https://login.example.com".to_string(),
                logonpage: "https://logon.example.com".to_string(),
            },
            AuthData::ApiKey,
            AuthData::UserPass,
        ]
    }

    fn generate_all_accounts() -> Vec<Account> {
        vec![
            Account {
                domain: "example.com".to_string(),
                user_name: None,
                cover: None,
                auth: AuthData::Cookie {
                    loginpage: "https://login".to_string(),
                    logonpage: "https://logon".to_string(),
                },
                creds: None,
            },
            Account {
                domain: "test.com".to_string(),
                user_name: Some("test_user".to_string()),
                cover: None,
                auth: AuthData::ApiKey,
                creds: None,
            },
            Account {
                domain: "demo.com".to_string(),
                user_name: Some("demo_user".to_string()),
                cover: Some("https://cover.jpg".to_string()),
                auth: AuthData::UserPass,
                creds: Some(AuthCreds::ApiKey {
                    key: "SomeKey".to_string(),
                }),
            },
            Account {
                domain: "demo.com".to_string(),
                user_name: Some("demo_user".to_string()),
                cover: Some("https://cover.jpg".to_string()),
                auth: AuthData::UserPass,
                creds: Some(AuthCreds::UserPass {
                    password: "password123".to_string(),
                    username: "demo_user".to_string(),
                }),
            },
            Account {
                domain: "demo.com".to_string(),
                user_name: Some("demo_user".to_string()),
                cover: Some("https://cover.jpg".to_string()),
                auth: AuthData::UserPass,
                creds: Some(AuthCreds::Cookies {
                    cookies: HashMap::from([(
                        "session".to_string(),
                        vec!["cookie_value".to_string()],
                    )]),
                }),
            },
        ]
    }

    // ============================================================================
    // CUSTOM UI MODULE GENERATORS
    // ============================================================================

    fn generate_entry_for_ui() -> Entry {
        Entry {
            id: EntryId {
                uid: "entry_uid".to_string(),
                iddata: Some("test_iddata".to_string()),
            },
            url: "https://entry".to_string(),
            title: "Test Entry".to_string(),
            media_type: MediaType::Video,
            cover: Some(generate_link()),
            author: Some(vec!["Test Author".to_string()]),
            rating: Some(4.5),
            views: Some(1000.0),
            length: Some(3600),
        }
    }

    fn generate_all_timestamp_types() -> Vec<TimestampType> {
        vec![TimestampType::Relative, TimestampType::Absolute]
    }

    fn generate_all_custom_uis() -> Vec<CustomUI> {
        vec![
            CustomUI::Text {
                text: "Test text".to_string(),
            },
            CustomUI::Text {
                text: "Another text".to_string(),
            },
            CustomUI::Image {
                image: generate_link(),
                width: None,
                height: None,
            },
            CustomUI::Image {
                image: generate_link_simple(),
                width: Some(100),
                height: Some(100),
            },
            CustomUI::Image {
                image: generate_link(),
                width: Some(200),
                height: None,
            },
            CustomUI::Link {
                link: "https://link.com".to_string(),
                label: None,
            },
            CustomUI::Link {
                link: "https://another.com".to_string(),
                label: Some("Click Here".to_string()),
            },
            CustomUI::TimeStamp {
                timestamp: "1234567890".to_string(),
                display: TimestampType::Relative,
            },
            CustomUI::TimeStamp {
                timestamp: "0987654321".to_string(),
                display: TimestampType::Absolute,
            },
            CustomUI::EntryCard {
                entry: generate_entry_for_ui(),
            },
            CustomUI::Card {
                image: generate_link(),
                top: Box::new(generate_custom_ui_text()),
                bottom: Box::new(generate_custom_ui_button()),
            },
            CustomUI::Feed {
                event: "feed_event".to_string(),
                data: "feed_data".to_string(),
            },
            CustomUI::Button {
                label: "Click Me".to_string(),
                on_click: None,
            },
            CustomUI::Button {
                label: "Open Link".to_string(),
                on_click: Some(Box::new(UIAction::Action {
                    action: Box::new(Action::OpenBrowser {
                        url: "https://example.com".to_string(),
                    }),
                })),
            },
            CustomUI::InlineSetting {
                setting_id: "setting_1".to_string(),
                setting_kind: SettingKind::Extension,
                on_commit: None,
            },
            CustomUI::InlineSetting {
                setting_id: "setting_2".to_string(),
                setting_kind: SettingKind::Search,
                on_commit: Some(Box::new(UIAction::Action {
                    action: Box::new(Action::TriggerEvent {
                        event: "commit".to_string(),
                        data: "data".to_string(),
                    }),
                })),
            },
            CustomUI::Slot {
                id: "slot_1".to_string(),
                child: Box::new(generate_custom_ui_text()),
            },
            CustomUI::Column {
                children: vec![generate_custom_ui_text(), generate_custom_ui_button()],
            },
            CustomUI::Column { children: vec![] },
            CustomUI::Row {
                children: vec![generate_custom_ui_text()],
            },
            CustomUI::Row {
                children: vec![generate_custom_ui_text(), generate_custom_ui_button()],
            },
        ]
    }

    // ============================================================================
    // EXTENSION MODULE GENERATORS
    // ============================================================================

    fn generate_all_media_types() -> Vec<MediaType> {
        vec![
            MediaType::Video,
            MediaType::Comic,
            MediaType::Audio,
            MediaType::Book,
            MediaType::Unknown,
        ]
    }

    fn generate_all_source_types() -> Vec<SourceType> {
        vec![
            SourceType::Epub,
            SourceType::Pdf,
            SourceType::Imagelist,
            SourceType::Video,
            SourceType::Audio,
            SourceType::Paragraphlist,
        ]
    }

    fn generate_all_source_open_types() -> Vec<SourceOpenType> {
        vec![SourceOpenType::Download, SourceOpenType::Stream]
    }

    fn generate_all_extension_types() -> Vec<ExtensionType> {
        vec![
            ExtensionType::EntryProvider { has_search: true },
            ExtensionType::EntryProvider { has_search: false },
            ExtensionType::SourceProcessor {
                sourcetypes: HashSet::from([SourceType::Pdf]),
                opentype: HashSet::from([SourceOpenType::Download]),
            },
            ExtensionType::SourceProcessor {
                sourcetypes: HashSet::from([SourceType::Video]),
                opentype: HashSet::from([SourceOpenType::Stream]),
            },
            ExtensionType::SourceProcessor {
                sourcetypes: HashSet::from([SourceType::Epub, SourceType::Pdf]),
                opentype: HashSet::from([SourceOpenType::Download, SourceOpenType::Stream]),
            },
            ExtensionType::EntryProcessor {
                trigger_map_entry: true,
                trigger_on_entry_activity: true,
            },
            ExtensionType::EntryProcessor {
                trigger_map_entry: false,
                trigger_on_entry_activity: false,
            },
            ExtensionType::URLHandler {
                url_patterns: vec!["https://example.com/*".to_string()],
            },
            ExtensionType::URLHandler {
                url_patterns: vec![
                    "https://site1.com/*".to_string(),
                    "https://site2.com/*".to_string(),
                ],
            },
        ]
    }

    fn generate_all_extension_data() -> Vec<ExtensionData> {
        vec![
            ExtensionData {
                id: "test_id_1".to_string(),
                name: "Test Extension 1".to_string(),
                url: "https://ext1".to_string(),
                icon: "icon1.png".to_string(),
                desc: None,
                author: vec![],
                tags: vec![],
                lang: vec![],
                nsfw: false,
                media_type: HashSet::from([MediaType::Video]),
                extension_type: HashSet::from([ExtensionType::EntryProvider { has_search: true }]),
                repo: None,
                version: "1.0".to_string(),
                license: "MIT".to_string(),
                compatible: true,
            },
            ExtensionData {
                id: "test_id_2".to_string(),
                name: "Test Extension 2".to_string(),
                url: "https://ext2".to_string(),
                icon: "icon2.png".to_string(),
                desc: Some("Test description".to_string()),
                author: vec!["Author 1".to_string(), "Author 2".to_string()],
                tags: vec!["tag1".to_string(), "tag2".to_string()],
                lang: vec!["en".to_string(), "ja".to_string()],
                nsfw: false,
                media_type: HashSet::from([MediaType::Comic, MediaType::Book]),
                extension_type: HashSet::from([ExtensionType::SourceProcessor {
                    sourcetypes: HashSet::from([SourceType::Pdf]),
                    opentype: HashSet::from([SourceOpenType::Download]),
                }]),
                repo: Some("https://repo".to_string()),
                version: "2.0".to_string(),
                license: "Apache-2.0".to_string(),
                compatible: true,
            },
            ExtensionData {
                id: "test_id_3".to_string(),
                name: "NSFW Extension".to_string(),
                url: "https://ext3".to_string(),
                icon: "icon3.png".to_string(),
                desc: Some("NSFW content".to_string()),
                author: vec!["NSFW Author".to_string()],
                tags: vec!["nsfw".to_string()],
                lang: vec!["en".to_string()],
                nsfw: true,
                media_type: HashSet::from([MediaType::Video, MediaType::Audio]),
                extension_type: HashSet::from([ExtensionType::EntryProvider { has_search: false }]),
                repo: None,
                version: "1.5".to_string(),
                license: "GPL-3.0".to_string(),
                compatible: false,
            },
        ]
    }

    // ============================================================================
    // EXTENSION MANAGER MODULE GENERATORS
    // ============================================================================

    fn generate_all_extension_manager_data() -> Vec<ExtensionManagerData> {
        vec![
            ExtensionManagerData {
                name: "Test Manager".to_string(),
                icon: None,
                repo: None,
                api_version: 1,
            },
            ExtensionManagerData {
                name: "Manager with Icon".to_string(),
                icon: Some("manager_icon.png".to_string()),
                repo: None,
                api_version: 2,
            },
            ExtensionManagerData {
                name: "Full Manager".to_string(),
                icon: Some("full_icon.png".to_string()),
                repo: Some("https://repo.example.com".to_string()),
                api_version: 1,
            },
        ]
    }

    // ============================================================================
    // EXTENSION REPO MODULE GENERATORS
    // ============================================================================

    fn generate_all_remote_extensions() -> Vec<RemoteExtension> {
        vec![
            RemoteExtension {
                remote_id: "remote_id_1".to_string(),
                id: "ext_id_1".to_string(),
                name: "Remote Extension 1".to_string(),
                url: "https://ext1".to_string(),
                cover: None,
                version: "1.0".to_string(),
                compatible: true,
            },
            RemoteExtension {
                remote_id: "remote_id_2".to_string(),
                id: "ext_id_2".to_string(),
                name: "Remote Extension 2".to_string(),
                url: "https://ext2".to_string(),
                cover: Some(Link {
                    url: "https://cover.jpg".to_string(),
                    header: Some(HashMap::from([(
                        "User-Agent".to_string(),
                        "Mozilla/5.0".to_string(),
                    )])),
                }),
                version: "2.0".to_string(),
                compatible: true,
            },
            RemoteExtension {
                remote_id: "remote_id_3".to_string(),
                id: "ext_id_3".to_string(),
                name: "Incompatible Extension".to_string(),
                url: "https://ext3".to_string(),
                cover: None,
                version: "0.5".to_string(),
                compatible: false,
            },
        ]
    }

    fn generate_all_remote_extension_results() -> Vec<RemoteExtensionResult> {
        vec![
            RemoteExtensionResult {
                content: vec![],
                hasnext: None,
                length: None,
            },
            RemoteExtensionResult {
                content: vec![generate_all_remote_extensions()[0].clone()],
                hasnext: Some(true),
                length: Some(1),
            },
            RemoteExtensionResult {
                content: generate_all_remote_extensions(),
                hasnext: Some(false),
                length: Some(3),
            },
        ]
    }

    fn generate_all_extension_repos() -> Vec<ExtensionRepo> {
        vec![
            ExtensionRepo {
                remote_id: "repo_id_1".to_string(),
                name: "Test Repo".to_string(),
                description: "Test description".to_string(),
                url: "https://repo1.com".to_string(),
            },
            ExtensionRepo {
                remote_id: "repo_id_2".to_string(),
                name: "Community Repo".to_string(),
                description: "Community maintained extensions".to_string(),
                url: "https://repo2.com".to_string(),
            },
        ]
    }

    // ============================================================================
    // PERMISSION MODULE GENERATORS
    // ============================================================================

    fn generate_all_permissions() -> Vec<Permission> {
        vec![
            Permission::Storage {
                path: "/test/path".to_string(),
                write: false,
            },
            Permission::Storage {
                path: "/test/path".to_string(),
                write: true,
            },
            Permission::Storage {
                path: "/another/path".to_string(),
                write: true,
            },
            Permission::Network {
                domains: vec!["example.com".to_string()],
            },
            Permission::Network {
                domains: vec![
                    "example.com".to_string(),
                    "test.com".to_string(),
                    "demo.com".to_string(),
                ],
            },
            Permission::ActionPopup,
            Permission::ArbitraryNetwork,
        ]
    }

    // ============================================================================
    // SETTINGS MODULE GENERATORS
    // ============================================================================

    fn generate_all_setting_kinds() -> Vec<SettingKind> {
        vec![SettingKind::Extension, SettingKind::Search]
    }

    fn generate_all_setting_values() -> Vec<SettingValue> {
        vec![
            SettingValue::String {
                data: "test_value".to_string(),
            },
            SettingValue::String {
                data: "another_value".to_string(),
            },
            SettingValue::Number { data: 0.0 },
            SettingValue::Number { data: 42.5 },
            SettingValue::Boolean { data: true },
            SettingValue::Boolean { data: false },
            SettingValue::StringList {
                data: vec!["item1".to_string(), "item2".to_string()],
            },
            SettingValue::StringList { data: vec![] },
        ]
    }

    fn generate_all_dropdown_options() -> Vec<DropdownOption> {
        vec![
            DropdownOption {
                label: "Option 1".to_string(),
                value: "opt1".to_string(),
            },
            DropdownOption {
                label: "Option 2".to_string(),
                value: "opt2".to_string(),
            },
        ]
    }

    fn generate_all_settings_uis() -> Vec<SettingsUI> {
        vec![
            SettingsUI::CheckBox,
            SettingsUI::Slider {
                min: 0.0,
                max: 100.0,
                step: 1,
            },
            SettingsUI::Slider {
                min: -10.0,
                max: 10.0,
                step: 5,
            },
            SettingsUI::Dropdown {
                options: generate_all_dropdown_options(),
            },
            SettingsUI::Dropdown { options: vec![] },
        ]
    }

    fn generate_all_settings() -> Vec<Setting> {
        vec![
            Setting {
                label: "Test Setting".to_string(),
                value: SettingValue::String {
                    data: "value1".to_string(),
                },
                default: SettingValue::String {
                    data: "default".to_string(),
                },
                visible: true,
                ui: Some(SettingsUI::CheckBox),
            },
            Setting {
                label: "Hidden Setting".to_string(),
                value: SettingValue::Boolean { data: false },
                default: SettingValue::Boolean { data: true },
                visible: false,
                ui: None,
            },
            Setting {
                label: "Slider Setting".to_string(),
                value: SettingValue::Number { data: 50.0 },
                default: SettingValue::Number { data: 0.0 },
                visible: true,
                ui: Some(SettingsUI::Slider {
                    min: 0.0,
                    max: 100.0,
                    step: 1,
                }),
            },
            Setting {
                label: "Dropdown Setting".to_string(),
                value: SettingValue::String {
                    data: "opt1".to_string(),
                },
                default: SettingValue::String {
                    data: "opt1".to_string(),
                },
                visible: true,
                ui: Some(SettingsUI::Dropdown {
                    options: generate_all_dropdown_options(),
                }),
            },
        ]
    }

    // ============================================================================
    // SOURCE MODULE GENERATORS
    // ============================================================================

    fn generate_all_links() -> Vec<Link> {
        vec![
            Link {
                url: "https://example.com".to_string(),
                header: None,
            },
            Link {
                url: "https://example.com".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            },
            Link {
                url: "https://another.com".to_string(),
                header: Some(HashMap::from([
                    ("User-Agent".to_string(), "CustomAgent".to_string()),
                    ("Authorization".to_string(), "Bearer token123".to_string()),
                ])),
            },
        ]
    }

    fn generate_all_entry_ids() -> Vec<EntryId> {
        vec![
            EntryId {
                uid: "entry_uid_1".to_string(),
                iddata: None,
            },
            EntryId {
                uid: "entry_uid_2".to_string(),
                iddata: Some("iddata_1".to_string()),
            },
            EntryId {
                uid: "entry_uid_3".to_string(),
                iddata: Some("iddata_2".to_string()),
            },
        ]
    }

    fn generate_all_entries() -> Vec<Entry> {
        let links = generate_all_links();
        vec![
            Entry {
                id: generate_all_entry_ids()[0].clone(),
                url: "https://entry1.com".to_string(),
                title: "Entry 1".to_string(),
                media_type: MediaType::Video,
                cover: None,
                author: None,
                rating: None,
                views: None,
                length: None,
            },
            Entry {
                id: generate_all_entry_ids()[1].clone(),
                url: "https://entry2.com".to_string(),
                title: "Entry 2".to_string(),
                media_type: MediaType::Comic,
                cover: Some(links[0].clone()),
                author: Some(vec!["Author 1".to_string()]),
                rating: Some(4.5),
                views: Some(1000.0),
                length: Some(3600),
            },
            Entry {
                id: generate_all_entry_ids()[2].clone(),
                url: "https://entry3.com".to_string(),
                title: "Entry 3".to_string(),
                media_type: MediaType::Audio,
                cover: Some(links[1].clone()),
                author: Some(vec!["Author A".to_string(), "Author B".to_string()]),
                rating: Some(3.8),
                views: Some(500.0),
                length: Some(1800),
            },
            Entry {
                id: generate_all_entry_ids()[0].clone(),
                url: "https://entry4.com".to_string(),
                title: "Entry 4".to_string(),
                media_type: MediaType::Book,
                cover: None,
                author: None,
                rating: None,
                views: None,
                length: None,
            },
        ]
    }

    fn generate_all_entry_lists() -> Vec<EntryList> {
        let entries = generate_all_entries();
        vec![
            EntryList {
                content: vec![],
                hasnext: None,
                length: None,
            },
            EntryList {
                content: vec![entries[0].clone()],
                hasnext: Some(true),
                length: Some(1),
            },
            EntryList {
                content: entries.clone(),
                hasnext: Some(false),
                length: Some(4),
            },
        ]
    }

    fn generate_all_episode_ids() -> Vec<EpisodeId> {
        vec![
            EpisodeId {
                uid: "epi_uid_1".to_string(),
                iddata: None,
            },
            EpisodeId {
                uid: "epi_uid_2".to_string(),
                iddata: Some("epi_iddata_1".to_string()),
            },
        ]
    }

    fn generate_all_episodes() -> Vec<Episode> {
        let links = generate_all_links();
        vec![
            Episode {
                id: generate_all_episode_ids()[0].clone(),
                name: "Episode 1".to_string(),
                description: None,
                url: "https://episode1.com".to_string(),
                cover: None,
                timestamp: None,
            },
            Episode {
                id: generate_all_episode_ids()[1].clone(),
                name: "Episode 2".to_string(),
                description: Some("Description for episode 2".to_string()),
                url: "https://episode2.com".to_string(),
                cover: Some(links[0].clone()),
                timestamp: Some("1234567890".to_string()),
            },
            Episode {
                id: generate_all_episode_ids()[0].clone(),
                name: "Episode 3".to_string(),
                description: Some("Description for episode 3".to_string()),
                url: "https://episode3.com".to_string(),
                cover: Some(links[1].clone()),
                timestamp: Some("0987654321".to_string()),
            },
        ]
    }

    fn generate_all_release_statuses() -> Vec<ReleaseStatus> {
        vec![
            ReleaseStatus::Releasing,
            ReleaseStatus::Complete,
            ReleaseStatus::Unknown,
        ]
    }

    fn generate_all_entry_detailed() -> Vec<EntryDetailed> {
        let links = generate_all_links();
        let episodes = generate_all_episodes();
        vec![
            EntryDetailed {
                id: generate_all_entry_ids()[0].clone(),
                url: "https://detailed1.com".to_string(),
                titles: vec!["Title 1".to_string()],
                author: None,
                ui: None,
                meta: None,
                media_type: MediaType::Video,
                status: ReleaseStatus::Releasing,
                description: "Description 1".to_string(),
                language: "en".to_string(),
                cover: None,
                poster: None,
                episodes: vec![episodes[0].clone()],
                genres: None,
                rating: None,
                views: None,
                length: None,
            },
            EntryDetailed {
                id: generate_all_entry_ids()[1].clone(),
                url: "https://detailed2.com".to_string(),
                titles: vec!["Title 2".to_string(), "Alternative Title".to_string()],
                author: Some(vec!["Author 1".to_string()]),
                ui: Some(generate_custom_ui_text()),
                meta: Some(HashMap::from([
                    ("meta1".to_string(), "value1".to_string()),
                    ("meta2".to_string(), "value2".to_string()),
                ])),
                media_type: MediaType::Comic,
                status: ReleaseStatus::Complete,
                description: "Description 2".to_string(),
                language: "ja".to_string(),
                cover: Some(links[0].clone()),
                poster: Some(links[1].clone()),
                episodes: vec![episodes[1].clone()],
                genres: Some(vec!["Action".to_string(), "Adventure".to_string()]),
                rating: Some(4.5),
                views: Some(1000.0),
                length: Some(3600),
            },
            EntryDetailed {
                id: generate_all_entry_ids()[2].clone(),
                url: "https://detailed3.com".to_string(),
                titles: vec!["Title 3".to_string()],
                author: Some(vec!["Author A".to_string(), "Author B".to_string()]),
                ui: Some(generate_custom_ui_button()),
                meta: Some(HashMap::from([("single".to_string(), "meta".to_string())])),
                media_type: MediaType::Audio,
                status: ReleaseStatus::Unknown,
                description: "Description 3".to_string(),
                language: "en".to_string(),
                cover: Some(links[0].clone()),
                poster: None,
                episodes: episodes.clone(),
                genres: Some(vec!["Drama".to_string()]),
                rating: Some(3.8),
                views: Some(500.0),
                length: Some(1800),
            },
        ]
    }

    fn generate_all_entry_detailed_results() -> Vec<EntryDetailedResult> {
        let detailed_entries = generate_all_entry_detailed();
        let settings = generate_all_settings();
        vec![
            EntryDetailedResult {
                entry: detailed_entries[0].clone(),
                settings: HashMap::new(),
            },
            EntryDetailedResult {
                entry: detailed_entries[1].clone(),
                settings: HashMap::from([("setting1".to_string(), settings[0].clone())]),
            },
            EntryDetailedResult {
                entry: detailed_entries[2].clone(),
                settings: HashMap::from([
                    ("setting1".to_string(), settings[0].clone()),
                    ("setting2".to_string(), settings[1].clone()),
                ]),
            },
        ]
    }

    fn generate_all_stream_sources() -> Vec<StreamSource> {
        let links = generate_all_links();
        vec![
            StreamSource {
                name: "Stream 1".to_string(),
                lang: "en".to_string(),
                url: links[0].clone(),
            },
            StreamSource {
                name: "Stream 2".to_string(),
                lang: "ja".to_string(),
                url: links[1].clone(),
            },
            StreamSource {
                name: "Stream 3".to_string(),
                lang: "es".to_string(),
                url: links[0].clone(),
            },
        ]
    }

    fn generate_all_subtitles() -> Vec<Subtitles> {
        let links = generate_all_links();
        vec![
            Subtitles {
                title: "English".to_string(),
                lang: "en".to_string(),
                url: links[0].clone(),
            },
            Subtitles {
                title: "Japanese".to_string(),
                lang: "ja".to_string(),
                url: links[1].clone(),
            },
        ]
    }

    fn generate_all_image_list_audios() -> Vec<ImageListAudio> {
        let links = generate_all_links();
        vec![
            ImageListAudio {
                link: links[0].clone(),
                from: 0,
                to: 100,
            },
            ImageListAudio {
                link: links[1].clone(),
                from: 50,
                to: 200,
            },
        ]
    }

    fn generate_all_sources() -> Vec<Source> {
        let links = generate_all_links();
        let stream_sources = generate_all_stream_sources();
        let subtitles = generate_all_subtitles();
        let image_list_audios = generate_all_image_list_audios();
        vec![
            Source::Epub {
                link: links[0].clone(),
            },
            Source::Pdf {
                link: links[1].clone(),
            },
            Source::Imagelist {
                links: vec![links[0].clone(), links[1].clone()],
                audio: None,
            },
            Source::Imagelist {
                links: links.clone(),
                audio: Some(vec![image_list_audios[0].clone()]),
            },
            Source::Imagelist {
                links: vec![links[0].clone()],
                audio: Some(image_list_audios.clone()),
            },
            Source::Video {
                sources: vec![stream_sources[0].clone()],
                sub: vec![],
            },
            Source::Video {
                sources: stream_sources.clone(),
                sub: subtitles.clone(),
            },
            Source::Audio {
                sources: vec![stream_sources[0].clone()],
            },
            Source::Audio {
                sources: stream_sources.clone(),
            },
            Source::Paragraphlist {
                paragraphs: vec![
                    Paragraph::Text {
                        content: "Text paragraph".to_string(),
                    },
                    Paragraph::CustomUI {
                        ui: Box::new(generate_custom_ui_text()),
                    },
                ],
            },
        ]
    }

    fn generate_all_source_results() -> Vec<SourceResult> {
        let sources = generate_all_sources();
        let settings = generate_all_settings();
        vec![
            SourceResult {
                source: sources[0].clone(),
                settings: HashMap::new(),
            },
            SourceResult {
                source: sources[1].clone(),
                settings: HashMap::from([("source_setting".to_string(), settings[0].clone())]),
            },
            SourceResult {
                source: sources[2].clone(),
                settings: HashMap::from([
                    ("setting1".to_string(), settings[0].clone()),
                    ("setting2".to_string(), settings[1].clone()),
                ]),
            },
        ]
    }

    fn generate_all_paragraphs() -> Vec<Paragraph> {
        vec![
            Paragraph::Text {
                content: "Test paragraph".to_string(),
            },
            Paragraph::Text {
                content: "Another paragraph".to_string(),
            },
            Paragraph::CustomUI {
                ui: Box::new(generate_custom_ui_text()),
            },
            Paragraph::CustomUI {
                ui: Box::new(generate_custom_ui_button()),
            },
            Paragraph::Table {
                columns: vec![
                    crate::data::source::Row {
                        cells: vec![Paragraph::Text {
                            content: "Cell 1".to_string(),
                        }],
                    },
                    crate::data::source::Row {
                        cells: vec![Paragraph::Text {
                            content: "Cell 2".to_string(),
                        }],
                    },
                ],
            },
        ]
    }

    // ============================================================================
    // MAIN TEST FUNCTION
    // ============================================================================

    #[test]
    fn build_json_data() {
        fs::create_dir_all(PATH).unwrap();

        // action.rs types
        write_json_array("PopupAction", &generate_all_popup_actions());
        write_json_array("Action", &generate_all_actions());
        write_json_array("UIAction", &generate_all_ui_actions());
        write_json_array("EventData", &generate_all_event_data());
        write_json_array("EventResult", &generate_all_event_results());

        // activity.rs types
        write_json_array("EntryActivity", &generate_all_entry_activities());

        // auth.rs types
        write_json_array("AuthData", &generate_all_auth_data());
        write_json_array("Account", &generate_all_accounts());

        // custom_ui.rs types
        write_json_array("TimestampType", &generate_all_timestamp_types());
        write_json_array("CustomUI", &generate_all_custom_uis());

        // extension.rs types
        write_json_array("SourceOpenType", &generate_all_source_open_types());
        write_json_array("ExtensionType", &generate_all_extension_types());
        write_json_array("ExtensionData", &generate_all_extension_data());

        // extension_manager.rs types
        write_json_array(
            "ExtensionManagerData",
            &generate_all_extension_manager_data(),
        );

        // extension_repo.rs types
        write_json_array("RemoteExtension", &generate_all_remote_extensions());
        write_json_array(
            "RemoteExtensionResult",
            &generate_all_remote_extension_results(),
        );
        write_json_array("ExtensionRepo", &generate_all_extension_repos());

        // permission.rs types
        write_json_array("Permission", &generate_all_permissions());

        // settings.rs types
        write_json_array("SettingKind", &generate_all_setting_kinds());
        write_json_array("SettingValue", &generate_all_setting_values());
        write_json_array("DropdownOption", &generate_all_dropdown_options());
        write_json_array("SettingsUI", &generate_all_settings_uis());
        write_json_array("Setting", &generate_all_settings());

        // source.rs types
        write_json_array("MediaType", &generate_all_media_types());
        write_json_array("Link", &generate_all_links());
        write_json_array("EntryId", &generate_all_entry_ids());
        write_json_array("Entry", &generate_all_entries());
        write_json_array("EntryList", &generate_all_entry_lists());
        write_json_array("EpisodeId", &generate_all_episode_ids());
        write_json_array("Episode", &generate_all_episodes());
        write_json_array("ReleaseStatus", &generate_all_release_statuses());
        write_json_array("SourceType", &generate_all_source_types());
        write_json_array("EntryDetailed", &generate_all_entry_detailed());
        write_json_array(
            "EntryDetailedResult",
            &generate_all_entry_detailed_results(),
        );
        write_json_array("Source", &generate_all_sources());
        write_json_array("SourceResult", &generate_all_source_results());
        write_json_array("Paragraph", &generate_all_paragraphs());
        write_json_array("StreamSource", &generate_all_stream_sources());
        write_json_array("Subtitles", &generate_all_subtitles());
        write_json_array("ImageListAudio", &generate_all_image_list_audios());
    }

    fn write_json_array<T: serde::Serialize>(name: &str, data: &[T]) {
        let json = to_string_pretty(data).unwrap();
        fs::write(format!("{}/{}.json", PATH, name), json).unwrap();
    }
}
