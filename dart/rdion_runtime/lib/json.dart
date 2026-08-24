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
  dynamic toJson() => {"name": name, "lang": lang, "url": url.toJson()};
  static StreamSource fromJson(dynamic value) => StreamSource(
        name: value["name"],
        lang: value["lang"],
        url: JsonLink.fromJson(value["url"]),
      );
}

extension JsonLink on Link {
  dynamic toJson() => {"url": url, if (header != null) "header": header};
  static Link fromJson(dynamic value) => Link(
        url: value["url"],
        header:
            (value["header"] as Map<String, dynamic>?)?.cast<String, String>(),
      );
}

extension JsonAction on Action {
  dynamic toJson() => switch (this) {
        Action_OpenBrowser(:final url) => {"type": "OpenBrowser", "url": url},
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
        Action_PopView() => {"type": "PopView"},
        Action_NavEntry(:final entry) => {
            "type": "NavEntry",
            "entry": entry.toJson(),
          },
        Action_ShowToast(:final message, :final kind) => {
            "type": "ShowToast",
            "message": message,
            "kind": kind.toJson(),
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
      case "PopView":
        return const Action.popView();
      case "NavEntry":
        return Action.navEntry(
          entry: JsonEntryDetailed.fromJson(value["entry"]),
        );
      case "ShowToast":
        return Action.showToast(
          message: value["message"],
          kind: JsonToastKind.fromJson(value["kind"]),
        );
      default:
        throw FormatException("Unknown Action type: $type");
    }
  }
}

extension JsonToastKind on ToastKind {
  dynamic toJson() => switch (this) {
        ToastKind.info => "Info",
        ToastKind.success => "Success",
        ToastKind.warning => "Warning",
        ToastKind.error => "Error",
      };

  static ToastKind fromJson(dynamic value) => switch (value.toString()) {
        "Info" => ToastKind.info,
        "Success" => ToastKind.success,
        "Warning" => ToastKind.warning,
        "Error" => ToastKind.error,
        _ => ToastKind.info,
      };
}

extension JsonPopupAction on PopupAction {
  dynamic toJson() => {"label": label, "onclick": onclick.toJson()};

  static PopupAction fromJson(dynamic value) => PopupAction(
        label: value["label"],
        onclick: JsonAction.fromJson(value["onclick"]),
      );
}

extension JsonInteraction on Interaction {
  dynamic toJson() => switch (this) {
        Interaction_Invoke(:final handler, :final payload) => {
            "type": "Invoke",
            "handler": handler,
            "payload": payload,
          },
        Interaction_WriteKey(:final key, :final value) => {
            "type": "WriteKey",
            "key": key,
            "value": value,
          },
      };

  static Interaction fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Invoke":
        return Interaction.invoke(
          handler: value["handler"],
          payload: value["payload"],
        );
      case "WriteKey":
        return Interaction.writeKey(key: value["key"], value: value["value"]);
      default:
        throw FormatException("Unknown Interaction type: $type");
    }
  }
}

extension JsonSlotValue on SlotValue {
  dynamic toJson() => switch (this) {
        SlotValue_Setting(:final value) => {
            "type": "Setting",
            "value": value.toJson(),
          },
        SlotValue_Store(:final key, :final value) => {
            "type": "Store",
            "key": key,
            "value": value,
          },
      };

  static SlotValue fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Setting":
        return SlotValue.setting(
            value: JsonSettingValue.fromJson(value["value"]));
      case "Store":
        return SlotValue.store(key: value["key"], value: value["value"]);
      default:
        throw FormatException("Unknown SlotValue type: $type");
    }
  }
}

extension JsonEventData on EventData {
  dynamic toJson() => switch (this) {
        EventData_LoadSlot(
          :final handler,
          :final staticData,
          :final values,
        ) =>
          {
            "type": "LoadSlot",
            "handler": handler,
            "static_data": staticData,
            "values": values.map((k, v) => MapEntry(k, v.toJson())),
          },
        EventData_LoadPage(:final handler, :final data, :final page) => {
            "type": "LoadPage",
            "handler": handler,
            "data": data,
            "page": page,
          },
        EventData_Invoke(:final handler, :final payload) => {
            "type": "Invoke",
            "handler": handler,
            "payload": payload,
          },
      };

  static EventData fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "LoadSlot":
        return EventData.loadSlot(
          handler: value["handler"],
          staticData: value["static_data"],
          values: (value["values"] as Map<String, dynamic>).map(
            (k, v) => MapEntry(k, JsonSlotValue.fromJson(v)),
          ),
        );
      case "LoadPage":
        return EventData.loadPage(
          handler: value["handler"],
          data: value["data"],
          page: value["page"],
        );
      case "Invoke":
        return EventData.invoke(
          handler: value["handler"],
          payload: value["payload"],
        );
      default:
        throw FormatException("Unknown EventData type: $type");
    }
  }
}

extension JsonEventResult on EventResult {
  dynamic toJson() => switch (this) {
        EventResult_SlotContent(:final customui) => {
            "type": "SlotContent",
            "customui": customui.toJson(),
          },
        EventResult_FeedPage(:final items, :final hasMore) => {
            "type": "FeedPage",
            "items": items.map((e) => e.toJson()).toList(),
            "has_more": hasMore,
          },
      };

  static EventResult fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "SlotContent":
        return EventResult.slotContent(
          customui: JsonCustomUI.fromJson(value["customui"]),
        );
      case "FeedPage":
        return EventResult.feedPage(
          items: (value["items"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
          hasMore: value["has_more"],
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
        return EntryActivity.episodeActivity(progress: value["progress"]);
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

extension JsonSubscriptionSource on SubscriptionSource {
  dynamic toJson() => switch (this) {
        SubscriptionSource_Store() => {"type": "Store"},
        SubscriptionSource_Setting(:final kind) => {
            "type": "Setting",
            "kind": kind.toJson(),
          },
        SubscriptionSource_EntrySetting() => {"type": "EntrySetting"},
      };

  static SubscriptionSource fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Store":
        return const SubscriptionSource.store();
      case "Setting":
        return SubscriptionSource.setting(
          kind: JsonSettingKind.fromJson(value["kind"]),
        );
      case "EntrySetting":
        return const SubscriptionSource.entrySetting();
      default:
        throw FormatException("Unknown SubscriptionSource type: $type");
    }
  }
}

extension JsonSubscription on Subscription {
  dynamic toJson() => {
        "source": source.toJson(),
        "key": key,
        "state_key": stateKey,
      };

  static Subscription fromJson(dynamic value) => Subscription(
        source: JsonSubscriptionSource.fromJson(value["source"]),
        key: value["key"],
        stateKey: value["state_key"],
      );
}

extension JsonTextStyle on TextStyle {
  dynamic toJson() => {
        if (bold != null) "bold": bold,
        if (italic != null) "italic": italic,
        if (underline != null) "underline": underline,
        if (strikethrough != null) "strikethrough": strikethrough,
        if (code != null) "code": code,
        if (link != null) "link": link,
        if (fontSize != null) "font_size": fontSize,
      };

  static TextStyle fromJson(dynamic value) => TextStyle(
        bold: value["bold"],
        italic: value["italic"],
        underline: value["underline"],
        strikethrough: value["strikethrough"],
        code: value["code"],
        link: value["link"],
        fontSize: value["font_size"],
      );
}

extension JsonEdgeInsets on EdgeInsets {
  dynamic toJson() => {
        if (left != null) "left": left,
        if (top != null) "top": top,
        if (right != null) "right": right,
        if (bottom != null) "bottom": bottom,
      };

  static EdgeInsets fromJson(dynamic value) => EdgeInsets(
        left: (value["left"] as num?)?.toDouble(),
        top: (value["top"] as num?)?.toDouble(),
        right: (value["right"] as num?)?.toDouble(),
        bottom: (value["bottom"] as num?)?.toDouble(),
      );
}

extension JsonColorToken on ColorToken {
  dynamic toJson() => switch (this) {
        ColorToken.primary => "Primary",
        ColorToken.onPrimary => "OnPrimary",
        ColorToken.primaryContainer => "PrimaryContainer",
        ColorToken.onPrimaryContainer => "OnPrimaryContainer",
        ColorToken.secondary => "Secondary",
        ColorToken.onSecondary => "OnSecondary",
        ColorToken.surface => "Surface",
        ColorToken.onSurface => "OnSurface",
        ColorToken.surfaceContainer => "SurfaceContainer",
        ColorToken.surfaceContainerHighest => "SurfaceContainerHighest",
        ColorToken.error => "Error",
        ColorToken.onError => "OnError",
        ColorToken.disabled => "Disabled",
        ColorToken.shadow => "Shadow",
      };

  static ColorToken fromJson(dynamic value) => switch (value.toString()) {
        "Primary" => ColorToken.primary,
        "OnPrimary" => ColorToken.onPrimary,
        "PrimaryContainer" => ColorToken.primaryContainer,
        "OnPrimaryContainer" => ColorToken.onPrimaryContainer,
        "Secondary" => ColorToken.secondary,
        "OnSecondary" => ColorToken.onSecondary,
        "Surface" => ColorToken.surface,
        "OnSurface" => ColorToken.onSurface,
        "SurfaceContainer" => ColorToken.surfaceContainer,
        "SurfaceContainerHighest" => ColorToken.surfaceContainerHighest,
        "Error" => ColorToken.error,
        "OnError" => ColorToken.onError,
        "Disabled" => ColorToken.disabled,
        "Shadow" => ColorToken.shadow,
        _ => ColorToken.primary,
      };
}

extension JsonContainerType on ContainerType {
  dynamic toJson() => switch (this) {
        ContainerType.ghost => "Ghost",
        ContainerType.filled => "Filled",
        ContainerType.outlined => "Outlined",
      };

  static ContainerType fromJson(dynamic value) => switch (value.toString()) {
        "Ghost" => ContainerType.ghost,
        "Filled" => ContainerType.filled,
        "Outlined" => ContainerType.outlined,
        _ => ContainerType.ghost,
      };
}

extension JsonButtonType on ButtonType {
  dynamic toJson() => switch (this) {
        ButtonType.filled => "Filled",
        ButtonType.ghost => "Ghost",
        ButtonType.elevated => "Elevated",
      };

  static ButtonType fromJson(dynamic value) => switch (value.toString()) {
        "Filled" => ButtonType.filled,
        "Ghost" => ButtonType.ghost,
        "Elevated" => ButtonType.elevated,
        _ => ButtonType.filled,
      };
}

extension JsonMainAxisAlignment on MainAxisAlignment {
  dynamic toJson() => switch (this) {
        MainAxisAlignment.start => "Start",
        MainAxisAlignment.center => "Center",
        MainAxisAlignment.end => "End",
        MainAxisAlignment.spaceBetween => "SpaceBetween",
        MainAxisAlignment.spaceAround => "SpaceAround",
        MainAxisAlignment.spaceEvenly => "SpaceEvenly",
      };

  static MainAxisAlignment fromJson(dynamic value) =>
      switch (value.toString()) {
        "Start" => MainAxisAlignment.start,
        "Center" => MainAxisAlignment.center,
        "End" => MainAxisAlignment.end,
        "SpaceBetween" => MainAxisAlignment.spaceBetween,
        "SpaceAround" => MainAxisAlignment.spaceAround,
        "SpaceEvenly" => MainAxisAlignment.spaceEvenly,
        _ => MainAxisAlignment.start,
      };
}

extension JsonCrossAxisAlignment on CrossAxisAlignment {
  dynamic toJson() => switch (this) {
        CrossAxisAlignment.start => "Start",
        CrossAxisAlignment.center => "Center",
        CrossAxisAlignment.end => "End",
        CrossAxisAlignment.stretch => "Stretch",
        CrossAxisAlignment.baseline => "Baseline",
      };

  static CrossAxisAlignment fromJson(dynamic value) =>
      switch (value.toString()) {
        "Start" => CrossAxisAlignment.start,
        "Center" => CrossAxisAlignment.center,
        "End" => CrossAxisAlignment.end,
        "Stretch" => CrossAxisAlignment.stretch,
        "Baseline" => CrossAxisAlignment.baseline,
        _ => CrossAxisAlignment.start,
      };
}

extension JsonMainAxisSize on MainAxisSize {
  dynamic toJson() => switch (this) {
        MainAxisSize.min => "Min",
        MainAxisSize.max => "Max",
      };

  static MainAxisSize fromJson(dynamic value) => switch (value.toString()) {
        "Min" => MainAxisSize.min,
        "Max" => MainAxisSize.max,
        _ => MainAxisSize.min,
      };
}

extension JsonWrapAlignment on WrapAlignment {
  dynamic toJson() => switch (this) {
        WrapAlignment.start => "Start",
        WrapAlignment.center => "Center",
        WrapAlignment.end => "End",
        WrapAlignment.spaceBetween => "SpaceBetween",
        WrapAlignment.spaceAround => "SpaceAround",
        WrapAlignment.spaceEvenly => "SpaceEvenly",
      };

  static WrapAlignment fromJson(dynamic value) => switch (value.toString()) {
        "Start" => WrapAlignment.start,
        "Center" => WrapAlignment.center,
        "End" => WrapAlignment.end,
        "SpaceBetween" => WrapAlignment.spaceBetween,
        "SpaceAround" => WrapAlignment.spaceAround,
        "SpaceEvenly" => WrapAlignment.spaceEvenly,
        _ => WrapAlignment.start,
      };
}

extension JsonStackFit on StackFit {
  dynamic toJson() => switch (this) {
        StackFit.loose => "Loose",
        StackFit.expand => "Expand",
        StackFit.passthrough => "Passthrough",
      };

  static StackFit fromJson(dynamic value) => switch (value.toString()) {
        "Loose" => StackFit.loose,
        "Expand" => StackFit.expand,
        "Passthrough" => StackFit.passthrough,
        _ => StackFit.loose,
      };
}

extension JsonAlignment on Alignment {
  dynamic toJson() => switch (this) {
        Alignment.center => "Center",
        Alignment.topLeft => "TopLeft",
        Alignment.topCenter => "TopCenter",
        Alignment.topRight => "TopRight",
        Alignment.centerLeft => "CenterLeft",
        Alignment.centerRight => "CenterRight",
        Alignment.bottomLeft => "BottomLeft",
        Alignment.bottomCenter => "BottomCenter",
        Alignment.bottomRight => "BottomRight",
      };

  static Alignment fromJson(dynamic value) => switch (value.toString()) {
        "Center" => Alignment.center,
        "TopLeft" => Alignment.topLeft,
        "TopCenter" => Alignment.topCenter,
        "TopRight" => Alignment.topRight,
        "CenterLeft" => Alignment.centerLeft,
        "CenterRight" => Alignment.centerRight,
        "BottomLeft" => Alignment.bottomLeft,
        "BottomCenter" => Alignment.bottomCenter,
        "BottomRight" => Alignment.bottomRight,
        _ => Alignment.center,
      };
}

extension JsonDropdownItem on DropdownItem {
  dynamic toJson() => {"value": value, "label": label};

  static DropdownItem fromJson(dynamic value) => DropdownItem(
        value: value["value"],
        label: value["label"],
      );
}

extension JsonCustomUI on CustomUI {
  dynamic toJson() => switch (this) {
        CustomUI_Text(:final text, :final style) => {
            "type": "Text",
            "text": text,
            if (style != null) "style": style.toJson(),
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
        CustomUI_Timestamp(:final timestamp, :final display) => {
            "type": "Timestamp",
            "timestamp": timestamp,
            "display": display.toJson(),
          },
        CustomUI_EntryCard(:final entry) => {
            "type": "EntryCard",
            "entry": entry.toJson(),
          },
        CustomUI_Card(
          :final image,
          :final top,
          :final bottom,
          :final onClick
        ) =>
          {
            "type": "Card",
            "image": image.toJson(),
            "top": top.toJson(),
            "bottom": bottom.toJson(),
            if (onClick != null) "on_click": onClick.toJson(),
          },
        CustomUI_Spinner() => {"type": "Spinner"},
        CustomUI_Feed(:final handler, :final data) => {
            "type": "Feed",
            "handler": handler,
            "data": data,
          },
        CustomUI_Button(
          :final label,
          :final onClick,
          :final buttonType,
          :final color,
        ) =>
          {
            "type": "Button",
            "label": label,
            if (onClick != null) "on_click": onClick.toJson(),
            if (buttonType != null) "button_type": buttonType.toJson(),
            if (color != null) "color": color.toJson(),
          },
        CustomUI_InlineSetting(
          :final settingId,
          :final settingKind,
          :final onCommit,
        ) =>
          {
            "type": "InlineSetting",
            "setting_id": settingId,
            "setting_kind": settingKind.toJson(),
            if (onCommit != null) "on_commit": onCommit.toJson(),
          },
        CustomUI_Slot(
          :final handler,
          :final child,
          :final staticData,
          :final subscriptions,
        ) =>
          {
            "type": "Slot",
            "handler": handler,
            "child": child.toJson(),
            "static_data": staticData,
            "subscriptions": subscriptions.map((e) => e.toJson()).toList(),
          },
        CustomUI_Column(
          :final children,
          :final mainAxisAlignment,
          :final crossAxisAlignment,
          :final mainAxisSize,
          :final scrollable,
        ) =>
          {
            "type": "Column",
            "children": children.map((e) => e.toJson()).toList(),
            if (mainAxisAlignment != null)
              "main_axis_alignment": mainAxisAlignment.toJson(),
            if (crossAxisAlignment != null)
              "cross_axis_alignment": crossAxisAlignment.toJson(),
            if (mainAxisSize != null) "main_axis_size": mainAxisSize.toJson(),
            "scrollable": scrollable,
          },
        CustomUI_Row(
          :final children,
          :final mainAxisAlignment,
          :final crossAxisAlignment,
          :final mainAxisSize,
          :final scrollable,
        ) =>
          {
            "type": "Row",
            "children": children.map((e) => e.toJson()).toList(),
            if (mainAxisAlignment != null)
              "main_axis_alignment": mainAxisAlignment.toJson(),
            if (crossAxisAlignment != null)
              "cross_axis_alignment": crossAxisAlignment.toJson(),
            if (mainAxisSize != null) "main_axis_size": mainAxisSize.toJson(),
            "scrollable": scrollable,
          },
        CustomUI_TextInput(
          :final onChange,
          :final debounceMs,
          :final initial,
          :final onCommit,
        ) =>
          {
            "type": "TextInput",
            if (onChange != null) "on_change": onChange.toJson(),
            if (debounceMs != null) "debounce_ms": debounceMs,
            if (initial != null) "initial": initial,
            if (onCommit != null) "on_commit": onCommit.toJson(),
          },
        // --- Layout primitives ---
        CustomUI_Padding(:final padding, :final child) => {
            "type": "Padding",
            "padding": padding.toJson(),
            "child": child.toJson(),
          },
        CustomUI_Container(
          :final child,
          :final containerType,
          :final color,
          :final borderColor,
          :final padding,
          :final width,
          :final height,
          :final alignment,
          :final emphasized,
        ) =>
          {
            "type": "Container",
            "child": child.toJson(),
            if (containerType != null) "container_type": containerType.toJson(),
            if (color != null) "color": color.toJson(),
            if (borderColor != null) "border_color": borderColor.toJson(),
            if (padding != null) "padding": padding.toJson(),
            if (width != null) "width": width,
            if (height != null) "height": height,
            if (alignment != null) "alignment": alignment.toJson(),
            if (emphasized != null) "emphasized": emphasized,
          },
        CustomUI_Clickable(
          :final child,
          :final onClick,
          :final onLongClick,
        ) =>
          {
            "type": "Clickable",
            "child": child.toJson(),
            if (onClick != null) "on_click": onClick.toJson(),
            if (onLongClick != null) "on_long_click": onLongClick.toJson(),
          },
        CustomUI_Expanded(:final child, :final flex) => {
            "type": "Expanded",
            "child": child.toJson(),
            "flex": flex,
          },
        CustomUI_SizedBox(:final width, :final height, :final child) => {
            "type": "SizedBox",
            if (width != null) "width": width,
            if (height != null) "height": height,
            if (child != null) "child": child.toJson(),
          },
        CustomUI_Spacer(:final flex) => {"type": "Spacer", "flex": flex},
        CustomUI_Wrap(
          :final children,
          :final spacing,
          :final runSpacing,
          :final alignment,
        ) =>
          {
            "type": "Wrap",
            "children": children.map((e) => e.toJson()).toList(),
            if (spacing != null) "spacing": spacing,
            if (runSpacing != null) "run_spacing": runSpacing,
            if (alignment != null) "alignment": alignment.toJson(),
          },
        CustomUI_Center(:final child) => {
            "type": "Center",
            "child": child.toJson(),
          },
        CustomUI_Align(:final alignment, :final child) => {
            "type": "Align",
            "alignment": alignment.toJson(),
            "child": child.toJson(),
          },
        CustomUI_Stack(:final children, :final alignment, :final fit) => {
            "type": "Stack",
            "children": children.map((e) => e.toJson()).toList(),
            if (alignment != null) "alignment": alignment.toJson(),
            if (fit != null) "fit": fit.toJson(),
          },
        CustomUI_Divider() => {"type": "Divider"},
        // --- Dion-themed container widgets ---
        CustomUI_ListTile(
          :final leading,
          :final title,
          :final subtitle,
          :final trailing,
          :final onClick,
          :final onLongClick,
        ) =>
          {
            "type": "ListTile",
            if (leading != null) "leading": leading.toJson(),
            if (title != null) "title": title.toJson(),
            if (subtitle != null) "subtitle": subtitle.toJson(),
            if (trailing != null) "trailing": trailing.toJson(),
            if (onClick != null) "on_click": onClick.toJson(),
            if (onLongClick != null) "on_long_click": onLongClick.toJson(),
          },
        CustomUI_Badge(:final child, :final color) => {
            "type": "Badge",
            "child": child.toJson(),
            if (color != null) "color": color.toJson(),
          },
        // --- Display primitives ---
        CustomUI_FoldableText(
          :final text,
          :final maxLines,
          :final style,
          :final animate,
        ) =>
          {
            "type": "FoldableText",
            "text": text,
            "max_lines": maxLines,
            if (style != null) "style": style.toJson(),
            "animate": animate,
          },
        CustomUI_StarDisplay(:final fill, :final maxStars) => {
            "type": "StarDisplay",
            "fill": fill,
            "max_stars": maxStars,
          },
        CustomUI_Dropdown(
          :final items,
          :final initialValue,
          :final onChange,
        ) =>
          {
            "type": "Dropdown",
            "items": items.map((e) => e.toJson()).toList(),
            if (initialValue != null) "initial_value": initialValue,
            if (onChange != null) "on_change": onChange.toJson(),
          },
      };

  static CustomUI fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "Text":
        return CustomUI.text(
          text: value["text"],
          style: value["style"] != null
              ? JsonTextStyle.fromJson(value["style"])
              : null,
        );
      case "Image":
        return CustomUI.image(
          image: JsonLink.fromJson(value["image"]),
          width: value["width"],
          height: value["height"],
        );
      case "Link":
        return CustomUI.link(link: value["link"], label: value["label"]);
      case "Timestamp":
        return CustomUI.timestamp(
          timestamp: value["timestamp"],
          display: JsonTimestampType.fromJson(value["display"]),
        );
      case "EntryCard":
        return CustomUI.entryCard(entry: JsonEntry.fromJson(value["entry"]));
      case "Card":
        return CustomUI.card(
          image: JsonLink.fromJson(value["image"]),
          top: JsonCustomUI.fromJson(value["top"]),
          bottom: JsonCustomUI.fromJson(value["bottom"]),
          onClick: value["on_click"] != null
              ? JsonInteraction.fromJson(value["on_click"])
              : null,
        );
      case "Spinner":
        return const CustomUI.spinner();
      case "Feed":
        return CustomUI.feed(handler: value["handler"], data: value["data"]);
      case "Button":
        return CustomUI.button(
          label: value["label"],
          onClick: value["on_click"] != null
              ? JsonInteraction.fromJson(value["on_click"])
              : null,
          buttonType: value["button_type"] != null
              ? JsonButtonType.fromJson(value["button_type"])
              : null,
          color: value["color"] != null
              ? JsonColorToken.fromJson(value["color"])
              : null,
        );
      case "InlineSetting":
        return CustomUI.inlineSetting(
          settingId: value["setting_id"],
          settingKind: JsonSettingKind.fromJson(value["setting_kind"]),
          onCommit: value["on_commit"] != null
              ? JsonInteraction.fromJson(value["on_commit"])
              : null,
        );
      case "Slot":
        return CustomUI.slot(
          handler: value["handler"],
          child: JsonCustomUI.fromJson(value["child"]),
          staticData: value["static_data"],
          subscriptions: (value["subscriptions"] as List)
              .map((e) => JsonSubscription.fromJson(e))
              .toList(),
        );
      case "Column":
        return CustomUI.column(
          children: (value["children"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
          mainAxisAlignment: value["main_axis_alignment"] != null
              ? JsonMainAxisAlignment.fromJson(value["main_axis_alignment"])
              : null,
          crossAxisAlignment: value["cross_axis_alignment"] != null
              ? JsonCrossAxisAlignment.fromJson(value["cross_axis_alignment"])
              : null,
          mainAxisSize: value["main_axis_size"] != null
              ? JsonMainAxisSize.fromJson(value["main_axis_size"])
              : null,
          scrollable: value["scrollable"] ?? true,
        );
      case "Row":
        return CustomUI.row(
          children: (value["children"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
          mainAxisAlignment: value["main_axis_alignment"] != null
              ? JsonMainAxisAlignment.fromJson(value["main_axis_alignment"])
              : null,
          crossAxisAlignment: value["cross_axis_alignment"] != null
              ? JsonCrossAxisAlignment.fromJson(value["cross_axis_alignment"])
              : null,
          mainAxisSize: value["main_axis_size"] != null
              ? JsonMainAxisSize.fromJson(value["main_axis_size"])
              : null,
          scrollable: value["scrollable"] ?? true,
        );
      case "TextInput":
        return CustomUI.textInput(
          onChange: value["on_change"] != null
              ? JsonInteraction.fromJson(value["on_change"])
              : null,
          debounceMs: value["debounce_ms"],
          initial: value["initial"],
          onCommit: value["on_commit"] != null
              ? JsonInteraction.fromJson(value["on_commit"])
              : null,
        );
      // --- Layout primitives ---
      case "Padding":
        return CustomUI.padding(
          padding: JsonEdgeInsets.fromJson(value["padding"]),
          child: JsonCustomUI.fromJson(value["child"]),
        );
      case "Container":
        return CustomUI.container(
          child: JsonCustomUI.fromJson(value["child"]),
          containerType: value["container_type"] != null
              ? JsonContainerType.fromJson(value["container_type"])
              : null,
          color: value["color"] != null
              ? JsonColorToken.fromJson(value["color"])
              : null,
          borderColor: value["border_color"] != null
              ? JsonColorToken.fromJson(value["border_color"])
              : null,
          padding: value["padding"] != null
              ? JsonEdgeInsets.fromJson(value["padding"])
              : null,
          width: (value["width"] as num?)?.toDouble(),
          height: (value["height"] as num?)?.toDouble(),
          alignment: value["alignment"] != null
              ? JsonAlignment.fromJson(value["alignment"])
              : null,
          emphasized: value["emphasized"],
        );
      case "Clickable":
        return CustomUI.clickable(
          child: JsonCustomUI.fromJson(value["child"]),
          onClick: value["on_click"] != null
              ? JsonInteraction.fromJson(value["on_click"])
              : null,
          onLongClick: value["on_long_click"] != null
              ? JsonInteraction.fromJson(value["on_long_click"])
              : null,
        );
      case "Expanded":
        return CustomUI.expanded(
          child: JsonCustomUI.fromJson(value["child"]),
          flex: value["flex"] ?? 1,
        );
      case "SizedBox":
        return CustomUI.sizedBox(
          width: (value["width"] as num?)?.toDouble(),
          height: (value["height"] as num?)?.toDouble(),
          child: value["child"] != null
              ? JsonCustomUI.fromJson(value["child"])
              : null,
        );
      case "Spacer":
        return CustomUI.spacer(flex: value["flex"] ?? 1);
      case "Wrap":
        return CustomUI.wrap(
          children: (value["children"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
          spacing: (value["spacing"] as num?)?.toDouble(),
          runSpacing: (value["run_spacing"] as num?)?.toDouble(),
          alignment: value["alignment"] != null
              ? JsonWrapAlignment.fromJson(value["alignment"])
              : null,
        );
      case "Center":
        return CustomUI.center(child: JsonCustomUI.fromJson(value["child"]));
      case "Align":
        return CustomUI.align(
          alignment: JsonAlignment.fromJson(value["alignment"]),
          child: JsonCustomUI.fromJson(value["child"]),
        );
      case "Stack":
        return CustomUI.stack(
          children: (value["children"] as List)
              .map((e) => JsonCustomUI.fromJson(e))
              .toList(),
          alignment: value["alignment"] != null
              ? JsonAlignment.fromJson(value["alignment"])
              : null,
          fit:
              value["fit"] != null ? JsonStackFit.fromJson(value["fit"]) : null,
        );
      case "Divider":
        return const CustomUI.divider();
      // --- Dion-themed container widgets ---
      case "ListTile":
        return CustomUI.listTile(
          leading: value["leading"] != null
              ? JsonCustomUI.fromJson(value["leading"])
              : null,
          title: value["title"] != null
              ? JsonCustomUI.fromJson(value["title"])
              : null,
          subtitle: value["subtitle"] != null
              ? JsonCustomUI.fromJson(value["subtitle"])
              : null,
          trailing: value["trailing"] != null
              ? JsonCustomUI.fromJson(value["trailing"])
              : null,
          onClick: value["on_click"] != null
              ? JsonInteraction.fromJson(value["on_click"])
              : null,
          onLongClick: value["on_long_click"] != null
              ? JsonInteraction.fromJson(value["on_long_click"])
              : null,
        );
      case "Badge":
        return CustomUI.badge(
          child: JsonCustomUI.fromJson(value["child"]),
          color: value["color"] != null
              ? JsonColorToken.fromJson(value["color"])
              : null,
        );
      // --- Display primitives ---
      case "FoldableText":
        return CustomUI.foldableText(
          text: value["text"],
          maxLines: value["max_lines"] ?? 3,
          style: value["style"] != null
              ? JsonTextStyle.fromJson(value["style"])
              : null,
          animate: value["animate"] ?? true,
        );
      case "StarDisplay":
        return CustomUI.starDisplay(
          fill: (value["fill"] as num).toDouble(),
          maxStars: value["max_stars"] ?? 5,
        );
      case "Dropdown":
        return CustomUI.dropdown(
          items: (value["items"] as List)
              .map((e) => JsonDropdownItem.fromJson(e))
              .toList(),
          initialValue: value["initial_value"],
          onChange: value["on_change"] != null
              ? JsonInteraction.fromJson(value["on_change"])
              : null,
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
          :final triggerOnEntryActivity,
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
        return ExtensionType.entryProvider(hasSearch: value["has_search"]);
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
        SettingValue_String(:final data) => {"type": "String", "data": data},
        SettingValue_Number(:final data) => {"type": "Number", "data": data},
        SettingValue_Boolean(:final data) => {"type": "Boolean", "data": data},
        SettingValue_StringList(:final data) => {
            "type": "StringList",
            "data": data,
          },
      };

  static SettingValue fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "String":
        return SettingValue.string(data: value["data"]);
      case "Number":
        return SettingValue.number(data: value["data"]);
      case "Boolean":
        return SettingValue.boolean(data: value["data"]);
      case "StringList":
        return SettingValue.stringList(data: List<String>.from(value["data"]));
      default:
        throw FormatException("Unknown SettingValue type: $type");
    }
  }
}

extension JsonDropdownOption on DropdownOption {
  dynamic toJson() => {"label": label, "value": value};

  static DropdownOption fromJson(dynamic value) =>
      DropdownOption(label: value["label"], value: value["value"]);
}

extension JsonSettingsUI on SettingsUI {
  dynamic toJson() => switch (this) {
        SettingsUI_CheckBox() => {"type": "CheckBox"},
        SettingsUI_CustomUI(:final ui) => {
            "type": "CustomUI",
            "ui": ui.toJson()
          },
        SettingsUI_MultiDropdown(:final options) => {
            "type": "MultiDropdown",
            "options": options.map((e) => e.toJson()).toList(),
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
      case "CustomUI":
        return SettingsUI.customUi(ui: JsonCustomUI.fromJson(value["ui"]));
      case "MultiDropdown":
        return SettingsUI.multiDropdown(
          options: (value["options"] as List)
              .map((e) => JsonDropdownOption.fromJson(e))
              .toList(),
        );
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
        settings: (value["settings"] as Map).map(
          (key, v) => MapEntry(key, JsonSetting.fromJson(v)),
        ),
      );
}

extension JsonEntryId on EntryId {
  dynamic toJson() => {"uid": uid, if (iddata != null) "iddata": iddata};

  static EntryId fromJson(dynamic value) =>
      EntryId(uid: value["uid"], iddata: value["iddata"]);
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
  dynamic toJson() => {"uid": uid, if (iddata != null) "iddata": iddata};

  static EpisodeId fromJson(dynamic value) =>
      EpisodeId(uid: value["uid"], iddata: value["iddata"]);
}

extension JsonImageListAudio on ImageListAudio {
  dynamic toJson() => {"link": link.toJson(), "from": from, "to": to};

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
        Source_Epub(:final link) => {"type": "Epub", "link": link.toJson()},
        Source_Pdf(:final link) => {"type": "Pdf", "link": link.toJson()},
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
        return Source.epub(link: JsonLink.fromJson(value["link"]));
      case "Pdf":
        return Source.pdf(link: JsonLink.fromJson(value["link"]));
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
        settings: (value["settings"] as Map).map(
          (key, v) => MapEntry(key, JsonSetting.fromJson(v)),
        ),
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
  dynamic toJson() => {"title": title, "lang": lang, "url": url.toJson()};

  static Subtitles fromJson(dynamic value) => Subtitles(
        title: value["title"],
        lang: value["lang"],
        url: JsonLink.fromJson(value["url"]),
      );
}

extension JsonRow on Row {
  dynamic toJson() => {"cells": cells.map((e) => e.toJson()).toList()};

  static Row fromJson(dynamic value) => Row(
        cells: (value["cells"] as List)
            .map((e) => JsonParagraph.fromJson(e))
            .toList(),
      );
}

extension JsonParagraph on Paragraph {
  dynamic toJson() => switch (this) {
        Paragraph_Text(:final content) => {"type": "Text", "content": content},
        Paragraph_Mixed(:final content) => {
            "type": "Mixed",
            "content": content.map((e) => e.toJson()).toList(),
          },
        Paragraph_CustomUI(:final ui) => {
            "type": "CustomUI",
            "ui": ui.toJson()
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
        return Paragraph.text(content: value["content"]);
      case "CustomUI":
        return Paragraph.customUi(ui: JsonCustomUI.fromJson(value["ui"]));
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
            "content": content
          },
        MixedContent_CustomUI(:final ui) => {
            "type": "CustomUI",
            "ui": ui.toJson()
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
        return MixedContent.text(content: value["content"]);
      case "CustomUI":
        return MixedContent.customUi(ui: JsonCustomUI.fromJson(value["ui"]));
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
        AuthData_OAuth(
          :final authorizationUrl,
          :final tokenUrl,
          :final clientId,
          :final clientSecret,
          :final scope,
        ) =>
          {
            "type": "OAuth",
            "authorization_url": authorizationUrl,
            "token_url": tokenUrl,
            "client_id": clientId,
            "client_secret": clientSecret,
            "scope": scope,
          },
        AuthData_Cookie(:final loginpage, :final logonpage) => {
            "type": "Cookie",
            "loginpage": loginpage,
            "logonpage": logonpage,
          },
        AuthData_ApiKey() => {"type": "ApiKey"},
        AuthData_UserPass() => {"type": "UserPass"},
      };

  static AuthData fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "OAuth":
        return AuthData.oAuth(
          authorizationUrl: value["authorization_url"],
          tokenUrl: value["token_url"],
          clientId: value["client_id"],
          clientSecret: value["client_secret"],
          scope: value["scope"],
        );
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
        AuthCreds_OAuth(
          :final accessToken,
          :final refreshToken,
          :final expiresAt,
        ) =>
          {
            "type": "OAuth",
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "expires_at": expiresAt,
          },
        AuthCreds_Cookies(:final cookies) => {
            "type": "Cookies",
            "cookies": cookies,
          },
        AuthCreds_ApiKey(:final key) => {"type": "ApiKey", "key": key},
        AuthCreds_UserPass(:final username, :final password) => {
            "type": "UserPass",
            "username": username,
            "password": password,
          },
      };

  static AuthCreds fromJson(dynamic value) {
    final type = value["type"] as String;
    switch (type) {
      case "OAuth":
        return AuthCreds.oAuth(
          accessToken: value["access_token"],
          refreshToken: value["refresh_token"],
          expiresAt: value["expires_at"],
        );
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
        return AuthCreds.apiKey(key: value["key"]);
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
