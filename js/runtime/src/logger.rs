#![allow(clippy::all)]

use napi::threadsafe_function::{ThreadsafeFunction, ThreadsafeFunctionCallMode};
use napi_derive::napi;
use std::sync::OnceLock;

/// One runtime log record, forwarded from Rust to JS.
#[napi(object)]
pub struct LogEntry {
  /// "error" | "warn" | "info" | "debug" | "trace"
  pub level: String,
  /// The Rust module that emitted the record.
  pub target: String,
  /// The fully formatted message.
  pub message: String,
}

static LOGGER: OnceLock<ThreadsafeFunction<LogEntry, ()>> = OnceLock::new();

/// Installs a logging hook for embedding apps: every log record the Rust
/// runtime emits (extension load failures during discovery, proxy errors,
/// permission persist warnings, ...) is forwarded to `callback`. Without
/// this, those records go nowhere — broken extension bundles then fail
/// silently.
///
/// Call once at startup, before creating an `Adapter`:
/// `setLogger((entry) => console.log("[dion:" + entry.level + "] " + entry.message))`.
#[napi(js_name = "setLogger")]
pub fn set_logger(callback: ThreadsafeFunction<LogEntry, ()>) -> napi::Result<()> {
  if LOGGER.set(callback).is_err() {
    // Keep the first installed sink.
    return Ok(());
  }
  dion_runtime::logger::init_logger(|record| {
    if let Some(logger) = LOGGER.get() {
      logger.call(
        Ok(LogEntry {
          level: record.level.to_string().to_ascii_lowercase(),
          target: record.target.clone(),
          message: record.message.clone(),
        }),
        ThreadsafeFunctionCallMode::NonBlocking,
      );
    }
  })
  .map_err(|_| napi::Error::from_reason("another logger is already installed in this process"))?;
  Ok(())
}

/// Narrows the records forwarded to the `setLogger` callback: one of
/// "error", "warn", "info", "debug", "trace" or "off". Defaults to "trace".
#[napi(js_name = "setLogLevel")]
pub fn set_log_level(level: String) -> napi::Result<()> {
  let level = match level.to_ascii_lowercase().as_str() {
    "off" => log::LevelFilter::Off,
    "error" => log::LevelFilter::Error,
    "warn" => log::LevelFilter::Warn,
    "info" => log::LevelFilter::Info,
    "debug" => log::LevelFilter::Debug,
    "trace" => log::LevelFilter::Trace,
    other => {
      return Err(napi::Error::from_reason(format!(
        "unknown log level {other:?}; expected off/error/warn/info/debug/trace"
      )))
    }
  };
  dion_runtime::logger::set_log_level(level);
  Ok(())
}
