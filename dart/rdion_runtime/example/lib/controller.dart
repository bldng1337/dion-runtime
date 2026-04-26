import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

/// A log entry recording the result of an operation.
class LogEntry {
  final String label;
  final String message;
  final bool isError;
  final DateTime timestamp;

  const LogEntry({
    required this.label,
    required this.message,
    required this.isError,
    required this.timestamp,
  });
}

/// Controller that provides pages with access to shared playground state and actions.
class PlaygroundController {
  final rdion.ProxyExtension? Function() getExt;
  final rdion.ProxyAdapter? Function() getAdapter;
  final bool Function() getIsLoading;
  final List<LogEntry> Function() getLog;
  final void Function(String label, String message, {bool isError}) log;
  final String Function(dynamic result) encodeResult;
  final Future<void> Function(String location) installExtension;

  const PlaygroundController({
    required this.getExt,
    required this.getAdapter,
    required this.getIsLoading,
    required this.getLog,
    required this.log,
    required this.encodeResult,
    required this.installExtension,
  });
}