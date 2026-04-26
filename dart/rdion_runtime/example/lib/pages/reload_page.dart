import 'package:flutter/material.dart';

import '../controller.dart';
import '../widgets/result_card.dart';

class ReloadPage extends StatefulWidget {
  final PlaygroundController controller;

  const ReloadPage({super.key, required this.controller});

  @override
  State<ReloadPage> createState() => _ReloadPageState();
}

class _ReloadPageState extends State<ReloadPage> {
  String? _result;
  bool _isError = false;
  bool _loading = false;

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Reload', 'No extension loaded', isError: true);
      return;
    }
    setState(() => _loading = true);
    widget.controller.log('Reload', 'Running...');
    try {
      await ext.reload();
      setState(() {
        _result = 'Extension reloaded successfully';
        _isError = false;
        _loading = false;
      });
      widget.controller.log('Reload', _result!);
    } catch (e, st) {
      final msg = 'Error: $e\n$st';
      setState(() {
        _result = msg;
        _isError = true;
        _loading = false;
      });
      widget.controller.log('Reload', msg, isError: true);
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
              Icon(Icons.refresh, color: theme.colorScheme.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reload', style: theme.textTheme.headlineSmall),
                    Text(
                      'Reload the extension to refresh its state',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _loading ? null : _run,
            icon: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            label: const Text('Reload Extension'),
          ),
          const SizedBox(height: 16),
          ResultCard(result: _result, isError: _isError, isLoading: _loading),
        ],
      ),
    );
  }
}