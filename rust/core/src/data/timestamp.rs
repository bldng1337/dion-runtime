//! Serde helpers for timestamp fields.
//!
//! Timestamps are real `chrono::DateTime<Utc>` values in Rust, `DateTime` in
//! Dart and ISO-8601 strings on every JSON boundary (including the JS
//! boundary, where extension code can use the Temporal API —
//! `Temporal.Instant.from(...)`, whose `toJSON` output parses right back).
//! Deserialization is deliberately lenient so sources can keep emitting what
//! they naturally have: RFC 3339 / ISO-8601 strings (including
//! `Temporal.ZonedDateTime` strings with a trailing `[Zone]` annotation),
//! date-only strings, epoch-second/millisecond numbers, and digit strings of
//! the same.

use chrono::{DateTime, TimeZone, Utc};
use serde::{Deserializer, Serializer};

/// Parses a timestamp from the shapes sources actually emit.
pub fn parse_lenient(input: &str) -> Option<DateTime<Utc>> {
    let trimmed = input.trim();
    if trimmed.is_empty() {
        return None;
    }
    // Temporal.ZonedDateTime toJSON: "2024-01-01T00:00:00+01:00[Europe/Berlin]"
    let trimmed = trimmed.split('[').next().unwrap_or(trimmed).trim_end();
    if let Ok(parsed) = DateTime::parse_from_rfc3339(trimmed) {
        return Some(parsed.with_timezone(&Utc));
    }
    if trimmed.bytes().all(|b| b.is_ascii_digit()) {
        return parse_epoch(trimmed).map(|dt| dt.with_timezone(&Utc));
    }
    let formats = [
        "%Y-%m-%d %H:%M:%S%.f",
        "%Y-%m-%dT%H:%M:%S%.f",
        "%Y-%m-%d %H:%M",
        "%Y-%m-%dT%H:%M",
        "%Y-%m-%d",
    ];
    for format in formats {
        if let Ok(parsed) = chrono::NaiveDateTime::parse_from_str(trimmed, format) {
            return Some(parsed.and_utc());
        }
        if trimmed.len() == 10 {
            if let Ok(date) = chrono::NaiveDate::parse_from_str(trimmed, format) {
                return Some(date.and_hms_opt(0, 0, 0)?.and_utc());
            }
        }
    }
    None
}

fn parse_epoch(digits: &str) -> Option<DateTime<Utc>> {
    let value: i64 = digits.parse().ok()?;
    // Heuristic: >= 1e11 means milliseconds (mihon uses epoch millis; epoch
    // seconds only crossed 1e11 in 5138).
    let seconds = if value >= 100_000_000_000 {
        value / 1000
    } else {
        value
    };
    Utc.timestamp_opt(seconds, 0).single()
}

fn epoch_millis(millis: i64) -> Option<DateTime<Utc>> {
    Utc.timestamp_millis_opt(millis).single()
}

/// Serializes as ISO-8601 with a `Z` suffix (`2024-01-02T03:04:05.678Z`).
fn to_iso(value: &DateTime<Utc>) -> String {
    value.to_rfc3339_opts(chrono::SecondsFormat::Millis, true)
}

/// `#[serde(with = "...timestamp")]` for required fields.
pub mod ts {
    use super::*;

    pub fn serialize<S: Serializer>(
        value: &DateTime<Utc>,
        serializer: S,
    ) -> Result<S::Ok, S::Error> {
        serializer.serialize_str(&to_iso(value))
    }

    pub fn deserialize<'de, D: Deserializer<'de>>(
        deserializer: D,
    ) -> Result<DateTime<Utc>, D::Error> {
        struct Visitor;
        impl serde::de::Visitor<'_> for Visitor {
            type Value = DateTime<Utc>;

            fn expecting(&self, formatter: &mut std::fmt::Formatter) -> std::fmt::Result {
                formatter.write_str("an ISO-8601 timestamp, epoch number, or epoch digit string")
            }

            fn visit_str<E: serde::de::Error>(self, value: &str) -> Result<Self::Value, E> {
                parse_lenient(value)
                    .or_else(|| value.trim().parse::<i64>().ok().and_then(epoch_millis))
                    .ok_or_else(|| E::custom(format!("invalid timestamp: {value:?}")))
            }

            fn visit_i64<E: serde::de::Error>(self, value: i64) -> Result<Self::Value, E> {
                epoch_millis(value)
                    .ok_or_else(|| E::custom(format!("invalid epoch timestamp: {value}")))
            }

            fn visit_u64<E: serde::de::Error>(self, value: u64) -> Result<Self::Value, E> {
                i64::try_from(value)
                    .ok()
                    .and_then(epoch_millis)
                    .ok_or_else(|| E::custom(format!("invalid epoch timestamp: {value}")))
            }

            fn visit_f64<E: serde::de::Error>(self, value: f64) -> Result<Self::Value, E> {
                epoch_millis(value as i64)
                    .ok_or_else(|| E::custom(format!("invalid epoch timestamp: {value}")))
            }
        }
        deserializer.deserialize_any(Visitor)
    }
}

/// `#[serde(default, with = "...option")]` for `Option<DateTime<Utc>>`
/// fields; `null` and an absent field map to `None`.
pub mod option_ts {
    use super::*;

    pub fn serialize<S: Serializer>(
        value: &Option<DateTime<Utc>>,
        serializer: S,
    ) -> Result<S::Ok, S::Error> {
        match value {
            Some(value) => serializer.serialize_some(&to_iso(value)),
            None => serializer.serialize_none(),
        }
    }

    pub fn deserialize<'de, D: Deserializer<'de>>(
        deserializer: D,
    ) -> Result<Option<DateTime<Utc>>, D::Error> {
        struct Visitor;
        impl<'de> serde::de::Visitor<'de> for Visitor {
            type Value = Option<DateTime<Utc>>;

            fn expecting(&self, formatter: &mut std::fmt::Formatter) -> std::fmt::Result {
                formatter
                    .write_str("an ISO-8601 timestamp, epoch number, epoch digit string, or null")
            }

            fn visit_unit<E: serde::de::Error>(self) -> Result<Self::Value, E> {
                Ok(None)
            }

            fn visit_none<E: serde::de::Error>(self) -> Result<Self::Value, E> {
                Ok(None)
            }

            fn visit_some<D: Deserializer<'de>>(
                self,
                deserializer: D,
            ) -> Result<Self::Value, D::Error> {
                super::ts::deserialize(deserializer).map(Some)
            }
        }
        deserializer.deserialize_option(Visitor)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parses_iso_shapes() {
        assert_eq!(
            parse_lenient("2024-01-02T03:04:05Z"),
            Some(Utc.with_ymd_and_hms(2024, 1, 2, 3, 4, 5).unwrap())
        );
        assert_eq!(
            parse_lenient("2024-01-02T03:04:05.678+02:00"),
            Some(
                DateTime::parse_from_rfc3339("2024-01-02T03:04:05.678+02:00")
                    .unwrap()
                    .with_timezone(&Utc)
            )
        );
        // Temporal.ZonedDateTime stringification.
        assert_eq!(
            parse_lenient("2024-01-02T03:04:05+01:00[Europe/Berlin]"),
            parse_lenient("2024-01-02T03:04:05+01:00")
        );
        assert_eq!(
            parse_lenient("2024-01-02"),
            Some(Utc.with_ymd_and_hms(2024, 1, 2, 0, 0, 0).unwrap())
        );
        assert_eq!(
            parse_lenient("2024-01-02 03:04:05"),
            Some(Utc.with_ymd_and_hms(2024, 1, 2, 3, 4, 5).unwrap())
        );
    }

    #[test]
    fn parses_epoch_values() {
        let expected = Utc.with_ymd_and_hms(2024, 1, 2, 3, 4, 5).unwrap();
        assert_eq!(parse_lenient("1704164645"), Some(expected));
        assert_eq!(parse_lenient("1704164645000"), Some(expected));
        assert!(parse_lenient("0").is_some());
    }

    #[test]
    fn rejects_garbage() {
        assert_eq!(parse_lenient("not a date"), None);
        assert_eq!(parse_lenient(""), None);
        assert_eq!(parse_lenient("  "), None);
    }

    #[test]
    fn serde_roundtrip_and_lenient_wire_formats() {
        #[derive(serde::Serialize, serde::Deserialize, Debug, PartialEq)]
        struct Sample {
            #[serde(default, with = "super::option_ts")]
            when: Option<DateTime<Utc>>,
            #[serde(with = "super::ts")]
            created: DateTime<Utc>,
        }
        let created = Utc.with_ymd_and_hms(2024, 1, 2, 3, 4, 5).unwrap();
        let sample = Sample {
            when: Some(created),
            created,
        };
        let json = serde_json::to_value(&sample).unwrap();
        assert_eq!(json["when"], "2024-01-02T03:04:05.000Z");
        assert_eq!(json["created"], "2024-01-02T03:04:05.000Z");
        assert_eq!(serde_json::from_value::<Sample>(json).unwrap(), sample);

        // Lenient inputs.
        let lenient = serde_json::json!({ "when": 1704164645000i64, "created": "1704164645" });
        assert_eq!(serde_json::from_value::<Sample>(lenient).unwrap(), sample);
        // null / absent.
        let none = serde_json::from_value::<Sample>(
            serde_json::json!({ "created": "2024-01-02T03:04:05Z" }),
        )
        .unwrap();
        assert_eq!(none.when, None);
    }
}
