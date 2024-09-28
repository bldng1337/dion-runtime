import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());

  test('E2E Extension Manager Test', () async {
    setPermissionRequest((permission) {
      final path = (permission.permission as Permission_StoragePermission).path;
      expect(path, 'some', reason: 'Permission is not correct');
      return true;
    });
    final em = ExtensionManagerProxy();
    final ext =
        await em.addFromFile(path: "../../../testextensions/test.dion.js");
    final extensions = await em.iter();

    for (var extension in extensions) {
      await extension.enable();
      final setting = await extension.getSetting(name: "someid");
      expect(setting.val.val, "somevalue", reason: "Setting is not correct");
      extension.setSetting(
          name: "someid",
          setting: const Settingvalue.string(
              val: "othervalue", defaultVal: "defaultVal"));
      final data = await extension.data();
      expect(data.id, '123', reason: 'Extension data is not correct');
      final entries = await extension.browse(page: 1, sort: Sort.popular);
      final entry = await extension.detail(entryid: entries[0].id);
      final source = await extension.source(epid: entry.episodes[0].episodes[0].id);
      expect(source is Source_Directlink, true,
          reason: 'Source is not a direct link');
      final sourceData = (source as Source_Directlink).sourcedata;
      expect(sourceData is LinkSource_Epub, true,
          reason: 'Source data is not an epub');
      expect((sourceData as LinkSource_Epub).link, 'epid',
          reason: 'Epub link is not correct');
    }
    await em.remove(id: (await ext.data()).id);

  });

  test('E2E Extension Test', () async {
    setPermissionRequest((permission) {
      final path = (permission.permission as Permission_StoragePermission).path;
      expect(path, 'some', reason: 'Permission is not correct');
      return true;
    });
    final extension = await ExtensionProxy.newInstance(filepath: "../../../testextensions/test.dion.js");

    await extension.enable();
    final setting = await extension.getSetting(name: "someid");
    expect(setting.val.val, "somevalue", reason: "Setting is not correct");
    extension.setSetting(
        name: "someid",
        setting: const Settingvalue.string(
            val: "othervalue", defaultVal: "defaultVal"));
    final data = await extension.data();
    expect(data.id, '123', reason: 'Extension data is not correct');
    final entries = await extension.browse(page: 1, sort: Sort.popular);
    final entry = await extension.detail(entryid: entries[0].id);
    final source = await extension.source(epid: entry.episodes[0].episodes[0].id);
    expect(source is Source_Directlink, true,
        reason: 'Source is not a direct link');
    final sourceData = (source as Source_Directlink).sourcedata;
    expect(sourceData is LinkSource_Epub, true,
        reason: 'Source data is not an epub');
    expect((sourceData as LinkSource_Epub).link, 'epid',
        reason: 'Epub link is not correct');
    await extension.disable();
    expect(await extension.isEnabled(), false);
  });
}
