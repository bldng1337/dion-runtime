import 'package:flutter/material.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import '../controller.dart';
import '../widgets/result_card.dart';

class SettingsPage extends StatefulWidget {
  final PlaygroundController controller;
  const SettingsPage({super.key, required this.controller});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  rdion.SettingKind _kind = rdion.SettingKind.extension_;
  bool _showBoth = true;
  String? _result;
  bool _isError = false;
  bool _loading = false;

  Future<void> _run() async {
    final ext = widget.controller.getExt();
    if (ext == null) {
      widget.controller.log('Settings', 'No extension loaded', isError: true);
      return;
    }
    setState(() => _loading = true);
    final label = 'Settings (${_showBoth ? "both" : _kind.name})';
    widget.controller.log(label, 'Running...');
    try {
      if (_showBoth) {
        final extSettings = await ext.getSettings(kind: rdion.SettingKind.extension_);
        final searchSettings = await ext.getSettings(kind: rdion.SettingKind.search);
        final encoded = widget.controller.encodeResult({
          'extension': Map.fromEntries(
            extSettings.entries.map((e) => MapEntry(e.key, e.value.toJson())),
          ),
          'search': Map.fromEntries(
            searchSettings.entries.map((e) => MapEntry(e.key, e.value.toJson())),
          ),
        });
        setState(() {
          _result = encoded;
          _isError = false;
          _loading = false;
        });
        widget.controller.log(label, encoded);
      } else {
        final settings = await ext.getSettings(kind: _kind);
        final encoded = widget.controller.encodeResult(
          Map.fromEntries(settings.entries.map((e) => MapEntry(e.key, e.value.toJson()))),
        );
        setState(() {
          _result = encoded;
          _isError = false;
          _loading = false;
        });
        widget.controller.log(label, encoded);
      }
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
          Text('Settings', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'View extension settings by kind',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _showBoth,
                    onChanged: (v) => setState(() => _showBoth = v ?? true),
                  ),
                  const Text('Show both'),
                ],
              ),
              if (!_showBoth)
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField<rdion.SettingKind>(
                    value: _kind,
                    decoration: const InputDecoration(
                      labelText: 'Kind',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: rdion.SettingKind.extension_,
                        child: Text('Extension'),
                      ),
                      DropdownMenuItem(
                        value: rdion.SettingKind.search,
                        child: Text('Search'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _kind = v);
                    },
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