import 'package:flutter/material.dart';

/// A reusable card for displaying API call results.
class ResultCard extends StatelessWidget {
  final String? result;
  final bool isError;
  final bool isLoading;

  const ResultCard({
    super.key,
    this.result,
    this.isError = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (result == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: isError ? theme.colorScheme.errorContainer : theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isError ? Icons.error_outline : Icons.check_circle_outline,
                  size: 16,
                  color: isError ? theme.colorScheme.error : theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  isError ? 'Error' : 'Result',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isError ? theme.colorScheme.error : theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: SingleChildScrollView(
                child: SelectableText(
                  result!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: isError ? theme.colorScheme.onErrorContainer : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}