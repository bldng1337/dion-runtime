import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

import 'controller.dart';
import 'pages/browse_page.dart';
import 'pages/search_page.dart';
import 'pages/detail_page.dart';
import 'pages/source_page.dart';
import 'pages/handle_url_page.dart';
import 'pages/map_entry_page.dart';
import 'pages/map_source_page.dart';
import 'pages/activity_page.dart';
import 'pages/settings_page.dart';
import 'pages/reload_page.dart';
import 'pages/repo_page.dart';
import 'pages/log_page.dart';

enum AdapterType { dion, mihon }

class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  // Navigation
  int _currentPage = 0;

  // Adapter state
  AdapterType _adapterType = AdapterType.dion;
  rdion.ProxyAdapter? _adapter;
  List<rdion.ProxyExtension> _extensions = [];
  List<String> _extensionNames = [];
  int _selectedExtensionIndex = 0;
  bool _isLoading = false;
  String? _initError;
  HttpServer? _testServer;

  // Config controllers
  final _extensionDirController = TextEditingController();
  final _clientDirController = TextEditingController();
  final _serverUrlController = TextEditingController(text: 'http://localhost:3010');

  // Log
  final List<LogEntry> _log = [];
  final _logScrollController = ScrollController();

  static const _mobileBreakpoint = 600.0;

  // Navigation items
  static const _navItems = <_NavItem>[
    _NavItem('Browse', Icons.explore, 'Browse entries'),
    _NavItem('Search', Icons.search, 'Search with filter'),
    _NavItem('Detail', Icons.info_outline, 'Get entry details'),
    _NavItem('Source', Icons.play_circle_outline, 'Get episode source'),
    _NavItem('Handle URL', Icons.link, 'Handle a URL'),
    _NavItem('Map Entry', Icons.map, 'Map an entry'),
    _NavItem('Map Source', Icons.transform, 'Map a source'),
    _NavItem('Activity', Icons.event, 'Report activity'),
    _NavItem('Settings', Icons.settings, 'View settings'),
    _NavItem('Reload', Icons.refresh, 'Reload extension'),
    _NavItem('Repo Browser', Icons.cloud_download_outlined, 'Browse repositories'),
    _NavItem('Log', Icons.article_outlined, 'Operation log'),
  ];

  rdion.ProxyExtension? get _ext =>
      _extensions.isNotEmpty && _selectedExtensionIndex >= 0 && _selectedExtensionIndex < _extensions.length
          ? _extensions[_selectedExtensionIndex]
          : null;

  late final PlaygroundController _controller = PlaygroundController(
    getExt: () => _ext,
    getAdapter: () => _adapter,
    getIsLoading: () => _isLoading,
    getLog: () => _log,
    log: _logResponse,
    encodeResult: _encodeResult,
    installExtension: _installExtensionFromLocation,
  );

  @override
  void initState() {
    super.initState();
    _initDefaultPaths();
  }

  Future<void> _initDefaultPaths() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      if (mounted) {
        setState(() {
          _extensionDirController.text = '${appDir.path}/dion_extensions';
          _clientDirController.text = '${appDir.path}/dion_client';
        });
      }
    } catch (_) {
      // path_provider unavailable on current platform
    }
  }

  // ── Test Server ──────────────────────────────────────────────────────────

  Future<void> _startTestServer() async {
    if (_testServer != null) {
      _logResponse('Server', 'Already running at ${_serverUrlController.text}');
      return;
    }
    try {
      final router = shelf_router.Router()
        ..get(
          "/getEntry",
          (Request request) => Response.ok(const JsonEncoder().convert(
            const rdion.EntryDetailed(
              id: rdion.EntryId(uid: '', iddata: ''),
              url: 'https://example.com/entry',
              titles: ['Test Entry'],
              mediaType: rdion.MediaType.audio,
              status: rdion.ReleaseStatus.unknown,
              description: 'Test description',
              language: 'en',
              episodes: [],
            ).toJson(),
          )),
        )
        ..get(
          "/getEntries",
          (Request request) => Response.ok(const JsonEncoder().convert([
            const rdion.Entry(
              id: rdion.EntryId(uid: '', iddata: ''),
              url: 'https://example.com/entry',
              title: 'Test Entry',
              mediaType: rdion.MediaType.audio,
            ).toJson(),
          ])),
        )
        ..get(
          "/getSource",
          (Request request) => Response.ok(const JsonEncoder().convert(
            const rdion.Source.epub(link: rdion.Link(url: '')).toJson(),
          )),
        );

      _testServer = await shelf_io.serve(
        logRequests().addHandler(router.call),
        InternetAddress.loopbackIPv4,
        3010,
      );
      setState(() {
        _serverUrlController.text = 'http://${_testServer!.address.address}:${_testServer!.port}';
      });
      _logResponse('Server', 'Started at ${_serverUrlController.text}');
    } catch (e, st) {
      _logResponse('Server', 'Error: $e\n$st', isError: true);
    }
  }

  Future<void> _stopTestServer() async {
    await _testServer?.close();
    _testServer = null;
    _logResponse('Server', 'Stopped');
  }

  // ── Adapter Initialization ───────────────────────────────────────────────

  Future<void> _initializeAdapter() async {
    setState(() {
      _isLoading = true;
      _initError = null;
      _extensions = [];
      _extensionNames = [];
      _selectedExtensionIndex = 0;
    });

    try {
      final extensionDir = _extensionDirController.text.trim();
      final clientDir = _clientDirController.text.trim();
      final serverUrl = _serverUrlController.text.trim();

      if (extensionDir.isEmpty) throw Exception('Extension directory is required');
      if (clientDir.isEmpty) throw Exception('Client directory is required');

      await Directory(extensionDir).create(recursive: true);
      await Directory(clientDir).create(recursive: true);

      final client = await rdion.ManagerClient.init(
        getPath: () => extensionDir,
        getClient: (data) async {
          return await rdion.ExtensionClient.init(
            setEntrySetting: (id, key, value) async {},
            loadDataSecure: (key) => "",
            storeDataSecure: (key, value) {},
            loadData: (key) => "",
            storeData: (key, value) {},
            doAction: (action) {},
            requestPermission: (permission, msg) => false,
            getPath: () => clientDir,
          );
        },
      );

      final adapter = switch (_adapterType) {
        AdapterType.dion => await rdion.ProxyAdapter.initDion(client: client),
        AdapterType.mihon => await rdion.ProxyAdapter.initMihon(client: client),
      };

      final extensions = await adapter.getExtensions();

      final names = <String>[];
      for (final ext in extensions) {
        if (serverUrl.isNotEmpty) {
          await ext.mergeSettingDefinition(
            definition: rdion.Setting(
              default_: rdion.SettingValue.string(data: serverUrl),
              value: rdion.SettingValue.string(data: serverUrl),
              label: "Test Data Server",
              visible: false,
            ),
            id: "testdataserver",
            kind: rdion.SettingKind.extension_,
          );
        }
        await ext.setEnabled(enabled: true);
        try {
          final data = await ext.getExtensionData();
          names.add(data.name);
        } catch (_) {
          names.add('Extension ${names.length + 1}');
        }
      }

      setState(() {
        _adapter = adapter;
        _extensions = extensions;
        _extensionNames = names;
        _selectedExtensionIndex = 0;
        _isLoading = false;
      });
      _logResponse('Init', 'Loaded ${extensions.length} extension(s)');
    } catch (e, st) {
      setState(() {
        _isLoading = false;
        _initError = '$e\n$st';
      });
      _logResponse('Init', 'Error: $e\n$st', isError: true);
    }
  }

  // ── Extension Install / Uninstall ────────────────────────────────────────

  Future<void> _installExtensionFromLocation(String location) async {
    if (location.isEmpty) {
      _logResponse('Install', 'Enter a location', isError: true);
      return;
    }
    if (_adapter == null) {
      _logResponse('Install', 'Load adapter first', isError: true);
      return;
    }

    _logResponse('Install', 'Installing from: $location...');
    try {
      final ext = await _adapter!.install(location: location);
      final data = await ext.getExtensionData();

      final serverUrl = _serverUrlController.text.trim();
      if (serverUrl.isNotEmpty) {
        await ext.mergeSettingDefinition(
          definition: rdion.Setting(
            default_: rdion.SettingValue.string(data: serverUrl),
            value: rdion.SettingValue.string(data: serverUrl),
            label: "Test Data Server",
            visible: false,
          ),
          id: "testdataserver",
          kind: rdion.SettingKind.extension_,
        );
      }
      await ext.setEnabled(enabled: true);

      setState(() {
        _extensions.add(ext);
        _extensionNames.add(data.name);
        _selectedExtensionIndex = _extensions.length - 1;
      });
      _logResponse('Install', 'Installed: ${data.name} v${data.version}');
    } catch (e, st) {
      _logResponse('Install', 'Error: $e\n$st', isError: true);
    }
  }

  Future<void> _uninstallExtension() async {
    if (_ext == null || _adapter == null) return;
    final name = _selectedExtensionIndex < _extensionNames.length
        ? _extensionNames[_selectedExtensionIndex]
        : 'extension';
    final ext = _ext!;
    _logResponse('Uninstall', 'Uninstalling $name...');
    try {
      await _adapter!.uninstall(ext: ext);
      setState(() {
        _extensions.removeAt(_selectedExtensionIndex);
        _extensionNames.removeAt(_selectedExtensionIndex);
        if (_selectedExtensionIndex >= _extensions.length && _selectedExtensionIndex > 0) {
          _selectedExtensionIndex = _extensions.length - 1;
        }
      });
      _logResponse('Uninstall', 'Uninstalled: $name');
    } catch (e, st) {
      _logResponse('Uninstall', 'Error: $e\n$st', isError: true);
    }
  }

  // ── Log & Encoding ───────────────────────────────────────────────────────

  void _logResponse(String label, String message, {bool isError = false}) {
    setState(() {
      _log.add(LogEntry(label: label, message: message, isError: isError, timestamp: DateTime.now()));
    });
    _scrollLogToBottom();
  }

  void _scrollLogToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_logScrollController.hasClients) {
        _logScrollController.animateTo(
          _logScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _encodeResult(dynamic result) {
    try {
      if (result == null) return 'null';
      if (result is rdion.EntryList) {
        return const JsonEncoder.withIndent('  ').convert({
          'length': result.length,
          'hasNext': result.hasnext,
          'content': result.content.map((e) => e.toJson()).toList(),
        });
      }
      if (result is rdion.EntryDetailedResult) {
        return const JsonEncoder.withIndent('  ').convert({
          'settings': Map.fromEntries(result.settings.entries.map((e) => MapEntry(e.key, e.value.toJson()))),
          'entry': result.entry.toJson(),
        });
      }
      if (result is rdion.SourceResult) {
        return const JsonEncoder.withIndent('  ').convert({
          'settings': Map.fromEntries(result.settings.entries.map((e) => MapEntry(e.key, e.value.toJson()))),
          'source': result.source.toJson(),
        });
      }
      if (result is Map) {
        return const JsonEncoder.withIndent('  ').convert(
          Map.fromEntries(result.entries.map((e) => MapEntry(e.key, e.value?.toJson()))),
        );
      }
      if (result is List) {
        return const JsonEncoder.withIndent('  ').convert(result.map((e) => e?.toJson()).toList());
      }
      return result.toString();
    } catch (e) {
      return result.toString();
    }
  }

  // ── Dialogs ──────────────────────────────────────────────────────────────

  void _showConfigDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Configuration'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _extensionDirController,
                  decoration: const InputDecoration(
                    labelText: 'Extension Directory',
                    border: OutlineInputBorder(),
                    helperText: 'Path where extensions are stored',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _clientDirController,
                  decoration: const InputDecoration(
                    labelText: 'Client Data Directory',
                    border: OutlineInputBorder(),
                    helperText: 'Path for extension client data',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _serverUrlController,
                  decoration: InputDecoration(
                    labelText: 'Test Server URL',
                    border: const OutlineInputBorder(),
                    helperText: 'URL for the mock data server',
                    suffixIcon: _testServer != null
                        ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _startTestServer();
                          Navigator.pop(ctx);
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Server'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _stopTestServer();
                          Navigator.pop(ctx);
                        },
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop Server'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showInstallDialog() {
    final locationController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Install Extension'),
        content: TextField(
          controller: locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            border: OutlineInputBorder(),
            helperText: 'File path or URL to the extension package',
          ),
          onSubmitted: (_) {
            Navigator.pop(ctx);
            _installExtensionFromLocation(locationController.text.trim());
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _installExtensionFromLocation(locationController.text.trim());
            },
            child: const Text('Install'),
          ),
        ],
      ),
    );
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _logScrollController.dispose();
    _extensionDirController.dispose();
    _clientDirController.dispose();
    _serverUrlController.dispose();
    _testServer?.close();
    super.dispose();
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dion Runtime Playground'),
        backgroundColor: theme.colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configure Paths & Server',
            onPressed: _showConfigDialog,
          ),
        ],
      ),
      drawer: _buildNavDrawer(theme),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < _mobileBreakpoint) {
            return Column(
              children: [
                _buildAdapterBar(theme),
                const Divider(height: 1),
                _buildExtensionSection(theme),
                const Divider(height: 1),
                Expanded(child: _buildPage()),
              ],
            );
          }
          return Row(
            children: [
              _buildNavPanel(theme),
              const VerticalDivider(width: 1),
              Expanded(
                child: Column(
                  children: [
                    _buildAdapterBar(theme),
                    const Divider(height: 1),
                    _buildExtensionSection(theme),
                    const Divider(height: 1),
                    Expanded(child: _buildPage()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Navigation Panel ─────────────────────────────────────────────────────

  Widget _buildNavPanel(ThemeData theme) {
    return Material(
      color: theme.colorScheme.surface,
      child: SizedBox(
        width: 160,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Extension Calls',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (int i = 0; i < 10; i++) _buildNavTile(theme, i),
            const Divider(indent: 12, endIndent: 12, height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Management',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildNavTile(theme, 10),
            _buildNavTile(theme, 11),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTile(ThemeData theme, int index) {
    final item = _navItems[index];
    final selected = _currentPage == index;
    return ListTile(
      dense: true,
      selected: selected,
      leading: Icon(item.icon, size: 20),
      title: Text(item.label, style: const TextStyle(fontSize: 13)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      onTap: () => setState(() => _currentPage = index),
    );
  }

  Widget _buildNavDrawer(ThemeData theme) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.inversePrimary),
            child: Text('Navigation', style: theme.textTheme.titleLarge),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Extension Calls',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < 10; i++) _buildDrawerNavTile(theme, i),
          const Divider(indent: 12, endIndent: 12, height: 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Management',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerNavTile(theme, 10),
          _buildDrawerNavTile(theme, 11),
        ],
      ),
    );
  }

  Widget _buildDrawerNavTile(ThemeData theme, int index) {
    final item = _navItems[index];
    final selected = _currentPage == index;
    return ListTile(
      dense: true,
      selected: selected,
      leading: Icon(item.icon, size: 20),
      title: Text(item.label, style: const TextStyle(fontSize: 13)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      onTap: () {
        setState(() => _currentPage = index);
        Navigator.pop(context);
      },
    );
  }

  // ── Adapter Bar ──────────────────────────────────────────────────────────

  Widget _buildAdapterBar(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: theme.colorScheme.surfaceContainerHighest,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.hub, color: theme.colorScheme.primary),
          Text('Adapter:', style: theme.textTheme.titleSmall),
          DropdownButton<AdapterType>(
            value: _adapterType,
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(
                value: AdapterType.dion,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.extension, size: 18),
                  SizedBox(width: 6),
                  Text('Dion (Native)'),
                ]),
              ),
              DropdownMenuItem(
                value: AdapterType.mihon,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.android, size: 18),
                  SizedBox(width: 6),
                  Text('Mihon (Tachiyomi)'),
                ]),
              ),
            ],
            onChanged: _isLoading
                ? null
                : (value) {
                    if (value != null && value != _adapterType) {
                      setState(() {
                        _adapterType = value;
                        _log.clear();
                      });
                    }
                  },
          ),
          FilledButton.tonal(
            onPressed: _isLoading ? null : _initializeAdapter,
            child: _isLoading
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Load'),
          ),
          if (!_isLoading && _adapter != null)
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
          if (!_isLoading && _initError != null)
            Tooltip(
              message: 'Initialization failed',
              child: Icon(Icons.error, color: theme.colorScheme.error, size: 20),
            ),
        ],
      ),
    );
  }

  // ── Extension Section ────────────────────────────────────────────────────

  Widget _buildExtensionSection(ThemeData theme) {
    if (_isLoading && _extensions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: LinearProgressIndicator(),
      );
    }
    if (_initError != null && _extensions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Initialization failed: $_initError',
          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.extension, color: theme.colorScheme.primary),
          if (_extensions.isNotEmpty) ...[
            Text('Extension:', style: theme.textTheme.titleSmall),
            DropdownButton<int>(
              value: _selectedExtensionIndex,
              underline: const SizedBox.shrink(),
              items: _extensionNames.asMap().entries.map((e) {
                return DropdownMenuItem(value: e.key, child: Text(e.value));
              }).toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedExtensionIndex = v);
              },
            ),
            FutureBuilder<rdion.ExtensionData>(
              key: ValueKey(_selectedExtensionIndex),
              future: _ext?.getExtensionData(),
              builder: (context, snap) {
                if (!snap.hasData) return const SizedBox.shrink();
                final d = snap.data!;
                return Text(
                  '${d.id} · v${d.version} · ${d.mediaType.map((m) => m.name).join(", ")}',
                  style: theme.textTheme.bodySmall,
                );
              },
            ),
            FutureBuilder<bool>(
              key: ValueKey('enabled_$_selectedExtensionIndex'),
              future: _ext?.isEnabled(),
              builder: (context, snap) {
                final enabled = snap.data ?? false;
                return Chip(
                  label: Text(enabled ? 'Enabled' : 'Disabled', style: const TextStyle(fontSize: 11)),
                  backgroundColor: enabled ? Colors.green[100] : Colors.red[100],
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                );
              },
            ),
          ] else
            Text('No extensions loaded — use Install or configure directory', style: theme.textTheme.bodyMedium),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Install extension from URL/path',
            onPressed: _adapter != null ? _showInstallDialog : null,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Uninstall selected extension',
            onPressed: _ext != null ? _uninstallExtension : null,
          ),
        ],
      ),
    );
  }

  // ── Page Builder ─────────────────────────────────────────────────────────

  Widget _buildPage() {
    return IndexedStack(
      index: _currentPage,
      children: [
        BrowsePage(controller: _controller),
        SearchPage(controller: _controller),
        DetailPage(controller: _controller),
        SourcePage(controller: _controller),
        HandleUrlPage(controller: _controller),
        MapEntryPage(controller: _controller),
        MapSourcePage(controller: _controller),
        ActivityPage(controller: _controller),
        SettingsPage(controller: _controller),
        ReloadPage(controller: _controller),
        RepoPage(controller: _controller),
        LogPage(
          log: _log,
          onClear: () => setState(() => _log.clear()),
          scrollController: _logScrollController,
        ),
      ],
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String tooltip;
  const _NavItem(this.label, this.icon, this.tooltip);
}
