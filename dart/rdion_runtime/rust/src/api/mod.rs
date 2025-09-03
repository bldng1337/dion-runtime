pub mod cancel;
pub mod client;
/// flutter_rust_bridge:ignore
mod client_impls;
/// flutter_rust_bridge:ignore
mod ext_wrap;
pub mod extension;
pub mod value;
use flutter_rust_bridge::frb;

#[frb(init)]
pub fn lets_init_app_here() {
    flutter_rust_bridge::setup_default_user_utils();
}
