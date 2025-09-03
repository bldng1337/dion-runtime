use flutter_rust_bridge::frb;
pub use serde_json::Value;

#[frb(rust2dart(dart_type = "dynamic", dart_code = "jsonDecode({})"))]
pub fn encode_fancy_type(raw: Value) -> String {
    serde_json::to_string(&raw).unwrap()
}

#[frb(dart2rust(dart_type = "dynamic", dart_code = "jsonEncode({})"))]
pub fn decode_fancy_type(raw: String) -> Value {
    serde_json::from_str(&raw).unwrap()
}
