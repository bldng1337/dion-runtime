import 'package:flutter/material.dart';

import '../controller.dart';

class LogPage extends StatefulWidget {
  final List<LogEntry> log;
  final VoidCallback onClear;
  final ScrollController scrollController;

  const LogPage({
    super.key,
    required this.log,
    required this.onClear,
    required this.scrollController,
  });

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              Icon(Icons.article_outlined, color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 8),
              Text('Operation Log', style: theme.textTheme.titleLarge),
              const Spacer(),
              Text(
                '${widget.log.length} entries',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
              ),
              const SizedBox(width: 12),
              FilledButton.tonalIcon(
                onPressed: widget.log.isEmpty ? null : () => _showClearDialog(context),
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Clear'),
              ),
            ],
          ),
        ),
        const Divider(),
        if (widget.log.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.article_outlined, size: 48, color: theme.colorScheme.outline),
                  const SizedBox(height: 12),
                  Text(
                    'No log entries yet',
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Run an operation from any page to see results here',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: widget.log.length,
              itemBuilder: (context, index) {
                final entry = widget.log[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    color: entry.isError
                        ? theme.colorScheme.errorContainer
                        : theme.colorScheme.surfaceContainerLow,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                entry.isError ? Icons.error_outline : Icons.check_circle_outline,
                                size: 16,
                                color: entry.isError
                                    ? theme.colorScheme.error
                                    : theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                entry.label,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: entry.isError
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.primary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _formatTime(entry.timestamp),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          SelectableText(
                            entry.message,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: entry.isError
                                  ? theme.colorScheme.onErrorContainer
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Log'),
        content: const Text('Are you sure you want to clear all log entries?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              widget.onClear();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}