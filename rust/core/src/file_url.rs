use std::path::PathBuf;

/// The local path of a `file://` location, or `None` for anything else.
///
/// Hosts send `file://` followed by a raw native path (Dion's `File.fileURL`,
/// e.g. `file://C:\dir\a.apk`), so the path is deliberately not
/// percent-decoded: a literal `%` in a file name must survive. The standard
/// Windows form `file:///C:/dir/a.apk` is accepted as well.
pub fn path_from_file_url(location: &str) -> Option<PathBuf> {
    let path = location.strip_prefix("file://")?;
    Some(PathBuf::from(if cfg!(windows) {
        strip_slash_before_drive(path)
    } else {
        path
    }))
}

fn strip_slash_before_drive(path: &str) -> &str {
    match path.as_bytes() {
        [b'/', drive, b':', ..] if drive.is_ascii_alphabetic() => &path[1..],
        _ => path,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn only_file_urls_have_a_path() {
        assert_eq!(path_from_file_url("https://a.example/x"), None);
        assert!(path_from_file_url("file:///dir/a%20b.js").is_some());
    }

    #[test]
    fn standard_windows_form_loses_its_leading_slash() {
        assert_eq!(strip_slash_before_drive("/C:/dir/a.js"), "C:/dir/a.js");
    }

    #[test]
    fn other_paths_are_left_alone() {
        assert_eq!(strip_slash_before_drive(r"C:\dir\a.js"), r"C:\dir\a.js");
        assert_eq!(strip_slash_before_drive("/home/a.js"), "/home/a.js");
    }
}
