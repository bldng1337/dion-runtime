use super::*;
use anyhow::Result;
use specta::datatype::{DataType, EnumType, EnumVariant, NamedDataTypeItem};
use specta::export::TYPES;
use specta::ts::{self, ExportConfiguration};
use std::collections::{BTreeMap, HashMap, HashSet};
use std::path::PathBuf;

pub struct Exporter {
    pub rust_to_ts_libs: HashMap<String, String>,
    pub rust_to_valibot_libs: HashMap<String, String>,
    pub output_path: PathBuf,
    pub export_libraries: Vec<String>,
    pub skip_libraries: Vec<String>,
    pub ts_header: String,
    pub valibot_header: String,
    pub ts_conf: ExportConfiguration,
    pub vali_conf: Config,
}

impl Exporter {
    pub fn new(output_path: impl Into<PathBuf>) -> Self {
        Self {
            rust_to_ts_libs: HashMap::new(),
            rust_to_valibot_libs: HashMap::new(),
            output_path: output_path.into(),
            export_libraries: Vec::new(),
            skip_libraries: Vec::new(),
            ts_header: "// This file has been generated. DO NOT EDIT.\n\n".to_string(),
            valibot_header:
                "// This file has been generated. DO NOT EDIT.\nimport * as v from \"valibot\";\n\n"
                    .to_string(),
            ts_conf: ExportConfiguration::new(),
            vali_conf: Config::default(),
        }
    }

    pub fn add_ts_lib_mapping(
        mut self,
        rust_lib: impl Into<String>,
        js_lib: impl Into<String>,
    ) -> Self {
        self.rust_to_ts_libs.insert(rust_lib.into(), js_lib.into());
        self
    }

    pub fn add_valibot_lib_mapping(
        mut self,
        rust_lib: impl Into<String>,
        js_lib: impl Into<String>,
    ) -> Self {
        self.rust_to_valibot_libs
            .insert(rust_lib.into(), js_lib.into());
        self
    }

    pub fn add_lib_mapping(
        self,
        rust_lib: impl Into<String> + Clone,
        js_lib: impl Into<String> + Clone,
    ) -> Self {
        self.add_ts_lib_mapping(rust_lib.clone(), js_lib.clone())
            .add_valibot_lib_mapping(rust_lib, js_lib)
    }

    pub fn export_lib(mut self, lib: impl Into<String>) -> Self {
        self.export_libraries.push(lib.into());
        self
    }

    pub fn skip_lib(mut self, lib: impl Into<String>) -> Self {
        self.skip_libraries.push(lib.into());
        self
    }

    pub fn ts_header(mut self, header: impl Into<String>) -> Self {
        self.ts_header = header.into();
        self
    }

    pub fn valibot_header(mut self, header: impl Into<String>) -> Self {
        self.valibot_header = header.into();
        self
    }

    pub fn ts_conf(mut self, conf: ExportConfiguration) -> Self {
        self.ts_conf = conf;
        self
    }

    pub fn vali_conf(mut self, conf: Config) -> Self {
        self.vali_conf = conf;
        self
    }

    pub fn run(&self) -> Result<()> {
        let types_lock = TYPES.lock().expect("Failed to acquire lock on 'TYPES'");
        let (ref type_map, ref errors) = *types_lock;

        if let Some(err) = errors.iter().next() {
            return Err(err.clone().into());
        }

        let mut filtered_types = BTreeMap::new();
        for (sid, dt) in type_map {
            if let Some(dt) = dt {
                let should_export = if self.export_libraries.is_empty() {
                    true
                } else {
                    dt.impl_location
                        .map(|loc| {
                            self.export_libraries
                                .iter()
                                .any(|lib| loc.as_str().contains(lib))
                        })
                        .unwrap_or(false)
                };

                let should_skip = dt
                    .impl_location
                    .map(|loc| {
                        self.skip_libraries
                            .iter()
                            .any(|lib| loc.as_str().contains(lib))
                    })
                    .unwrap_or(false);

                if should_export && !should_skip {
                    filtered_types.insert(dt.name, (sid, dt));
                }
            }
        }

        // Duplicate detection
        let mut name_map = BTreeMap::new();
        for (name, (sid, dt)) in &filtered_types {
            if let Some((existing_sid, existing_loc)) =
                name_map.insert(*name, (**sid, dt.impl_location))
                && existing_sid != **sid
            {
                return Err(specta::ts::TsExportError::DuplicateTypeName(
                    name,
                    dt.impl_location,
                    existing_loc,
                )
                .into());
            }
        }

        // Topological sort for Valibot
        let mut sorted_names = Vec::new();
        let mut visited = HashSet::new();
        let mut visiting = HashSet::new();
        let mut recursive_types = HashSet::new();

        for name in filtered_types.keys() {
            self.topo_visit(
                name,
                &filtered_types,
                &mut visited,
                &mut visiting,
                &mut sorted_names,
                &mut recursive_types,
            )?;
        }

        let mut vali_conf = self.vali_conf.clone();
        for name in recursive_types {
            vali_conf.recursive_types.insert(name);
        }

        let mut ts_out = self.ts_header.clone();
        let mut vali_out = self.valibot_header.clone();

        // Handle imports for TS
        let mut ts_imports: HashMap<String, Vec<String>> = HashMap::new();
        for (_, dt) in filtered_types.values() {
            self.collect_imports(&dt.item, type_map, &self.rust_to_ts_libs, &mut ts_imports);
        }
        self.write_imports(&mut ts_out, &ts_imports, &filtered_types);

        // Handle imports for Valibot
        let mut vali_imports: HashMap<String, Vec<String>> = HashMap::new();
        for (_, dt) in filtered_types.values() {
            self.collect_imports(
                &dt.item,
                type_map,
                &self.rust_to_valibot_libs,
                &mut vali_imports,
            );
        }
        self.write_imports(&mut vali_out, &vali_imports, &filtered_types);

        for name in &sorted_names {
            let (_, dt) = filtered_types.get(name).unwrap();
            ts_out += &format_comments(dt.comments);
            ts_out += &format!("export type {} = ", dt.name);

            vali_out += &format_comments(dt.comments);
            let type_annotation = if vali_conf.recursive_types.contains(name) {
                ": v.GenericSchema"
            } else {
                ""
            };
            vali_out += &format!("export const {}{} = ", dt.name, type_annotation);

            let inner_dt = match &dt.item {
                NamedDataTypeItem::Object(obj) => DataType::Object(obj.clone()),
                NamedDataTypeItem::Tuple(tuple) => DataType::Tuple(tuple.clone()),
                NamedDataTypeItem::Enum(enum_) => DataType::Enum(enum_.clone()),
            };

            ts_out += &ts::datatype(&self.ts_conf, &inner_dt)?;
            ts_out += ";\n\n";

            vali_out += &datatype(&vali_conf, &inner_dt)?;
            vali_out += ";\n\n";
        }

        if !self.output_path.exists() {
            std::fs::create_dir_all(&self.output_path)?;
        }

        std::fs::write(self.output_path.join("generated_types.ts"), ts_out)?;
        std::fs::write(self.output_path.join("generated_validators.ts"), vali_out)?;

        Ok(())
    }

    fn write_imports(
        &self,
        out: &mut String,
        imports: &HashMap<String, Vec<String>>,
        filtered_types: &BTreeMap<
            &'static str,
            (&specta::TypeSid, &specta::datatype::NamedDataType),
        >,
    ) {
        let mut import_libs: Vec<_> = imports.keys().collect();
        import_libs.sort();

        let mut wrote_any = false;
        for js_lib in import_libs {
            let mut types = imports.get(js_lib).unwrap().clone();
            types.retain(|t| !filtered_types.contains_key(t.as_str()));
            if types.is_empty() {
                continue;
            }
            types.sort();
            types.dedup();
            *out += &format!("import {{ {} }} from \"{}\";\n", types.join(", "), js_lib);
            wrote_any = true;
        }
        if wrote_any {
            *out += "\n";
        }
    }

    fn topo_visit(
        &self,
        name: &'static str,
        types: &BTreeMap<&'static str, (&specta::TypeSid, &specta::datatype::NamedDataType)>,
        visited: &mut HashSet<&'static str>,
        visiting: &mut HashSet<&'static str>,
        sorted: &mut Vec<&'static str>,
        recursive_types: &mut HashSet<&'static str>,
    ) -> Result<()> {
        if visited.contains(name) {
            return Ok(());
        }
        if visiting.contains(name) {
            // Circular dependency detected.
            recursive_types.insert(name);
            return Ok(());
        }

        visiting.insert(name);

        if let Some((_, dt)) = types.get(name) {
            let mut deps = HashSet::new();
            self.collect_deps(&dt.item, &mut deps);
            for dep in deps {
                if types.contains_key(dep) {
                    self.topo_visit(dep, types, visited, visiting, sorted, recursive_types)?;
                }
            }
        }

        visiting.remove(name);
        visited.insert(name);
        sorted.push(name);

        Ok(())
    }

    fn collect_deps(&self, item: &NamedDataTypeItem, deps: &mut HashSet<&'static str>) {
        match item {
            NamedDataTypeItem::Object(obj) => {
                for field in &obj.fields {
                    Exporter::collect_type_deps(&field.ty, deps);
                }
            }
            NamedDataTypeItem::Tuple(tuple) => {
                for field in &tuple.fields {
                    Exporter::collect_type_deps(field, deps);
                }
            }
            NamedDataTypeItem::Enum(e) => match e {
                EnumType::Untagged { variants, .. } => {
                    for v in variants {
                        self.collect_variant_deps(v, deps);
                    }
                }
                EnumType::Tagged { variants, .. } => {
                    for (_, v) in variants {
                        self.collect_variant_deps(v, deps);
                    }
                }
            },
        }
    }

    fn collect_variant_deps(&self, v: &EnumVariant, deps: &mut HashSet<&'static str>) {
        match v {
            EnumVariant::Unit => {}
            EnumVariant::Unnamed(tuple) => {
                for field in &tuple.fields {
                    Exporter::collect_type_deps(field, deps);
                }
            }
            EnumVariant::Named(obj) => {
                for field in &obj.fields {
                    Exporter::collect_type_deps(&field.ty, deps);
                }
            }
        }
    }

    fn collect_type_deps(ty: &DataType, deps: &mut HashSet<&'static str>) {
        match ty {
            DataType::Named(named) => {
                deps.insert(named.name);
            }
            DataType::Reference(r) => {
                deps.insert(r.name);
                for g in &r.generics {
                    Exporter::collect_type_deps(g, deps);
                }
            }
            DataType::Nullable(inner) => Exporter::collect_type_deps(inner, deps),
            DataType::List(inner) => Exporter::collect_type_deps(inner, deps),
            DataType::Record(inner) => {
                Exporter::collect_type_deps(&inner.0, deps);
                Exporter::collect_type_deps(&inner.1, deps);
            }
            DataType::Tuple(tuple) => {
                for field in &tuple.fields {
                    Exporter::collect_type_deps(field, deps);
                }
            }
            DataType::Object(obj) => {
                for field in &obj.fields {
                    Exporter::collect_type_deps(&field.ty, deps);
                }
            }
            _ => {}
        }
    }

    fn collect_imports(
        &self,
        item: &NamedDataTypeItem,
        type_map: &BTreeMap<specta::TypeSid, Option<specta::datatype::NamedDataType>>,
        lib_mapping: &HashMap<String, String>,
        imports: &mut HashMap<String, Vec<String>>,
    ) {
        match item {
            NamedDataTypeItem::Object(obj) => {
                for field in &obj.fields {
                    self.collect_type_imports(&field.ty, type_map, lib_mapping, imports);
                }
            }
            NamedDataTypeItem::Tuple(tuple) => {
                for field in &tuple.fields {
                    self.collect_type_imports(field, type_map, lib_mapping, imports);
                }
            }
            NamedDataTypeItem::Enum(e) => match e {
                EnumType::Untagged { variants, .. } => {
                    for v in variants {
                        self.collect_variant_imports(v, type_map, lib_mapping, imports);
                    }
                }
                EnumType::Tagged { variants, .. } => {
                    for (_, v) in variants {
                        self.collect_variant_imports(v, type_map, lib_mapping, imports);
                    }
                }
            },
        }
    }

    fn collect_variant_imports(
        &self,
        v: &EnumVariant,
        type_map: &BTreeMap<specta::TypeSid, Option<specta::datatype::NamedDataType>>,
        lib_mapping: &HashMap<String, String>,
        imports: &mut HashMap<String, Vec<String>>,
    ) {
        match v {
            EnumVariant::Unit => {}
            EnumVariant::Unnamed(tuple) => {
                for field in &tuple.fields {
                    self.collect_type_imports(field, type_map, lib_mapping, imports);
                }
            }
            EnumVariant::Named(obj) => {
                for field in &obj.fields {
                    self.collect_type_imports(&field.ty, type_map, lib_mapping, imports);
                }
            }
        }
    }

    fn collect_type_imports(
        &self,
        ty: &DataType,
        type_map: &BTreeMap<specta::TypeSid, Option<specta::datatype::NamedDataType>>,
        lib_mapping: &HashMap<String, String>,
        imports: &mut HashMap<String, Vec<String>>,
    ) {
        match ty {
            DataType::Named(named) => {
                self.add_import(named.name, named.impl_location, lib_mapping, imports);
            }
            DataType::Reference(r) => {
                if let Some(Some(dt)) = type_map.get(&r.sid) {
                    self.add_import(dt.name, dt.impl_location, lib_mapping, imports);
                }
                for g in &r.generics {
                    self.collect_type_imports(g, type_map, lib_mapping, imports);
                }
            }
            DataType::Nullable(inner) => {
                self.collect_type_imports(inner, type_map, lib_mapping, imports)
            }
            DataType::List(inner) => {
                self.collect_type_imports(inner, type_map, lib_mapping, imports)
            }
            DataType::Record(inner) => {
                self.collect_type_imports(&inner.0, type_map, lib_mapping, imports);
                self.collect_type_imports(&inner.1, type_map, lib_mapping, imports);
            }
            DataType::Tuple(tuple) => {
                for field in &tuple.fields {
                    self.collect_type_imports(field, type_map, lib_mapping, imports);
                }
            }
            DataType::Object(obj) => {
                for field in &obj.fields {
                    self.collect_type_imports(&field.ty, type_map, lib_mapping, imports);
                }
            }
            _ => {}
        }
    }

    fn add_import(
        &self,
        name: &'static str,
        loc: Option<specta::ImplLocation>,
        lib_mapping: &HashMap<String, String>,
        imports: &mut HashMap<String, Vec<String>>,
    ) {
        if let Some(loc) = loc {
            for (rust_lib, js_lib) in lib_mapping {
                if loc.as_str().contains(rust_lib) {
                    imports
                        .entry(js_lib.clone())
                        .or_default()
                        .push(name.to_string());
                }
            }
        }
    }
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
