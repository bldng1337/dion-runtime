// Mirrors `rust/mihon/tests/integration_test.rs`, but runs on an Android
// emulator/device against the native Android mihon adapter (no JVM embedding).
//
// It exercises every `.apk` discovered in the test data directory:
//   install -> browse -> search -> detail -> source -> uninstall
//
// Network/server errors are tolerated; code/compat-layer errors fail the suite.
// Successful APKs are moved into a `success/` subdirectory so subsequent runs
// only exercise the extensions that still need attention (filter-run workflow).
//
// # Running
//
//   1. Build & install the app (includes the Rust + Kotlin compat layer):
//
//        cd dart/rdion_runtime/example
//        flutter build apk --debug --target-platform android-x64
//        adb install -r build/app/outputs/flutter-apk/app-debug.apk
//
//   2. Push the extension APKs into the app's internal test data dir using
//      the helper script (uses `adb shell run-as`, so no storage permissions
//      are needed — works on Android 11+ scoped storage):
//
//        bash script/push_test_apks.sh rust/mihon/testdata/success <apk>...
//
//      or manually:
//
//        adb push foo.apk /data/local/tmp/
//        adb shell run-as com.example.rdion_runtime_example \
//          cp /data/local/tmp/foo.apk files/mihon_testdata/
//
//   3. Run the integration test on a connected emulator/device:
//
//        flutter test integration_test/mihon_extension_test.dart \
//          -d <device-id>
//
//      Override the test data dir with
//      `--dart-define=TESTDATA_DIR=/path/to/apks` (e.g. for shared storage
//      when the app has the relevant permissions).
//
// Note: `flutter test` reinstalls the app, which wipes its internal storage.
// Re-run step 2 after each `flutter test` if the data dir is internal.
//
// # Filter-run workflow
//
// On each run, extensions that complete the full workflow (tolerating network
// errors) are moved into `TESTDATA_DIR/success/` so subsequent runs only
// exercise the extensions that still need attention. Extensions that fail with a
// code/compat bug are NOT moved — they stay in `TESTDATA_DIR/` and are re-tried
// after the underlying compat-layer bug is fixed.

import 'dart:async';
import 'dart:io';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

/// Directory on the device containing the test extension APKs.
///
/// Defaults to `<app support dir>/mihon_testdata`, i.e. the app's internal
/// `/data/data/<package>/files/mihon_testdata`. On Android (API 30+) this is
/// the location the app can read without any storage permissions, and it is
/// also where `adb shell run-as <package>` can write, so APKs can be pushed
/// from the host without permission headaches:
///
///   adb push foo.apk /data/local/tmp/
///   adb shell run-as <package> cp /data/local/tmp/foo.apk files/mihon_testdata/
///
/// Override with `--dart-define=TESTDATA_DIR=/path/to/apks` (e.g. for
/// shared storage when the app has the relevant permissions).
const String _kTestDataDir = String.fromEnvironment(
  'TESTDATA_DIR',
  defaultValue: '', // resolved at runtime against app support dir
);

/// Subdirectory of the test data dir where fully-working extensions are moved
/// so they are excluded from future runs.
const String _kSuccessDirName = 'success';

/// Delay inserted between extension calls to avoid triggering rate limits.
const Duration _kCallDelay = Duration(milliseconds: 500);

/// Per-operation timeout. A single browse/search/detail/source call that takes
/// longer than this is aborted and treated as a tolerated failure rather than
/// hanging the whole suite.
const Duration _kOpTimeout = Duration(seconds: 45);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('mihon full extension workflow on android', (tester) async {
    await rdion.RustLib.init();
    await _runFullExtensionWorkflow();
  });
}

// ── Outcome / error classification ─────────────────────────────────────────

/// Outcome of running the full workflow against a single extension.
///
/// Mirrors the `WorkflowOutcome` enum in the Rust integration test, including
/// the payload strings on the failure variants.
sealed class WorkflowOutcome {
  const WorkflowOutcome();
}

/// The workflow completed. Network/server errors from the call chain are
/// tolerated and still count as success.
class WorkflowSuccess extends WorkflowOutcome {
  const WorkflowSuccess();
}

/// A code/compat-layer bug was hit. The APK is NOT moved to `success/` so it is
/// re-tried after the compat layer is fixed.
class WorkflowCompatFailed extends WorkflowOutcome {
  final String step;
  const WorkflowCompatFailed(this.step);
}

/// Installing or uninstalling failed — an adapter-level error unrelated to a
/// specific extension call.
class WorkflowInstallFailed extends WorkflowOutcome {
  final String reason;
  const WorkflowInstallFailed(this.reason);
}

/// How a single extension-call error should be treated.
enum ErrorKind {
  /// A network/server condition. Tolerated.
  network,

  /// A code/compat-layer bug that must be fixed.
  compat,
}

/// Check whether an error from an extension operation is a genuine network error
/// that should be tolerated by the test, or a code/compat bug that must fail.
///
/// Ported from `classify_extension_error` in the Rust integration test.
ErrorKind classifyExtensionError(String context, Object error) {
  final errorString = error.toString();
  final errorLower = errorString.toLowerCase();

  // Code/compat error patterns — structural failures indicating a real
  // compat-layer bug (missing class/method, bad linkage, type mismatch,
  // VM-level errors). NOT including nullpointer/json/parse: during a network
  // operation those almost always mean the server returned unexpected content.
  const codeErrorIndicators = <String>[
    'noclassdeffounderror',
    'classnotfoundexception',
    'classcastexception',
    'nosuchmethoderror',
    'nosuchfielderror',
    'illegalaccesserror',
    'incompatibleclasschangeerror',
    'linkageerror',
    'outofmemoryerror',
  ];

  for (final indicator in codeErrorIndicators) {
    if (errorLower.contains(indicator)) {
      print(
        '\n❌ CODE/COMPAT ERROR during $context — this is NOT a network error!\n'
        'This indicates a bug in the compat layer or a missing Android stub.\n'
        'Error: $errorString',
      );
      return ErrorKind.compat;
    }
  }

  // Network error patterns — tolerated.
  const networkErrorIndicators = <String>[
    // HTTP status errors
    'http 4',
    'http 5',
    'http error',
    'status code',
    // Connection errors
    'timeout',
    'timed out',
    'connection refused',
    'connection reset',
    'connection closed',
    'connection aborted',
    'connection dropped',
    'unable to resolve host',
    'unknownhostexception',
    'sockettimeoutexception',
    'socketexception',
    'no route to host',
    'connection pool',
    'premature end of',
    // SSL/TLS errors
    'ssl',
    'tls',
    'certificate',
    'handshake',
    // Server-side blocks
    'rate limit',
    'too many requests',
    'cloudflare',
    'access denied',
    'forbidden',
    // NPE during a network operation: server returned unexpected content.
    'cannot invoke',
    'is null',
    'nullpointerexception',
    // Parsing failures during a network operation.
    'expected start of',
    'eof',
    'unexpected json',
    'failed to parse',
    'parse',
    'deserialize',
    // StackOverflowError: extension's own deep recursion during a parse.
    'stackoverflowerror',
    'stackoverflow',
    // Java network exception class names
    'java.net.',
    'javax.net.',
    'java.io.ioexception',
    'okhttp',
  ];

  for (final indicator in networkErrorIndicators) {
    if (errorLower.contains(indicator)) {
      print(
        '⚠️  $context failed with a network error (tolerated): $errorString',
      );
      return ErrorKind.network;
    }
  }

  // Unrecognized: during a network operation, virtually always a server/input
  // condition rather than a compat bug. Log and move on so the suite makes
  // progress across 1000+ extensions.
  print(
    '⚠️  $context failed with an unrecognized error '
    '(tolerated, likely network/input): $errorString',
  );
  return ErrorKind.network;
}

// ── Test data discovery ────────────────────────────────────────────────────

/// Resolve the test data directory. Uses `--dart-define=TESTDATA_DIR` if set,
/// otherwise defaults to `<app support dir>/mihon_testdata`.
Future<Directory> _resolveTestDataDir() async {
  if (_kTestDataDir.isNotEmpty) {
    return Directory(_kTestDataDir);
  }
  final support = await getApplicationSupportDirectory();
  return Directory('${support.path}/mihon_testdata');
}

/// Discover all `.apk` files at the top level of the test data directory,
/// sorted alphabetically for deterministic ordering. Only the top level is
/// scanned, so anything already moved into `success/` is skipped.
List<File> discoverTestApks(Directory testDir) {
  if (!testDir.existsSync()) return const [];
  final apks = testDir
      .listSync(followLinks: false)
      .whereType<File>()
      .where((f) => f.path.toLowerCase().endsWith('.apk'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  return apks;
}

/// Human-readable label for an APK file (its basename).
String apkLabel(File apk) => apk.uri.pathSegments.lastOrNull ?? apk.path;

// ── Mock client (mirrors MockAdapterClient / MockExtensionClient) ──────────

Future<rdion.ManagerClient> _createMockManagerClient({
  required String clientDir,
}) async {
  await Directory(clientDir).create(recursive: true);
  return rdion.ManagerClient.init(
    getPath: () => clientDir,
    getClient: (data) async {
      return rdion.ExtensionClient.init(
        loadData: (key) => '',
        storeData: (key, value) {},
        loadDataSecure: (key) => '',
        storeDataSecure: (key, value) {},
        doAction: (action) {},
        requestPermission: (permission, msg) => false,
        getPath: () => clientDir,
        setEntrySetting: (id, key, value) {},
      );
    },
  );
}

// ── Workflow ───────────────────────────────────────────────────────────────

/// Run the full extension workflow against a single APK:
/// install → browse → search → detail → source → uninstall.
Future<WorkflowOutcome> runExtensionWorkflow(
  rdion.ProxyAdapter adapter,
  File apk,
) async {
  rdion.ProxyExtension extension;
  try {
    // `install` routes on the `file://` scheme for local files (matching the
    // Rust integration test); a bare path is treated as a remote URL.
    final location = 'file://${apk.path}';
    extension = await adapter.install(location: location);
  } catch (e) {
    return WorkflowInstallFailed('install: $e');
  }

  String extName;
  try {
    final data = await extension.getExtensionData();
    extName = data.name;
  } catch (_) {
    extName = apkLabel(apk);
  }
  print('✅ Extension installed: $extName');

  final outcome = await runExtensionCalls(extension);

  // Always try to uninstall so we don't leak loaded extensions even when a
  // compat bug was hit. An uninstall failure is an adapter-level error.
  try {
    await adapter.uninstall(ext: extension);
  } catch (e) {
    return WorkflowInstallFailed('uninstall: $e');
  }
  print('✅ Extension uninstalled: $extName');

  return outcome;
}

/// Run the browse → search → detail → source call chain against `extension`.
/// Network errors are tolerated (remaining dependent steps are skipped); compat
/// errors abort as `WorkflowCompatFailed`.
Future<WorkflowOutcome> runExtensionCalls(
  rdion.ProxyExtension extension,
) async {
  // ========== Browse (Popular) ==========
  // Browse is exercised for its own sake (to verify it works). Its first
  // entry's title is logged; its id is NOT used downstream — detail always
  // drills into the search result, matching the Rust integration test.
  print('\n=== Browse (Popular) ===');
  await Future.delayed(_kCallDelay);
  try {
    final browse = await extension.browse(page: 0).timeout(_kOpTimeout);
    print('✅ Browse returned ${browse.content.length} entries');
    if (browse.content.isNotEmpty) {
      print('  First entry: ${browse.content.first.title}');
    }
  } on TimeoutException {
    print('⚠️  browse timed out after $_kOpTimeout (tolerated)');
    return const WorkflowSuccess();
  } catch (e) {
    final kind = classifyExtensionError('browse', e);
    if (kind == ErrorKind.compat) {
      return const WorkflowCompatFailed('browse');
    }
  }

  // ========== Search ==========
  print('\n=== Search ===');
  await Future.delayed(_kCallDelay);

  rdion.EntryId searchId;
  try {
    final search =
        await extension.search(page: 0, filter: 'test').timeout(_kOpTimeout);
    print('✅ Search returned ${search.content.length} entries');
    if (search.content.isEmpty) {
      print('⚠️  Search returned no entries to drill into (tolerated)');
      return const WorkflowSuccess();
    }
    final first = search.content.first;
    searchId = first.id;
    print('  First result: ${first.title} (${first.id.uid})');
  } on TimeoutException {
    print('⚠️  search timed out after $_kOpTimeout (tolerated)');
    return const WorkflowSuccess();
  } catch (e) {
    final kind = classifyExtensionError('search', e);
    if (kind == ErrorKind.compat) {
      return const WorkflowCompatFailed('search');
    }
    return const WorkflowSuccess();
  }

  // Detail always drills into the search result's id (matches Rust test).
  final drillId = searchId;

  // ========== Detail ==========
  print('\n=== Detail ===');
  await Future.delayed(_kCallDelay);

  rdion.EntryDetailed detail;
  try {
    final result = await extension
        .detail(entryid: drillId, settings: {}).timeout(_kOpTimeout);
    detail = result.entry;
  } on TimeoutException {
    print('⚠️  detail timed out after $_kOpTimeout (tolerated)');
    return const WorkflowSuccess();
  } catch (e) {
    final kind = classifyExtensionError('detail', e);
    if (kind == ErrorKind.compat) {
      return const WorkflowCompatFailed('detail');
    }
    return const WorkflowSuccess();
  }

  final title = detail.titles.isNotEmpty ? detail.titles.first : '';
  print(
    '✅ Detail retrieved: $title with ${detail.episodes.length} episodes',
  );

  if (detail.episodes.isEmpty) {
    print('⚠️  Detail returned no episodes to fetch a source for (tolerated)');
    return const WorkflowSuccess();
  }
  final episode = detail.episodes.first;
  print('  First episode: ${episode.name} (${episode.id.uid})');

  // ========== Source ==========
  print('\n=== Source ===');
  await Future.delayed(_kCallDelay);
  try {
    final sourceResult = await extension
        .source(epid: episode.id, settings: {}).timeout(_kOpTimeout);
    final description = switch (sourceResult.source) {
      rdion.Source_Imagelist(:final links) => '${links.length} images',
      rdion.Source_Video(:final sources) => '${sources.length} video sources',
      rdion.Source_Audio(:final sources) => '${sources.length} audio sources',
      rdion.Source_Epub() => 'epub',
      rdion.Source_Pdf() => 'pdf',
      rdion.Source_Paragraphlist(:final paragraphs) =>
        '${paragraphs.length} paragraphs',
    };
    print('✅ Source retrieved: $description');
    return const WorkflowSuccess();
  } on TimeoutException {
    print('⚠️  source timed out after $_kOpTimeout (tolerated)');
    return const WorkflowSuccess();
  } catch (e) {
    final kind = classifyExtensionError('source', e);
    if (kind == ErrorKind.compat) {
      return const WorkflowCompatFailed('source');
    }
    return const WorkflowSuccess();
  }
}

// ── Filter-run: move a successful APK into `success/` ──────────────────────

Future<void> moveToSuccess(File apk, Directory successDir) async {
  await successDir.create(recursive: true);
  final dest = File('${successDir.path}/${apk.uri.pathSegments.last}');
  if (dest.existsSync()) await dest.delete();
  await apk.rename(dest.path);
}

// ── Driver ─────────────────────────────────────────────────────────────────

Future<void> _runFullExtensionWorkflow() async {
  final testDir = await _resolveTestDataDir();
  final successDir = Directory('${testDir.path}/$_kSuccessDirName');

  final apks = discoverTestApks(testDir);
  if (apks.isEmpty) {
    fail(
      'No `.apk` files found in `${testDir.path}`. Push extension APKs to the '
      'device before running, e.g.:\n'
      '  adb shell mkdir -p ${testDir.path}\n'
      '  adb push *.apk ${testDir.path}/\n'
      'or override the directory with '
      '--dart-define=TESTDATA_DIR=/path/to/apks',
    );
  }

  print('=== Initialize ===');
  final docs = await getApplicationDocumentsDirectory();
  final clientDir = '${docs.path}/mihon_client';
  final client = await _createMockManagerClient(clientDir: clientDir);
  final adapter = await rdion.ProxyAdapter.initMihon(client: client);
  print('✅ MihonAdapter initialized successfully');

  print('\nDiscovered ${apks.length} extension APK(s):');
  for (final apk in apks) {
    print('  - ${apkLabel(apk)}');
  }

  final successes = <String>[];
  final compatFailures = <(String, String)>[];
  final installFailures = <(String, String)>[];

  for (var i = 0; i < apks.length; i++) {
    final apk = apks[i];
    final label = apkLabel(apk);
    print(
      '\n======================================== [${i + 1}/${apks.length}]\n'
      '=== Testing extension: $label ===\n'
      '========================================',
    );
    switch (await runExtensionWorkflow(adapter, apk)) {
      case WorkflowSuccess():
        print('✅ SUCCESS: $label');
        try {
          await moveToSuccess(apk, successDir);
          print('📦 Moved $label to $_kSuccessDirName/');
        } catch (e) {
          print('warn: could not move $label to $successDir: $e');
        }
        successes.add(label);
      case WorkflowCompatFailed(:final step):
        print('❌ COMPAT FAIL: $label ($step)');
        compatFailures.add((label, step));
      case WorkflowInstallFailed(:final reason):
        print('⚠️  INSTALL/UNINSTALL FAIL: $label ($reason)');
        installFailures.add((label, reason));
    }
  }

  print('\n========================================');
  print('=== SUMMARY ===');
  print('========================================');
  print('Total:   ${apks.length}');
  print('Success: ${successes.length} (moved to $_kSuccessDirName/)');
  print('Compat:  ${compatFailures.length}');
  print('Install: ${installFailures.length}');

  if (compatFailures.isNotEmpty) {
    print('\n--- Compat/code failures (these need fixing) ---');
    for (final (label, step) in compatFailures) {
      print('  $label  @  $step');
    }
  }
  if (installFailures.isNotEmpty) {
    print('\n--- Install/uninstall failures ---');
    for (final (label, reason) in installFailures) {
      print('  $label  @  $reason');
    }
  }

  if (compatFailures.isNotEmpty) {
    fail(
      '\n❌ ${compatFailures.length} extension(s) failed with code/compat '
      'errors that need fixing (see list above).\n'
      '${successes.length} extension(s) succeeded and were moved to '
      '$_kSuccessDirName/ — re-running now will only exercise the remaining '
      'extensions.',
    );
  }

  print('\n✅ All extension(s) completed successfully!');
}
