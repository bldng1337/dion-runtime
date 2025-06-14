// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastructs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomUI_TextImpl _$$CustomUI_TextImplFromJson(Map<String, dynamic> json) =>
    _$CustomUI_TextImpl(
      text: json['text'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_TextImplToJson(_$CustomUI_TextImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'runtimeType': instance.$type,
    };

_$CustomUI_ImageImpl _$$CustomUI_ImageImplFromJson(Map<String, dynamic> json) =>
    _$CustomUI_ImageImpl(
      image: json['image'] as String,
      header: (json['header'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_ImageImplToJson(
        _$CustomUI_ImageImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'header': instance.header,
      'runtimeType': instance.$type,
    };

_$CustomUI_LinkImpl _$$CustomUI_LinkImplFromJson(Map<String, dynamic> json) =>
    _$CustomUI_LinkImpl(
      link: json['link'] as String,
      label: json['label'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_LinkImplToJson(_$CustomUI_LinkImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'label': instance.label,
      'runtimeType': instance.$type,
    };

_$CustomUI_TimeStampImpl _$$CustomUI_TimeStampImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomUI_TimeStampImpl(
      timestamp: json['timestamp'] as String,
      display: $enumDecode(_$TimestampTypeEnumMap, json['display']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_TimeStampImplToJson(
        _$CustomUI_TimeStampImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'display': _$TimestampTypeEnumMap[instance.display]!,
      'runtimeType': instance.$type,
    };

const _$TimestampTypeEnumMap = {
  TimestampType.relative: 'relative',
  TimestampType.absolute: 'absolute',
};

_$CustomUI_EntryCardImpl _$$CustomUI_EntryCardImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomUI_EntryCardImpl(
      entry: Entry.fromJson(json['entry'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_EntryCardImplToJson(
        _$CustomUI_EntryCardImpl instance) =>
    <String, dynamic>{
      'entry': instance.entry,
      'runtimeType': instance.$type,
    };

_$CustomUI_ColumnImpl _$$CustomUI_ColumnImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomUI_ColumnImpl(
      children: (json['children'] as List<dynamic>)
          .map((e) => CustomUI.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_ColumnImplToJson(
        _$CustomUI_ColumnImpl instance) =>
    <String, dynamic>{
      'children': instance.children,
      'runtimeType': instance.$type,
    };

_$CustomUI_RowImpl _$$CustomUI_RowImplFromJson(Map<String, dynamic> json) =>
    _$CustomUI_RowImpl(
      children: (json['children'] as List<dynamic>)
          .map((e) => CustomUI.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_RowImplToJson(_$CustomUI_RowImpl instance) =>
    <String, dynamic>{
      'children': instance.children,
      'runtimeType': instance.$type,
    };

_$DataSource_ParagraphlistImpl _$$DataSource_ParagraphlistImplFromJson(
        Map<String, dynamic> json) =>
    _$DataSource_ParagraphlistImpl(
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$DataSource_ParagraphlistImplToJson(
        _$DataSource_ParagraphlistImpl instance) =>
    <String, dynamic>{
      'paragraphs': instance.paragraphs,
    };

_$EntryImpl _$$EntryImplFromJson(Map<String, dynamic> json) => _$EntryImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      cover: json['cover'] as String?,
      coverHeader: (json['coverHeader'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      author:
          (json['author'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      views: (json['views'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EntryImplToJson(_$EntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'cover': instance.cover,
      'coverHeader': instance.coverHeader,
      'author': instance.author,
      'rating': instance.rating,
      'views': instance.views,
      'length': instance.length,
    };

const _$MediaTypeEnumMap = {
  MediaType.video: 'video',
  MediaType.comic: 'comic',
  MediaType.audio: 'audio',
  MediaType.book: 'book',
  MediaType.unknown: 'unknown',
};

_$EntryDetailedImpl _$$EntryDetailedImplFromJson(Map<String, dynamic> json) =>
    _$EntryDetailedImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      author:
          (json['author'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ui: json['ui'] == null
          ? null
          : CustomUI.fromJson(json['ui'] as Map<String, dynamic>),
      meta: (json['meta'] as List<dynamic>?)
          ?.map((e) => MetaData.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      status: $enumDecode(_$ReleaseStatusEnumMap, json['status']),
      description: json['description'] as String,
      language: json['language'] as String,
      cover: json['cover'] as String?,
      coverHeader: (json['coverHeader'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      alttitles: (json['alttitles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      views: (json['views'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toInt(),
      settings: (json['settings'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Setting.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$EntryDetailedImplToJson(_$EntryDetailedImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'author': instance.author,
      'ui': instance.ui,
      'meta': instance.meta,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'status': _$ReleaseStatusEnumMap[instance.status]!,
      'description': instance.description,
      'language': instance.language,
      'cover': instance.cover,
      'coverHeader': instance.coverHeader,
      'episodes': instance.episodes,
      'genres': instance.genres,
      'alttitles': instance.alttitles,
      'rating': instance.rating,
      'views': instance.views,
      'length': instance.length,
      'settings': instance.settings,
    };

const _$ReleaseStatusEnumMap = {
  ReleaseStatus.releasing: 'releasing',
  ReleaseStatus.complete: 'complete',
  ReleaseStatus.unknown: 'unknown',
};

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      cover: json['cover'] as String?,
      coverHeader: (json['coverHeader'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$EpisodeImplToJson(_$EpisodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'cover': instance.cover,
      'coverHeader': instance.coverHeader,
      'timestamp': instance.timestamp,
    };

_$ExtensionDataImpl _$$ExtensionDataImplFromJson(Map<String, dynamic> json) =>
    _$ExtensionDataImpl(
      id: json['id'] as String,
      repo: json['repo'] as String?,
      name: json['name'] as String,
      mediaType: (json['mediaType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MediaTypeEnumMap, e))
          .toList(),
      giturl: json['giturl'] as String?,
      version: json['version'] as String?,
      desc: json['desc'] as String?,
      author: json['author'] as String?,
      license: json['license'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      nsfw: json['nsfw'] as bool?,
      lang: (json['lang'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$ExtensionDataImplToJson(_$ExtensionDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repo': instance.repo,
      'name': instance.name,
      'mediaType':
          instance.mediaType?.map((e) => _$MediaTypeEnumMap[e]!).toList(),
      'giturl': instance.giturl,
      'version': instance.version,
      'desc': instance.desc,
      'author': instance.author,
      'license': instance.license,
      'tags': instance.tags,
      'nsfw': instance.nsfw,
      'lang': instance.lang,
      'url': instance.url,
      'icon': instance.icon,
    };

_$ImageListAudioImpl _$$ImageListAudioImplFromJson(Map<String, dynamic> json) =>
    _$ImageListAudioImpl(
      link: json['link'] as String,
      from: (json['from'] as num).toInt(),
      to: (json['to'] as num).toInt(),
    );

Map<String, dynamic> _$$ImageListAudioImplToJson(
        _$ImageListAudioImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'from': instance.from,
      'to': instance.to,
    };

_$LinkSource_EpubImpl _$$LinkSource_EpubImplFromJson(
        Map<String, dynamic> json) =>
    _$LinkSource_EpubImpl(
      link: json['link'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LinkSource_EpubImplToJson(
        _$LinkSource_EpubImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'runtimeType': instance.$type,
    };

_$LinkSource_PdfImpl _$$LinkSource_PdfImplFromJson(Map<String, dynamic> json) =>
    _$LinkSource_PdfImpl(
      link: json['link'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LinkSource_PdfImplToJson(
        _$LinkSource_PdfImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'runtimeType': instance.$type,
    };

_$LinkSource_ImagelistImpl _$$LinkSource_ImagelistImplFromJson(
        Map<String, dynamic> json) =>
    _$LinkSource_ImagelistImpl(
      links: (json['links'] as List<dynamic>).map((e) => e as String).toList(),
      header: (json['header'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      audio: (json['audio'] as List<dynamic>?)
          ?.map((e) => ImageListAudio.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LinkSource_ImagelistImplToJson(
        _$LinkSource_ImagelistImpl instance) =>
    <String, dynamic>{
      'links': instance.links,
      'header': instance.header,
      'audio': instance.audio,
      'runtimeType': instance.$type,
    };

_$LinkSource_M3u8Impl _$$LinkSource_M3u8ImplFromJson(
        Map<String, dynamic> json) =>
    _$LinkSource_M3u8Impl(
      link: json['link'] as String,
      sub: (json['sub'] as List<dynamic>)
          .map((e) => Subtitles.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LinkSource_M3u8ImplToJson(
        _$LinkSource_M3u8Impl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'sub': instance.sub,
      'runtimeType': instance.$type,
    };

_$LinkSource_Mp3Impl _$$LinkSource_Mp3ImplFromJson(Map<String, dynamic> json) =>
    _$LinkSource_Mp3Impl(
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => UrlChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LinkSource_Mp3ImplToJson(
        _$LinkSource_Mp3Impl instance) =>
    <String, dynamic>{
      'chapters': instance.chapters,
      'runtimeType': instance.$type,
    };

_$MetaDataImpl _$$MetaDataImplFromJson(Map<String, dynamic> json) =>
    _$MetaDataImpl(
      key: json['key'] as String,
    );

Map<String, dynamic> _$$MetaDataImplToJson(_$MetaDataImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
    };

_$Source_DataImpl _$$Source_DataImplFromJson(Map<String, dynamic> json) =>
    _$Source_DataImpl(
      sourcedata:
          DataSource.fromJson(json['sourcedata'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_DataImplToJson(_$Source_DataImpl instance) =>
    <String, dynamic>{
      'sourcedata': instance.sourcedata,
      'runtimeType': instance.$type,
    };

_$Source_DirectlinkImpl _$$Source_DirectlinkImplFromJson(
        Map<String, dynamic> json) =>
    _$Source_DirectlinkImpl(
      sourcedata:
          LinkSource.fromJson(json['sourcedata'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_DirectlinkImplToJson(
        _$Source_DirectlinkImpl instance) =>
    <String, dynamic>{
      'sourcedata': instance.sourcedata,
      'runtimeType': instance.$type,
    };

_$SubtitlesImpl _$$SubtitlesImplFromJson(Map<String, dynamic> json) =>
    _$SubtitlesImpl(
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$SubtitlesImplToJson(_$SubtitlesImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };

_$UrlChapterImpl _$$UrlChapterImplFromJson(Map<String, dynamic> json) =>
    _$UrlChapterImpl(
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$UrlChapterImplToJson(_$UrlChapterImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };
