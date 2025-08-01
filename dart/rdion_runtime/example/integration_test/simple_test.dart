import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());

  test('E2E Extension Manager Test', () async {
    // setPermissionRequest((permission) {
    //   final path = (permission.permission as Permission_StoragePermission).path;
    //   expect(path, 'some', reason: 'Permission is not correct');
    //   return true;
    // });
    // final em = ExtensionManagerProxy
    print("test");
    final em = SourceExtensionManagerProxy(path: "../../../testextensions");
    final extensions = await em.getExtensions();

    for (var extension in extensions) {
      await extension.setEnabled(enabled: true);
      final extsetting = await extension.getSetting(name: "someid");
      expect(extsetting.setting.val.val, "somevalue",
          reason: "Setting is not correct");
      extension.setSetting(
          name: "someid",
          value: const Settingvalue.string(
              val: "othervalue", defaultVal: "defaultVal"));
      final data = await extension.getData();
      expect(data.id, '123', reason: 'Extension data is not correct');
      final entries = await extension.browse(page: 1, sort: Sort.popular);
      final entry = await extension.detail(entryid: entries[0].id, settings: {
        "someid": const Setting(
            val: Settingvalue.boolean(val: true, defaultVal: true))
      });
      final source =
          await extension.source(epid: entry.episodes[0].id, settings: {});
      expect(source is Source_Directlink, true,
          reason: 'Source is not a direct link');
      final sourceData = (source as Source_Directlink).sourcedata;
      expect(sourceData is LinkSource_Epub, true,
          reason: 'Source data is not an epub');
      expect((sourceData as LinkSource_Epub).link, 'epid',
          reason: 'Epub link is not correct');
    }
  });
}
