use anyhow::Result;

pub trait ErrorConverter<T> {
  fn map_to_node(self) -> Result<T, napi::Error>;

  fn map_to_node_code(self, status: napi::Status) -> Result<T, napi::Error>;
}

impl<T> ErrorConverter<T> for Result<T> {
  fn map_to_node(self) -> Result<T, napi::Error> {
    self.map_to_node_code(napi::Status::GenericFailure)
  }
  fn map_to_node_code(self, status: napi::Status) -> Result<T, napi::Error> {
    self.map_err(|e| napi::Error::new(status, format!("{:?}", e)))
  }
}

impl<T> ErrorConverter<T> for Result<T, serde_json::Error> {
  fn map_to_node(self) -> Result<T, napi::Error> {
    self.map_to_node_code(napi::Status::GenericFailure)
  }

  fn map_to_node_code(self, status: napi::Status) -> Result<T, napi::Error> {
    self.map_err(|e| {
      napi::Error::new(
        status,
        format!(
          "JsonError: {:?} at {}:{}",
          e.classify(),
          e.line(),
          e.column()
        ),
      )
    })
  }
}
