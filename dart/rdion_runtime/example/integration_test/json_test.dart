import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart';

void main() {
  const path = "./../../../tests/jsondata";
  test('JsonMediaType', () {
    final data = File("$path/MediaType.json").readAsStringSync();
    final json = jsonDecode(data);
    final mediaType = JsonMediaType.fromJson(json);
    final json2 = mediaType.toJson();
    JsonMediaType.fromJson(json2);
  });
  test("StreamSource", () {
    final data = File("$path/StreamSource.json").readAsStringSync();
    final json = jsonDecode(data);
    final mp3Chapter = JsonStreamSource.fromJson(json);
    final json2 = mp3Chapter.toJson();
    JsonStreamSource.fromJson(json2);
  });
  test("JsonLink", () {
    final data = File("$path/Link.json").readAsStringSync();
    final json = jsonDecode(data);
    final link = JsonLink.fromJson(json);
    final json2 = link.toJson();
    JsonLink.fromJson(json2);
  });
  test("JsonAction", () {
    final data = File("$path/Action.json").readAsStringSync();
    final json = jsonDecode(data);
    final action = JsonAction.fromJson(json);
    final json2 = action.toJson();
    JsonAction.fromJson(json2);
  });
  test("JsonPopupAction", () {
    final data = File("$path/PopupAction.json").readAsStringSync();
    final json = jsonDecode(data);
    final popupAction = JsonPopupAction.fromJson(json);
    final json2 = popupAction.toJson();
    JsonPopupAction.fromJson(json2);
  });
  test("JsonUIAction", () {
    final data = File("$path/UIAction.json").readAsStringSync();
    final json = jsonDecode(data);
    final uiAction = JsonUIAction.fromJson(json);
    final json2 = uiAction.toJson();
    JsonUIAction.fromJson(json2);
  });
  test("JsonEventData", () {
    final data = File("$path/EventData.json").readAsStringSync();
    final json = jsonDecode(data);
    final eventData = JsonEventData.fromJson(json);
    final json2 = eventData.toJson();
    JsonEventData.fromJson(json2);
  });
  test("JsonEventResult", () {
    final data = File("$path/EventResult.json").readAsStringSync();
    final json = jsonDecode(data);
    final eventResult = JsonEventResult.fromJson(json);
    final json2 = eventResult.toJson();
    JsonEventResult.fromJson(json2);
  });
  test("JsonEntryActivity", () {
    final data = File("$path/EntryActivity.json").readAsStringSync();
    final json = jsonDecode(data);
    final entryActivity = JsonEntryActivity.fromJson(json);
    final json2 = entryActivity.toJson();
    JsonEntryActivity.fromJson(json2);
  });
  test("JsonTimestampType", () {
    final data = File("$path/TimestampType.json").readAsStringSync();
    final json = jsonDecode(data);
    final timestampType = JsonTimestampType.fromJson(json);
    final json2 = timestampType.toJson();
    JsonTimestampType.fromJson(json2);
  });
  test("JsonCustomUI", () {
    final data = File("$path/CustomUI.json").readAsStringSync();
    final json = jsonDecode(data);
    final customUI = JsonCustomUI.fromJson(json);
    final json2 = customUI.toJson();
    JsonCustomUI.fromJson(json2);
  });
  test("JsonExtensionData", () {
    final data = File("$path/ExtensionData.json").readAsStringSync();
    final json = jsonDecode(data);
    final extensionData = JsonExtensionData.fromJson(json);
    final json2 = extensionData.toJson();
    JsonExtensionData.fromJson(json2);
  });
  test("JsonSourceOpenType", () {
    final data = File("$path/SourceOpenType.json").readAsStringSync();
    final json = jsonDecode(data);
    final sourceOpenType = JsonSourceOpenType.fromJson(json);
    final json2 = sourceOpenType.toJson();
    JsonSourceOpenType.fromJson(json2);
  });
  test("JsonExtensionType", () {
    final data = File("$path/ExtensionType.json").readAsStringSync();
    final json = jsonDecode(data);
    final extensionType = JsonExtensionType.fromJson(json);
    final json2 = extensionType.toJson();
    JsonExtensionType.fromJson(json2);
  });
  test("JsonExtensionManagerData", () {
    final data = File("$path/ExtensionManagerData.json").readAsStringSync();
    final json = jsonDecode(data);
    final extensionManagerData = JsonExtensionManagerData.fromJson(json);
    final json2 = extensionManagerData.toJson();
    JsonExtensionManagerData.fromJson(json2);
  });
  test("JsonExtensionRepo", () {
    final data = File("$path/ExtensionRepo.json").readAsStringSync();
    final json = jsonDecode(data);
    final extensionRepo = JsonExtensionRepo.fromJson(json);
    final json2 = extensionRepo.toJson();
    JsonExtensionRepo.fromJson(json2);
  });
  test("JsonRemoteExtension", () {
    final data = File("$path/RemoteExtension.json").readAsStringSync();
    final json = jsonDecode(data);
    final remoteExtension = JsonRemoteExtension.fromJson(json);
    final json2 = remoteExtension.toJson();
    JsonRemoteExtension.fromJson(json2);
  });
  test("JsonRemoteExtensionResult", () {
    final data = File("$path/RemoteExtensionResult.json").readAsStringSync();
    final json = jsonDecode(data);
    final remoteExtensionResult = JsonRemoteExtensionResult.fromJson(json);
    final json2 = remoteExtensionResult.toJson();
    JsonRemoteExtensionResult.fromJson(json2);
  });
  test("JsonPermission", () {
    final data = File("$path/Permission.json").readAsStringSync();
    final json = jsonDecode(data);
    final permission = JsonPermission.fromJson(json);
    final json2 = permission.toJson();
    JsonPermission.fromJson(json2);
  });
  test("JsonSettingKind", () {
    final data = File("$path/SettingKind.json").readAsStringSync();
    final json = jsonDecode(data);
    final settingKind = JsonSettingKind.fromJson(json);
    final json2 = settingKind.toJson();
    JsonSettingKind.fromJson(json2);
  });
}
