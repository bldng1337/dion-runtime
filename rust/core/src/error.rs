use std::{
    fmt::{Debug, Display},
    string::FromUtf8Error,
    sync::PoisonError,
};

use boa_engine::JsError;
use tokio::sync::oneshot::error::RecvError;

// use boa_engine::JsError;

#[derive(Debug)]
pub enum Error {
    ExtensionError(String),
    FileIO(std::io::Error),
    #[allow(dead_code)]
    JSEngineData(String),
    Serialization(serde_json::Error),
    Encoding(FromUtf8Error),
    Poison(),
    // NewJs(JsError),
    Cancelled,
}

pub type Result<T> = std::result::Result<T, Error>;

impl Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Error::ExtensionError(a) => Debug::fmt(&a, f),
            Error::FileIO(err) => Debug::fmt(&err, f),
            Error::Serialization(err) => Debug::fmt(&err, f),
            Error::Encoding(err) => Debug::fmt(&err, f),
            Error::JSEngineData(message) => Debug::fmt(&message, f),
            Error::Poison() => Debug::fmt("Lock Poisoned", f),
            Error::Cancelled => Debug::fmt("Task Cancelled", f),
            // Error::NewJs(js_error) => std::fmt::Display::fmt(&js_error, f),
        }
    }
}

impl std::error::Error for Error {}

impl<T> From<PoisonError<T>> for Error {
    fn from(_value: PoisonError<T>) -> Self {
        Error::Poison()
    }
}

impl From<JsError> for Error {
    fn from(value: JsError) -> Self {
        // Error::NewJs(value)
        Error::ExtensionError(value.to_string())
    }
}
impl From<RecvError> for Error {
    fn from(value: RecvError) -> Self {
        Error::ExtensionError(value.to_string())
    }
}

impl From<FromUtf8Error> for Error {
    fn from(value: FromUtf8Error) -> Self {
        Error::Encoding(value)
    }
}
impl From<std::io::Error> for Error {
    fn from(value: std::io::Error) -> Self {
        Error::FileIO(value)
    }
}
impl From<serde_json::Error> for Error {
    fn from(value: serde_json::Error) -> Self {
        Error::Serialization(value)
    }
}
