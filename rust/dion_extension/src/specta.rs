#[allow(unused_imports)]
#[cfg(feature = "type")]
mod ts {
    use specta::ts::ExportConfiguration;
    use specta_valibot::{BigIntExportBehavior, Config, export::Exporter};

    #[test]
    fn gen_types() {
        let version = env!("CARGO_PKG_VERSION");
        let package_name = env!("CARGO_MANIFEST_DIR")
            .split(|c| c == '/' || c == '\\')
            .last()
            .unwrap();

        Exporter::new("../../js/runtime_types/gen/dion_extension")
            .ts_header(format!(
                "// This file has been generated. DO NOT EDIT.\n// dion extension types\n// Version: {version}\n\n"
            ))
            .valibot_header(format!(
                "// This file has been generated. DO NOT EDIT.\n// dion extension types\n// Version: {version}\nimport * as v from \"valibot\";\n\n"
            ))
            .export_lib(package_name)
            .add_ts_lib_mapping("core", "../dion_runtime/generated_types")
            .add_valibot_lib_mapping("core", "../dion_runtime/generated_validators")
            .ts_conf(
                ExportConfiguration::new()
                    .bigint(specta::ts::BigIntExportBehavior::Fail)
                    .export_by_default(Some(true)),
            )
            .vali_conf(Config::new().bigint(BigIntExportBehavior::Fail))
            .run()
            .expect("TS/Valibot Export failed");
    }
}
