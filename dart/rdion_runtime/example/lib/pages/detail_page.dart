import 'package:flutter/material.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import '../controller.dart';
import '../widgets/result_card.dart';

class DetailPage extends StatefulWidget {
  final PlaygroundController controller;
  const DetailPage({super.key, required this.controller});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _uidController = TextEditingController(text: 'test');
  String? _result;
  bool _isError = false;
  bool _loading = false;

  @override
  void dispose() {
    _uidController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Detail', 'No extension loaded', isError: true);
      return;
    }
    setState(() => _loading = true);
    final uid = _uidController.text;
    final label = 'Detail (uid: "$uid")';
    widget.controller.log(label, 'Running...');
    try {
      final result = await ext.detail(
        entryid: rdion.EntryId(uid: uid),
        settings: {},
      );
      final encoded = widget.controller.encodeResult(result);
      setState(() {
        _result = encoded;
        _isError = false;
        _loading = false;
      });
      widget.controller.log(label, encoded);
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
          Text('Detail', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Get detailed information about a specific entry',
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
              FilledButton.icon(
                onPressed: _loading ? null : _run,
                icon: _loading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
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