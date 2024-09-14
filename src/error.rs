use std::{ fmt::{ Debug, Display }, string::FromUtf8Error, sync::PoisonError };

use rquickjs::{ runtime::UserDataError, IntoJs, Value };


#[derive(Debug)]
pub enum Error {
    ExtensionError(String),
    FileIO(std::io::Error),
    #[allow(dead_code)]
    JS(rquickjs::Error, String),
    JSEngine(rquickjs::Error),
    JSEngineData(String),
    Serialization(serde_json::Error),
    Encoding(FromUtf8Error),
    Poison(),
    Cancelled,
}

pub type Result<T>=std::result::Result<T,Error>;

impl Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Error::ExtensionError(a) => Debug::fmt(&a, f),
            Error::FileIO(err) => Debug::fmt(&err, f),
            Error::JSEngine(err) => Debug::fmt(&err, f),
            Error::Serialization(err) => Debug::fmt(&err, f),
            Error::Encoding(err) => Debug::fmt(&err, f),
            Error::JS(_, message) => Debug::fmt(&message, f),
            Error::JSEngineData(message) => Debug::fmt(&message, f),
            Error::Poison() => Debug::fmt("Lock Poisoned", f),
            Error::Cancelled => Debug::fmt("Task Cancelled", f),
        }
    }
}

impl std::error::Error for Error {}


impl<T> From<PoisonError<T>> for Error {
    fn from(_value: PoisonError<T>) -> Self {
        Error::Poison()
    }
}

impl<U> From<UserDataError<U>> for Error {
    fn from(value: UserDataError<U>) -> Self {
        Error::JSEngineData(format!("{}", value))
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
impl From<rquickjs::Error> for Error {
    fn from(value: rquickjs::Error) -> Self {
        Error::JSEngine(value)
    }
}
impl From<serde_json::Error> for Error {
    fn from(value: serde_json::Error) -> Self {
        Error::Serialization(value)
    }
}
impl Into<rquickjs::Error> for Error {
    fn into(self) -> rquickjs::Error {
        rquickjs::Error::new_into_js("", "")
    }
}

impl<'js> IntoJs<'js> for Error {
    fn into_js(self, ctx: &rquickjs::Ctx<'js>) -> rquickjs::Result<Value<'js>> {
        Err(ctx.throw(format!("{}", self).into_js(ctx)?))
    }
}
