// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastructs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Action_OpenBrowserImpl _$$Action_OpenBrowserImplFromJson(
        Map<String, dynamic> json) =>
    _$Action_OpenBrowserImpl(
      url: json['url'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Action_OpenBrowserImplToJson(
        _$Action_OpenBrowserImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'runtimeType': instance.$type,
    };

_$Action_PopupImpl _$$Action_PopupImplFromJson(Map<String, dynamic> json) =>
    _$Action_PopupImpl(
      title: json['title'] as String,
      content: CustomUI.fromJson(json['content'] as Map<String, dynamic>),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => PopupAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Action_PopupImplToJson(_$Action_PopupImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'actions': instance.actions,
      'runtimeType': instance.$type,
    };

_$Action_NavImpl _$$Action_NavImplFromJson(Map<String, dynamic> json) =>
    _$Action_NavImpl(
      title: json['title'] as String,
      content: CustomUI.fromJson(json['content'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Action_NavImplToJson(_$Action_NavImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'runtimeType': instance.$type,
    };

_$Action_TriggerEventImpl _$$Action_TriggerEventImplFromJson(
        Map<String, dynamic> json) =>
    _$Action_TriggerEventImpl(
      event: json['event'] as String,
      data: json['data'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Action_TriggerEventImplToJson(
        _$Action_TriggerEventImpl instance) =>
    <String, dynamic>{
      'event': instance.event,
      'data': instance.data,
      'runtimeType': instance.$type,
    };

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
      image: Link.fromJson(json['image'] as Map<String, dynamic>),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_ImageImplToJson(
        _$CustomUI_ImageImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'width': instance.width,
      'height': instance.height,
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

_$CustomUI_ButtonImpl _$$CustomUI_ButtonImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomUI_ButtonImpl(
      label: json['label'] as String,
      onClick: json['onClick'] == null
          ? null
          : UIAction.fromJson(json['onClick'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_ButtonImplToJson(
        _$CustomUI_ButtonImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'onClick': instance.onClick,
      'runtimeType': instance.$type,
    };

_$CustomUI_InlineSettingImpl _$$CustomUI_InlineSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomUI_InlineSettingImpl(
      settingId: json['settingId'] as String,
      onCommit: json['onCommit'] == null
          ? null
          : UIAction.fromJson(json['onCommit'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_InlineSettingImplToJson(
        _$CustomUI_InlineSettingImpl instance) =>
    <String, dynamic>{
      'settingId': instance.settingId,
      'onCommit': instance.onCommit,
      'runtimeType': instance.$type,
    };

_$CustomUI_SlotImpl _$$CustomUI_SlotImplFromJson(Map<String, dynamic> json) =>
    _$CustomUI_SlotImpl(
      id: json['id'] as String,
      child: CustomUI.fromJson(json['child'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CustomUI_SlotImplToJson(_$CustomUI_SlotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'child': instance.child,
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

_$EntryImpl _$$EntryImplFromJson(Map<String, dynamic> json) => _$EntryImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      cover: json['cover'] == null
          ? null
          : Link.fromJson(json['cover'] as Map<String, dynamic>),
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

_$EntryActivity_EpisodeActivityImpl
    _$$EntryActivity_EpisodeActivityImplFromJson(Map<String, dynamic> json) =>
        _$EntryActivity_EpisodeActivityImpl(
          progress: (json['progress'] as num).toInt(),
        );

Map<String, dynamic> _$$EntryActivity_EpisodeActivityImplToJson(
        _$EntryActivity_EpisodeActivityImpl instance) =>
    <String, dynamic>{
      'progress': instance.progress,
    };

_$EntryDetailedImpl _$$EntryDetailedImplFromJson(Map<String, dynamic> json) =>
    _$EntryDetailedImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      titles:
          (json['titles'] as List<dynamic>).map((e) => e as String).toList(),
      author:
          (json['author'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ui: json['ui'] == null
          ? null
          : CustomUI.fromJson(json['ui'] as Map<String, dynamic>),
      meta: (json['meta'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['mediaType']),
      status: $enumDecode(_$ReleaseStatusEnumMap, json['status']),
      description: json['description'] as String,
      language: json['language'] as String,
      cover: json['cover'] == null
          ? null
          : Link.fromJson(json['cover'] as Map<String, dynamic>),
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      views: (json['views'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EntryDetailedImplToJson(_$EntryDetailedImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'titles': instance.titles,
      'author': instance.author,
      'ui': instance.ui,
      'meta': instance.meta,
      'mediaType': _$MediaTypeEnumMap[instance.mediaType]!,
      'status': _$ReleaseStatusEnumMap[instance.status]!,
      'description': instance.description,
      'language': instance.language,
      'cover': instance.cover,
      'episodes': instance.episodes,
      'genres': instance.genres,
      'rating': instance.rating,
      'views': instance.views,
      'length': instance.length,
    };

const _$ReleaseStatusEnumMap = {
  ReleaseStatus.releasing: 'releasing',
  ReleaseStatus.complete: 'complete',
  ReleaseStatus.unknown: 'unknown',
};

_$EntryDetailedResultImpl _$$EntryDetailedResultImplFromJson(
        Map<String, dynamic> json) =>
    _$EntryDetailedResultImpl(
      entry: EntryDetailed.fromJson(json['entry'] as Map<String, dynamic>),
      settings: (json['settings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Setting.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$EntryDetailedResultImplToJson(
        _$EntryDetailedResultImpl instance) =>
    <String, dynamic>{
      'entry': instance.entry,
      'settings': instance.settings,
    };

_$EntryListImpl _$$EntryListImplFromJson(Map<String, dynamic> json) =>
    _$EntryListImpl(
      hasnext: json['hasnext'] as bool?,
      length: (json['length'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EntryListImplToJson(_$EntryListImpl instance) =>
    <String, dynamic>{
      'hasnext': instance.hasnext,
      'length': instance.length,
      'content': instance.content,
    };

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      cover: json['cover'] == null
          ? null
          : Link.fromJson(json['cover'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$EpisodeImplToJson(_$EpisodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'cover': instance.cover,
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
      extensionType: (json['extensionType'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ExtensionTypeEnumMap, e))
          .toList(),
      version: json['version'] as String?,
      desc: json['desc'] as String?,
      author:
          (json['author'] as List<dynamic>).map((e) => e as String).toList(),
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
      'extensionType': instance.extensionType
          ?.map((e) => _$ExtensionTypeEnumMap[e]!)
          .toList(),
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

const _$ExtensionTypeEnumMap = {
  ExtensionType.sourceProvider: 'sourceProvider',
  ExtensionType.urlResolve: 'urlResolve',
  ExtensionType.sourceProcessor: 'sourceProcessor',
  ExtensionType.entryExtension: 'entryExtension',
};

_$ExtensionRepoImpl _$$ExtensionRepoImplFromJson(Map<String, dynamic> json) =>
    _$ExtensionRepoImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      id: json['id'] as String,
      extensions: (json['extensions'] as List<dynamic>)
          .map((e) => RemoteExtension.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExtensionRepoImplToJson(_$ExtensionRepoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'id': instance.id,
      'extensions': instance.extensions,
    };

_$ImageListAudioImpl _$$ImageListAudioImplFromJson(Map<String, dynamic> json) =>
    _$ImageListAudioImpl(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
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

_$LinkImpl _$$LinkImplFromJson(Map<String, dynamic> json) => _$LinkImpl(
      url: json['url'] as String,
      header: (json['header'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$LinkImplToJson(_$LinkImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'header': instance.header,
    };

_$Mp3ChapterImpl _$$Mp3ChapterImplFromJson(Map<String, dynamic> json) =>
    _$Mp3ChapterImpl(
      title: json['title'] as String,
      url: Link.fromJson(json['url'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$Mp3ChapterImplToJson(_$Mp3ChapterImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };

_$Paragraph_TextImpl _$$Paragraph_TextImplFromJson(Map<String, dynamic> json) =>
    _$Paragraph_TextImpl(
      content: json['content'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Paragraph_TextImplToJson(
        _$Paragraph_TextImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'runtimeType': instance.$type,
    };

_$Paragraph_CustomUIImpl _$$Paragraph_CustomUIImplFromJson(
        Map<String, dynamic> json) =>
    _$Paragraph_CustomUIImpl(
      ui: CustomUI.fromJson(json['ui'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Paragraph_CustomUIImplToJson(
        _$Paragraph_CustomUIImpl instance) =>
    <String, dynamic>{
      'ui': instance.ui,
      'runtimeType': instance.$type,
    };

_$PopupActionImpl _$$PopupActionImplFromJson(Map<String, dynamic> json) =>
    _$PopupActionImpl(
      label: json['label'] as String,
      onclick: Action.fromJson(json['onclick'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PopupActionImplToJson(_$PopupActionImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'onclick': instance.onclick,
    };

_$RemoteExtensionImpl _$$RemoteExtensionImplFromJson(
        Map<String, dynamic> json) =>
    _$RemoteExtensionImpl(
      extensionUrl: json['extensionUrl'] as String,
      compatible: json['compatible'] as bool,
      data: ExtensionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RemoteExtensionImplToJson(
        _$RemoteExtensionImpl instance) =>
    <String, dynamic>{
      'extensionUrl': instance.extensionUrl,
      'compatible': instance.compatible,
      'data': instance.data,
    };

_$Source_EpubImpl _$$Source_EpubImplFromJson(Map<String, dynamic> json) =>
    _$Source_EpubImpl(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_EpubImplToJson(_$Source_EpubImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'runtimeType': instance.$type,
    };

_$Source_PdfImpl _$$Source_PdfImplFromJson(Map<String, dynamic> json) =>
    _$Source_PdfImpl(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_PdfImplToJson(_$Source_PdfImpl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'runtimeType': instance.$type,
    };

_$Source_ImagelistImpl _$$Source_ImagelistImplFromJson(
        Map<String, dynamic> json) =>
    _$Source_ImagelistImpl(
      links: (json['links'] as List<dynamic>)
          .map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      audio: (json['audio'] as List<dynamic>?)
          ?.map((e) => ImageListAudio.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_ImagelistImplToJson(
        _$Source_ImagelistImpl instance) =>
    <String, dynamic>{
      'links': instance.links,
      'audio': instance.audio,
      'runtimeType': instance.$type,
    };

_$Source_M3u8Impl _$$Source_M3u8ImplFromJson(Map<String, dynamic> json) =>
    _$Source_M3u8Impl(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
      sub: (json['sub'] as List<dynamic>)
          .map((e) => Subtitles.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_M3u8ImplToJson(_$Source_M3u8Impl instance) =>
    <String, dynamic>{
      'link': instance.link,
      'sub': instance.sub,
      'runtimeType': instance.$type,
    };

_$Source_Mp3Impl _$$Source_Mp3ImplFromJson(Map<String, dynamic> json) =>
    _$Source_Mp3Impl(
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => Mp3Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_Mp3ImplToJson(_$Source_Mp3Impl instance) =>
    <String, dynamic>{
      'chapters': instance.chapters,
      'runtimeType': instance.$type,
    };

_$Source_ParagraphlistImpl _$$Source_ParagraphlistImplFromJson(
        Map<String, dynamic> json) =>
    _$Source_ParagraphlistImpl(
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => Paragraph.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Source_ParagraphlistImplToJson(
        _$Source_ParagraphlistImpl instance) =>
    <String, dynamic>{
      'paragraphs': instance.paragraphs,
      'runtimeType': instance.$type,
    };

_$SourceResultImpl _$$SourceResultImplFromJson(Map<String, dynamic> json) =>
    _$SourceResultImpl(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      settings: (json['settings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Setting.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$SourceResultImplToJson(_$SourceResultImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'settings': instance.settings,
    };

_$SubtitlesImpl _$$SubtitlesImplFromJson(Map<String, dynamic> json) =>
    _$SubtitlesImpl(
      title: json['title'] as String,
      url: Link.fromJson(json['url'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SubtitlesImplToJson(_$SubtitlesImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
    };

_$UIAction_ActionImpl _$$UIAction_ActionImplFromJson(
        Map<String, dynamic> json) =>
    _$UIAction_ActionImpl(
      action: Action.fromJson(json['action'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UIAction_ActionImplToJson(
        _$UIAction_ActionImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'runtimeType': instance.$type,
    };

_$UIAction_SwapContentImpl _$$UIAction_SwapContentImplFromJson(
        Map<String, dynamic> json) =>
    _$UIAction_SwapContentImpl(
      targetid: json['targetid'] as String?,
      event: json['event'] as String,
      placeholder: json['placeholder'] == null
          ? null
          : CustomUI.fromJson(json['placeholder'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UIAction_SwapContentImplToJson(
        _$UIAction_SwapContentImpl instance) =>
    <String, dynamic>{
      'targetid': instance.targetid,
      'event': instance.event,
      'placeholder': instance.placeholder,
      'runtimeType': instance.$type,
    };
