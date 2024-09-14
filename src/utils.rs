use std::{ops::Deref, sync::Arc};

use rquickjs::{ convert, runtime::UserData, FromJs, Value };
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
        let stringified = <convert::Coerced<String>>
            ::from_js(&val.ctx().clone(), val)
            .map(|string| string.to_string())?;
        Ok(stringified)
    }
}

pub fn wrapcatch<T>(ctx: &rquickjs::Ctx, res: Result<T, rquickjs::Error>) -> Result<T, Error> {
    match res {
        Ok(val) => Ok(val),
        Err(err) =>
            match err {
                rquickjs::Error::Exception => Err(Error::JS(err, val_to_string(ctx.catch())?)),
                _ => Err(Error::JSEngine(err)),
            }
    }
}

pub struct SharedUserContextContainer<T> {
    pub inner: Arc<RwLock<T>>,
}

impl<T> SharedUserContextContainer<T> {
    pub fn new(inner: T) -> Self {
        SharedUserContextContainer { inner: Arc::new(RwLock::new(inner)) }
    }
    pub fn from(arc: Arc<RwLock<T>>) -> Self {
        SharedUserContextContainer { inner: arc }
    }
    pub async  fn get(&self) -> tokio::sync::RwLockReadGuard<'_, T> {
        self.inner.read().await
    }
    pub async  fn get_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, T> {
        self.inner.write().await
    }
}

impl<T> Default for SharedUserContextContainer<T> where T: Default {
    fn default() -> Self {
        Self { inner: Default::default() }
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
        UserContextContainer { inner: RwLock::new(inner) }
    }
    pub fn get(&self) -> tokio::sync::RwLockReadGuard<'_, T> {
        self.inner.blocking_read()
    }
    pub fn get_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, T> {
        self.inner.blocking_write()
    }
}

impl<T> Default for UserContextContainer<T> where T: Default {
    fn default() -> Self {
        Self { inner: Default::default() }
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
    type Target=T;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

impl<T> ReadOnlyUserContextContainer<T>{
    pub fn new(inner:T)-> Self{
        return ReadOnlyUserContextContainer { inner: inner }
    }
}