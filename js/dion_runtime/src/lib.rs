#![deny(clippy::all)]

use napi_derive::napi;
pub mod cancel;
pub mod client;
pub mod error;
pub mod extension;
pub mod manager;

#[napi]
pub fn plus_100(input: u32) -> u32 {
  input + 100
}
