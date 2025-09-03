use std::collections::HashMap;

use serde::{Deserialize, Serialize};
#[cfg(test)]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Account {
    domain: String,
    user_name: Option<String>,
    cover: Option<String>,
    auth: AuthData,
    creds: Option<HashMap<String, String>>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum AuthData {
    Cookie {
        loginpage: String,
        logonpage: String,
    },
    ApiKey {},
    UserPass {},
}

pub struct AuthStore {
    accounts: Vec<Account>,
}

impl AuthStore {
    pub fn merge_auth(&mut self, account: &Account) {
        self.accounts
            .iter_mut()
            .filter(|acc| acc.domain == account.domain)
            .for_each(|acc| {
                *acc = account.clone();
            });
    }

    pub fn is_logged_in(&self, domain: &str) -> bool {
        self.accounts
            .iter()
            .filter(|acc| acc.domain == domain)
            .any(|acc| acc.creds.is_some())
    }

    pub fn invalidate(&mut self, domain: &str) {
        self.accounts
            .iter_mut()
            .filter(|acc| acc.domain == domain)
            .for_each(|acc| acc.creds = None);
    }
}
