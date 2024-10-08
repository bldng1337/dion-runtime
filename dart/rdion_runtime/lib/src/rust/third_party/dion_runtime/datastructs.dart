// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'datastructs.freezed.dart';

// These types are ignored because they are not used by any `pub` functions: `CustomUI`, `TimestampType`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`
// These functions are ignored (category: IgnoreBecauseExplicitAttribute): `into_js`

@freezed
sealed class DataSource with _$DataSource {
  const DataSource._();

  const factory DataSource.paragraphlist({
    required List<String> paragraphs,
  }) = DataSource_Paragraphlist;
}

/// flutter_rust_bridge:non_opaque
class Entry {
  final String id;
  final String url;
  final String title;
  final String? cover;
  final Map<String, String>? coverHeader;
  final List<String>? auther;
  final double? rating;
  final double? views;
  final PlatformInt64? length;

  const Entry({
    required this.id,
    required this.url,
    required this.title,
    this.cover,
    this.coverHeader,
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
      cover.hashCode ^
      coverHeader.hashCode ^
      auther.hashCode ^
      rating.hashCode ^
      views.hashCode ^
      length.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          url == other.url &&
          title == other.title &&
          cover == other.cover &&
          coverHeader == other.coverHeader &&
          auther == other.auther &&
          rating == other.rating &&
          views == other.views &&
          length == other.length;
}

/// flutter_rust_bridge:non_opaque
class Episode {
  final String id;
  final String name;
  final String url;
  final String? cover;
  final Map<String, String>? coverHeader;
  final String? timestamp;

  const Episode({
    required this.id,
    required this.name,
    required this.url,
    this.cover,
    this.coverHeader,
    this.timestamp,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      url.hashCode ^
      cover.hashCode ^
      coverHeader.hashCode ^
      timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Episode &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          url == other.url &&
          cover == other.cover &&
          coverHeader == other.coverHeader &&
          timestamp == other.timestamp;
}

/// flutter_rust_bridge:non_opaque
class EpisodeList {
  final String title;
  final List<Episode> episodes;

  const EpisodeList({
    required this.title,
    required this.episodes,
  });

  @override
  int get hashCode => title.hashCode ^ episodes.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeList &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          episodes == other.episodes;
}

/// flutter_rust_bridge:non_opaque
class ImageListAudio {
  final String link;
  final PlatformInt64 from;
  final PlatformInt64 to;

  const ImageListAudio({
    required this.link,
    required this.from,
    required this.to,
  });

  @override
  int get hashCode => link.hashCode ^ from.hashCode ^ to.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageListAudio &&
          runtimeType == other.runtimeType &&
          link == other.link &&
          from == other.from &&
          to == other.to;
}

@freezed
sealed class LinkSource with _$LinkSource {
  const LinkSource._();

  const factory LinkSource.epub({
    required String link,
  }) = LinkSource_Epub;
  const factory LinkSource.pdf({
    required String link,
  }) = LinkSource_Pdf;
  const factory LinkSource.imagelist({
    required List<String> links,
    required Map<String, String> header,
    required List<ImageListAudio> audio,
  }) = LinkSource_Imagelist;
  const factory LinkSource.m3U8({
    required String link,
    required List<Subtitles> sub,
  }) = LinkSource_M3u8;
}

/// flutter_rust_bridge:non_opaque
enum MediaType {
  video,
  comic,
  audio,
  book,
  unknown,
  ;
}

/// flutter_rust_bridge:non_opaque
enum ReleaseStatus {
  releasing,
  complete,
  unknown,
  ;
}

/// flutter_rust_bridge:non_opaque
enum Sort {
  popular,
  latest,
  updated,
  ;
}

@freezed
sealed class Source with _$Source {
  const Source._();

  const factory Source.data({
    required DataSource sourcedata,
  }) = Source_Data;
  const factory Source.directlink({
    required LinkSource sourcedata,
  }) = Source_Directlink;
}

/// flutter_rust_bridge:non_opaque
class Subtitles {
  final String title;
  final String url;

  const Subtitles({
    required this.title,
    required this.url,
  });

  @override
  int get hashCode => title.hashCode ^ url.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subtitles &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          url == other.url;
}
