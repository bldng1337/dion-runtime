#[cfg(feature = "type")]
mod ts {

    #[test]
    fn gen_types() {
        let version = env!("CARGO_PKG_VERSION");
        Exporter::new("../../js/runtime_types/gen/dion_runtime")
            .ts_header(format!(
                "// This file has been generated. DO NOT EDIT.\n// dion runtime types\n// Version: {version}\n\n"
            ))
            .valibot_header(format!(
                "// This file has been generated. DO NOT EDIT.\n// dion runtime types\n// Version: {version}\nimport * as v from \"valibot\";\n\n"
            ))
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
