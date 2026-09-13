// Standalone entrypoint for the Android repo suite. See
// `integration_test/repo_suite_test.dart` (and `lib/repo_suite/runner.dart`)
// for what the suite does, the dart-define knobs, and how to build/install.
//
// Unlike the integration-test entrypoint this runs without the flutter test
// driver: install the app once, then relaunch it for every run — the suite
// state and the APK cache in the app's external directory survive relaunches
// and `adb install -r` updates.
import 'package:flutter/widgets.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import 'repo_suite/runner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await rdion.RustLib.init();
  try {
    await runRepoSuite();
  } catch (e, st) {
    print('=== REPO SUITE CRASHED ===');
    print('$e');
    print(st);
    rethrow;
  }
}
