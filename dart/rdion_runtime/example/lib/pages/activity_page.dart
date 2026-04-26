import 'package:flutter/material.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import '../controller.dart';
import '../widgets/result_card.dart';

class ActivityPage extends StatefulWidget {
  final PlaygroundController controller;

  const ActivityPage({super.key, required this.controller});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final _uidController = TextEditingController(text: 'test');
  final _progressController = TextEditingController(text: '50');
  String? _result;
  bool _isError = false;
  bool _loading = false;

  @override
  void dispose() {
    _uidController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Activity', 'No extension loaded', isError: true);
      return;
    }
    setState(() => _loading = true);
    final uid = _uidController.text;
    final progress = int.tryParse(_progressController.text) ?? 0;
    final label = 'Activity (uid: "$uid", progress: $progress%)';
    widget.controller.log(label, 'Running...');
    try {
      final entry = rdion.EntryDetailed(
        id: rdion.EntryId(uid: uid, iddata: 'test'),
        url: 'https://example.com/test',
        titles: ['Test Entry'],
        mediaType: rdion.MediaType.audio,
        status: rdion.ReleaseStatus.unknown,
        description: 'Test description',
        language: 'en',
        episodes: [],
      );
      await ext.onEntryActivity(
        activity: rdion.EntryActivity.episodeActivity(progress: progress),
        entry: entry,
        settings: {},
      );
      final msg = 'Activity reported successfully (progress: $progress%)';
      setState(() {
        _result = msg;
        _isError = false;
        _loading = false;
      });
      widget.controller.log(label, msg);
    } catch (e, st) {
      final msg = 'Error: $e\n$st';
      setState(() {
        _result = msg;
        _isError = true;
        _loading = false;
      });
      widget.controller.log(label, msg, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Activity', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Report an entry activity (e.g. reading/watching progress)',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _uidController,
                  decoration: const InputDecoration(
                    labelText: 'Entry UID',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 140,
                child: TextField(
                  controller: _progressController,
                  decoration: const InputDecoration(
                    labelText: 'Progress',
                    border: OutlineInputBorder(),
                    hintText: '0–100',
                    suffixText: '%',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              FilledButton.icon(
                onPressed: _loading ? null : _run,
                icon: _loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                label: const Text('Run'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ResultCard(result: _result, isError: _isError, isLoading: _loading),
        ],
      ),
    );
  }
}