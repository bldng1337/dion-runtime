import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rdion_runtime/rdion_runtime.dart';

void main() {
  const path = "./../../../tests/jsondata";

  test('JsonMediaType', () {
    final data = File("$path/MediaType.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final mediaType = JsonMediaType.fromJson(item);
      final encoded = mediaType.toJson();
      final redecoded = JsonMediaType.fromJson(encoded);

      expect(encoded, equals(item),
          reason: _buildJsonEqualityError("MediaType[$i]", item, encoded));
      // expect(redecoded, equals(mediaType),
      //     reason: "Object equality check failed for MediaType at index $i");
    }
  });

  test("JsonStreamSource", () {
    final data = File("$path/StreamSource.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final streamSource = JsonStreamSource.fromJson(item);
      final encoded = streamSource.toJson();
      final redecoded = JsonStreamSource.fromJson(encoded);

      _deepEquals(encoded, item, "StreamSource[$i]");
      // expect(redecoded, equals(streamSource),
      //     reason: "Object equality check failed for StreamSource at index $i");
    }
  });

  test("JsonLink", () {
    final data = File("$path/Link.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final link = JsonLink.fromJson(item);
      final encoded = link.toJson();
      final redecoded = JsonLink.fromJson(encoded);

      _deepEquals(encoded, item, "Link[$i]");
      // expect(redecoded, equals(link),
      //     reason: "Object equality check failed for Link at index $i");
    }
  });

  test("JsonAction", () {
    final data = File("$path/Action.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final action = JsonAction.fromJson(item);
      final encoded = action.toJson();
      final redecoded = JsonAction.fromJson(encoded);

      _deepEquals(encoded, item, "Action[$i]");
      // expect(redecoded, equals(action),
      //     reason: "Object equality check failed for Action at index $i");
    }
  });

  test("JsonPopupAction", () {
    final data = File("$path/PopupAction.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final popupAction = JsonPopupAction.fromJson(item);
      final encoded = popupAction.toJson();
      final redecoded = JsonPopupAction.fromJson(encoded);

      _deepEquals(encoded, item, "PopupAction[$i]");
      // expect(redecoded, equals(popupAction),
      //     reason: "Object equality check failed for PopupAction at index $i");
    }
  });

  test("JsonUIAction", () {
    final data = File("$path/UIAction.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final uiAction = JsonUIAction.fromJson(item);
      final encoded = uiAction.toJson();
      final redecoded = JsonUIAction.fromJson(encoded);

      _deepEquals(encoded, item, "UIAction[$i]");
      // expect(redecoded, equals(uiAction),
      //     reason: "Object equality check failed for UIAction at index $i");
    }
  });

  test("JsonEventData", () {
    final data = File("$path/EventData.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final eventData = JsonEventData.fromJson(item);
      final encoded = eventData.toJson();
      final redecoded = JsonEventData.fromJson(encoded);

      _deepEquals(encoded, item, "EventData[$i]");
      // expect(redecoded, equals(eventData),
      //     reason: "Object equality check failed for EventData at index $i");
    }
  });

  test("JsonEventResult", () {
    final data = File("$path/EventResult.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final eventResult = JsonEventResult.fromJson(item);
      final encoded = eventResult.toJson();
      final redecoded = JsonEventResult.fromJson(encoded);

      _deepEquals(encoded, item, "EventResult[$i]");
      // expect(redecoded, equals(eventResult),
      //     reason: "Object equality check failed for EventResult at index $i");
    }
  });

  test("JsonEntryActivity", () {
    final data = File("$path/EntryActivity.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final entryActivity = JsonEntryActivity.fromJson(item);
      final encoded = entryActivity.toJson();
      final redecoded = JsonEntryActivity.fromJson(encoded);

      _deepEquals(encoded, item, "EntryActivity[$i]");
      // expect(redecoded, equals(entryActivity),
      //     reason: "Object equality check failed for EntryActivity at index $i");
    }
  });

  test("JsonTimestampType", () {
    final data = File("$path/TimestampType.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final timestampType = JsonTimestampType.fromJson(item);
      final encoded = timestampType.toJson();
      final redecoded = JsonTimestampType.fromJson(encoded);

      expect(encoded, equals(item),
          reason: _buildJsonEqualityError("TimestampType[$i]", item, encoded));
      // expect(redecoded, equals(timestampType),
      //     reason: "Object equality check failed for TimestampType at index $i");
    }
  });

  test("JsonCustomUI", () {
    final data = File("$path/CustomUI.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final customUI = JsonCustomUI.fromJson(item);
      final encoded = customUI.toJson();
      final redecoded = JsonCustomUI.fromJson(encoded);

      _deepEquals(encoded, item, "CustomUI[$i]");
      // expect(redecoded, equals(customUI),
      //     reason: "Object equality check failed for CustomUI at index $i");
    }
  });

  test("JsonExtensionData", () {
    final data = File("$path/ExtensionData.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final extensionData = JsonExtensionData.fromJson(item);
      final encoded = extensionData.toJson();
      final redecoded = JsonExtensionData.fromJson(encoded);

      _deepEquals(encoded, item, "ExtensionData[$i]");
      // expect(redecoded, equals(extensionData),
      //     reason: "Object equality check failed for ExtensionData at index $i");
    }
  });

  test("JsonSourceOpenType", () {
    final data = File("$path/SourceOpenType.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final sourceOpenType = JsonSourceOpenType.fromJson(item);
      final encoded = sourceOpenType.toJson();
      final redecoded = JsonSourceOpenType.fromJson(encoded);

      expect(encoded, equals(item),
          reason: _buildJsonEqualityError("SourceOpenType[$i]", item, encoded));
      // expect(redecoded, equals(sourceOpenType),
      //     reason:
      //         "Object equality check failed for SourceOpenType at index $i");
    }
  });

  test("JsonExtensionType", () {
    final data = File("$path/ExtensionType.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final extensionType = JsonExtensionType.fromJson(item);
      final encoded = extensionType.toJson();
      final redecoded = JsonExtensionType.fromJson(encoded);

      _deepEquals(encoded, item, "ExtensionType[$i]");
      // expect(redecoded, equals(extensionType),
      //     reason: "Object equality check failed for ExtensionType at index $i");
    }
  });

  test("JsonExtensionManagerData", () {
    final data = File("$path/ExtensionManagerData.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final extensionManagerData = JsonExtensionManagerData.fromJson(item);
      final encoded = extensionManagerData.toJson();
      final redecoded = JsonExtensionManagerData.fromJson(encoded);

      _deepEquals(encoded, item, "ExtensionManagerData[$i]");
      // expect(redecoded, equals(extensionManagerData),
      //     reason:
      //         "Object equality check failed for ExtensionManagerData at index $i");
    }
  });

  test("JsonExtensionRepo", () {
    final data = File("$path/ExtensionRepo.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final extensionRepo = JsonExtensionRepo.fromJson(item);
      final encoded = extensionRepo.toJson();
      final redecoded = JsonExtensionRepo.fromJson(encoded);

      _deepEquals(encoded, item, "ExtensionRepo[$i]");
      // expect(redecoded, equals(extensionRepo),
      //     reason: "Object equality check failed for ExtensionRepo at index $i");
    }
  });

  test("JsonRemoteExtension", () {
    final data = File("$path/RemoteExtension.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final remoteExtension = JsonRemoteExtension.fromJson(item);
      final encoded = remoteExtension.toJson();
      final redecoded = JsonRemoteExtension.fromJson(encoded);

      _deepEquals(encoded, item, "RemoteExtension[$i]");
      // expect(redecoded, equals(remoteExtension),
      //     reason:
      //         "Object equality check failed for RemoteExtension at index $i");
    }
  });

  test("JsonRemoteExtensionResult", () {
    final data = File("$path/RemoteExtensionResult.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final remoteExtensionResult = JsonRemoteExtensionResult.fromJson(item);
      final encoded = remoteExtensionResult.toJson();
      final redecoded = JsonRemoteExtensionResult.fromJson(encoded);

      _deepEquals(encoded, item, "RemoteExtensionResult[$i]");
      // expect(redecoded, equals(remoteExtensionResult),
      //     reason:
      //         "Object equality check failed for RemoteExtensionResult at index $i");
    }
  });

  test("JsonPermission", () {
    final data = File("$path/Permission.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final permission = JsonPermission.fromJson(item);
      final encoded = permission.toJson();
      final redecoded = JsonPermission.fromJson(encoded);

      _deepEquals(encoded, item, "Permission[$i]");
      // expect(redecoded, equals(permission),
      //     reason: "Object equality check failed for Permission at index $i");
    }
  });

  test("JsonSettingKind", () {
    final data = File("$path/SettingKind.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final settingKind = JsonSettingKind.fromJson(item);
      final encoded = settingKind.toJson();
      final redecoded = JsonSettingKind.fromJson(encoded);

      expect(encoded, equals(item),
          reason: _buildJsonEqualityError("SettingKind[$i]", item, encoded));
      // expect(redecoded, equals(settingKind),
      //     reason: "Object equality check failed for SettingKind at index $i");
    }
  });

  // Missing test cases
  test("JsonDropdownOption", () {
    final data = File("$path/DropdownOption.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final dropdownOption = JsonDropdownOption.fromJson(item);
      final encoded = dropdownOption.toJson();
      final redecoded = JsonDropdownOption.fromJson(encoded);

      _deepEquals(encoded, item, "DropdownOption[$i]");
      // expect(redecoded, equals(dropdownOption),
      //     reason:
      //         "Object equality check failed for DropdownOption at index $i");
    }
  });

  test("JsonEntry", () {
    final data = File("$path/Entry.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final entry = JsonEntry.fromJson(item);
      final encoded = entry.toJson();
      final redecoded = JsonEntry.fromJson(encoded);

      _deepEquals(encoded, item, "Entry[$i]");
      // expect(redecoded, equals(entry),
      //     reason: "Object equality check failed for Entry at index $i");
    }
  });

  test("JsonEntryDetailed", () {
    final data = File("$path/EntryDetailed.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final entryDetailed = JsonEntryDetailed.fromJson(item);
      final encoded = entryDetailed.toJson();
      final redecoded = JsonEntryDetailed.fromJson(encoded);

      _deepEquals(encoded, item, "EntryDetailed[$i]");
      // expect(redecoded, equals(entryDetailed),
      //     reason: "Object equality check failed for EntryDetailed at index $i");
    }
  });

  test("JsonEntryDetailedResult", () {
    final data = File("$path/EntryDetailedResult.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final entryDetailedResult = JsonEntryDetailedResult.fromJson(item);
      final encoded = entryDetailedResult.toJson();
      final redecoded = JsonEntryDetailedResult.fromJson(encoded);

      _deepEquals(encoded, item, "EntryDetailedResult[$i]");
      // expect(redecoded, equals(entryDetailedResult),
      //     reason:
      //         "Object equality check failed for EntryDetailedResult at index $i");
    }
  });

  test("JsonEntryId", () {
    final data = File("$path/EntryId.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final entryId = JsonEntryId.fromJson(item);
      final encoded = entryId.toJson();
      final redecoded = JsonEntryId.fromJson(encoded);

      _deepEquals(encoded, item, "EntryId[$i]");
      // expect(redecoded, equals(entryId),
      //     reason: "Object equality check failed for EntryId at index $i");
    }
  });

  test("JsonEntryList", () {
    final data = File("$path/EntryList.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final entryList = JsonEntryList.fromJson(item);
      final encoded = entryList.toJson();
      final redecoded = JsonEntryList.fromJson(encoded);

      _deepEquals(encoded, item, "EntryList[$i]");
      // expect(redecoded, equals(entryList),
      //     reason: "Object equality check failed for EntryList at index $i");
    }
  });

  test("JsonEpisode", () {
    final data = File("$path/Episode.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final episode = JsonEpisode.fromJson(item);
      final encoded = episode.toJson();
      final redecoded = JsonEpisode.fromJson(encoded);

      _deepEquals(encoded, item, "Episode[$i]");
      // expect(redecoded, equals(episode),
      //     reason: "Object equality check failed for Episode at index $i");
    }
  });

  test("JsonEpisodeId", () {
    final data = File("$path/EpisodeId.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final episodeId = JsonEpisodeId.fromJson(item);
      final encoded = episodeId.toJson();
      final redecoded = JsonEpisodeId.fromJson(encoded);

      _deepEquals(encoded, item, "EpisodeId[$i]");
      // expect(redecoded, equals(episodeId),
      //     reason: "Object equality check failed for EpisodeId at index $i");
    }
  });

  test("JsonImageListAudio", () {
    final data = File("$path/ImageListAudio.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final imageListAudio = JsonImageListAudio.fromJson(item);
      final encoded = imageListAudio.toJson();
      final redecoded = JsonImageListAudio.fromJson(encoded);

      _deepEquals(encoded, item, "ImageListAudio[$i]");
      // expect(redecoded, equals(imageListAudio),
      //     reason:
      //         "Object equality check failed for ImageListAudio at index $i");
    }
  });

  test("JsonParagraph", () {
    final data = File("$path/Paragraph.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final paragraph = JsonParagraph.fromJson(item);
      final encoded = paragraph.toJson();
      final redecoded = JsonParagraph.fromJson(encoded);

      _deepEquals(encoded, item, "Paragraph[$i]");
      // expect(redecoded, equals(paragraph),
      //     reason: "Object equality check failed for Paragraph at index $i");
    }
  });

  test("JsonReleaseStatus", () {
    final data = File("$path/ReleaseStatus.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final releaseStatus = JsonReleaseStatus.fromJson(item);
      final encoded = releaseStatus.toJson();
      final redecoded = JsonReleaseStatus.fromJson(encoded);

      expect(encoded, equals(item),
          reason: _buildJsonEqualityError("ReleaseStatus[$i]", item, encoded));
      // expect(redecoded, equals(releaseStatus),
      //     reason: "Object equality check failed for ReleaseStatus at index $i");
    }
  });

  test("JsonSetting", () {
    final data = File("$path/Setting.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final setting = JsonSetting.fromJson(item);
      final encoded = setting.toJson();
      final redecoded = JsonSetting.fromJson(encoded);

      _deepEquals(encoded, item, "Setting[$i]");
      // expect(redecoded, equals(setting),
      //     reason: "Object equality check failed for Setting at index $i");
    }
  });

  test("JsonSettingsUI", () {
    final data = File("$path/SettingsUI.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final settingsUI = JsonSettingsUI.fromJson(item);
      final encoded = settingsUI.toJson();
      final redecoded = JsonSettingsUI.fromJson(encoded);

      _deepEquals(encoded, item, "SettingsUI[$i]");
      // expect(redecoded, equals(settingsUI),
      //     reason: "Object equality check failed for SettingsUI at index $i");
    }
  });

  test("JsonSettingValue", () {
    final data = File("$path/SettingValue.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final settingValue = JsonSettingValue.fromJson(item);
      final encoded = settingValue.toJson();
      final redecoded = JsonSettingValue.fromJson(encoded);

      _deepEquals(encoded, item, "SettingValue[$i]");
      // expect(redecoded, equals(settingValue),
      //     reason: "Object equality check failed for SettingValue at index $i");
    }
  });

  test("JsonSource", () {
    final data = File("$path/Source.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final source = JsonSource.fromJson(item);
      final encoded = source.toJson();
      final redecoded = JsonSource.fromJson(encoded);

      _deepEquals(encoded, item, "Source[$i]");
      // expect(redecoded, equals(source),
      //     reason: "Object equality check failed for Source at index $i");
    }
  });

  test("JsonSourceResult", () {
    final data = File("$path/SourceResult.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final sourceResult = JsonSourceResult.fromJson(item);
      final encoded = sourceResult.toJson();
      final redecoded = JsonSourceResult.fromJson(encoded);

      _deepEquals(encoded, item, "SourceResult[$i]");
      // expect(redecoded, equals(sourceResult),
      //     reason: "Object equality check failed for SourceResult at index $i");
    }
  });

  test("JsonSourceType", () {
    final data = File("$path/SourceType.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final sourceType = JsonSourceType.fromJson(item);
      final encoded = sourceType.toJson();
      final redecoded = JsonSourceType.fromJson(encoded);

      expect(encoded, equals(item),
          reason: _buildJsonEqualityError("SourceType[$i]", item, encoded));
      // expect(redecoded, equals(sourceType),
      //     reason: "Object equality check failed for SourceType at index $i");
    }
  });

  test("JsonSubtitles", () {
    final data = File("$path/Subtitles.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final subtitles = JsonSubtitles.fromJson(item);
      final encoded = subtitles.toJson();
      final redecoded = JsonSubtitles.fromJson(encoded);

      _deepEquals(encoded, item, "Subtitles[$i]");
      // expect(redecoded, equals(subtitles),
      //     reason: "Object equality check failed for Subtitles at index $i");
    }
  });

  test("JsonAuthData", () {
    final data = File("$path/AuthData.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final authData = JsonAuthData.fromJson(item);
      final encoded = authData.toJson();
      final redecoded = JsonAuthData.fromJson(encoded);

      _deepEquals(encoded, item, "AuthData[$i]");
      // expect(redecoded, equals(authData),
      //     reason: "Object equality check failed for AuthData at index $i");
    }
  });

  test("Paragraph", () {
    final data = File("$path/Paragraph.json").readAsStringSync();
    final json = jsonDecode(data) as List;
    for (int i = 0; i < json.length; i++) {
      final item = json[i];
      final paragraph = JsonParagraph.fromJson(item);
      final encoded = paragraph.toJson();
      final redecoded = JsonParagraph.fromJson(encoded);

      _deepEquals(encoded, item, "Paragraph[$i]");
      // expect(redecoded, equals(paragraph),
      //     reason: "Object equality check failed for Paragraph at index $i");
    }
  });
}

/// Performs deep equality check on two values with detailed error reporting.
/// Tracks the JSON path where comparisons occur and provides full JSON context on failure.
void _deepEquals(dynamic a, dynamic b, String path) {
  if (a == b) return;

  if (a is Map && b is Map) {
    // Remove null values from both maps before comparing
    // This treats keys with null values as if they don't exist
    final filteredA = _removeNullValues(a.cast());
    final filteredB = _removeNullValues(b.cast());

    expect(filteredA.length, equals(filteredB.length),
        reason: _buildError(
            path,
            "Map length mismatch",
            "Expected ${filteredB.length} keys, got ${filteredA.length}",
            a,
            b));

    for (final key in filteredA.keys) {
      final newPath = "$path.$key";
      expect(filteredB.containsKey(key), isTrue,
          reason: _buildError(newPath, "Key not found in encoded JSON",
              "Original JSON has key '$key' but encoded JSON does not", a, b));
      _deepEquals(filteredA[key], filteredB[key], newPath);
    }

    // Check for keys in b that aren't in a
    for (final key in filteredB.keys) {
      if (!filteredA.containsKey(key)) {
        fail(_buildError("$path.$key", "Extra key in encoded JSON",
            "Encoded JSON has key '$key' but original JSON does not", a, b));
      }
    }
  } else if (a is List && b is List) {
    expect(a.length, equals(b.length),
        reason: _buildError(path, "List length mismatch",
            "Expected length ${b.length}, got ${a.length}", a, b));
    for (int i = 0; i < a.length; i++) {
      _deepEquals(a[i], b[i], "$path[$i]");
    }
  } else if (a is Set && b is Set) {
    expect(a.length, equals(b.length),
        reason: _buildError(path, "Set size mismatch",
            "Expected ${b.length} elements, got ${a.length}", a, b));
    for (final item in a) {
      expect(b.contains(item), isTrue,
          reason: _buildError(path, "Element not found in encoded set",
              "Original set contains '$item' but encoded set does not", a, b));
    }
  } else {
    expect(a, equals(b),
        reason: _buildError(path, "Value mismatch",
            "Expected: ${_formatValue(b)}\nActual: ${_formatValue(a)}", a, b));
  }
}

/// Builds a detailed error message with JSON path and full content.
String _buildError(String path, String summary, String details,
    dynamic original, dynamic encoded) {
  return '''
================================================================================
JSON Equality Test Failed
================================================================================

Path: $path
Summary: $summary
Details: $details

Original JSON:
${_formatJson(original, indent: "  ")}

Encoded JSON:
${_formatJson(encoded, indent: "  ")}
================================================================================
''';
}

/// Builds an error message for simple type comparisons (primitives).
String _buildJsonEqualityError(String path, dynamic original, dynamic encoded) {
  return '''
================================================================================
JSON Equality Test Failed at $path
================================================================================

Expected: ${_formatValue(original)}
Actual: ${_formatValue(encoded)}

Original JSON:
${_formatJson(original, indent: "  ")}

Encoded JSON:
${_formatJson(encoded, indent: "  ")}
================================================================================
''';
}

/// Formats a value for display in error messages.
String _formatValue(dynamic value) {
  if (value == null) return 'null';
  if (value is String) return '"$value"';
  if (value is List) return '[... (length: ${value.length})]';
  if (value is Map) return '{... (${value.length} keys)}';
  if (value is Set) return '{... (${value.length} elements)}';
  return value.toString();
}

/// Formats a JSON value with proper indentation for display.
String _formatJson(dynamic value, {String indent = ""}) {
  final encoder = JsonEncoder.withIndent(indent);
  try {
    return encoder.convert(value);
  } catch (_) {
    // Fallback if encoder fails
    return value.toString();
  }
}

/// Removes all keys with null values from a map recursively.
/// This treats keys with null values as if they don't exist for comparison purposes.
Map<String, dynamic> _removeNullValues(Map<String, dynamic> map) {
  final result = <String, dynamic>{};

  for (final entry in map.entries) {
    if (entry.value == null) {
      // Skip null values - treat as if key doesn't exist
      continue;
    } else if (entry.value is Map) {
      // Recursively remove null values from nested maps
      result[entry.key] =
          _removeNullValues((entry.value as Map).cast<String, dynamic>());
    } else if (entry.value is List) {
      // Recursively process list items
      final list = entry.value as List;
      result[entry.key] = list.map((item) {
        if (item is Map) {
          return _removeNullValues(item.cast<String, dynamic>());
        }
        return item;
      }).toList();
    } else {
      result[entry.key] = entry.value;
    }
  }

  return result;
}
