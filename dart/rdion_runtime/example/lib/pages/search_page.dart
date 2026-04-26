import 'package:flutter/material.dart';

import '../controller.dart';
import '../widgets/result_card.dart';

class SearchPage extends StatefulWidget {
  final PlaygroundController controller;
  const SearchPage({super.key, required this.controller});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _pageController = TextEditingController(text: '0');
  final _filterController = TextEditingController();
  String? _result;
  bool _isError = false;
  bool _loading = false;

  @override
  void dispose() {
    _pageController.dispose();
    _filterController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Search', 'No extension loaded', isError: true);
      return;
    }
    setState(() => _loading = true);
    final page = int.tryParse(_pageController.text) ?? 0;
    final filter = _filterController.text;
    final label = 'Search (filter: "$filter", page: $page)';
    widget.controller.log(label, 'Running...');
    try {
      final result = await ext.search(page: page, filter: filter);
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
          Text('Search', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Search for entries using a filter string',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  controller: _pageController,
                  decoration: const InputDecoration(
                    labelText: 'Page',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 240,
                child: TextField(
                  controller: _filterController,
                  decoration: const InputDecoration(
                    labelText: 'Filter',
                    border: OutlineInputBorder(),
                    hintText: 'Search query',
                  ),
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