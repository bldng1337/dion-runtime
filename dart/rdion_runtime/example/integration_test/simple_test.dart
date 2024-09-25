
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // setUpAll(() async => await RustLib.init());

  test('E2E Extension Test', () async {
    await RustLib.init();
    setPermissionRequest((permission) {
      final path=(permission.permission as Permission_StoragePermission).path;
      expect(path, 'some', reason: 'Permission is not correct');
      return true;
    });
    final em = ExtensionManagerProxy();
    em.addFromFile(path: "../../../testextensions/test.dion.js");
    final extensions = await em.iter();
    for (var extension in extensions) {
      await extension.enable();
      final entries = await extension.browse(page: 1, sort: Sort.popular);
      final entry = await extension.detail(entry: entries[0]);
      final source = await extension.source(ep: entry.episodes[0].episodes[0]);
      expect(source is Source_Directlink, true,reason: 'Source is not a direct link');
      final sourceData = (source as Source_Directlink).sourcedata;
      expect(sourceData is LinkSource_Epub, true,reason: 'Source data is not an epub');
      expect((sourceData as LinkSource_Epub).link, 'epid', reason: 'Epub link is not correct');
    }
  });
}