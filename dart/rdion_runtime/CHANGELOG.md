## 0.1.0

* Breaking: `Episode.timestamp` and `CustomUI.Timestamp` are now real
  `DateTime` values (ISO-8601 on the wire) instead of strings; lenient
  parsing still accepts epoch seconds/milliseconds.
* `Source.Paragraphlist` gained an optional `audio` list (paragraph index
  spans) for parity with `Source.Imagelist`.
* New `ProxyExtension.storageUsage()` / `ProxyExtension.clearCache()`:
  per-extension storage split into cache / extension / data buckets.
* Runtime logs (extension load failures, proxy errors, ...) are forwarded
  to stderr by default (visible in `flutter run` and logcat).
* Android: `content://` URIs work with the extension `filesystem` read
  APIs (`readFile`, `readTextFile`, `stat`, `exists`) via ContentResolver.
* Runtime: `handleProxy` results may return `{ type: "file", path }` to
  stream a local file with HTTP `Range` support; metadata `inspect`
  understands PDF and RAR/CBR containers; extension JS gains WHATWG
  `TextEncoder`/`TextDecoder` and the Temporal API; mihon extensions that
  are also installed as system apps stay uninstalled across restarts.

## 0.0.1

* TODO: Describe initial release.
