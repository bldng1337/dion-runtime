# Dion runtime

The extension runtime behind the [Dion](https://github.com/bldng1337/dion) app.
The runtime is written in [rust](https://www.rust-lang.org/) with bindings for [flutter](https://flutter.dev/) and [node](https://nodejs.org/).

# Supported Extension Formats
- Dions own extension format: `.dion.js`.
- Mihon/Aniyomi/Tsundoku extensions `.apk` (This is on best effort basis).

## Development

You need `bun`, `cargo`, `dart`, `flutter` and `biome` on your `PATH`.

```sh
bun install
bun run precommit   # formats, then runs every check
```
