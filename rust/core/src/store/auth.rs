use anyhow::Result;

use crate::{client_data::ExtensionClient, data::auth::Account};

#[derive(Debug)]
pub struct AuthStore {
    accounts: Vec<Account>,
}

impl AuthStore {
    pub async fn new(client: &dyn ExtensionClient) -> Self {
        let mut ret = Self {
            accounts: Default::default(),
        };
        let _ = ret.load_data(client).await;
        ret
    }

    async fn load_data(&mut self, client: &dyn ExtensionClient) -> Result<()> {
        self.accounts = serde_json::from_str(&client.load_data_secure("auth").await?)?;
        Ok(())
    }

    pub async fn save_state(&self, client: &dyn ExtensionClient) -> Result<()> {
        client
            .store_data_secure("auth", serde_json::to_string(&self.accounts)?)
            .await
    }

    pub fn get_mut(&mut self, domain: &str) -> Option<&mut Account> {
        self.accounts.iter_mut().find(|acc| acc.domain == domain)
    }

    pub fn merge_auth(&mut self, account: &Account) {
        if !self.accounts.iter().any(|acc| acc.domain == account.domain) {
            self.accounts.push(account.clone());
            return;
        }
        self.accounts
            .iter_mut()
            .filter(|acc| acc.domain == account.domain)
            .for_each(|acc| {
                if acc.auth != account.auth {
                    *acc = account.clone();
                } else {
                    if account.cover.is_some() {
                        acc.cover = account.cover.clone();
                    }
                    if account.user_name.is_some() {
                        acc.user_name = account.user_name.clone();
                    }
                }
            });
    }

    pub fn get_accounts(&self) -> &Vec<Account> {
        &self.accounts
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
