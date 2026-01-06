import 'dart:convert';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart';
import 'package:shelf/shelf.dart';
import 'dart:io';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());
  test('E2E Extension Manager Test', () async {
    final router = shelf_router.Router()
      ..get(
          "/getEntry",
          (Request request) => Response.ok(jsonEncode(const EntryDetailed(
              id: EntryId(uid: '', iddata: ''),
              url: '',
              titles: [],
              mediaType: MediaType.audio,
              status: ReleaseStatus.unknown,
              description: '',
              language: '',
              episodes: []).toJson())))
      ..get(
          "/getEntries",
          (Request request) => Response.ok(jsonEncode([
                const Entry(
                        id: EntryId(uid: '', iddata: ''),
                        url: '',
                        title: '',
                        mediaType: MediaType.audio)
                    .toJson(),
              ])))
      ..get(
          "/getSource",
          (Request request) => Response.ok(
              jsonEncode(const Source.epub(link: Link(url: '')).toJson())));
    final server = await shelf_io.serve(
      logRequests().addHandler(router.call),
      InternetAddress.loopbackIPv4,
      3010,
    );

    final adress = 'http://${server.address.address}:${server.port}';
    final client = await ManagerClient.init(
      getPath: () => "./../../../tests/extensions/native/.dist",
      getClient: (data) async {
        return await ExtensionClient.init(
            loadDataSecure: (key) {
              return "";
            },
            storeDataSecure: (key, value) {},
            loadData: (key) {
              return "";
            },
            storeData: (key, value) {},
            doAction: (action) {},
            requestPermission: (permission, msg) {
              return false;
            },
            getPath: () {
              return "./../../../tests/dion/native";
            });
      },
    );
    final ext = await ProxyAdapter.initDion(client: client);
    final exts = await ext.getExtensions();
    for (final ext in exts) {
      await ext.mergeSettingDefinition(
        definition: Setting(
          default_: SettingValue.string(data: adress),
          value: SettingValue.string(data: adress),
          label: "",
          visible: false,
        ),
        id: "testdataserver",
        kind: SettingKind.extension_,
      );
      await ext.setEnabled(enabled: true);
      await ext.browse(page: 0);
      final entry =
          await ext.detail(entryid: const EntryId(uid: "asd"), settings: {});
      await ext.handleUrl(url: "");
      await ext.mapEntry(entry: entry.entry, settings: {});
      final source =
          await ext.source(epid: const EpisodeId(uid: "asd"), settings: {});
      await ext.onEntryActivity(
          activity: const EntryActivity.episodeActivity(progress: 23),
          entry: entry.entry,
          settings: {});
      await ext.mapSource(
          source: source.source,
          epid: const EpisodeId(iddata: "asd", uid: "asd"),
          settings: {});
      await ext.search(filter: "", page: 2);
      await ext.reload();
    }
    server.close();
  });
}
