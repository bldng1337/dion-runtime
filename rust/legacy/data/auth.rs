use std::collections::HashMap;

struct Account {
    domain: String,
    user_name: Option<String>,
    cover: Option<String>,
    auth: AuthData,
    creds: Option<HashMap<String, String>>,
}

enum AuthData {
    Cookie { loginpage: String },
    ApiKey {},
    UserPass {},
}

struct AccountStore {
    accounts: Vec<Account>,
}
