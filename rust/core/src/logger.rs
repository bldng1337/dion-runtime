//! Logging bridge for embedding applications.
//!
//! The runtime emits diagnostics (extension load failures, permission
//! persist errors, proxy problems, ...) through the `log` crate, which is a
//! no-op unless someone installs a logger. Embedders that want visibility —
//! e.g. a Node app forwarding records into its own logger, or a Flutter app
//! writing to logcat — call [`init_logger`] once at startup and receive
//! every record the runtime produces. Until then, records silently go
//! nowhere, which historically made broken extension bundles invisible.

use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::OnceLock;

/// One formatted log record, handed to the host callback.
#[derive(Debug, Clone)]
pub struct LogRecord {
    pub level: log::Level,
    /// The module path that emitted the record (e.g. `dion_extension::extension_manager`).
    pub target: String,
    /// The fully formatted message (`format!("{}", record.args())`).
    pub message: String,
}

type Sink = Box<dyn Fn(&LogRecord) + Send + Sync>;

static SINK: OnceLock<Sink> = OnceLock::new();
static MAX_LEVEL: AtomicUsize = AtomicUsize::new(log::LevelFilter::Off as usize);

struct Bridge;

impl log::Log for Bridge {
    fn enabled(&self, metadata: &log::Metadata) -> bool {
        metadata.level() as usize <= MAX_LEVEL.load(Ordering::Relaxed)
    }

    fn log(&self, record: &log::Record) {
        if !self.enabled(record.metadata()) {
            return;
        }
        if let Some(sink) = SINK.get() {
            sink(&LogRecord {
                level: record.level(),
                target: record.target().to_string(),
                message: format!("{}", record.args()),
            });
        }
    }

    fn flush(&self) {}
}

/// Installs the process-wide logger that forwards records to `callback`.
///
/// The first call wins: later calls only swap nothing — the original sink
/// stays (returning `Ok`). Fails only when some *other* logger is already
/// installed in the process. The max level starts at `Trace`; narrow it
/// with [`set_log_level`].
pub fn init_logger(
    callback: impl Fn(&LogRecord) + Send + Sync + 'static,
) -> Result<(), log::SetLoggerError> {
    if SINK.set(Box::new(callback)).is_err() {
        // A sink is already registered and the bridge is live.
        return Ok(());
    }
    log::set_boxed_logger(Box::new(Bridge))?;
    MAX_LEVEL.store(log::LevelFilter::Trace as usize, Ordering::Relaxed);
    log::set_max_level(log::LevelFilter::Trace);
    Ok(())
}

/// Narrows the records forwarded to the sink (the logger must have been
/// installed with [`init_logger`]; otherwise this is a no-op).
pub fn set_log_level(level: log::LevelFilter) {
    MAX_LEVEL.store(level as usize, Ordering::Relaxed);
    if SINK.get().is_some() {
        log::set_max_level(level);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::sync::Mutex;

    #[test]
    fn forwards_records_to_the_sink() {
        static SEEN: Mutex<Vec<String>> = Mutex::new(Vec::new());
        // Tests in one process share the global logger; only assert when we
        // win the race to install it.
        if init_logger(|record| {
            SEEN.lock()
                .unwrap()
                .push(format!("{} {}", record.level, record.message));
        })
        .is_ok()
        {
            log::error!("boom: {detail}", detail = 42);
            let seen = SEEN.lock().unwrap();
            assert!(seen.last().is_some_and(|last| last == "ERROR boom: 42"));
        }
    }
}
