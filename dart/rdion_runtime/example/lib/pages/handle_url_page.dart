import 'package:flutter/material.dart';

import '../controller.dart';
import '../widgets/result_card.dart';

class HandleUrlPage extends StatefulWidget {
  final PlaygroundController controller;
  const HandleUrlPage({super.key, required this.controller});

  @override
  State<HandleUrlPage> createState() => _HandleUrlPageState();
}

class _HandleUrlPageState extends State<HandleUrlPage> {
  final _urlController = TextEditingController();
  String? _result;
  bool _isError = false;
  bool _loading = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Handle URL', 'No extension loaded', isError: true);
      return;
    }
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _result = 'Please enter a URL';
        _isError = true;
      });
      return;
    }

    setState(() => _loading = true);
    final label = 'Handle URL (url: "$url")';
    widget.controller.log(label, 'Running...');
    try {
      final result = await ext.handleUrl(url: url);
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
          Row(
            children: [
              Icon(Icons.link, color: theme.colorScheme.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Handle URL', style: theme.textTheme.headlineSmall),
                    Text(
                      'Try to handle a URL with the extension',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: TextField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'URL',
                    border: OutlineInputBorder(),
                    hintText: 'https://example.com/entry/123',
                  ),
                  onSubmitted: (_) => _run(),
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