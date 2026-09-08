# AGENTS.md

Dion runtime: a polyglot monorepo. Rust crates implement the runtime and extension
hosts; TS/JS packages expose them to Node/Bun and to extension authors; a Flutter
plugin exposes them to Dart. JS extensions are bundled JS modules executed by a
Rust-hosted boa_engine VM (see `skills/create-extension/SKILL.md` for that API).

## Layout

| Path | What it is |
| --- | --- |
| `rust/core` | Crate `dion-runtime` — the core runtime: extension model, store, client data. No JS VM; everything builds on this. |
| `rust/dion_extension` | Crate `dion-extension` — the Dion extension runtime: hosts JS extensions via boa_engine (extension manager/executor, network, proxy, built-in modules). Depends on `core`. |
| `rust/mihon` | Crate `mihon-adapter` — Mihon/Tachiyomi extension adapter (APK parsing, JNI, mapping) so Dion can run Mihon extensions. Depends on `core`. |
| `rust/specta_valibot` | specta ↔ valibot support used for type exports (enabled via the `type` cargo feature). |
| `js/runtime` | `@dion-js/runtime` — napi-rs native module wrapping `core` + `dion_extension` for Node/Bun; builds `runtime.*.node`. Bun tests in `test/`. |
| `js/lib` | `@dion-js/runtime-lib` — TS convenience library for extension authors (net, html, auth, settings, ui, …). |
| `js/extension_types` | `@dion-js/extension-types` — the TS API surface (`.d.ts`) extensions are written against. |
| `js/runtime_types` | `@dion-js/runtime-types` — TS types **generated** from Rust via specta into `gen/`; don't edit by hand. |
| `js/repo_scripts` | `@dion-js/extension-scripts` — CLI for extension devs: `dion-bundle`, `dion-create`. |
| `js/test_utils` | `@dion-js/extension-test-utils` — helpers for testing extensions. |
| `js/config` | `@dion-js/config` — shared biome/tsconfig presets. |
| `dart/rdion_runtime` | Flutter plugin (`rdion_runtime`) wrapping the runtime via flutter_rust_bridge; its Rust crate lives in `dart/rdion_runtime/rust`, built through cargokit. `example/` has a demo app. |
| `tests/` | Bun workspace with extension test suites (`tests/extensions/*`) and JSON fixtures (`tests/jsondata`). |
| `external/` | Reference checkouts of upstream Android apps (`mihon-upstream`, `tsundoku`). Not part of the build — consult when touching adapters. |
| `skills/create-extension` | Instructions for scaffolding/building/testing Dion extensions. |
| `script/` | Repo maintenance scripts (run with Bun from the repo root). |

The cargo workspace spans `rust/*`, `js/runtime`, and `dart/rdion_runtime/rust`.
JS packages are Bun workspaces orchestrated by turborepo (`bunx turbo build|lint|test|check-types`).

## Checking your work

Prereqs on PATH: `bun`, `cargo`, `dart`, `flutter`, `biome`.

- **`bun run precommit`** — the full gate; run it before finishing any change.
  It formats everything (biome, `cargo fmt`, `dart format` + `dart fix`), then
  runs in order: biome check → `turbo check-types` → `cargo test` →
  `cargo fmt --check` → `cargo clippy -- -D warnings` → `turbo build` →
  `bun test` → `flutter analyze`. All steps must pass; fix at the failing step
  and rerun.
- **`bun script/index.ts <action…> [-p path]… [-r] [-t]`** — targeted actions
  (`build`, `test`, `format`, `lint`, `clean`) across `rust/core`,
  `rust/dion_extension`, `dart/rdion_runtime`, and `js/runtime`. Use `-p` to
  filter by path prefix, `-r` for release builds, `-t` to keep going after a
  failure instead of stopping at the first one.
- **`bun script/genjstypes.ts`** — regenerate the TS types in
  `js/runtime_types/gen` by running the specta generators in `rust/core` and
  `rust/dion_extension`. Rerun after changing specta-typed Rust APIs, and commit
  the regenerated output.
