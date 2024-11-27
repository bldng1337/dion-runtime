use std::{ops::Deref, sync::Arc};

use rquickjs::{convert, qjs::JSValue, runtime::UserData, FromJs, Value};
use serde::de::DeserializeOwned;
use serde::Serialize;
use serde::Deserialize;
use serde_json::{de, from_str, to_string};
use tokio::sync::RwLock;

use crate::error::Error;

pub fn val_to_string<'js>(val: Value<'js>) -> Result<String, Error> {
    if let Some(symbol) = val.as_symbol() {
        if let Some(description) = symbol.description()?.into_string() {
            let description = description.to_string()?;
            Ok(format!("Symbol({description})"))
        } else {
            Ok("Symbol()".into())
        }
    } else {
        let stringified = <convert::Coerced<String>>::from_js(&val.ctx().clone(), val)
            .map(|string| string.to_string())?;
        Ok(stringified)
    }
}

pub fn wrapcatch<T>(ctx: &rquickjs::Ctx, res: Result<T, rquickjs::Error>) -> Result<T, Error> {
    match res {
        Ok(val) => Ok(val),
        Err(err) => match err {
            rquickjs::Error::Exception => Err(Error::JS(err, val_to_string(ctx.catch())?)),
            _ => Err(Error::JSEngine(err)),
        },
    }
}

pub struct SharedUserContextContainer<T> {
    pub inner: Arc<RwLock<T>>,
}

impl<T> SharedUserContextContainer<T> {
    pub fn new(inner: T) -> Self {
        SharedUserContextContainer {
            inner: Arc::new(RwLock::new(inner)),
        }
    }
    pub fn from(arc: Arc<RwLock<T>>) -> Self {
        SharedUserContextContainer { inner: arc }
    }
    pub async fn get(&self) -> tokio::sync::RwLockReadGuard<'_, T> {
        self.inner.read().await
    }
    pub async fn get_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, T> {
        self.inner.write().await
    }
}

impl<T> Default for SharedUserContextContainer<T>
where
    T: Default,
{
    fn default() -> Self {
        Self {
            inner: Default::default(),
        }
    }
}

unsafe impl<'js, T: 'static> UserData<'js> for SharedUserContextContainer<T> {
    type Static = SharedUserContextContainer<T>;
}

pub struct UserContextContainer<T> {
    pub inner: RwLock<T>,
}

impl<T> UserContextContainer<T> {
    pub fn new(inner: T) -> Self {
        UserContextContainer {
            inner: RwLock::new(inner),
        }
    }
    pub fn get(&self) -> tokio::sync::RwLockReadGuard<'_, T> {
        self.inner.blocking_read()
    }
    pub fn get_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, T> {
        self.inner.blocking_write()
    }
}

impl<T> Default for UserContextContainer<T>
where
    T: Default,
{
    fn default() -> Self {
        Self {
            inner: Default::default(),
        }
    }
}

unsafe impl<'js, T: 'static> UserData<'js> for UserContextContainer<T> {
    type Static = UserContextContainer<T>;
}

pub struct ReadOnlyUserContextContainer<T> {
    pub inner: T,
}

unsafe impl<'js, T: 'static> UserData<'js> for ReadOnlyUserContextContainer<T> {
    type Static = ReadOnlyUserContextContainer<T>;
}

impl<T> Deref for ReadOnlyUserContextContainer<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

impl<T> ReadOnlyUserContextContainer<T> {
    pub fn new(inner: T) -> Self {
        return ReadOnlyUserContextContainer { inner: inner };
    }
}

pub fn converttojS<'js, T>(val: &T, ctx: &rquickjs::Ctx<'js>) -> Result<rquickjs::Value<'js>, Error>
where
    T: Sized + Serialize,
{
    let string = to_string(val)?;
    Ok(ctx.json_parse(string)?)
}

pub fn convertfromjs<'js, T>(
    val: rquickjs::Object<'js>,
    ctx: &rquickjs::Ctx<'js>,
) -> Result<T, Error>
where
    T: DeserializeOwned,
{
    let str: String = ctx
        .json_stringify(val)?
        .ok_or(Error::ExtensionError("Failed to get return value".into()))?
        .get()?;
    Ok(from_str(&str)?)
}
