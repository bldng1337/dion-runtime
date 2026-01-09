import 'package:rdion_runtime/rdion_runtime.dart';

extension JsonMediaType on MediaType {
  dynamic toJson() => switch (this) {
        MediaType.video => "Video",
        MediaType.audio => "Audio",
        MediaType.book => "Book",
        MediaType.comic => "Comic",
        MediaType.unknown => "Unknown",
      };
  static MediaType fromJson(dynamic value) =>
      switch (value.toString().toLowerCase()) {
        "video" => MediaType.video,
        "audio" => MediaType.audio,
        "book" => MediaType.book,
        "comic" => MediaType.comic,
        "unknown" => MediaType.unknown,
        _ => MediaType.unknown,
      };
}

extension JsonStreamSource on StreamSource {
  dynamic toJson() => {
        "name": name,
        "lang": lang,
        "url": url.toJson(),
      };
  static StreamSource fromJson(dynamic value) => StreamSource(
        name: value["name"],
        lang: value["lang"],
        url: JsonLink.fromJson(value["url"]),
      );
}

extension JsonLink on Link {
  dynamic toJson() => {
        "url": url,
        if (header != null) "header": header,
      };
  static Link fromJson(dynamic value) => Link(
        url: value["url"],
        header:
            (value["header"] as Map<String, dynamic>?)?.cast<String, String>(),
      );
}

extension JsonAction on Action {
  dynamic toJson() => switch (this) {
        Action_OpenBrowser(:final url) => {
            "type": "OpenBrowser",
            "url": url,
          },
        Action_Popup(:final title, :final content, :final actions) => {
            "type": "Popup",
            "title": title,
            "content": content.toJson(),
            "actions": actions.map((e) => e.toJson()).toList(),
          },
        Action_Nav(:final title, :final content) => {
            "type": "Nav",
            "title": title,
            "content": content.toJson(),
          },
        Action_TriggerEvent(:final event, :final data) => {
            "type": "TriggerEvent",
            "event": event,
            "data": data,
          },
        Action_NavEntry(:final entry) => {
            "type": "NavEntry",
            "entry": entry.toJson(),
          },
      };

  static Action fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "OpenBrowser":
        return Action.openBrowser(url: value["url"]);
      case "Popup":
        return Action.popup(
          title: value["title"],
          content: JsonCustomUI.fromJson(value["content"]),
          actions: (value["actions"] as List)
              .map((e) => JsonPopupAction.fromJson(e))
              .toList(),
        );
      case "Nav":
        return Action.nav(
          title: value["title"],
          content: JsonCustomUI.fromJson(value["content"]),
        );
      case "TriggerEvent":
        return Action.triggerEvent(
          event: value["event"],
          data: value["data"],
        );
      case "NavEntry":
        return Action.navEntry(
          entry: JsonEntryDetailed.fromJson(value["entry"]),
        );
      default:
        throw FormatException("Unknown Action type: $type");
    }
  }
}

extension JsonPopupAction on PopupAction {
  dynamic toJson() => {
        "label": label,
        "onclick": onclick.toJson(),
      };

  static PopupAction fromJson(dynamic value) => PopupAction(
        label: value["label"],
        onclick: JsonAction.fromJson(value["onclick"]),
      );
}

extension JsonUIAction on UIAction {
  dynamic toJson() => switch (this) {
        UIAction_Action(:final action) => {
            "type": "Action",
            "action": action.toJson(),
          },
        UIAction_SwapContent(
          :final targetid,
          :final event,
          :final data,
          :final placeholder
        ) =>
          {
            "type": "SwapContent",
            "targetid": targetid,
            "event": event,
            "data": data,
            if (placeholder != null) "placeholder": placeholder.toJson(),
          },
      };

  static UIAction fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Action":
        return UIAction.action(
          action: JsonAction.fromJson(value["action"]),
        );
      case "SwapContent":
        return UIAction.swapContent(
          targetid: value["targetid"],
          event: value["event"],
          data: value["data"],
          placeholder: value["placeholder"] != null
              ? JsonCustomUI.fromJson(value["placeholder"])
              : null,
        );
      default:
        throw FormatException("Unknown UIAction type: $type");
    }
  }
}

extension JsonEventData on EventData {
  dynamic toJson() => switch (this) {
        EventData_SwapContent(:final event, :final targetid, :final data) => {
            "type": "SwapContent",
            "event": event,
            "targetid": targetid,
            "data": data,
          },
        EventData_FeedUpdate(:final event, :final data, :final page) => {
            "type": "FeedUpdate",
            "event": event,
            "data": data,
            "page": page,
          },
        EventData_Action(:final event, :final data) => {
            "type": "Action",
            "event": event,
            "data": data,
          },
      };

  static EventData fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "SwapContent":
        return EventData.swapContent(
          event: value["event"],
          targetid: value["targetid"],
          data: value["data"],
        );
      case "FeedUpdate":
        return EventData.feedUpdate(
          event: value["event"],
          data: value["data"],
          page: value["page"],
        );
      case "Action":
        return EventData.action(
          event: value["event"],
          data: value["data"],
        );
      default:
        throw FormatException("Unknown EventData type: $type");
    }
  }
}

extension JsonEventResult on EventResult {
  dynamic toJson() => switch (this) {
        EventResult_SwapContent(:final customui) => {
            "type": "SwapContent",
            "customui": customui.toJson(),
          },
        EventResult_FeedUpdate(
          :final customui,
          :final hasnext,
          :final length
        ) =>
          {
            "type": "FeedUpdate",
            "customui": customui.map((e) => e.toJson()).toList(),
            if (hasnext != null) "hasnext": hasnext,
            if (length != null) "length": length,
          },
      };

  static EventResult fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "SwapContent":
        return EventResult.swapContent(
          customui: JsonCustomUI.fromJson(value["customui"]),
        );
      case "FeedUpdate":
        return EventResult.feedUpdate(
          customui: (value["customui"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
          hasnext: value["hasnext"],
          length: value["length"],
        );
      default:
        throw FormatException("Unknown EventResult type: $type");
    }
  }
}

extension JsonEntryActivity on EntryActivity {
  dynamic toJson() => switch (this) {
        EntryActivity_EpisodeActivity(:final progress) => {
            "type": "EpisodeActivity",
            "progress": progress,
          },
      };

  static EntryActivity fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "EpisodeActivity":
        return EntryActivity.episodeActivity(
          progress: value["progress"],
        );
      default:
        throw FormatException("Unknown EntryActivity type: $type");
    }
  }
}

extension JsonTimestampType on TimestampType {
  dynamic toJson() => switch (this) {
        TimestampType.relative => "Relative",
        TimestampType.absolute => "Absolute",
      };

  static TimestampType fromJson(dynamic value) => switch (value.toString()) {
        "Relative" => TimestampType.relative,
        "Absolute" => TimestampType.absolute,
        _ => TimestampType.relative,
      };
}

extension JsonCustomUI on CustomUI {
  dynamic toJson() => switch (this) {
        CustomUI_Text(:final text) => {
            "type": "Text",
            "text": text,
          },
        CustomUI_Image(:final image, :final width, :final height) => {
            "type": "Image",
            "image": image.toJson(),
            if (width != null) "width": width,
            if (height != null) "height": height,
          },
        CustomUI_Link(:final link, :final label) => {
            "type": "Link",
            "link": link,
            if (label != null) "label": label,
          },
        CustomUI_TimeStamp(:final timestamp, :final display) => {
            "type": "TimeStamp",
            "timestamp": timestamp,
            "display": display.toJson(),
          },
        CustomUI_EntryCard(:final entry) => {
            "type": "EntryCard",
            "entry": entry.toJson(),
          },
        CustomUI_Card(:final image, :final top, :final bottom) => {
            "type": "Card",
            "image": image.toJson(),
            "top": top.toJson(),
            "bottom": bottom.toJson(),
          },
        CustomUI_Feed(:final event, :final data) => {
            "type": "Feed",
            "event": event,
            "data": data,
          },
        CustomUI_Button(:final label, :final onClick) => {
            "type": "Button",
            "label": label,
            if (onClick != null) "on_click": onClick.toJson(),
          },
        CustomUI_InlineSetting(
          :final settingId,
          :final settingKind,
          :final onCommit
        ) =>
          {
            "type": "InlineSetting",
            "setting_id": settingId,
            "setting_kind": settingKind.toJson(),
            if (onCommit != null) "on_commit": onCommit.toJson(),
          },
        CustomUI_Slot(:final id, :final child) => {
            "type": "Slot",
            "id": id,
            "child": child.toJson(),
          },
        CustomUI_Column(:final children) => {
            "type": "Column",
            "children": children.map((e) => e.toJson()).toList(),
          },
        CustomUI_Row(:final children) => {
            "type": "Row",
            "children": children.map((e) => e.toJson()).toList(),
          },
      };

  static CustomUI fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Text":
        return CustomUI.text(
          text: value["text"],
        );
      case "Image":
        return CustomUI.image(
          image: JsonLink.fromJson(value["image"]),
          width: value["width"],
          height: value["height"],
        );
      case "Link":
        return CustomUI.link(
          link: value["link"],
          label: value["label"],
        );
      case "TimeStamp":
        return CustomUI.timeStamp(
          timestamp: value["timestamp"],
          display: JsonTimestampType.fromJson(value["display"]),
        );
      case "EntryCard":
        return CustomUI.entryCard(
          entry: JsonEntry.fromJson(value["entry"]),
        );
      case "Card":
        return CustomUI.card(
          image: JsonLink.fromJson(value["image"]),
          top: JsonCustomUI.fromJson(value["top"]),
          bottom: JsonCustomUI.fromJson(value["bottom"]),
        );
      case "Feed":
        return CustomUI.feed(
          event: value["event"],
          data: value["data"],
        );
      case "Button":
        return CustomUI.button(
          label: value["label"],
          onClick: value["on_click"] != null
              ? JsonUIAction.fromJson(value["on_click"])
              : null,
        );
      case "InlineSetting":
        return CustomUI.inlineSetting(
          settingId: value["setting_id"],
          settingKind: JsonSettingKind.fromJson(value["setting_kind"]),
          onCommit: value["on_commit"] != null
              ? JsonUIAction.fromJson(value["on_commit"])
              : null,
        );
      case "Slot":
        return CustomUI.slot(
          id: value["id"],
          child: JsonCustomUI.fromJson(value["child"]),
        );
      case "Column":
        return CustomUI.column(
          children: (value["children"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
        );
      case "Row":
        return CustomUI.row(
          children: (value["children"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
        );
      default:
        throw FormatException("Unknown CustomUI type: $type");
    }
  }
}

extension JsonExtensionData on ExtensionData {
  dynamic toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "icon": icon,
        if (desc != null) "desc": desc,
        "author": author,
        "tags": tags,
        "lang": lang,
        "nsfw": nsfw,
        "media_type": mediaType.map((e) => e.toJson()).toList(),
        "extension_type": extensionType.map((e) => e.toJson()).toList(),
        if (repo != null) "repo": repo,
        "version": version,
        "license": license,
        "compatible": compatible,
      };

  static ExtensionData fromJson(dynamic value) => ExtensionData(
        id: value["id"],
        name: value["name"],
        url: value["url"],
        icon: value["icon"],
        desc: value["desc"],
        author: List<String>.from(value["author"]),
        tags: List<String>.from(value["tags"]),
        lang: List<String>.from(value["lang"]),
        nsfw: value["nsfw"],
        mediaType: (value["media_type"] as List)
            .map((e) => JsonMediaType.fromJson(e))
            .toSet(),
        extensionType: (value["extension_type"] as List)
            .map((e) => JsonExtensionType.fromJson(e))
            .toSet(),
        repo: value["repo"],
        version: value["version"],
        license: value["license"],
        compatible: value["compatible"],
      );
}

extension JsonSourceOpenType on SourceOpenType {
  dynamic toJson() => switch (this) {
        SourceOpenType.download => "Download",
        SourceOpenType.stream => "Stream",
      };

  static SourceOpenType fromJson(dynamic value) => switch (value.toString()) {
        "Download" => SourceOpenType.download,
        "Stream" => SourceOpenType.stream,
        _ => SourceOpenType.stream,
      };
}

extension JsonExtensionType on ExtensionType {
  dynamic toJson() => switch (this) {
        ExtensionType_EntryProvider(:final hasSearch) => {
            "type": "EntryProvider",
            "has_search": hasSearch,
          },
        ExtensionType_SourceProcessor(:final sourcetypes, :final opentype) => {
            "type": "SourceProcessor",
            "sourcetypes": sourcetypes.map((e) => e.toJson()).toList(),
            "opentype": opentype.map((e) => e.toJson()).toList(),
          },
        ExtensionType_EntryProcessor(
          :final triggerMapEntry,
          :final triggerOnEntryActivity
        ) =>
          {
            "type": "EntryProcessor",
            "trigger_map_entry": triggerMapEntry,
            "trigger_on_entry_activity": triggerOnEntryActivity,
          },
        ExtensionType_URLHandler(:final urlPatterns) => {
            "type": "URLHandler",
            "url_patterns": urlPatterns,
          },
      };

  static ExtensionType fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "EntryProvider":
        return ExtensionType.entryProvider(
          hasSearch: value["has_search"],
        );
      case "SourceProcessor":
        return ExtensionType.sourceProcessor(
          sourcetypes: (value["sourcetypes"] as List)
              .map((e) => JsonSourceType.fromJson(e))
              .toSet(),
          opentype: (value["opentype"] as List)
              .map((e) => JsonSourceOpenType.fromJson(e))
              .toSet(),
        );
      case "EntryProcessor":
        return ExtensionType.entryProcessor(
          triggerMapEntry: value["trigger_map_entry"],
          triggerOnEntryActivity: value["trigger_on_entry_activity"],
        );
      case "URLHandler":
        return ExtensionType.urlHandler(
          urlPatterns: List<String>.from(value["url_patterns"]),
        );
      default:
        throw FormatException("Unknown ExtensionType type: $type");
    }
  }
}

extension JsonExtensionManagerData on ExtensionManagerData {
  dynamic toJson() => {
        "name": name,
        if (icon != null) "icon": icon,
        if (repo != null) "repo": repo,
        "api_version": apiVersion,
      };

  static ExtensionManagerData fromJson(dynamic value) => ExtensionManagerData(
        name: value["name"],
        icon: value["icon"],
        repo: value["repo"],
        apiVersion: value["api_version"],
      );
}

extension JsonExtensionRepo on ExtensionRepo {
  dynamic toJson() => {
        "name": name,
        "description": description,
        "url": url,
        "remote_id": remoteId,
      };

  static ExtensionRepo fromJson(dynamic value) => ExtensionRepo(
        name: value["name"],
        description: value["description"],
        url: value["url"],
        remoteId: value["remote_id"],
      );
}

extension JsonRemoteExtension on RemoteExtension {
  dynamic toJson() => {
        "id": id,
        "remote_id": remoteId,
        "name": name,
        "url": url,
        if (cover != null) "cover": cover!.toJson(),
        "version": version,
        "compatible": compatible,
      };

  static RemoteExtension fromJson(dynamic value) => RemoteExtension(
        id: value["id"],
        url: value["url"],
        remoteId: value["remote_id"],
        name: value["name"],
        cover:
            value["cover"] != null ? JsonLink.fromJson(value["cover"]) : null,
        version: value["version"],
        compatible: value["compatible"],
      );
}

extension JsonRemoteExtensionResult on RemoteExtensionResult {
  dynamic toJson() => {
        "content": content.map((e) => e.toJson()).toList(),
        if (hasnext != null) "hasnext": hasnext,
        if (length != null) "length": length,
      };

  static RemoteExtensionResult fromJson(dynamic value) => RemoteExtensionResult(
        content: (value["content"] as List)
            .map((e) => JsonRemoteExtension.fromJson(e))
            .toList(),
        hasnext: value["hasnext"],
        length: value["length"],
      );
}

extension JsonPermission on Permission {
  dynamic toJson() => switch (this) {
        Permission_Storage(:final path, :final write) => {
            "type": "Storage",
            "path": path,
            "write": write,
          },
        Permission_Network(:final domains) => {
            "type": "Network",
            "domains": domains,
          },
        Permission_ActionPopup() => {"type": "ActionPopup"},
        Permission_ArbitraryNetwork() => {"type": "ArbitraryNetwork"},
      };

  static Permission fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Storage":
        return Permission.storage(
          path: value["path"],
          write: value["write"] ?? false,
        );
      case "Network":
        return Permission.network(
          domains: value["domains"] != null
              ? List<String>.from(value["domains"])
              : <String>[],
        );
      case "ActionPopup":
        return const Permission.actionPopup();
      case "ArbitraryNetwork":
        return const Permission.arbitraryNetwork();
      default:
        throw FormatException("Unknown Permission type: $type");
    }
  }
}

extension JsonSettingKind on SettingKind {
  dynamic toJson() => switch (this) {
        SettingKind.extension_ => "Extension",
        SettingKind.search => "Search",
      };

  static SettingKind fromJson(dynamic value) => switch (value.toString()) {
        "Extension" => SettingKind.extension_,
        "Search" => SettingKind.search,
        _ => SettingKind.extension_,
      };
}

extension JsonSettingValue on SettingValue {
  dynamic toJson() => switch (this) {
        SettingValue_String(:final data) => {
            "type": "String",
            "data": data,
          },
        SettingValue_Number(:final data) => {
            "type": "Number",
            "data": data,
          },
        SettingValue_Boolean(:final data) => {
            "type": "Boolean",
            "data": data,
          },
        SettingValue_StringList(:final data) => {
            "type": "StringList",
            "data": data,
          },
      };

  static SettingValue fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "String":
        return SettingValue.string(
          data: value["data"],
        );
      case "Number":
        return SettingValue.number(
          data: value["data"],
        );
      case "Boolean":
        return SettingValue.boolean(
          data: value["data"],
        );
      case "StringList":
        return SettingValue.stringList(
          data: List<String>.from(value["data"]),
        );
      default:
        throw FormatException("Unknown SettingValue type: $type");
    }
  }
}

extension JsonDropdownOption on DropdownOption {
  dynamic toJson() => {
        "label": label,
        "value": value,
      };

  static DropdownOption fromJson(dynamic value) => DropdownOption(
        label: value["label"],
        value: value["value"],
      );
}

extension JsonSettingsUI on SettingsUI {
  dynamic toJson() => switch (this) {
        SettingsUI_CheckBox() => {"type": "CheckBox"},
        SettingsUI_MultiDropdown(:final options) => {
            "type": "MultiDropdown",
            "options": options.map((e) => e.toJson()).toList()
          },
        SettingsUI_Slider(:final min, :final max, :final step) => {
            "type": "Slider",
            "min": min,
            "max": max,
            "step": step,
          },
        SettingsUI_Dropdown(:final options) => {
            "type": "Dropdown",
            "options": options.map((e) => e.toJson()).toList(),
          },
      };

  static SettingsUI fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "MultiDropdown":
        return SettingsUI.multiDropdown(
            options: (value["options"] as List)
                .map((e) => JsonDropdownOption.fromJson(e))
                .toList());
      case "CheckBox":
        return const SettingsUI.checkBox();
      case "Slider":
        return SettingsUI.slider(
          min: value["min"],
          max: value["max"],
          step: value["step"],
        );
      case "Dropdown":
        return SettingsUI.dropdown(
          options: (value["options"] as List)
              .map((e) => JsonDropdownOption.fromJson(e))
              .toList(),
        );
      default:
        throw FormatException("Unknown SettingsUI type: $type");
    }
  }
}

extension JsonSetting on Setting {
  dynamic toJson() => {
        "label": label,
        "value": value.toJson(),
        "default": default_.toJson(),
        "visible": visible,
        if (ui != null) "ui": ui!.toJson(),
      };

  static Setting fromJson(dynamic value) => Setting(
        label: value["label"],
        value: JsonSettingValue.fromJson(value["value"]),
        default_: JsonSettingValue.fromJson(value["default"]),
        visible: value["visible"],
        ui: value["ui"] != null ? JsonSettingsUI.fromJson(value["ui"]) : null,
      );
}

extension JsonEntry on Entry {
  dynamic toJson() => {
        "id": id.toJson(),
        "url": url,
        "title": title,
        "media_type": mediaType.toJson(),
        if (cover != null) "cover": cover!.toJson(),
        if (author != null) "author": author,
        if (rating != null) "rating": rating,
        if (views != null) "views": views,
        if (length != null) "length": length,
      };

  static Entry fromJson(dynamic value) => Entry(
        id: JsonEntryId.fromJson(value["id"]),
        url: value["url"],
        title: value["title"],
        mediaType: JsonMediaType.fromJson(value["media_type"]),
        cover:
            value["cover"] != null ? JsonLink.fromJson(value["cover"]) : null,
        author: (value["author"] as List<dynamic>?)?.cast<String>(),
        rating: value["rating"],
        views: value["views"],
        length: value["length"],
      );
}

extension JsonEntryDetailed on EntryDetailed {
  dynamic toJson() => {
        "id": id.toJson(),
        "url": url,
        "titles": titles,
        if (author != null) "author": author,
        if (ui != null) "ui": ui!.toJson(),
        if (meta != null) "meta": meta,
        "media_type": mediaType.toJson(),
        "status": status.toJson(),
        "description": description,
        "language": language,
        if (cover != null) "cover": cover!.toJson(),
        if (poster != null) "poster": poster!.toJson(),
        "episodes": episodes.map((e) => e.toJson()).toList(),
        if (genres != null) "genres": genres,
        if (rating != null) "rating": rating,
        if (views != null) "views": views,
        if (length != null) "length": length,
      };

  static EntryDetailed fromJson(dynamic value) => EntryDetailed(
        id: JsonEntryId.fromJson(value["id"]),
        url: value["url"],
        titles: List<String>.from(value["titles"]),
        author: (value["author"] as List<dynamic>?)?.cast<String>(),
        ui: value["ui"] != null ? JsonCustomUI.fromJson(value["ui"]) : null,
        meta: (value["meta"] as Map<String, dynamic>?)?.cast<String, String>(),
        mediaType: JsonMediaType.fromJson(value["media_type"]),
        status: JsonReleaseStatus.fromJson(value["status"]),
        description: value["description"],
        language: value["language"],
        cover:
            value["cover"] != null ? JsonLink.fromJson(value["cover"]) : null,
        poster:
            value["poster"] != null ? JsonLink.fromJson(value["poster"]) : null,
        episodes: (value["episodes"] as List)
            .map((e) => JsonEpisode.fromJson(e))
            .toList(),
        genres: (value["genres"] as List<dynamic>?)?.cast<String>(),
        rating: value["rating"],
        views: value["views"],
        length: value["length"],
      );
}

extension JsonEntryDetailedResult on EntryDetailedResult {
  dynamic toJson() => {
        "entry": entry.toJson(),
        "settings": settings.map((key, value) => MapEntry(key, value.toJson())),
      };

  static EntryDetailedResult fromJson(dynamic value) => EntryDetailedResult(
        entry: JsonEntryDetailed.fromJson(value["entry"]),
        settings: (value["settings"] as Map)
            .map((key, v) => MapEntry(key, JsonSetting.fromJson(v))),
      );
}

extension JsonEntryId on EntryId {
  dynamic toJson() => {
        "uid": uid,
        if (iddata != null) "iddata": iddata,
      };

  static EntryId fromJson(dynamic value) => EntryId(
        uid: value["uid"],
        iddata: value["iddata"],
      );
}

extension JsonEntryList on EntryList {
  dynamic toJson() => {
        if (hasnext != null) "hasnext": hasnext,
        if (length != null) "length": length,
        "content": content.map((e) => e.toJson()).toList(),
      };

  static EntryList fromJson(dynamic value) => EntryList(
        hasnext: value["hasnext"],
        length: value["length"],
        content: (value["content"] as List)
            .map((e) => JsonEntry.fromJson(e))
            .toList(),
      );
}

extension JsonEpisode on Episode {
  dynamic toJson() => {
        "id": id.toJson(),
        "name": name,
        if (description != null) "description": description,
        "url": url,
        if (cover != null) "cover": cover!.toJson(),
        if (timestamp != null) "timestamp": timestamp,
      };

  static Episode fromJson(dynamic value) => Episode(
        id: JsonEpisodeId.fromJson(value["id"]),
        name: value["name"],
        description: value["description"],
        url: value["url"],
        cover:
            value["cover"] != null ? JsonLink.fromJson(value["cover"]) : null,
        timestamp: value["timestamp"],
      );
}

extension JsonEpisodeId on EpisodeId {
  dynamic toJson() => {
        "uid": uid,
        if (iddata != null) "iddata": iddata,
      };

  static EpisodeId fromJson(dynamic value) => EpisodeId(
        uid: value["uid"],
        iddata: value["iddata"],
      );
}

extension JsonImageListAudio on ImageListAudio {
  dynamic toJson() => {
        "link": link.toJson(),
        "from": from,
        "to": to,
      };

  static ImageListAudio fromJson(dynamic value) => ImageListAudio(
        link: JsonLink.fromJson(value["link"]),
        from: value["from"],
        to: value["to"],
      );
}

extension JsonReleaseStatus on ReleaseStatus {
  dynamic toJson() => switch (this) {
        ReleaseStatus.releasing => "Releasing",
        ReleaseStatus.complete => "Complete",
        ReleaseStatus.unknown => "Unknown",
      };

  static ReleaseStatus fromJson(dynamic value) => switch (value.toString()) {
        "Releasing" => ReleaseStatus.releasing,
        "Complete" => ReleaseStatus.complete,
        "Unknown" => ReleaseStatus.unknown,
        _ => ReleaseStatus.unknown,
      };
}

extension JsonSource on Source {
  dynamic toJson() => switch (this) {
        Source_Epub(:final link) => {
            "type": "Epub",
            "link": link.toJson(),
          },
        Source_Pdf(:final link) => {
            "type": "Pdf",
            "link": link.toJson(),
          },
        Source_Imagelist(:final links, :final audio) => {
            "type": "Imagelist",
            "links": links.map((e) => e.toJson()).toList(),
            if (audio != null) "audio": audio.map((e) => e.toJson()).toList(),
          },
        Source_Video(:final sources, :final sub) => {
            "type": "Video",
            "sources": sources.map((e) => e.toJson()).toList(),
            "sub": sub.map((e) => e.toJson()).toList(),
          },
        Source_Audio(:final sources) => {
            "type": "Audio",
            "sources": sources.map((e) => e.toJson()).toList(),
          },
        Source_Paragraphlist(:final paragraphs) => {
            "type": "Paragraphlist",
            "paragraphs": paragraphs.map((e) => e.toJson()).toList(),
          },
      };

  static Source fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Epub":
        return Source.epub(
          link: JsonLink.fromJson(value["link"]),
        );
      case "Pdf":
        return Source.pdf(
          link: JsonLink.fromJson(value["link"]),
        );
      case "Imagelist":
        return Source.imagelist(
          links: (value["links"] as List)
              .map((e) => JsonLink.fromJson(e))
              .toList(),
          audio: value["audio"] != null
              ? (value["audio"] as List)
                  .map((e) => JsonImageListAudio.fromJson(e))
                  .toList()
              : null,
        );
      case "Video":
        return Source.video(
          sources: (value["sources"] as List)
              .map((e) => JsonStreamSource.fromJson(e))
              .toList(),
          sub: value["sub"] != null
              ? (value["sub"] as List)
                  .map((e) => JsonSubtitles.fromJson(e))
                  .toList()
              : [],
        );
      case "Audio":
        return Source.audio(
          sources: (value["sources"] as List)
              .map((e) => JsonStreamSource.fromJson(e))
              .toList(),
        );
      case "Paragraphlist":
        return Source.paragraphlist(
          paragraphs: (value["paragraphs"] as List)
              .map((e) => JsonParagraph.fromJson(e))
              .toList(),
        );
      default:
        throw FormatException("Unknown Source type: $type");
    }
  }
}

extension JsonSourceResult on SourceResult {
  dynamic toJson() => {
        "source": source.toJson(),
        "settings": settings.map((key, value) => MapEntry(key, value.toJson())),
      };

  static SourceResult fromJson(dynamic value) => SourceResult(
        source: JsonSource.fromJson(value["source"]),
        settings: (value["settings"] as Map)
            .map((key, v) => MapEntry(key, JsonSetting.fromJson(v))),
      );
}

extension JsonSourceType on SourceType {
  dynamic toJson() => switch (this) {
        SourceType.epub => "Epub",
        SourceType.pdf => "Pdf",
        SourceType.imagelist => "Imagelist",
        SourceType.video => "Video",
        SourceType.audio => "Audio",
        SourceType.paragraphlist => "Paragraphlist",
      };

  static SourceType fromJson(dynamic value) => switch (value.toString()) {
        "Epub" => SourceType.epub,
        "Pdf" => SourceType.pdf,
        "Imagelist" => SourceType.imagelist,
        "Video" => SourceType.video,
        "Audio" => SourceType.audio,
        "Paragraphlist" => SourceType.paragraphlist,
        _ => throw FormatException("Unknown SourceType: $value"),
      };
}

extension JsonSubtitles on Subtitles {
  dynamic toJson() => {
        "title": title,
        "lang": lang,
        "url": url.toJson(),
      };

  static Subtitles fromJson(dynamic value) => Subtitles(
        title: value["title"],
        lang: value["lang"],
        url: JsonLink.fromJson(value["url"]),
      );
}

extension JsonRow on Row {
  dynamic toJson() => {
        "cells": cells.map((e) => e.toJson()).toList(),
      };

  static Row fromJson(dynamic value) => Row(
        cells: (value["cells"] as List)
            .map((e) => JsonParagraph.fromJson(e))
            .toList(),
      );
}

extension JsonParagraph on Paragraph {
  dynamic toJson() => switch (this) {
        Paragraph_Text(:final content) => {
            "type": "Text",
            "content": content,
          },
        Paragraph_Mixed(:final content) => {
            "type": "Mixed",
            "content": content.map((e) => e.toJson()).toList(),
          },
        Paragraph_CustomUI(:final ui) => {
            "type": "CustomUI",
            "ui": ui.toJson(),
          },
        Paragraph_Table(:final columns) => {
            "type": "Table",
            "columns": columns.map((row) => row.toJson()).toList(),
          },
      };

  static Paragraph fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Text":
        return Paragraph.text(
          content: value["content"],
        );
      case "CustomUI":
        return Paragraph.customUi(
          ui: JsonCustomUI.fromJson(value["ui"]),
        );
      case "Mixed":
        return Paragraph.mixed(
          content: (value["content"] as List)
              .map((e) => JsonMixedContent.fromJson(e))
              .toList(),
        );
      case "Table":
        return Paragraph.table(
          columns: (value["columns"] as List)
              .map((row) => JsonRow.fromJson(row))
              .toList(),
        );
      default:
        throw FormatException("Unknown Paragraph type: $type");
    }
  }
}

extension JsonMixedContent on MixedContent {
  dynamic toJson() => switch (this) {
        MixedContent_Text(:final content) => {
            "type": "Text",
            "content": content,
          },
        MixedContent_CustomUI(:final ui) => {
            "type": "CustomUI",
            "ui": ui.toJson(),
          },
        MixedContent_Table(:final columns) => {
            "type": "Table",
            "columns": columns.map((row) => row.toJson()).toList(),
          },
      };

  static MixedContent fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Text":
        return MixedContent.text(
          content: value["content"],
        );
      case "CustomUI":
        return MixedContent.customUi(
          ui: JsonCustomUI.fromJson(value["ui"]),
        );
      case "Table":
        return MixedContent.table(
          columns: (value["columns"] as List)
              .map((row) => JsonRow.fromJson(row))
              .toList(),
        );
      default:
        throw FormatException("Unknown MixedContent type: $type");
    }
  }
}

extension JsonAuthData on AuthData {
  dynamic toJson() => switch (this) {
        AuthData_Cookie(:final loginpage, :final logonpage) => {
            "type": "Cookie",
            "loginpage": loginpage,
            "logonpage": logonpage,
          },
        AuthData_ApiKey() => {
            "type": "ApiKey",
          },
        AuthData_UserPass() => {
            "type": "UserPass",
          },
      };

  static AuthData fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Cookie":
        return AuthData.cookie(
          loginpage: value["loginpage"],
          logonpage: value["logonpage"],
        );
      case "ApiKey":
        return const AuthData.apiKey();
      case "UserPass":
        return const AuthData.userPass();
      default:
        throw FormatException("Unknown AuthData type: $type");
    }
  }
}

extension JsonAccount on Account {
  dynamic toJson() => {
        "domain": domain,
        if (userName != null) "user_name": userName,
        if (cover != null) "cover": cover,
        "auth": auth.toJson(),
        if (creds != null) "creds": creds,
      };

  static Account fromJson(dynamic value) => Account(
        domain: value["domain"],
        userName: value["user_name"],
        cover: value["cover"],
        auth: JsonAuthData.fromJson(value["auth"]),
        creds: value["creds"] != null
            ? JsonAuthCreds.fromJson(value["creds"])
            : null,
      );
}

extension JsonAuthCreds on AuthCreds {
  dynamic toJson() => switch (this) {
        AuthCreds_Cookies(:final cookies) => {
            "type": "Cookies",
            "cookies": cookies,
          },
        AuthCreds_ApiKey(:final key) => {
            "type": "ApiKey",
            "key": key,
          },
        AuthCreds_UserPass(:final username, :final password) => {
            "type": "UserPass",
            "username": username,
            "password": password,
          },
      };

  static AuthCreds fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Cookies":
        return AuthCreds.cookies(
          cookies: (value["cookies"] as Map).map(
            (k, v) => MapEntry(
              k as String,
              (v as List).map((e) => e as String).toList(),
            ),
          ),
        );
      case "ApiKey":
        return AuthCreds.apiKey(
          key: value["key"],
        );
      case "UserPass":
        return AuthCreds.userPass(
          username: value["username"],
          password: value["password"],
        );
      default:
        throw FormatException("Unknown AuthCreds type: $type");
    }
  }
}
