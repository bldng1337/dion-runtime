// Mirrors `rust/mihon/tests/repo_suite_test.rs`, but runs on an Android
// emulator/device against the native Android mihon adapter. Where the desktop
// suite exercises the JVM-embedding compat layer, this suite exercises the
// platform-dependent parts of the runtime that only run on Android: the JNI
// bridge, DEX loading under Android W^X enforcement, the Android network
// stack (TLS/DNS via the device resolver), and app-directory filesystem
// semantics.
//
// Like the desktop suite it:
//   1. resolves each configured repo index (`REPO_INDEX_URLS`) through the
//      adapter's own repo fetching (`getRepo` — legacy `index.min.json`
//      arrays, `repo.json` → `index_v2` redirects, gzipped protobuf stores),
//   2. downloads/updates every listed extension APK into a local cache,
//   3. runs the full workflow (install → browse → search → detail → source →
//      uninstall) against each one, tolerating network/server errors and
//      failing on code/compat-layer bugs,
//   4. records every extension together with the version it was last tested
//      at in `state.json`. Extensions that completed the workflow
//      successfully are skipped on subsequent runs unless the repo ships a
//      newer version; failed extensions are re-tried every run.
//
// The suite itself lives in `lib/repo_suite/runner.dart` and is driven by two
// entrypoints:
//
//   * `integration_test/repo_suite_test.dart` — the `flutter test` variant:
//
//       cd dart/rdion_runtime/example
//       flutter test integration_test/repo_suite_test.dart -d <device-id> \
//         --dart-define=REPO_SUITE_LIMIT=25 ...
//
//     Note that `flutter test` uninstalls the app after the run, wiping the
//     suite state and the APK cache.
//
//   * `lib/main_repo_suite.dart` — a standalone app entrypoint. Build and
//     install it once, then simply relaunch the app for every further run;
//     `adb install -r` (update, no uninstall) keeps the suite state and APK
//     cache across rebuilds:
//
//       flutter build apk --debug \
//         --target=lib/main_repo_suite.dart \
//         --dart-define=REPO_SUITE_LIMIT=60 --dart-define=REPO_SUITE_REPOS=keiyoushi
//       adb install -r build/app/outputs/flutter-apk/app-debug.apk
//       adb logcat -c && adb shell am start -n com.example.rdion_runtime_example/.MainActivity
//       adb logcat -s flutter        # progress and the final summary
//
// # Dart-define knobs (mirroring the desktop suite's environment variables)
//
//   --dart-define=REPO_SUITE_LIMIT=10        test at most N extensions per repo
//   --dart-define=REPO_SUITE_REPOS=keiyoushi comma-separated substrings; only
//                                            matching repo URLs are resolved
//   --dart-define=REPO_SUITE_DIR=/path       override the suite directory
//   --dart-define=REPO_SUITE_RESET=true      delete state.json before running

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import 'package:rdion_runtime_example/repo_suite/runner.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // The full suite runs for hours; opt out of the default test timeout.
  binding.defaultTestTimeout = const Timeout(Duration(hours: 24));

  testWidgets(
    'repo extension suite on android',
    (tester) async {
      await rdion.RustLib.init();
      await runRepoSuite();
    },
    timeout: const Timeout(Duration(hours: 24)),
  );
}
