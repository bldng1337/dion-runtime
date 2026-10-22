pub mod cancel;
pub mod client;
/// flutter_rust_bridge:ignore
mod client_impls;
/// flutter_rust_bridge:ignore
mod ext_wrap;
pub mod extension;
pub mod value;
use flutter_rust_bridge::frb;
// pub mod data_comp;

#[frb(init)]
pub fn lets_init_app_here() {
    flutter_rust_bridge::setup_default_user_utils();
    // Default logging sink: forward runtime records (extension load
    // failures, proxy errors, ...) to stderr, which Flutter surfaces in the
    // `flutter run` console and logcat. Embedders wanting the records in
    // Dart can build on dion-runtime's logger from their own host function.
    let _ = dion_runtime::logger::init_logger(|record| {
        eprintln!(
            "[dion {} {}] {}",
            record.level, record.target, record.message
        );
    });
}
