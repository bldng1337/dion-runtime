//! WHATWG-style `TextEncoder`/`TextDecoder` globals for the extension VM.
//!
//! Mirrors the browser/Node API surface: `TextEncoder` always encodes UTF-8
//! (`encode`/`encodeInto`), `TextDecoder` supports every WHATWG encoding
//! label via encoding_rs with `fatal`/`ignoreBOM` options and incremental
//! `decode(..., { stream: true })` decoding.

use anyhow::{Context as ErrorContext, Result};
use boa_engine::Context;
use boa_engine::JsData;
use boa_engine::boa_class;
use boa_gc::{Finalize, Trace};
use encoding_rs::{Decoder, Encoding, UTF_8};
use std::sync::{Arc, Mutex};

use crate::utils::MapJsResult;

pub fn declare(context: &mut Context) -> Result<()> {
    context
        .register_global_class::<TextEncoderState>()
        .map_anyhow_ctx(context)
        .context("Failed to register TextEncoder class")?;
    context
        .register_global_class::<TextDecoderState>()
        .map_anyhow_ctx(context)
        .context("Failed to register TextDecoder class")?;
    Ok(())
}

fn new_decoder(encoding: &'static Encoding, ignore_bom: bool) -> Decoder {
    if ignore_bom {
        encoding.new_decoder_without_bom_handling()
    } else {
        encoding.new_decoder_with_bom_removal()
    }
}

fn type_error(message: impl Into<String>) -> boa_engine::JsError {
    boa_engine::JsError::from_native(boa_engine::JsNativeError::typ().with_message(message.into()))
}

/// Converts an optional `Uint8Array` argument to bytes (`undefined`/`null`
/// and missing arguments map to empty input).
fn bytes_arg(
    value: &boa_engine::JsValue,
    name: &str,
    context: &mut Context,
) -> boa_engine::JsResult<Vec<u8>> {
    use boa_engine::object::builtins::JsUint8Array;
    if value.is_undefined() || value.is_null() {
        return Ok(Vec::new());
    }
    let Some(object) = value.as_object() else {
        return Err(type_error(format!("{name} must be a Uint8Array")));
    };
    let array = JsUint8Array::from_object(object)
        .map_err(|_| type_error(format!("{name} must be a Uint8Array")))?;
    array.to_vec(context)
}

/// Reads an options object (`{ fatal?, ignoreBOM?, stream? }`).
fn opt_flag(
    options: &boa_engine::JsValue,
    field: &str,
    context: &mut Context,
) -> boa_engine::JsResult<bool> {
    if options.is_undefined() || options.is_null() {
        return Ok(false);
    }
    let Some(object) = options.as_object() else {
        return Err(type_error("options must be an object"));
    };
    let value = object.get(boa_engine::js_string!(field), context)?;
    match &value {
        v if v.is_undefined() => Ok(false),
        v if v.is_boolean() => Ok(v.as_boolean().unwrap()),
        _ => Err(type_error(format!("options.{field} must be a boolean"))),
    }
}

/// `TextEncoder`: always UTF-8, mirroring the WHATWG/Node API.
#[derive(Debug, Trace, Finalize, JsData)]
struct TextEncoderState;

#[boa_class(rename = "TextEncoder")]
impl TextEncoderState {
    #[boa(constructor)]
    fn new() -> Self {
        Self
    }

    #[boa(getter)]
    fn encoding(&self) -> String {
        "utf-8".to_string()
    }

    fn encode(
        &self,
        input: boa_engine::JsValue,
        context: &mut Context,
    ) -> boa_engine::JsResult<boa_engine::JsValue> {
        use boa_engine::object::builtins::JsUint8Array;
        let text = if input.is_undefined() || input.is_null() {
            String::new()
        } else {
            input
                .as_string()
                .ok_or_else(|| type_error("encode: input must be a string"))?
                .to_std_string_escaped()
        };
        let bytes = UTF_8.encode(&text);
        let array = JsUint8Array::from_iter(bytes.0.to_vec(), context)?;
        Ok(array.into())
    }

    #[boa(rename = "encodeInto")]
    fn encode_into(
        &self,
        source: String,
        destination: boa_engine::JsValue,
        context: &mut Context,
    ) -> boa_engine::JsResult<boa_engine::JsValue> {
        use boa_engine::object::builtins::JsUint8Array;
        let Some(object) = destination.as_object() else {
            return Err(type_error("encodeInto: destination must be a Uint8Array"));
        };
        let array = JsUint8Array::from_object(object)
            .map_err(|_| type_error("encodeInto: destination must be a Uint8Array"))?;
        let capacity = array.length(context)?;
        // Longest prefix of `source` (in whole characters) whose UTF-8
        // encoding fits the destination; `read` counts UTF-16 code units.
        let mut written = 0usize;
        let mut read = 0usize;
        let mut units = String::new();
        for ch in source.chars() {
            let ch_len = ch.len_utf8();
            if written + ch_len > capacity {
                break;
            }
            written += ch_len;
            read += ch.len_utf16();
            units.push(ch);
        }
        for (index, byte) in units.bytes().enumerate() {
            array.set(index as u64, byte, true, context)?;
        }
        let result = boa_engine::JsObject::with_null_proto();
        result.set(boa_engine::js_string!("read"), read, false, context)?;
        result.set(boa_engine::js_string!("written"), written, false, context)?;
        Ok(result.into())
    }
}

/// The underlying encoding_rs decoder plus its finished state. A WHATWG
/// `TextDecoder` is reusable after a non-streaming decode, but an
/// encoding_rs `Decoder` may not be used again once it finished; a fresh
/// one is created lazily instead.
struct DecoderSlot {
    decoder: Decoder,
    finished: bool,
}

/// `TextDecoder`: incremental decoding over any WHATWG encoding with
/// `fatal` and `ignoreBOM` options.
#[derive(Trace, Finalize, JsData)]
struct TextDecoderState {
    #[unsafe_ignore_trace]
    slot: Arc<Mutex<DecoderSlot>>,
    encoding: &'static Encoding,
    encoding_name: String,
    fatal: bool,
    ignore_bom: bool,
}

#[boa_class(rename = "TextDecoder")]
impl TextDecoderState {
    #[boa(constructor)]
    fn new(
        encoding: boa_engine::JsValue,
        options: boa_engine::JsValue,
        context: &mut Context,
    ) -> boa_engine::JsResult<Self> {
        let label = if encoding.is_undefined() || encoding.is_null() {
            "utf-8".to_string()
        } else {
            encoding
                .as_string()
                .ok_or_else(|| type_error("TextDecoder: encoding must be a string"))?
                .to_std_string_escaped()
        };
        let enc = Encoding::for_label(label.as_bytes())
            .ok_or_else(|| type_error(format!("TextDecoder: unknown encoding label {label:?}")))?;
        // The spec forbids the replacement label (it would emit U+FFFD as
        // normal output); reject it like browsers do.
        if enc == encoding_rs::REPLACEMENT {
            return Err(type_error(
                "TextDecoder: the 'replacement' encoding is not supported",
            ));
        }
        let fatal = opt_flag(&options, "fatal", context)?;
        let ignore_bom = opt_flag(&options, "ignoreBOM", context)?;
        Ok(Self {
            slot: Arc::new(Mutex::new(DecoderSlot {
                decoder: new_decoder(enc, ignore_bom),
                finished: false,
            })),
            encoding: enc,
            encoding_name: enc.name().to_ascii_lowercase(),
            fatal,
            ignore_bom,
        })
    }

    #[boa(getter)]
    fn encoding(&self) -> String {
        self.encoding_name.clone()
    }

    #[boa(getter)]
    fn fatal(&self) -> bool {
        self.fatal
    }

    #[boa(getter)]
    fn ignore_bom(&self) -> bool {
        self.ignore_bom
    }

    fn decode(
        &self,
        input: boa_engine::JsValue,
        options: boa_engine::JsValue,
        context: &mut Context,
    ) -> boa_engine::JsResult<boa_engine::JsValue> {
        let bytes = bytes_arg(&input, "input", context)?;
        let stream = opt_flag(&options, "stream", context)?;
        let mut slot = self
            .slot
            .lock()
            .map_err(|_| type_error("TextDecoder: decoder lock is poisoned"))?;
        if slot.finished {
            // The WHATWG spec allows reusing a decoder after a finished
            // (non-streaming) decode; encoding_rs does not.
            slot.decoder = new_decoder(self.encoding, self.ignore_bom);
            slot.finished = false;
        }
        let mut output = String::new();
        if let Some(capacity) = slot.decoder.max_utf8_buffer_length(bytes.len()) {
            output.reserve(capacity);
        }
        // Decode without replacement so fatal mode can distinguish malformed
        // sequences; non-fatal mode re-pushes the remainder after appending a
        // replacement character, matching the WHATWG algorithm.
        let mut src: &[u8] = &bytes;
        let last = !stream;
        loop {
            let (result, read) =
                slot.decoder
                    .decode_to_string_without_replacement(src, &mut output, last);
            src = &src[read..];
            match result {
                encoding_rs::DecoderResult::InputEmpty | encoding_rs::DecoderResult::OutputFull => {
                    break;
                }
                encoding_rs::DecoderResult::Malformed(_, _) => {
                    if self.fatal {
                        slot.finished = last;
                        return Err(type_error(
                            "TextDecoder: malformed input and fatal mode is enabled",
                        ));
                    }
                    output.push('\u{FFFD}');
                }
            }
        }
        slot.finished = last;
        Ok(boa_engine::JsValue::from(boa_engine::JsString::from(
            output,
        )))
    }
}

#[cfg(test)]
mod tests {
    use boa_engine::{Context, Source};

    fn eval(context: &mut Context, code: &str) -> String {
        context
            .eval(Source::from_bytes(code))
            .expect("eval failed")
            .to_string(context)
            .expect("to_string failed")
            .to_std_string_escaped()
    }

    fn context() -> Context {
        let mut context = Context::default();
        super::declare(&mut context).expect("declare text encoding globals");
        context
    }

    #[test]
    fn encoder_roundtrip() {
        let mut context = context();
        assert_eq!(eval(&mut context, "new TextEncoder().encoding"), "utf-8");
        assert_eq!(
            eval(&mut context, "new TextEncoder().encode('héllo 🎉').length"),
            // h(1) é(2) l(1) l(1) o(1) space(1) emoji(4) = 11
            "11"
        );
        assert_eq!(
            eval(
                &mut context,
                "const dst1 = new Uint8Array(3); const r1 = new TextEncoder().encodeInto('abcdé', dst1); `${r1.read}:${r1.written}:${dst1[0]},${dst1[2]}`"
            ),
            "3:3:97,99"
        );
        assert_eq!(
            eval(
                &mut context,
                "const dst2 = new Uint8Array(2); const r2 = new TextEncoder().encodeInto('a🎉', dst2); `${r2.read}:${r2.written}`"
            ),
            // The emoji (4 bytes) doesn't fit, so only 'a' is consumed.
            "1:1"
        );
    }

    #[test]
    fn decoder_basics() {
        let mut context = context();
        assert_eq!(eval(&mut context, "new TextDecoder().encoding"), "utf-8");
        assert_eq!(
            eval(&mut context, "new TextDecoder('latin1').encoding"),
            "windows-1252"
        );
        assert_eq!(
            eval(
                &mut context,
                "new TextDecoder().decode(new Uint8Array([104,105]))"
            ),
            "hi"
        );
        // BOM removal by default, kept with ignoreBOM.
        assert_eq!(
            eval(
                &mut context,
                "new TextDecoder().decode(new Uint8Array([0xEF,0xBB,0xBF,97]))"
            ),
            "a"
        );
        assert_eq!(
            eval(
                &mut context,
                "new TextDecoder('utf-8', {ignoreBOM: true}).decode(new Uint8Array([0xEF,0xBB,0xBF,97])).length"
            ),
            "2"
        );
        // Fatal mode throws on malformed input; default replaces.
        assert_eq!(
            eval(
                &mut context,
                "new TextDecoder().decode(new Uint8Array([0xC3,0x28]))"
            ),
            "\u{FFFD}("
        );
        assert!(
            context
                .eval(Source::from_bytes(
                    "new TextDecoder('utf-8', {fatal: true}).decode(new Uint8Array([0xC3]))"
                ))
                .is_err()
        );
        // Streaming across a split character.
        assert_eq!(
            eval(
                &mut context,
                "const dec = new TextDecoder(); dec.decode(new Uint8Array([0xF0,0x9F]), {stream:true}) + dec.decode(new Uint8Array([0x8E,0x89]))"
            ),
            "🎉"
        );
        // Reusing a decoder after a finished (non-streaming) decode works,
        // matching the WHATWG spec (encoding_rs decoders are single-shot).
        assert_eq!(
            eval(
                &mut context,
                "const dec2 = new TextDecoder(); dec2.decode(new Uint8Array([97])) + dec2.decode(new Uint8Array([98]))"
            ),
            "ab"
        );
        // Unknown label throws.
        assert!(
            context
                .eval(Source::from_bytes("new TextDecoder('nope')"))
                .is_err()
        );
    }
}
