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
          (Request request) => Response.ok(
              '{"id":"","url":"","titles":[],"author":null,"ui":null,"meta":null,"media_type":"Video","status":"Unknown","description":"","language":"","cover":null,"episodes":[],"genres":null,"rating":null,"views":null,"length":null}'))
      ..get(
          "/getEntries",
          (Request request) => Response.ok(
              '[{"id":"","url":"","title":"","media_type":"Video","cover":null,"author":null,"rating":null,"views":null,"length":null}]'))
      ..get(
          "/getSource",
          (Request request) =>
              Response.ok('{"type":"Epub","link":{"header":null,"url":""}}'));
    final server = await shelf_io.serve(
      logRequests().addHandler(router.call),
      InternetAddress.loopbackIPv4,
      3010,
    );

    final adress = 'http://${server.address.address}:${server.port}';
    final client = await ManagerClient.init(
      getPath: () => "./../../../tests/dion/native",
      getClient: (data) async {
        return await ExtensionClient.init(
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
      final entry = await ext.detail(
          entryid: const EntryId(idType: "asd", uid: "asd"), settings: {});
      await ext.handleUrl(url: "");
      await ext.mapEntry(entry: entry.entry, settings: {});
      final source = await ext.source(
          epid: const EpisodeId(idType: "asd", uid: "asd"), settings: {});
      await ext.onEntryActivity(
          activity: const EntryActivity.episodeActivity(progress: 23),
          entry: entry.entry,
          settings: {});
      await ext.mapSource(
          source: source.source,
          epid: const EpisodeId(idType: "asd", uid: "asd"),
          settings: {});
      await ext.search(filter: "", page: 2);
      await ext.reload();
    }
    server.close();
  });
//   test('E2E Extension Manager Test', () async {
//     // setPermissionRequest((permission) {
//     //   final path = (permission.permission as Permission_StoragePermission).path;
//     //   expect(path, 'some', reason: 'Permission is not correct');
//     //   return true;
//     // });
//     // final em = ExtensionManagerProxy
//     print("test");
//     final em = SourceExtensionManagerProxy(path: "../../../testextensions");
//     final extensions = await em.getExtensions();

//     for (var extension in extensions) {
//       await extension.setEnabled(enabled: true);
//       final extsetting = await extension.getSetting(name: "someid");
//       expect(extsetting.setting.val.val, "somevalue",
//           reason: "Setting is not correct");
//       extension.setSetting(
//           name: "someid",
//           value: const Settingvalue.string(
//               val: "othervalue", defaultVal: "defaultVal"));
//       final data = await extension.getData();
//       expect(data.id, '123', reason: 'Extension data is not correct');
//       final entries = await extension.browse(page: 1, sort: Sort.popular);
//       final entry = await extension.detail(entryid: entries[0].id, settings: {
//         "someid": const Setting(
//             val: Settingvalue.boolean(val: true, defaultVal: true))
//       });
//       final source =
//           await extension.source(epid: entry.episodes[0].id, settings: {});
//       expect(source is Source_Directlink, true,
//           reason: 'Source is not a direct link');
//       final sourceData = (source as Source_Directlink).sourcedata;
//       expect(sourceData is LinkSource_Epub, true,
//           reason: 'Source data is not an epub');
//       expect((sourceData as LinkSource_Epub).link, 'epid',
//           reason: 'Epub link is not correct');
//     }
//   });
}
