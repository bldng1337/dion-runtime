pub mod export;

use specta::datatype::{
    DataType, DataTypeReference, EnumRepr, EnumType, EnumVariant, GenericType, LiteralType,
    NamedDataType, NamedDataTypeItem, ObjectType, TupleType,
};
use std::collections::HashSet;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BigIntExportBehavior {
    String,
    Number,
    BigInt,
    Fail,
}

#[derive(Debug, Clone)]
pub struct Config {
    pub bigint: BigIntExportBehavior,
    pub recursive_types: HashSet<&'static str>,
}

impl Config {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn bigint(mut self, behavior: BigIntExportBehavior) -> Self {
        self.bigint = behavior;
        self
    }

    pub fn add_recursive_type(mut self, name: &'static str) -> Self {
        self.recursive_types.insert(name);
        self
    }
}

impl Default for Config {
    fn default() -> Self {
        Self {
            bigint: BigIntExportBehavior::BigInt,
            recursive_types: HashSet::new(),
        }
    }
}

#[derive(Debug, Clone)]
pub enum Error {
    BigIntForbidden(Vec<String>),
    Other(Vec<String>, String),
    UnableToTagUnnamedType(Vec<String>),
}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Error::BigIntForbidden(path) => {
                write!(f, "BigInt is forbidden at path: {}", path.join("."))
            }
            Error::Other(path, msg) => write!(f, "Error at path {}: {}", path.join("."), msg),
            Error::UnableToTagUnnamedType(path) => {
                write!(f, "Unable to tag unnamed type at path: {}", path.join("."))
            }
        }
    }
}

impl std::error::Error for Error {}

/// Convert a DataType to a Valibot schema string
pub fn datatype(conf: &Config, typ: &DataType) -> Result<String, Error> {
    datatype_inner(
        ExportContext {
            conf,
            path: Vec::new(),
        },
        typ,
    )
}

#[derive(Clone)]
struct ExportContext<'a> {
    conf: &'a Config,
    path: Vec<String>,
}

impl<'a> ExportContext<'a> {
    fn with_path(&self, item: &str) -> Self {
        let mut new_path = self.path.clone();
        new_path.push(item.to_string());
        Self {
            conf: self.conf,
            path: new_path,
        }
    }
}

fn datatype_inner(ctx: ExportContext, typ: &DataType) -> Result<String, Error> {
    Ok(match &typ {
        DataType::Any => "v.any()".into(),
        DataType::Primitive(p) => {
            use specta::datatype::PrimitiveType::*;
            match p {
                i8 | i16 | i32 | u8 | u16 | u32 | f32 | f64 => "v.number()".into(),
                usize | isize | i64 | u64 | i128 | u128 => match ctx.conf.bigint {
                    BigIntExportBehavior::String => "v.string()".into(),
                    BigIntExportBehavior::Number => "v.number()".into(),
                    BigIntExportBehavior::BigInt => "v.bigint()".into(),
                    BigIntExportBehavior::Fail => {
                        return Err(Error::BigIntForbidden(ctx.path));
                    }
                },
                String | char => "v.string()".into(),
                bool => "v.boolean()".into(),
            }
        }
        DataType::Literal(literal) => match literal {
            LiteralType::i8(v) => format!("v.literal({})", v),
            LiteralType::i16(v) => format!("v.literal({})", v),
            LiteralType::i32(v) => format!("v.literal({})", v),
            LiteralType::u8(v) => format!("v.literal({})", v),
            LiteralType::u16(v) => format!("v.literal({})", v),
            LiteralType::u32(v) => format!("v.literal({})", v),
            LiteralType::f32(v) => format!("v.literal({})", v),
            LiteralType::f64(v) => format!("v.literal({})", v),
            LiteralType::bool(v) => format!("v.literal({})", v),
            LiteralType::String(v) => format!("v.literal(\"{}\")", v),
            LiteralType::None => "v.null()".to_string(),
        },
        DataType::Nullable(def) => {
            let dt = datatype_inner(ctx, def)?;
            format!("v.nullable({dt})")
        }
        DataType::Record(def) => {
            format!(
                "v.record({}, {})",
                datatype_inner(ctx.clone(), &def.0)?,
                datatype_inner(ctx, &def.1)?
            )
        }
        DataType::List(def) => {
            let dt = datatype_inner(ctx, def)?;
            format!("v.array({dt})")
        }
        DataType::Named(NamedDataType {
            item: NamedDataTypeItem::Tuple(TupleType { fields, .. }),
            ..
        }) => tuple_datatype(ctx, fields)?,
        DataType::Tuple(TupleType { fields, .. }) => tuple_datatype(ctx, fields)?,
        DataType::Named(NamedDataType {
            name,
            item: NamedDataTypeItem::Object(item),
            ..
        }) => object_datatype(ctx.with_path(name), Some(name), item)?,
        DataType::Object(item) => object_datatype(ctx, None, item)?,
        DataType::Named(NamedDataType {
            name,
            item: NamedDataTypeItem::Enum(item),
            ..
        }) => enum_datatype(ctx.with_path(name), Some(name), item)?,
        DataType::Enum(item) => enum_datatype(ctx, None, item)?,
        DataType::Reference(DataTypeReference { name, generics, .. }) => {
            let is_recursive = ctx.conf.recursive_types.contains(name);
            let base = if is_recursive {
                format!("v.lazy(() => {})", name)
            } else {
                name.to_string()
            };

            match &generics[..] {
                [] => base,
                generics => {
                    let generics_str = generics
                        .iter()
                        .map(|v| datatype_inner(ctx.clone(), v))
                        .collect::<Result<Vec<_>, _>>()?
                        .join(", ");

                    if is_recursive {
                        format!("v.lazy(() => {name}({generics_str}))")
                    } else {
                        format!("{name}({generics_str})")
                    }
                }
            }
        }
        DataType::Generic(GenericType(ident)) => ident.to_string(),
    })
}

fn tuple_datatype(ctx: ExportContext, fields: &[DataType]) -> Result<String, Error> {
    match fields {
        [] => Ok("v.null()".to_string()),
        [ty] => datatype_inner(ctx, ty),
        tys => {
            let inner = tys
                .iter()
                .map(|v| datatype_inner(ctx.clone(), v))
                .collect::<Result<Vec<_>, _>>()?
                .join(", ");
            Ok(format!("v.tuple([{}])", inner))
        }
    }
}

fn object_datatype(
    ctx: ExportContext,
    name: Option<&'static str>,
    ObjectType { fields, tag, .. }: &ObjectType,
) -> Result<String, Error> {
    match &fields[..] {
        [] => Ok("v.null()".to_string()),
        fields => {
            let mut field_sections = fields
                .iter()
                .filter(|f| f.flatten)
                .map(|field| datatype_inner(ctx.with_path(field.key), &field.ty))
                .collect::<Result<Vec<_>, _>>()?;

            let mut unflattened_fields = fields
                .iter()
                .filter(|f| !f.flatten)
                .map(|f| {
                    let key = sanitise_key(f.key);
                    let ty = datatype_inner(ctx.with_path(f.key), &f.ty)?;
                    let ty = if f.optional {
                        format!("v.optional({ty})")
                    } else {
                        ty
                    };
                    Ok(format!("{key}: {ty}"))
                })
                .collect::<Result<Vec<_>, Error>>()?;

            if let Some(tag) = tag {
                let type_name =
                    name.ok_or_else(|| Error::UnableToTagUnnamedType(ctx.path.clone()))?;
                unflattened_fields
                    .push(format!("{}: v.literal(\"{type_name}\")", sanitise_key(tag)));
            }

            let mut result = if unflattened_fields.is_empty() {
                "".to_string()
            } else {
                format!("v.object({{ {} }})", unflattened_fields.join(", "))
            };

            if !field_sections.is_empty() {
                if !result.is_empty() {
                    field_sections.push(result);
                }
                if field_sections.len() == 1 {
                    result = field_sections.remove(0);
                } else {
                    result = format!("v.intersect([{}])", field_sections.join(", "));
                }
            }

            Ok(result)
        }
    }
}

fn enum_datatype(
    ctx: ExportContext,
    _name: Option<&'static str>,
    e: &EnumType,
) -> Result<String, Error> {
    match e {
        EnumType::Tagged { variants, repr, .. } => {
            if variants.is_empty() {
                return Ok("v.never()".to_string());
            }

            // Check for picklist optimization
            if matches!(repr, EnumRepr::External)
                && variants.iter().all(|(_, v)| matches!(v, EnumVariant::Unit))
            {
                let variants_str = variants
                    .iter()
                    .map(|(name, _)| format!("\"{}\"", name))
                    .collect::<Vec<_>>()
                    .join(", ");
                return Ok(format!("v.picklist([{}])", variants_str));
            }

            let variant_schemas = variants
                .iter()
                .map(|(variant_name, variant)| {
                    let ctx = ctx.with_path(variant_name);
                    let sanitised_name = format!("\"{}\"", variant_name);

                    Ok(match (repr, variant) {
                        (EnumRepr::Internal { tag }, EnumVariant::Unit) => {
                            format!(
                                "v.object({{ {}: v.literal({sanitised_name}) }})",
                                sanitise_key(tag)
                            )
                        }
                        (EnumRepr::Internal { tag }, EnumVariant::Unnamed(tuple)) => {
                            let typ = datatype_inner(ctx, &DataType::Tuple(tuple.clone()))?;
                            format!(
                                "v.intersect([v.object({{ {}: v.literal({sanitised_name}) }}), {typ}])",
                                sanitise_key(tag)
                            )
                        }
                        (EnumRepr::Internal { tag }, EnumVariant::Named(obj)) => {
                            let mut fields = vec![format!(
                                "{}: v.literal({sanitised_name})",
                                sanitise_key(tag)
                            )];

                            fields.extend(
                                obj.fields
                                    .iter()
                                    .map(|f| {
                                        let key = sanitise_key(f.key);
                                        let ty = datatype_inner(ctx.with_path(f.key), &f.ty)?;
                                        let ty = if f.optional {
                                            format!("v.optional({ty})")
                                        } else {
                                            ty
                                        };
                                        Ok(format!("{key}: {ty}"))
                                    })
                                    .collect::<Result<Vec<_>, Error>>()?,
                            );

                            format!("v.object({{ {} }})", fields.join(", "))
                        }
                        (EnumRepr::External, EnumVariant::Unit) => {
                            format!("v.literal({sanitised_name})")
                        }
                        (EnumRepr::External, v) => {
                            let ts_values = datatype_inner(ctx, &v.data_type())?;
                            format!(
                                "v.object({{ {}: {ts_values} }})",
                                sanitise_key(variant_name)
                            )
                        }
                        (EnumRepr::Adjacent { tag, .. }, EnumVariant::Unit) => {
                            format!(
                                "v.object({{ {}: v.literal({sanitised_name}) }})",
                                sanitise_key(tag)
                            )
                        }
                        (EnumRepr::Adjacent { tag, content }, v) => {
                            let ts_values = datatype_inner(ctx, &v.data_type())?;
                            format!(
                                "v.object({{ {}: v.literal({sanitised_name}), {}: {ts_values} }})",
                                sanitise_key(tag),
                                sanitise_key(content)
                            )
                        }
                    })
                })
                .collect::<Result<Vec<_>, Error>>()?;

            if variant_schemas.len() == 1 {
                Ok(variant_schemas.into_iter().next().unwrap())
            } else {
                let all_objects = variants.iter().all(|(_, v)| match (repr, v) {
                    (EnumRepr::Internal { .. }, EnumVariant::Unnamed(_)) => false,
                    (EnumRepr::External, EnumVariant::Unit) => false,
                    _ => true,
                });

                match repr {
                    EnumRepr::Internal { tag } if all_objects => Ok(format!(
                        "v.variant(\"{tag}\", [{}])",
                        variant_schemas.join(", ")
                    )),
                    EnumRepr::Adjacent { tag, .. } if all_objects => Ok(format!(
                        "v.variant(\"{tag}\", [{}])",
                        variant_schemas.join(", ")
                    )),
                    _ => Ok(format!("v.union([{}])", variant_schemas.join(", "))),
                }
            }
        }
        EnumType::Untagged { variants, .. } => {
            if variants.is_empty() {
                return Ok("v.never()".to_string());
            }
            let variant_schemas = variants
                .iter()
                .map(|variant| match variant {
                    EnumVariant::Unit => Ok("v.null()".to_string()),
                    v => datatype_inner(ctx.clone(), &v.data_type()),
                })
                .collect::<Result<Vec<_>, Error>>()?;

            if variant_schemas.len() == 1 {
                Ok(variant_schemas.into_iter().next().unwrap())
            } else {
                Ok(format!("v.union([{}])", variant_schemas.join(", ")))
            }
        }
    }
}

fn sanitise_key(field_name: &str) -> String {
    let valid = field_name
        .chars()
        .all(|c| c.is_alphanumeric() || c == '_' || c == '$')
        && field_name
            .chars()
            .next()
            .map(|first| !first.is_numeric())
            .unwrap_or(true);

    if !valid {
        format!(r#""{field_name}""#)
    } else {
        field_name.to_string()
    }
}
