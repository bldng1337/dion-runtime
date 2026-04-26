import 'package:flutter/material.dart';

import '../controller.dart';
import '../widgets/result_card.dart';

class BrowsePage extends StatefulWidget {
  final PlaygroundController controller;

  const BrowsePage({super.key, required this.controller});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final _pageController = TextEditingController(text: '0');
  String? _result;
  bool _isError = false;
  bool _loading = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Browse', 'No extension loaded', isError: true);
      return;
    }
    setState(() => _loading = true);
    final page = int.tryParse(_pageController.text) ?? 0;
    final label = 'Browse (page: $page)';
    widget.controller.log(label, 'Running...');
    try {
      final result = await ext.browse(page: page);
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
              Icon(Icons.explore, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text('Browse', style: theme.textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Browse entries from the extension catalog',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              SizedBox(
                width: 160,
                child: TextField(
                  controller: _pageController,
                  decoration: const InputDecoration(
                    labelText: 'Page',
                    border: OutlineInputBorder(),
                    hintText: '0',
                  ),
                  keyboardType: TextInputType.number,
                  enabled: !_loading,
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
          ResultCard(
            result: _result,
            isError: _isError,
            isLoading: _loading,
          ),
        ],
      ),
    );
  }
}