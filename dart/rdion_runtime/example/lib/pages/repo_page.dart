import 'package:flutter/material.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import '../controller.dart';

class RepoPage extends StatefulWidget {
  final PlaygroundController controller;

  const RepoPage({super.key, required this.controller});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  final _repoUrlController = TextEditingController();
  rdion.ExtensionRepo? _currentRepo;
  List<rdion.RemoteExtension> _repoExtensions = [];
  int _repoPage = 0;
  bool _repoHasNext = false;
  bool _repoLoading = false;
  String? _error;
  String? _installingName;

  @override
  void dispose() {
    _repoUrlController.dispose();
    super.dispose();
  }

  Future<void> _browseRepo({bool nextPage = false}) async {
    final adapter = widget.controller.getAdapter();
    if (adapter == null) {
      widget.controller.log('Repo', 'Load adapter first', isError: true);
      return;
    }

    if (!nextPage) {
      final url = _repoUrlController.text.trim();
      if (url.isEmpty) {
        setState(() => _error = 'Enter a repository URL');
        return;
      }
    }

    setState(() {
      _repoLoading = true;
      _error = null;
    });

    try {
      final repo = nextPage
          ? _currentRepo
          : await adapter.getRepo(url: _repoUrlController.text.trim());
      final page = nextPage ? _repoPage + 1 : 0;
      final existing = nextPage ? _repoExtensions : <rdion.RemoteExtension>[];

      final result = await adapter.browseRepo(repo: repo!, page: page);

      setState(() {
        _currentRepo = repo;
        _repoPage = page;
        _repoExtensions = [...existing, ...result.content];
        _repoHasNext = result.hasnext ?? false;
        _repoLoading = false;
      });
      widget.controller.log(
        'Repo',
        '${_currentRepo!.name} page $_repoPage: ${result.content.length} extensions',
      );
    } catch (e, st) {
      setState(() {
        _error = '$e\n$st';
        _repoLoading = false;
      });
      widget.controller.log('Repo', 'Error: $e\n$st', isError: true);
    }
  }

  Future<void> _installFromRepo(rdion.RemoteExtension remote) async {
    setState(() => _installingName = remote.name);
    try {
      await widget.controller.installExtension(remote.url);
    } finally {
      if (mounted) {
        setState(() => _installingName = null);
      }
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
              Icon(Icons.cloud_download_outlined, color: theme.colorScheme.primary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Repository Browser', style: theme.textTheme.headlineSmall),
                    Text(
                      'Browse and install extensions from repositories',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // URL input + browse button
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: TextField(
                  controller: _repoUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Repository URL',
                    border: OutlineInputBorder(),
                    hintText: 'https://example.com/repo',
                  ),
                  onSubmitted: (_) => _browseRepo(),
                ),
              ),
              FilledButton.icon(
                onPressed: _repoLoading ? null : () => _browseRepo(),
                icon: _repoLoading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.search),
                label: const Text('Browse'),
              ),
            ],
          ),
          // Error display
          if (_error != null) ...[
            const SizedBox(height: 12),
            Card(
              color: theme.colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, size: 18, color: theme.colorScheme.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: theme.colorScheme.onErrorContainer,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // Repo header
          if (_currentRepo != null) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.folder_special, size: 20, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentRepo!.name,
                            style: theme.textTheme.titleSmall,
                          ),
                          if (_currentRepo!.description.isNotEmpty)
                            Text(
                              _currentRepo!.description,
                              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    Text(
                      'Page $_repoPage${_repoHasNext ? ' · More available' : ''}',
                      style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // Extensions list
          if (_repoExtensions.isNotEmpty) ...[
            const SizedBox(height: 8),
            ..._repoExtensions.map((ext) => _buildExtensionTile(theme, ext)),
            // Load more button
            if (_repoHasNext)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: FilledButton.tonal(
                    onPressed: _repoLoading ? null : () => _browseRepo(nextPage: true),
                    child: _repoLoading
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Load More'),
                  ),
                ),
              ),
          ],
          // Empty state
          if (_currentRepo == null && !_repoLoading)
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_download_outlined, size: 64, color: theme.colorScheme.outline),
                    const SizedBox(height: 16),
                    Text(
                      'Enter a repository URL to browse extensions',
                      style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExtensionTile(ThemeData theme, rdion.RemoteExtension ext) {
    final isInstalling = _installingName == ext.name;
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          backgroundColor: ext.compatible ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
          child: Icon(
            ext.compatible ? Icons.extension : Icons.warning,
            size: 18,
            color: ext.compatible ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(ext.name)),
            if (!ext.compatible)
              Chip(
                label: const Text('incompatible', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.orange[100],
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
          ],
        ),
        subtitle: Text('v${ext.version} · ${ext.id}'),
        trailing: isInstalling
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : IconButton(
                icon: const Icon(Icons.download),
                tooltip: 'Install',
                onPressed: widget.controller.getAdapter() != null ? () => _installFromRepo(ext) : null,
              ),
      ),
    );
  }
}