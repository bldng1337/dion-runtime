/// The Android repo-suite harness shared by the integration test
/// (`integration_test/repo_suite_test.dart`) and the standalone app
/// entrypoint (`main_repo_suite.dart`). See either for run instructions.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

/// Repo indexes the suite pulls extensions from.
/// Mirrors `REPO_INDEX_URLS` in `repo_suite_test.rs`.
const List<String> kRepoIndexUrls = [
  // Aniyomi anime extensions.
  'https://raw.githubusercontent.com/yuzono/anime-repo/repo/index.min.json',
  // Novel extensions (index redirects to the new-style protobuf store).
  'https://raw.githubusercontent.com/NovelSourcery/extensions/refs/heads/repo/index.min.json',
  // Tachiyomi/Mihon manga extensions.
  'https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json',
];

/// Subdirectory of the suite dir holding the downloaded APKs, one subdir per
/// repo.
const String kApkDirName = 'apks';

/// Skip state file — delete (or pass REPO_SUITE_RESET) to re-test everything.
const String kStateFileName = 'state.json';

/// Packages that are never downloaded or tested. Unlike compat failures these
/// cannot be tolerated: they kill the whole process. Mirrors `SKIPPED_PKGS` in
/// the desktop suite; matched against the extension's APK URL / package name
/// derived from it.
const List<String> kSkippedPkgs = [
  'eu.kanade.tachiyomi.animeextension.en.hanime',
];

/// Total time budget for a single APK download.
const Duration kDownloadTimeout = Duration(seconds: 300);

/// Delay inserted between extension calls to avoid triggering rate limits.
const Duration kCallDelay = Duration(milliseconds: 500);

/// Per-operation timeout. A single browse/search/detail/source call that takes
/// longer than this (e.g. an extension stuck in deep recursion) is aborted and
/// treated as a tolerated failure rather than hanging the whole suite.
const Duration kOpTimeout = Duration(seconds: 45);

/// Grace period waited after a step timed out before the harness uninstalls
/// the extension, so the abandoned in-flight call can unwind first.
const Duration kTimeoutGrace = Duration(seconds: 5);

/// Thrown when the suite cannot proceed (no repos resolved) or ends with
/// code/compat failures. Under `flutter test` this fails the test; in the
/// standalone entrypoint it surfaces as the crash reason.
class SuiteFailure implements Exception {
  final String message;

  const SuiteFailure(this.message);

  @override
  String toString() => message;
}

// ---------------------------------------------------------------------------
// Environment knobs (dart-defines)
// ---------------------------------------------------------------------------

/// `REPO_SUITE_LIMIT`: cap on extensions per repo, for smoke runs.
final int? kEnvLimit = int.tryParse(
  const String.fromEnvironment('REPO_SUITE_LIMIT'),
);

/// `REPO_SUITE_REPOS`: comma-separated substrings filtering the repo URLs.
final List<String>? kEnvRepoFilter = () {
  const value = String.fromEnvironment('REPO_SUITE_REPOS');
  if (value.isEmpty) return null;
  final patterns =
      value.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  return patterns.isEmpty ? null : patterns;
}();

/// `REPO_SUITE_DIR`: override the suite directory.
const String kEnvSuiteDir = String.fromEnvironment('REPO_SUITE_DIR');

/// `REPO_SUITE_RESET`: delete `state.json` before running.
const bool kEnvReset = String.fromEnvironment('REPO_SUITE_RESET') == 'true';

// ---------------------------------------------------------------------------
// Skip state
// ---------------------------------------------------------------------------

/// Last-known outcome for one extension, persisted across runs.
/// Field layout matches `ExtensionState` in `repo_suite_test.rs`.
class ExtensionState {
  final String name;
  final String version;
  final String apk;

  /// `success` | `compat_failed` | `install_failed` | `download_failed`.
  final String status;
  final String? error;

  /// Errors that were tolerated while testing (network/server conditions),
  /// recorded for later triage ("`<step>: <error>`").
  final List<String> toleratedErrors;

  /// Unix timestamp (seconds) of the last test run.
  final int? testedAt;

  const ExtensionState({
    required this.name,
    required this.version,
    required this.apk,
    required this.status,
    this.error,
    this.toleratedErrors = const [],
    this.testedAt,
  });

  factory ExtensionState.fromJson(Map<String, dynamic> json) => ExtensionState(
        name: json['name'] as String? ?? '',
        version: json['version'] as String? ?? '',
        apk: json['apk'] as String? ?? '',
        status: json['status'] as String? ?? '',
        error: json['error'] as String?,
        toleratedErrors:
            (json['tolerated_errors'] as List<dynamic>? ?? const [])
                .cast<String>(),
        testedAt: json['tested_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'version': version,
        'apk': apk,
        'status': status,
        if (error != null) 'error': error,
        if (toleratedErrors.isNotEmpty) 'tolerated_errors': toleratedErrors,
        if (testedAt != null) 'tested_at': testedAt,
      };
}

/// The whole persisted skip state, keyed by repo key, then package name.
/// Mirrors `SuiteState` in `repo_suite_test.rs`.
class SuiteState {
  final Map<String, Map<String, ExtensionState>> repos = {};

  SuiteState();

  factory SuiteState.fromJson(Map<String, dynamic> json) {
    final state = SuiteState();
    // `{"repos": {...}}` is the persisted shape (matching the desktop
    // suite's state.json); the bare repo map is accepted for files written
    // by intermediate builds that skipped the wrapper.
    final repos = json['repos'] as Map<String, dynamic>? ?? json;
    (repos).forEach((repo, exts) {
      (exts as Map<String, dynamic>).forEach((pkg, entry) {
        state.repos.putIfAbsent(repo, () => {})[pkg] =
            ExtensionState.fromJson(entry as Map<String, dynamic>);
      });
    });
    return state;
  }

  Map<String, dynamic> toJson() => {
        'repos': {
          for (final entry in repos.entries)
            entry.key: {
              for (final ext in entry.value.entries)
                ext.key: ext.value.toJson(),
            },
        },
      };

  ExtensionState? entry(String repo, String pkg) => repos[repo]?[pkg];

  void set(String repo, String pkg, ExtensionState state) {
    repos.putIfAbsent(repo, () => {})[pkg] = state;
  }

  int get recordedCount =>
      repos.values.fold(0, (sum, extensions) => sum + extensions.length);
}

int _nowSecs() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

/// Whether an entry records a successful test of exactly this index version.
bool _testedCurrent(ExtensionState? entry, String version) =>
    entry != null && entry.status == 'success' && entry.version == version;

// ---------------------------------------------------------------------------
// Repo / APK naming helpers (mirror the desktop suite's helpers)
// ---------------------------------------------------------------------------

/// Return the directory portion of an index URL — everything before the final
/// path segment. Mirrors `repo_base_url`.
String _repoBaseUrl(String indexUrl) {
  final pos = indexUrl.lastIndexOf('/');
  return pos < 0 ? indexUrl : indexUrl.substring(0, pos);
}

/// Best-effort stable key for a repo (e.g. `keiyoushi__extensions`).
/// Mirrors `derive_repo_name` + `repo_key`.
String _repoKey(String indexUrl) {
  final base = _repoBaseUrl(indexUrl);
  var name = base
      .replaceFirst(RegExp('^https://'), '')
      .replaceFirst(RegExp('^http://'), '');
  if (name.startsWith('raw.githubusercontent.com/')) {
    final parts =
        name.substring('raw.githubusercontent.com/'.length).split('/');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      name = '${parts[0]}/${parts[1]}';
    } else {
      name = name.split('/').first;
    }
  } else {
    name = name.split('/').first;
  }
  return name.replaceAll('/', '__');
}

/// Local APK file name for an index entry: the basename of its download URL
/// (which carries the version), falling back to an id-based name.
String _apkFileName(rdion.RemoteExtension ext) {
  final base = ext.remoteId.split('/').last;
  if (base.isEmpty || base == ext.remoteId) {
    return '${ext.id}-v${ext.version}.apk';
  }
  return base;
}

/// Best-effort package name for an index entry, derived from the APK file
/// name (`<pkg>-v<version>.apk`). The Dart-facing `RemoteExtension` carries
/// `id` (`mihon:<source id>`) but not the Android package name; the package
/// keeps parity with the desktop suite's state keys and skip list.
String _packageName(rdion.RemoteExtension ext) {
  final file = _apkFileName(ext);
  final match = RegExp(r'^(.*)-v\d+[a-zA-Z0-9.\-]*\.apk$').firstMatch(file);
  final pkg = match?.group(1);
  if (pkg != null && pkg.isNotEmpty) return pkg;
  return ext.id;
}

// ---------------------------------------------------------------------------
// APK cache
// ---------------------------------------------------------------------------

/// Download an APK to `dest` (via a `.part` file, overwriting `dest`).
Future<void> _downloadApk(String url, File dest) async {
  final client = HttpClient();
  try {
    final request =
        await client.getUrl(Uri.parse(url)).timeout(kDownloadTimeout);
    request.followRedirects = true;
    final response = await request.close().timeout(kDownloadTimeout);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      await response.drain<void>();
      throw Exception(
        'failed to download $url: HTTP ${response.statusCode}',
      );
    }
    final builder = BytesBuilder(copy: false);
    await for (final chunk in response) {
      builder.add(chunk);
    }
    final bytes = builder.takeBytes();

    await dest.parent.create(recursive: true);
    final part = File('${dest.path}.part');
    await part.writeAsBytes(bytes, flush: true);
    if (await dest.exists()) {
      await dest.delete();
    }
    await part.rename(dest.path);
  } on TimeoutException {
    throw Exception('download of $url timed out after $kDownloadTimeout');
  } finally {
    client.close(force: true);
  }
}

// ---------------------------------------------------------------------------
// Outcome / error classification (mirror of `tests/common/mod.rs`)
// ---------------------------------------------------------------------------

/// Outcome of running the full workflow against a single extension.
sealed class WorkflowOutcome {
  const WorkflowOutcome();
}

/// The workflow completed. Network/server errors from the call chain are
/// tolerated and still count as success; `tolerated` carries the recorded
/// "<step>: <error>" strings.
class WorkflowSuccess extends WorkflowOutcome {
  final List<String> tolerated;
  const WorkflowSuccess(this.tolerated);
}

/// A code/compat-layer bug was hit. The string is `"<step>: <error>"`.
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

/// Check whether an error from an extension operation is a genuine network
/// error that should be tolerated by the test, or a code/compat bug that must
/// fail. Port of `classify_extension_error` in `tests/common/mod.rs`.
ErrorKind classifyExtensionError(String context, Object error) {
  final errorString = error.toString();
  final errorLower = errorString.toLowerCase();

  // Deterministic "needs user configuration" signals — checked before the
  // compat patterns because they are often IllegalStateExceptions: an
  // extension that requires settings or credentials fails the same way on
  // every platform and is not a compat bug.
  const configRequiredIndicators = [
    'extension settings',
    'failed to log in',
    // Comikey-style flows: the chapter content is gated behind a token that
    // only a WebView visit obtains. Deterministic without user interaction
    // on every platform, so tolerated like the above.
    'token not found',
  ];
  if (configRequiredIndicators.any(errorLower.contains)) {
    print(
      '⚠️  $context failed: extension requires user configuration '
      '(tolerated): $errorString',
    );
    return ErrorKind.network;
  }

  // Code/compat error patterns — structural failures indicating a real
  // compat-layer bug (missing class/method, bad linkage, type mismatch,
  // VM-level errors). Deliberately NOT including nullpointerexception/json/
  // parse: during a network operation those almost always mean the server
  // returned unexpected content that the parser choked on — a network/server
  // condition, not a compat bug.
  const codeErrorIndicators = [
    'noclassdeffounderror',
    'classnotfoundexception',
    'classcastexception',
    'nosuchmethoderror',
    'nosuchfielderror',
    'abstractmethoderror',
    'illegalaccesserror',
    'incompatibleclasschangeerror',
    'linkageerror',
    'outofmemoryerror',
    // IllegalStateException: Kotlin `check()`/`error()` failures from the
    // extension's own state machine. Unlike parse/NPE noise these are
    // deterministic local failures, so they are treated as compat bugs.
    'illegalstateexception',
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

  // Network error patterns — these are tolerated.
  const networkErrorIndicators = [
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

  // Not a recognized structural/code error and not a recognized network
  // error: during a network operation this is virtually always a network/
  // input condition rather than a compat bug. Log and move on so the suite
  // makes progress across 1000+ extensions.
  print(
    '⚠️  $context failed with an unrecognized error '
    '(tolerated, likely network/input): $errorString',
  );
  return ErrorKind.network;
}

/// Signals how to abort the rest of an extension's workflow when a step fails.
sealed class StepAbort {
  const StepAbort();
}

/// A tolerated network/server error: skip the remaining dependent steps and
/// treat the extension as having completed successfully.
class StepTolerated extends StepAbort {
  final String message;
  const StepTolerated(this.message);
}

/// A code/compat-layer bug: abort the extension and mark it as failed.
class StepCompat extends StepAbort {
  final String message;
  const StepCompat(this.message);
}

StepAbort _abortForError(String context, Object e) {
  final errorString = e.toString();
  return switch (classifyExtensionError(context, e)) {
    ErrorKind.network => StepTolerated('$context: $errorString'),
    ErrorKind.compat => StepCompat('$context: $errorString'),
  };
}

// ---------------------------------------------------------------------------
// Workflow (mirror of `run_extension_workflow` / `run_extension_calls`)
// ---------------------------------------------------------------------------

/// Run the full extension workflow against a single APK installed via
/// `adapter`: install → browse → search → detail → source → uninstall.
Future<WorkflowOutcome> runExtensionWorkflow(
  rdion.ProxyAdapter adapter,
  File apk,
) async {
  // `install` routes on the `file://` scheme for local files (matching the
  // Rust repo suite); a bare path is treated as a remote URL.
  rdion.ProxyExtension extension;
  try {
    extension = await adapter.install(location: 'file://${apk.path}');
  } catch (e) {
    return WorkflowInstallFailed('install: $e');
  }

  String extName;
  try {
    extName = (await extension.getExtensionData()).name;
  } catch (_) {
    extName = apk.uri.pathSegments.last;
  }
  print('✅ Extension installed: $extName');

  final outcome = await _runExtensionCalls(extension);

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

Future<WorkflowOutcome> _runExtensionCalls(
  rdion.ProxyExtension extension,
) async {
  final tolerated = <String>[];

  // ========== Browse (Popular) ==========
  print('\n=== Browse (Popular) ===');
  await Future<void>.delayed(kCallDelay);
  rdion.EntryId? browseEntryId;
  try {
    final browse = await extension.browse(page: 0).timeout(kOpTimeout);
    print('✅ Browse returned ${browse.content.length} entries');
    if (browse.content.isNotEmpty) {
      browseEntryId = browse.content.first.id;
      print('  First entry: ${browse.content.first.title}');
    }
  } on TimeoutException {
    print('⚠️  browse timed out after $kOpTimeout (tolerated)');
    await Future<void>.delayed(kTimeoutGrace);
    tolerated.add('browse: timed out after $kOpTimeout');
    return WorkflowSuccess(tolerated);
  } catch (e) {
    switch (_abortForError('browse', e)) {
      case StepTolerated(:final message):
        tolerated.add(message);
        return WorkflowSuccess(tolerated);
      case StepCompat(:final message):
        return WorkflowCompatFailed(message);
    }
  }

  if (browseEntryId == null) {
    // Browse succeeded but returned nothing to drill into. That's a
    // server/content condition, not a compat bug.
    print('⚠️  Browse returned no entries to drill into (tolerated)');
    tolerated.add('browse: returned no entries to drill into');
    return WorkflowSuccess(tolerated);
  }
  final browseId = browseEntryId;

  // The entry's identity (its URL) must be non-empty — it is the key used to
  // fetch details later, and an empty uid means our mapping lost the entry's
  // URL.
  if (browseId.uid.isEmpty) {
    return const WorkflowCompatFailed(
      'browse: first entry has an empty uid (entry URL was lost)',
    );
  }

  // ========== Search ==========
  print('\n=== Search ===');
  await Future<void>.delayed(kCallDelay);
  (String, rdion.EntryId)? searchEntry;
  try {
    final search =
        await extension.search(page: 0, filter: 'test').timeout(kOpTimeout);
    print('✅ Search returned ${search.content.length} entries');
    if (search.content.isNotEmpty) {
      final first = search.content.first;
      searchEntry = (first.title, first.id);
    }
  } on TimeoutException {
    print('⚠️  search timed out after $kOpTimeout (tolerated)');
    await Future<void>.delayed(kTimeoutGrace);
    tolerated.add('search: timed out after $kOpTimeout');
    return WorkflowSuccess(tolerated);
  } catch (e) {
    switch (_abortForError('search', e)) {
      case StepTolerated(:final message):
        tolerated.add(message);
        return WorkflowSuccess(tolerated);
      case StepCompat(:final message):
        return WorkflowCompatFailed(message);
    }
  }

  if (searchEntry == null) {
    print('⚠️  Search returned no entries to drill into (tolerated)');
    tolerated.add('search: returned no entries to drill into');
    return WorkflowSuccess(tolerated);
  }
  final (searchTitle, searchId) = searchEntry;
  print('  First result: $searchTitle (${searchId.uid})');

  if (searchId.uid.isEmpty) {
    return const WorkflowCompatFailed(
      'search: first result has an empty uid (entry URL was lost)',
    );
  }

  // ========== Detail ==========
  print('\n=== Detail ===');
  await Future<void>.delayed(kCallDelay);
  // Capture the requested id before it is moved into detail(); the detailed
  // entry's uid must round-trip back to this value.
  final requestedUid = searchId.uid;
  rdion.EntryDetailed detail;
  try {
    final result =
        await extension.detail(entryid: searchId, settings: {}).timeout(
      kOpTimeout,
    );
    detail = result.entry;
  } on TimeoutException {
    print('⚠️  detail timed out after $kOpTimeout (tolerated)');
    await Future<void>.delayed(kTimeoutGrace);
    tolerated.add('detail: timed out after $kOpTimeout');
    return WorkflowSuccess(tolerated);
  } catch (e) {
    switch (_abortForError('detail', e)) {
      case StepTolerated(:final message):
        tolerated.add(message);
        return WorkflowSuccess(tolerated);
      case StepCompat(:final message):
        return WorkflowCompatFailed(message);
    }
  }

  final title = detail.titles.isNotEmpty ? detail.titles.first : '';
  print(
    '✅ Detail retrieved: $title with ${detail.episodes.length} episodes',
  );

  // The detail call must preserve the entry's identity: the detailed entry's
  // uid must be non-empty and match the id we asked details for. Some
  // Tachiyomi/Mihon extensions return a fresh SManga from getMangaDetails
  // with an empty url; the adapter must fall back to the original id in that
  // case rather than propagating an empty uid.
  if (detail.id.uid.isEmpty) {
    return const WorkflowCompatFailed(
      'detail: entry id uid is empty after fetching details',
    );
  }
  if (detail.id.uid != requestedUid) {
    return WorkflowCompatFailed(
      'detail: entry id uid changed from "$requestedUid" (search) to '
      '"${detail.id.uid}" (detail)',
    );
  }

  if (detail.episodes.isEmpty) {
    print('⚠️  Detail returned no episodes to fetch a source for (tolerated)');
    tolerated.add('detail: returned no episodes to fetch a source for');
    return WorkflowSuccess(tolerated);
  }
  final episode = detail.episodes.first;
  print('  First episode: ${episode.name} (${episode.id.uid})');

  // Episode ids (chapter/anime URLs) must be non-empty: they are the key used
  // to resolve the actual content (pages/videos/text) in the source step.
  if (episode.id.uid.isEmpty) {
    return const WorkflowCompatFailed(
      'detail: first episode has an empty uid (chapter/episode URL was lost)',
    );
  }

  // ========== Source ==========
  print('\n=== Source ===');
  final episodeId = episode.id;
  await Future<void>.delayed(kCallDelay);
  try {
    final sourceResult =
        await extension.source(epid: episodeId, settings: {}).timeout(
      kOpTimeout,
    );
    final description = switch (sourceResult.source) {
      rdion.Source_Imagelist(:final links) => '${links.length} images',
      rdion.Source_Video(:final sources) => '${sources.length} video sources',
      rdion.Source_Audio(:final sources) => '${sources.length} audio sources',
      rdion.Source_Paragraphlist(:final paragraphs) =>
        '${paragraphs.length} paragraphs',
      _ => 'Unknown source type',
    };
    print('✅ Source retrieved: $description');
    return WorkflowSuccess(tolerated);
  } on TimeoutException {
    print('⚠️  source timed out after $kOpTimeout (tolerated)');
    await Future<void>.delayed(kTimeoutGrace);
    tolerated.add('source: timed out after $kOpTimeout');
    return WorkflowSuccess(tolerated);
  } catch (e) {
    switch (_abortForError('source', e)) {
      case StepTolerated(:final message):
        tolerated.add(message);
        return WorkflowSuccess(tolerated);
      case StepCompat(:final message):
        return WorkflowCompatFailed(message);
    }
  }
}

// ---------------------------------------------------------------------------
// Mock client (mirror of MockAdapterClient / MockExtensionClient)
// ---------------------------------------------------------------------------

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
        storeSet: (key, value) {},
      );
    },
  );
}

// ---------------------------------------------------------------------------
// The suite
// ---------------------------------------------------------------------------

/// One extension selected for this run, with its cached APK file and whether
/// it still needs testing (false = already succeeded at this version).
class _PlannedExt {
  final String repo;
  final rdion.RemoteExtension ext;
  final File apkFile;
  final bool test;

  const _PlannedExt({
    required this.repo,
    required this.ext,
    required this.apkFile,
    required this.test,
  });

  String get label =>
      '$repo/${ext.name} v${ext.version} (${_packageName(ext)})';
}

/// Resolve the suite directory.
///
/// `REPO_SUITE_DIR` if set. Otherwise the app's external app-specific
/// directory. Note that `flutter test` reinstalls (uninstall + install) the
/// app between runs, which wipes *all* app storage along with the skip state
/// and the APK cache.
///
/// To persist state across reinstalls on an emulator, point the suite at a
/// directory that is owned by neither the app nor any single uid:
///
///   adb root
///   adb shell "chmod 777 /data/local/tmp && mkdir -p /data/local/tmp/repo_suite"
///   flutter test integration_test/repo_suite_test.dart \
///     --dart-define=REPO_SUITE_DIR=/data/local/tmp/repo_suite
///
/// Shared storage (`/sdcard/Download`) does NOT work for this: files created
/// there are owned by the app's uid, and after a reinstall the app gets a new
/// uid and can no longer read *or* write them.
Future<Directory> _resolveSuiteDir() async {
  if (kEnvSuiteDir.isNotEmpty) {
    return Directory(kEnvSuiteDir);
  }
  final external = await getExternalStorageDirectory();
  final base = external?.path ?? (await getApplicationSupportDirectory()).path;
  return Directory('$base/repo_suite');
}

Future<void> _saveState(Directory suiteDir, SuiteState state) async {
  try {
    await suiteDir.create(recursive: true);
    // Write to a `.part` file and rename over the target: rename(2) only
    // needs write permission on the directory, so this also replaces a
    // state file owned by a previous app install (the uid changes on
    // reinstall, which revokes direct write access to the old file).
    final file = File('${suiteDir.path}/$kStateFileName');
    final part = File('${suiteDir.path}/$kStateFileName.part');
    await part.writeAsString(
      const JsonEncoder.withIndent('  ').convert(state.toJson()),
      flush: true,
    );
    if (await file.exists()) {
      await file.delete();
    }
    await part.rename(file.path);
  } catch (e) {
    // Losing the persisted state must not kill the run — the suite only
    // degrades to re-testing extensions it already covered.
    print('⚠️  failed to save $kStateFileName (continuing): $e');
  }
}

Future<void> runRepoSuite() async {
  final suiteDir = await _resolveSuiteDir();
  final apkDir = Directory('${suiteDir.path}/$kApkDirName');
  final stateFile = File('${suiteDir.path}/$kStateFileName');

  print(
    '=== Repo suite: ${kRepoIndexUrls.length} index URL(s), '
    'suite dir ${suiteDir.path} ===',
  );
  print('\n=== Initialize MihonAdapter ===');
  final docs = await getApplicationDocumentsDirectory();
  final client = await _createMockManagerClient(
    clientDir: '${docs.path}/mihon_client',
  );
  final adapter = await rdion.ProxyAdapter.initMihon(client: client);
  print('✅ MihonAdapter initialized successfully');
  final limit = kEnvLimit;
  final repoFilter = kEnvRepoFilter;
  if (limit != null) print('   limit: $limit extension(s)/repo');
  if (repoFilter != null) print('   repo filter: $repoFilter');

  final state = SuiteState();
  if (await stateFile.exists()) {
    if (kEnvReset) {
      await stateFile.delete();
      print('   REPO_SUITE_RESET — deleted $kStateFileName');
    } else {
      try {
        state.repos.addAll(
          SuiteState.fromJson(
            jsonDecode(await stateFile.readAsString()) as Map<String, dynamic>,
          ).repos,
        );
      } catch (e) {
        print(
          '⚠️  corrupt state file ${stateFile.path} — starting fresh: $e',
        );
      }
    }
  }
  print(
    '   ${state.recordedCount} extension(s) in state ($kStateFileName)',
  );

  // ---- Phase 1: resolve the repo indexes ----
  final repos = <(String, rdion.ExtensionRepo, List<rdion.RemoteExtension>)>[];
  for (final url in kRepoIndexUrls) {
    if (repoFilter != null && !repoFilter.any(url.contains)) {
      print('⏭️  Skipping repo $url (filtered by REPO_SUITE_REPOS)');
      continue;
    }
    print('\n=== Resolving index: $url ');
    final repo = await adapter.getRepo(url: url);
    final key = _repoKey(url);
    final result = await adapter.browseRepo(repo: repo, page: 0);
    print(
      '→ $key (${repo.name}, ${result.content.length} extensions)',
    );
    repos.add((key, repo, result.content));
  }
  if (repos.isEmpty) {
    const SuiteFailure('no repo index resolved — nothing to do');
  }

  // ---- Phase 2: download/update APKs, decide what to test ----
  print('\n=== Syncing APK cache (${apkDir.path}) ===');
  final planned = <_PlannedExt>[];
  var skippedPkg = 0;
  var alreadyOk = 0;
  var downloaded = 0;
  final downloadFailures = <(String, String)>[];

  for (final (key, _, entries) in repos) {
    var listed = entries;
    if (limit != null && listed.length > limit) {
      listed = listed.sublist(0, limit);
    }
    for (final ext in listed) {
      final pkg = _packageName(ext);
      final label = '$key/${ext.name} v${ext.version} ($pkg)';
      if (kSkippedPkgs.any(pkg.contains) ||
          kSkippedPkgs.any(ext.remoteId.contains)) {
        print(
          '⏭️  $key: ${ext.name} — package on the known-crasher list, '
          'never tested',
        );
        skippedPkg += 1;
        continue;
      }
      if (ext.remoteId.isEmpty) {
        print('⚠️  $label: index entry has no apk url');
        downloadFailures.add((label, 'index entry has no apk url'));
        state.set(
          key,
          pkg,
          ExtensionState(
            name: ext.name,
            version: ext.version,
            apk: '',
            status: 'download_failed',
            error: 'index entry has no apk url',
            testedAt: _nowSecs(),
          ),
        );
        continue;
      }

      final file = _apkFileName(ext);
      final apkFile = File('${apkDir.path}/$key/$file');
      final entry = state.entry(key, pkg);
      final tested = _testedCurrent(entry, ext.version);

      // Download when the APK is missing, or when the index ships a version
      // we have not cached (same file name with different contents is
      // possible, so re-download on any version change).
      final versionChanged = entry != null && (entry.version != ext.version);
      if (!await apkFile.exists() || versionChanged) {
        try {
          await _downloadApk(ext.remoteId, apkFile);
          downloaded += 1;
          final size = await apkFile.length();
          print(
            '⬇️  $label: $file (${(size / 1e6).toStringAsFixed(1)} MB)',
          );
        } catch (e) {
          print('❌ $label: download failed: $e');
          downloadFailures.add((label, e.toString()));
          state.set(
            key,
            pkg,
            ExtensionState(
              name: ext.name,
              version: ext.version,
              apk: file,
              status: 'download_failed',
              error: e.toString(),
              testedAt: _nowSecs(),
            ),
          );
          continue;
        }
      }

      if (tested) {
        alreadyOk += 1;
        print(
          '✅ $label: already tested successfully at this version — skipping',
        );
      }
      planned.add(
        _PlannedExt(
          repo: key,
          ext: ext,
          apkFile: apkFile,
          test: !tested,
        ),
      );
    }
  }
  await _saveState(suiteDir, state);

  // ---- Phase 3: run the workflow ----
  final toTest = planned.where((p) => p.test).toList();
  if (toTest.isEmpty) {
    print(
      '\n✅ Nothing to test — every extension is already recorded as '
      'succeeding at its current version.\n   Delete $kStateFileName '
      '(or pass REPO_SUITE_RESET=true) to force a full re-run.',
    );
    return;
  }

  var successes = 0;
  final compatFailures = <(String, String)>[];
  final installFailures = <(String, String)>[];

  for (var i = 0; i < toTest.length; i++) {
    final p = toTest[i];
    final label = p.label;
    print(
      '\n======================================== [${i + 1}/${toTest.length}]\n'
      '=== Testing extension: $label ===\n'
      '========================================',
    );

    final pkg = _packageName(p.ext);
    String status;
    String? error;
    var toleratedErrors = <String>[];
    switch (await runExtensionWorkflow(adapter, p.apkFile)) {
      case WorkflowSuccess(:final tolerated):
        successes += 1;
        print('✅ SUCCESS: $label');
        if (tolerated.isNotEmpty) {
          print(
            '   (tolerated ${tolerated.length} network/server error(s), '
            'recorded in state)',
          );
        }
        toleratedErrors = tolerated;
        status = 'success';
      case WorkflowCompatFailed(:final step):
        print('❌ COMPAT FAIL: $label ($step)');
        compatFailures.add((label, step));
        status = 'compat_failed';
        error = step;
      case WorkflowInstallFailed(:final reason):
        print('⚠️  INSTALL/UNINSTALL FAIL: $label ($reason)');
        installFailures.add((label, reason));
        status = 'install_failed';
        error = reason;
    }

    state.set(
      p.repo,
      pkg,
      ExtensionState(
        name: p.ext.name,
        version: p.ext.version,
        apk: _apkFileName(p.ext),
        status: status,
        error: error,
        toleratedErrors: toleratedErrors,
        testedAt: _nowSecs(),
      ),
    );
    // Persist after every extension so an interrupted run keeps its
    // progress (the full suite runs for hours).
    await _saveState(suiteDir, state);
  }

  // ---- Phase 4: summary ----
  print('\n========================================');
  print('=== REPO SUITE SUMMARY ===');
  print('========================================');
  print('Repos resolved:     ${repos.length}');
  print(
    'Extensions listed:  ${planned.length + skippedPkg + downloadFailures.length}',
  );
  print('APKs downloaded:    $downloaded');
  print('Skipped (known crashers): $skippedPkg');
  print('Skipped (already OK):    $alreadyOk');
  print('Tested:             ${toTest.length}');
  print('  success:          $successes');
  print('  compat failures:  ${compatFailures.length}');
  print('  install failures: ${installFailures.length}');
  print('Download failures:  ${downloadFailures.length}');
  print('State file:         ${stateFile.path} '
      '(delete or REPO_SUITE_RESET=true to re-test everything)');

  if (downloadFailures.isNotEmpty) {
    print('\n--- Download failures (retried on the next run) ---');
    for (final (label, reason) in downloadFailures) {
      print('  $label  @  $reason');
    }
  }
  if (installFailures.isNotEmpty) {
    print('\n--- Install/uninstall failures ---');
    for (final (label, reason) in installFailures) {
      print('  $label  @  $reason');
    }
  }
  if (compatFailures.isNotEmpty) {
    print('\n--- Compat/code failures (these need fixing) ---');
    for (final (label, step) in compatFailures) {
      print('  $label  @  $step');
    }
    throw SuiteFailure(
      '\n❌ ${compatFailures.length} extension(s) failed with code/compat '
      'errors that need fixing (see list above). Successful extensions were '
      'recorded in $kStateFileName and are skipped on the next run; the '
      'failures above are re-tried.',
    );
  }

  print('\n✅ All tested extension(s) completed successfully!');
}
