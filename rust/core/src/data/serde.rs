#[allow(unused_variables)]
#[allow(dead_code)]
#[allow(unreachable_code)]
#[allow(unused_imports)]
#[cfg(test)]
mod test {
    use std::{
        collections::{HashMap, HashSet},
        sync::Arc,
    };

    use crate::{
        client_data::{AdapterClient, ExtensionClient},
        data::{
            action::{Action, EventData, EventResult, PopupAction, UIAction},
            activity::EntryActivity,
            auth::{Account, AuthData},
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
        },
        extension::{Adapter, Extension},
        store::{permission::PermissionStore, settings::SettingStore, ExtensionStore},
    };

    use anyhow::{bail, Result};
    use serde_json::{self, to_string_pretty};
    use std::fs;
    use tokio::sync::RwLock;
    use tokio_util::sync::CancellationToken;

    const PATH: &str = "../../tests/jsondata";

    #[test]
    fn build_json_data() {
        fs::create_dir_all(PATH).unwrap();

        // action.rs types
        let popup_action = PopupAction {
            label: "Test Label".to_string(),
            onclick: Box::new(Action::OpenBrowser {
                url: "https://example.com".to_string(),
            }),
        };
        let json = to_string_pretty(&popup_action).unwrap();
        fs::write(format!("{}/PopupAction.json", PATH), json).unwrap();

        let action = Action::OpenBrowser {
            url: "https://example.com".to_string(),
        };
        let json = to_string_pretty(&action).unwrap();
        fs::write(format!("{}/Action.json", PATH), json).unwrap();

        let ui_action = UIAction::Action {
            action: Action::OpenBrowser {
                url: "https://example.com".to_string(),
            },
        };
        let json = to_string_pretty(&ui_action).unwrap();
        fs::write(format!("{}/UIAction.json", PATH), json).unwrap();

        let event_data = EventData::Action {
            event: "test_event".to_string(),
            data: "test_data".to_string(),
        };
        let json = to_string_pretty(&event_data).unwrap();
        fs::write(format!("{}/EventData.json", PATH), json).unwrap();

        let event_result = EventResult::FeedUpdate {
            customui: vec![
                CustomUI::Text {
                    text: "Test text".to_string(),
                },
                CustomUI::Button {
                    label: "Test Button".to_string(),
                    on_click: Some(Box::new(UIAction::Action {
                        action: Action::OpenBrowser {
                            url: "https://example.com".to_string(),
                        },
                    })),
                },
            ],
            hasnext: Some(true),
            length: Some(2),
        };
        let json = to_string_pretty(&event_result).unwrap();
        fs::write(format!("{}/EventResult.json", PATH), json).unwrap();

        // activity.rs types
        let entry_activity = EntryActivity::EpisodeActivity { progress: 50 };
        let json = to_string_pretty(&entry_activity).unwrap();
        fs::write(format!("{}/EntryActivity.json", PATH), json).unwrap();

        // auth.rs types
        let account = Account {
            domain: "example.com".to_string(),
            user_name: Some("test_user".to_string()),
            cover: Some("https://example.com/cover.jpg".to_string()),
            auth: AuthData::Cookie {
                loginpage: "https://login".to_string(),
                logonpage: "https://logon".to_string(),
            },
            creds: Some(HashMap::from([("key".to_string(), "value".to_string())])),
        };
        let json = to_string_pretty(&account).unwrap();
        fs::write(format!("{}/Account.json", PATH), json).unwrap();

        let auth_data = AuthData::Cookie {
            loginpage: "https://login".to_string(),
            logonpage: "https://logon".to_string(),
        };
        let json = to_string_pretty(&auth_data).unwrap();
        fs::write(format!("{}/AuthData.json", PATH), json).unwrap();

        // custom_ui.rs types
        let timestamp_type = TimestampType::Relative;
        let json = to_string_pretty(&timestamp_type).unwrap();
        fs::write(format!("{}/TimestampType.json", PATH), json).unwrap();

        let custom_ui = CustomUI::Text {
            text: "Test text".to_string(),
        };
        let json = to_string_pretty(&custom_ui).unwrap();
        fs::write(format!("{}/CustomUI.json", PATH), json).unwrap();

        // extension.rs types
        let extension_data = ExtensionData {
            id: "test_id".to_string(),
            name: "Test Extension".to_string(),
            url: "https://ext".to_string(),
            icon: "icon.png".to_string(),
            desc: Some("Test description".to_string()),
            author: vec!["Test Author".to_string()],
            tags: vec!["tag1".to_string()],
            lang: vec!["en".to_string()],
            nsfw: false,
            media_type: HashSet::from([MediaType::Video]),
            extension_type: HashSet::from([ExtensionType::EntryProvider { has_search: true }]),
            repo: Some("https://repo".to_string()),
            version: "1.0".to_string(),
            license: "MIT".to_string(),
            compatible: true,
        };
        let json = to_string_pretty(&extension_data).unwrap();
        fs::write(format!("{}/ExtensionData.json", PATH), json).unwrap();

        let source_open_type = SourceOpenType::Download;
        let json = to_string_pretty(&source_open_type).unwrap();
        fs::write(format!("{}/SourceOpenType.json", PATH), json).unwrap();

        let extension_type = ExtensionType::EntryProvider { has_search: true };
        let json = to_string_pretty(&extension_type).unwrap();
        fs::write(format!("{}/ExtensionType.json", PATH), json).unwrap();

        // extension_manager.rs types
        let extension_manager_data = ExtensionManagerData {
            name: "Test Manager".to_string(),
            icon: Some("icon.png".to_string()),
            repo: Some("https://repo".to_string()),
            api_version: 1,
        };
        let json = to_string_pretty(&extension_manager_data).unwrap();
        fs::write(format!("{}/ExtensionManagerData.json", PATH), json).unwrap();

        // extension_repo.rs types
        let remote_extension = RemoteExtension {
            id: "test_id".to_string(),
            exturl: "https://ext".to_string(),
            name: "Test Ext".to_string(),
            cover: Some(Link {
                url: "https://cover".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            }),
            version: "1.0".to_string(),
            compatible: true,
        };
        let json = to_string_pretty(&remote_extension).unwrap();
        fs::write(format!("{}/RemoteExtension.json", PATH), json).unwrap();

        let remote_extension_result = RemoteExtensionResult {
            content: vec![remote_extension.clone()],
            hasnext: Some(false),
            length: Some(1),
        };
        let json = to_string_pretty(&remote_extension_result).unwrap();
        fs::write(format!("{}/RemoteExtensionResult.json", PATH), json).unwrap();

        let extension_repo = ExtensionRepo {
            name: "Test Repo".to_string(),
            description: "Test description".to_string(),
            url: "https://repo".to_string(),
            id: "repo_id".to_string(),
        };
        let json = to_string_pretty(&extension_repo).unwrap();
        fs::write(format!("{}/ExtensionRepo.json", PATH), json).unwrap();

        // permission.rs types
        let permission = Permission::Storage {
            path: "/test/path".to_string(),
            write: true,
        };
        let json = to_string_pretty(&permission).unwrap();
        fs::write(format!("{}/Permission.json", PATH), json).unwrap();

        // settings.rs types
        let setting_kind = SettingKind::Extension;
        let json = to_string_pretty(&setting_kind).unwrap();
        fs::write(format!("{}/SettingKind.json", PATH), json).unwrap();

        let setting_value = SettingValue::String {
            data: "test_value".to_string(),
        };
        let json = to_string_pretty(&setting_value).unwrap();
        fs::write(format!("{}/SettingValue.json", PATH), json).unwrap();

        let dropdown_option = DropdownOption {
            label: "Option 1".to_string(),
            value: "opt1".to_string(),
        };
        let json = to_string_pretty(&dropdown_option).unwrap();
        fs::write(format!("{}/DropdownOption.json", PATH), json).unwrap();

        let settings_ui = SettingsUI::CheckBox;
        let json = to_string_pretty(&settings_ui).unwrap();
        fs::write(format!("{}/SettingsUI.json", PATH), json).unwrap();

        let setting = Setting {
            label: "Test Setting".to_string(),
            value: setting_value.clone(),
            default: SettingValue::String {
                data: "default".to_string(),
            },
            visible: true,
            ui: Some(SettingsUI::CheckBox),
        };
        let json = to_string_pretty(&setting).unwrap();
        fs::write(format!("{}/Setting.json", PATH), json).unwrap();

        // source.rs types
        let media_type = MediaType::Video;
        let json = to_string_pretty(&media_type).unwrap();
        fs::write(format!("{}/MediaType.json", PATH), json).unwrap();

        let link = Link {
            url: "https://example.com".to_string(),
            header: Some(HashMap::from([(
                "User-Agent".to_string(),
                "Mozilla/5.0".to_string(),
            )])),
        };
        let json = to_string_pretty(&link).unwrap();
        fs::write(format!("{}/Link.json", PATH), json).unwrap();

        let entry_id = EntryId {
            uid: "entry_uid".to_string(),
            iddata: Some("test_iddata".to_string()),
        };
        let entry = Entry {
            id: entry_id.clone(),
            url: "https://entry".to_string(),
            title: "Test Entry".to_string(),
            media_type: MediaType::Video,
            cover: Some(link.clone()),
            author: Some(vec!["Test Author".to_string()]),
            rating: Some(4.5),
            views: Some(1000.0),
            length: Some(3600),
        };
        let json = to_string_pretty(&entry).unwrap();
        fs::write(format!("{}/Entry.json", PATH), json).unwrap();

        let entry_list = EntryList {
            hasnext: Some(false),
            length: Some(1),
            content: vec![entry.clone()],
        };
        let json = to_string_pretty(&entry_list).unwrap();
        fs::write(format!("{}/EntryList.json", PATH), json).unwrap();

        let episode_id = EpisodeId {
            uid: "epi_uid".to_string(),
            iddata: Some("epi_iddata".to_string()),
        };
        let episode = Episode {
            id: episode_id.clone(),
            name: "Test Episode".to_string(),
            description: Some("Episode description".to_string()),
            url: "https://episode".to_string(),
            cover: Some(Link {
                url: "https://episode_cover.jpg".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            }),
            timestamp: Some("1234567890".to_string()),
        };
        let entry_detailed = EntryDetailed {
            id: entry_id.clone(),
            url: "https://detailed".to_string(),
            titles: vec!["Title".to_string()],
            author: Some(vec!["Test Author".to_string()]),
            poster: Some(Link {
                url: "https://poster.jpg".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            }),
            ui: Some(CustomUI::Text {
                text: "UI text".to_string(),
            }),
            meta: Some(HashMap::from([(
                "meta_key".to_string(),
                "meta_value".to_string(),
            )])),
            media_type: MediaType::Video,
            status: ReleaseStatus::Releasing,
            description: "Test desc".to_string(),
            language: "en".to_string(),
            cover: Some(Link {
                url: "https://cover.jpg".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            }),
            episodes: vec![episode],
            genres: Some(vec!["Action".to_string(), "Adventure".to_string()]),
            rating: Some(4.5),
            views: Some(1000.0),
            length: Some(3600),
        };
        let entry_detailed_result = EntryDetailedResult {
            entry: entry_detailed,
            settings: HashMap::from([(
                "setting1".to_string(),
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
            )]),
        };
        let json = to_string_pretty(&entry_detailed_result).unwrap();
        fs::write(format!("{}/EntryDetailedResult.json", PATH), json).unwrap();

        let source_result = SourceResult {
            source: Source::Pdf { link: link.clone() },
            settings: HashMap::from([(
                "source_setting".to_string(),
                Setting {
                    label: "Source Setting".to_string(),
                    value: SettingValue::Boolean { data: true },
                    default: SettingValue::Boolean { data: false },
                    visible: true,
                    ui: Some(SettingsUI::CheckBox),
                },
            )]),
        };
        let json = to_string_pretty(&source_result).unwrap();
        fs::write(format!("{}/SourceResult.json", PATH), json).unwrap();

        let release_status = ReleaseStatus::Complete;
        let json = to_string_pretty(&release_status).unwrap();
        fs::write(format!("{}/ReleaseStatus.json", PATH), json).unwrap();

        let source_type = SourceType::Pdf;
        let json = to_string_pretty(&source_type).unwrap();
        fs::write(format!("{}/SourceType.json", PATH), json).unwrap();

        let source = Source::Pdf { link };
        let json = to_string_pretty(&source).unwrap();
        fs::write(format!("{}/Source.json", PATH), json).unwrap();

        let paragraph = Paragraph::Text {
            content: "Test paragraph".to_string(),
        };
        let json = to_string_pretty(&paragraph).unwrap();
        fs::write(format!("{}/Paragraph.json", PATH), json).unwrap();

        let stream_source = StreamSource {
            name: "Chapter 1".to_string(),
            lang: "en".to_string(),
            url: Link {
                url: "https://chapter.mp3".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            },
        };
        let json = to_string_pretty(&stream_source).unwrap();
        fs::write(format!("{}/StreamSource.json", PATH), json).unwrap();

        let subtitles = Subtitles {
            title: "English".to_string(),
            lang: "en".to_string(),
            url: Link {
                url: "https://subs.vtt".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            },
        };
        let json = to_string_pretty(&subtitles).unwrap();
        fs::write(format!("{}/Subtitles.json", PATH), json).unwrap();

        let image_list_audio = ImageListAudio {
            link: Link {
                url: "https://audio.mp3".to_string(),
                header: Some(HashMap::from([(
                    "User-Agent".to_string(),
                    "Mozilla/5.0".to_string(),
                )])),
            },
            from: 0,
            to: 100,
        };
        let json = to_string_pretty(&image_list_audio).unwrap();
        fs::write(format!("{}/ImageListAudio.json", PATH), json).unwrap();

        let episode_id_json = to_string_pretty(&episode_id).unwrap();
        fs::write(format!("{}/EpisodeId.json", PATH), episode_id_json).unwrap();

        let entry_id_json = to_string_pretty(&entry_id).unwrap();
        fs::write(format!("{}/EntryId.json", PATH), entry_id_json).unwrap();
    }
}
