use napi_derive::napi;
use tokio_util::sync::CancellationToken;

#[napi(js_name = "CancelToken")]
pub struct CancelTokenProxy {
  token: CancellationToken,
}

impl From<CancellationToken> for CancelTokenProxy {
  fn from(value: CancellationToken) -> Self {
    Self { token: value }
  }
}

#[napi]
impl CancelTokenProxy {
  #[napi]
  pub fn cancel(&self) {
    self.token.cancel();
  }
  #[napi(getter)]
  pub fn cancelled(&self) -> bool {
    self.token.is_cancelled()
  }
  #[napi]
  pub fn get_child(&self) -> CancelTokenProxy {
    self.token.child_token().into()
  }
  pub fn take_token(&self) -> CancellationToken {
    self.token.clone()
  }
}
