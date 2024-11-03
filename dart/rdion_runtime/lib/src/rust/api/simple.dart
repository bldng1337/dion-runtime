// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../third_party/dion_runtime/datastructs.dart';
import '../third_party/dion_runtime/permission.dart';
import '../third_party/dion_runtime/settings.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These functions are ignored because they have generic arguments: `request`
// These types are ignored because they are not used by any `pub` functions: `PermissionSink`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`, `from`, `into`, `into`

Stream<PermissionRequest> internalSetPermissionRequestListener() =>
    RustLib.instance.api.crateApiSimpleInternalSetPermissionRequestListener();

Future<void> internalSendPermissionRequestAnswer({required bool answer}) =>
    RustLib.instance.api
        .crateApiSimpleInternalSendPermissionRequestAnswer(answer: answer);

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<CancelToken>>
abstract class CancelToken implements RustOpaqueInterface {
  Future<void> cancel();

  Future<CancelToken> child();

  factory CancelToken() => RustLib.instance.api.crateApiSimpleCancelTokenNew();
}

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<ExtensionManagerProxy>>
abstract class ExtensionManagerProxy implements RustOpaqueInterface {
  Future<List<ExtensionProxy>> getExtensions();

  factory ExtensionManagerProxy({required String path}) =>
      RustLib.instance.api.crateApiSimpleExtensionManagerProxyNew(path: path);
}

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<ExtensionProxy>>
abstract class ExtensionProxy implements RustOpaqueInterface {
  Future<List<Entry>> browse(
      {required PlatformInt64 page, required Sort sort, CancelToken? token});

  Future<ExtensionData> data();

  Future<EntryDetailed> detail({required String entryid, CancelToken? token});

  Future<void> disable();

  Future<void> enable();

  Future<Entry?> fromurl({required String url, CancelToken? token});

  Future<Setting> getSetting({required String name});

  Future<bool> isEnabled();

  Future<List<Permission>> permissionsIter();

  Future<void> removePermissions({required Permission permission});

  Future<List<Entry>> search(
      {required PlatformInt64 page,
      required String filter,
      CancelToken? token});

  Future<void> setSetting(
      {required String name, required Settingvalue setting});

  Future<List<String>> settingIds();

  Future<List<String>> settingIdsFiltered({required Settingtype settingtype});

  Future<Source> source({required String epid, CancelToken? token});
}

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<QueueStore>>
abstract class QueueStore implements RustOpaqueInterface {
  static Future<QueueStore> default_() =>
      RustLib.instance.api.crateApiSimpleQueueStoreDefault();
}

/// flutter_rust_bridge:non_opaque
class EntryDetailed {
  final String id;
  final String url;
  final String title;
  final String ui;
  final MediaType mediaType;
  final ReleaseStatus status;
  final String description;
  final String language;
  final String? cover;
  final Map<String, String>? coverHeader;
  final List<EpisodeList> episodes;
  final List<String>? genres;
  final List<String>? alttitles;
  final List<String>? auther;
  final double? rating;
  final double? views;
  final PlatformInt64? length;

  const EntryDetailed({
    required this.id,
    required this.url,
    required this.title,
    required this.ui,
    required this.mediaType,
    required this.status,
    required this.description,
    required this.language,
    this.cover,
    this.coverHeader,
    required this.episodes,
    this.genres,
    this.alttitles,
    this.auther,
    this.rating,
    this.views,
    this.length,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode ^
      title.hashCode ^
      ui.hashCode ^
      mediaType.hashCode ^
      status.hashCode ^
      description.hashCode ^
      language.hashCode ^
      cover.hashCode ^
      coverHeader.hashCode ^
      episodes.hashCode ^
      genres.hashCode ^
      alttitles.hashCode ^
      auther.hashCode ^
      rating.hashCode ^
      views.hashCode ^
      length.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryDetailed &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          url == other.url &&
          title == other.title &&
          ui == other.ui &&
          mediaType == other.mediaType &&
          status == other.status &&
          description == other.description &&
          language == other.language &&
          cover == other.cover &&
          coverHeader == other.coverHeader &&
          episodes == other.episodes &&
          genres == other.genres &&
          alttitles == other.alttitles &&
          auther == other.auther &&
          rating == other.rating &&
          views == other.views &&
          length == other.length;
}

class PermissionRequest {
  final Permission permission;
  final String? msg;

  const PermissionRequest({
    required this.permission,
    this.msg,
  });

  @override
  int get hashCode => permission.hashCode ^ msg.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionRequest &&
          runtimeType == other.runtimeType &&
          permission == other.permission &&
          msg == other.msg;
}
