use crate::data::auth::Account;

pub struct AuthStore {
    accounts: Vec<Account>,
}

impl AuthStore {
    pub fn merge_auth(&mut self, account: &Account) {
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
