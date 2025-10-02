use std::collections::HashMap;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Account {
    pub domain: String,
    pub user_name: Option<String>,
    pub cover: Option<String>,
    pub auth: AuthData,
    pub creds: Option<HashMap<String, String>>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum AuthData {
    Cookie {
        loginpage: String,
        logonpage: String,
    },
    ApiKey {},
    UserPass {},
}
