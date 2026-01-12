use std::collections::HashMap;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Account {
    pub domain: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub user_name: Option<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub cover: Option<String>,
    pub auth: AuthData,
    #[cfg_attr(feature = "type", specta(optional))]
    pub creds: Option<AuthCreds>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum AuthCreds {
    Cookies {
        cookies: HashMap<String, Vec<String>>,
    },
    ApiKey {
        key: String,
    },
    UserPass {
        username: String,
        password: String,
    },
    OAuth {
        access_token: String,
        refresh_token: Option<String>,
        expires_at: Option<u32>,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum AuthData {
    Cookie {
        loginpage: String,
        logonpage: String,
    },
    ApiKey,
    UserPass,
    OAuth {
        authorization_url: String,
        token_url: Option<String>,
        client_id: String,
        client_secret: String,
        scope: Option<String>,
    },
}
