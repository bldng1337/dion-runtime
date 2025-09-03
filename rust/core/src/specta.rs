#[cfg(feature = "type")]
#[allow(dead_code)] //clippy get confused about format_comments
mod ts {
    use std::collections::BTreeMap;

    use specta::datatype::{DataType, NamedDataTypeItem};
    use specta::{
        export::TYPES,
        ts::{self, ExportConfiguration, TsExportError},
    };

    #[test]
    fn gen_types() {
        ts_with_cfg(
            "../../js/dion_runtime_types/index.d.ts",
            &ExportConfiguration::new()
                .bigint(specta::ts::BigIntExportBehavior::Fail)
                .export_by_default(Some(true)),
        )
        .expect("TS Export failed");
    }

    fn ts_with_cfg(path: &str, conf: &ExportConfiguration) -> Result<(), TsExportError> {
        let mut out =
            "// This file has been generated. DO NOT EDIT.\n// dion runtime types\n\n".to_string();
        let types = TYPES.lock().expect("Failed to acquire lock on 'TYPES'");

        if let Some(err) = types.1.iter().next() {
            return Err(err.clone().into());
        }

        // We sort by name to detect duplicate types BUT also to ensure the output is deterministic. The SID can change between builds so is not suitable for this.
        let types = types.0.clone().into_iter().collect::<BTreeMap<_, _>>();

        // This is a clone of `detect_duplicate_type_names` but using a `BTreeMap` for deterministic ordering
        let mut map = BTreeMap::new();
        for (sid, dt) in &types {
            match dt {
                Some(dt) => {
                    if let Some((existing_sid, existing_impl_location)) =
                        map.insert(dt.name, (sid, dt.impl_location))
                    {
                        if existing_sid != sid {
                            return Err(TsExportError::DuplicateTypeName(
                                dt.name,
                                dt.impl_location,
                                existing_impl_location,
                            ));
                        }
                    }
                }
                None => unreachable!(),
            }
        }

        for (_, typ) in types {
            let typ = typ.unwrap();
            out += &format_comments(typ.comments);
            out += format!("type {} = ", typ.name).as_str();

            out += &ts::datatype(
                conf,
                &match typ.item {
                    NamedDataTypeItem::Object(obj) => DataType::Object(obj.clone()),
                    NamedDataTypeItem::Tuple(tuple) => DataType::Tuple(tuple.clone()),
                    NamedDataTypeItem::Enum(enum_) => DataType::Enum(enum_.clone()),
                },
            )?;
            out += "\n\n";
        }

        std::fs::write(path, out).map_err(Into::into)
    }

    fn format_comments(comments: &[&str]) -> String {
        if comments.is_empty() {
            return "".to_owned();
        }
        let mut result = "/**\n".to_owned();
        let mut empty = true;
        for comment in comments {
            let comment = comment.trim_start();
            if comment.starts_with("flutter_rust_bridge") {
                continue;
            }
            empty = false;
            result.push_str(&format!(" * {comment}\n"));
        }
        if empty {
            return "".to_owned();
        }
        result.push_str(" */\n");
        result
    }
}
