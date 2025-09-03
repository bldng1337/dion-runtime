use flutter_rust_bridge::frb;
use tokio_util::sync::CancellationToken;

#[derive(Debug, Clone)]
pub struct CancelToken {
    token: CancellationToken,
}

impl CancelToken {
    #[frb(sync)]
    pub fn new() -> Self {
        Self {
            token: CancellationToken::new(),
        }
    }

    pub fn is_cancelled(&self) -> bool {
        self.token.is_cancelled()
    }

    pub fn cancel(&self) {
        self.token.cancel();
    }

    pub fn get_child(&self) -> CancelToken {
        self.token.child_token().into()
    }
}
#[frb(ignore)]
impl From<CancellationToken> for CancelToken {
    fn from(token: CancellationToken) -> Self {
        Self { token }
    }
}
#[frb(ignore)]
impl From<CancelToken> for CancellationToken {
    fn from(cancel_token: CancelToken) -> Self {
        cancel_token.token
    }
}
