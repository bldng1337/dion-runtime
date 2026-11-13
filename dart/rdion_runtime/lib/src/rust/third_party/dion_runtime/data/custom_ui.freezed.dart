// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomUI {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CustomUI);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CustomUI()';
  }
}

/// @nodoc
class $CustomUICopyWith<$Res> {
  $CustomUICopyWith(CustomUI _, $Res Function(CustomUI) __);
}

/// Adds pattern-matching-related methods to [CustomUI].
extension CustomUIPatterns on CustomUI {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_Timestamp value)? timestamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Spinner value)? spinner,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    TResult Function(CustomUI_TextInput value)? textInput,
    TResult Function(CustomUI_Padding value)? padding,
    TResult Function(CustomUI_Container value)? container,
    TResult Function(CustomUI_Clickable value)? clickable,
    TResult Function(CustomUI_Expanded value)? expanded,
    TResult Function(CustomUI_SizedBox value)? sizedBox,
    TResult Function(CustomUI_Spacer value)? spacer,
    TResult Function(CustomUI_Wrap value)? wrap,
    TResult Function(CustomUI_Center value)? center,
    TResult Function(CustomUI_Align value)? align,
    TResult Function(CustomUI_Stack value)? stack,
    TResult Function(CustomUI_Divider value)? divider,
    TResult Function(CustomUI_ListTile value)? listTile,
    TResult Function(CustomUI_Badge value)? badge,
    TResult Function(CustomUI_FoldableText value)? foldableText,
    TResult Function(CustomUI_StarDisplay value)? starDisplay,
    TResult Function(CustomUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomUI_Text() when text != null:
        return text(_that);
      case CustomUI_Image() when image != null:
        return image(_that);
      case CustomUI_Link() when link != null:
        return link(_that);
      case CustomUI_Timestamp() when timestamp != null:
        return timestamp(_that);
      case CustomUI_EntryCard() when entryCard != null:
        return entryCard(_that);
      case CustomUI_Card() when card != null:
        return card(_that);
      case CustomUI_Spinner() when spinner != null:
        return spinner(_that);
      case CustomUI_Feed() when feed != null:
        return feed(_that);
      case CustomUI_Button() when button != null:
        return button(_that);
      case CustomUI_InlineSetting() when inlineSetting != null:
        return inlineSetting(_that);
      case CustomUI_Slot() when slot != null:
        return slot(_that);
      case CustomUI_Column() when column != null:
        return column(_that);
      case CustomUI_Row() when row != null:
        return row(_that);
      case CustomUI_TextInput() when textInput != null:
        return textInput(_that);
      case CustomUI_Padding() when padding != null:
        return padding(_that);
      case CustomUI_Container() when container != null:
        return container(_that);
      case CustomUI_Clickable() when clickable != null:
        return clickable(_that);
      case CustomUI_Expanded() when expanded != null:
        return expanded(_that);
      case CustomUI_SizedBox() when sizedBox != null:
        return sizedBox(_that);
      case CustomUI_Spacer() when spacer != null:
        return spacer(_that);
      case CustomUI_Wrap() when wrap != null:
        return wrap(_that);
      case CustomUI_Center() when center != null:
        return center(_that);
      case CustomUI_Align() when align != null:
        return align(_that);
      case CustomUI_Stack() when stack != null:
        return stack(_that);
      case CustomUI_Divider() when divider != null:
        return divider(_that);
      case CustomUI_ListTile() when listTile != null:
        return listTile(_that);
      case CustomUI_Badge() when badge != null:
        return badge(_that);
      case CustomUI_FoldableText() when foldableText != null:
        return foldableText(_that);
      case CustomUI_StarDisplay() when starDisplay != null:
        return starDisplay(_that);
      case CustomUI_Dropdown() when dropdown != null:
        return dropdown(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_Timestamp value) timestamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Spinner value) spinner,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
    required TResult Function(CustomUI_TextInput value) textInput,
    required TResult Function(CustomUI_Padding value) padding,
    required TResult Function(CustomUI_Container value) container,
    required TResult Function(CustomUI_Clickable value) clickable,
    required TResult Function(CustomUI_Expanded value) expanded,
    required TResult Function(CustomUI_SizedBox value) sizedBox,
    required TResult Function(CustomUI_Spacer value) spacer,
    required TResult Function(CustomUI_Wrap value) wrap,
    required TResult Function(CustomUI_Center value) center,
    required TResult Function(CustomUI_Align value) align,
    required TResult Function(CustomUI_Stack value) stack,
    required TResult Function(CustomUI_Divider value) divider,
    required TResult Function(CustomUI_ListTile value) listTile,
    required TResult Function(CustomUI_Badge value) badge,
    required TResult Function(CustomUI_FoldableText value) foldableText,
    required TResult Function(CustomUI_StarDisplay value) starDisplay,
    required TResult Function(CustomUI_Dropdown value) dropdown,
  }) {
    final _that = this;
    switch (_that) {
      case CustomUI_Text():
        return text(_that);
      case CustomUI_Image():
        return image(_that);
      case CustomUI_Link():
        return link(_that);
      case CustomUI_Timestamp():
        return timestamp(_that);
      case CustomUI_EntryCard():
        return entryCard(_that);
      case CustomUI_Card():
        return card(_that);
      case CustomUI_Spinner():
        return spinner(_that);
      case CustomUI_Feed():
        return feed(_that);
      case CustomUI_Button():
        return button(_that);
      case CustomUI_InlineSetting():
        return inlineSetting(_that);
      case CustomUI_Slot():
        return slot(_that);
      case CustomUI_Column():
        return column(_that);
      case CustomUI_Row():
        return row(_that);
      case CustomUI_TextInput():
        return textInput(_that);
      case CustomUI_Padding():
        return padding(_that);
      case CustomUI_Container():
        return container(_that);
      case CustomUI_Clickable():
        return clickable(_that);
      case CustomUI_Expanded():
        return expanded(_that);
      case CustomUI_SizedBox():
        return sizedBox(_that);
      case CustomUI_Spacer():
        return spacer(_that);
      case CustomUI_Wrap():
        return wrap(_that);
      case CustomUI_Center():
        return center(_that);
      case CustomUI_Align():
        return align(_that);
      case CustomUI_Stack():
        return stack(_that);
      case CustomUI_Divider():
        return divider(_that);
      case CustomUI_ListTile():
        return listTile(_that);
      case CustomUI_Badge():
        return badge(_that);
      case CustomUI_FoldableText():
        return foldableText(_that);
      case CustomUI_StarDisplay():
        return starDisplay(_that);
      case CustomUI_Dropdown():
        return dropdown(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_Timestamp value)? timestamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Spinner value)? spinner,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
    TResult? Function(CustomUI_TextInput value)? textInput,
    TResult? Function(CustomUI_Padding value)? padding,
    TResult? Function(CustomUI_Container value)? container,
    TResult? Function(CustomUI_Clickable value)? clickable,
    TResult? Function(CustomUI_Expanded value)? expanded,
    TResult? Function(CustomUI_SizedBox value)? sizedBox,
    TResult? Function(CustomUI_Spacer value)? spacer,
    TResult? Function(CustomUI_Wrap value)? wrap,
    TResult? Function(CustomUI_Center value)? center,
    TResult? Function(CustomUI_Align value)? align,
    TResult? Function(CustomUI_Stack value)? stack,
    TResult? Function(CustomUI_Divider value)? divider,
    TResult? Function(CustomUI_ListTile value)? listTile,
    TResult? Function(CustomUI_Badge value)? badge,
    TResult? Function(CustomUI_FoldableText value)? foldableText,
    TResult? Function(CustomUI_StarDisplay value)? starDisplay,
    TResult? Function(CustomUI_Dropdown value)? dropdown,
  }) {
    final _that = this;
    switch (_that) {
      case CustomUI_Text() when text != null:
        return text(_that);
      case CustomUI_Image() when image != null:
        return image(_that);
      case CustomUI_Link() when link != null:
        return link(_that);
      case CustomUI_Timestamp() when timestamp != null:
        return timestamp(_that);
      case CustomUI_EntryCard() when entryCard != null:
        return entryCard(_that);
      case CustomUI_Card() when card != null:
        return card(_that);
      case CustomUI_Spinner() when spinner != null:
        return spinner(_that);
      case CustomUI_Feed() when feed != null:
        return feed(_that);
      case CustomUI_Button() when button != null:
        return button(_that);
      case CustomUI_InlineSetting() when inlineSetting != null:
        return inlineSetting(_that);
      case CustomUI_Slot() when slot != null:
        return slot(_that);
      case CustomUI_Column() when column != null:
        return column(_that);
      case CustomUI_Row() when row != null:
        return row(_that);
      case CustomUI_TextInput() when textInput != null:
        return textInput(_that);
      case CustomUI_Padding() when padding != null:
        return padding(_that);
      case CustomUI_Container() when container != null:
        return container(_that);
      case CustomUI_Clickable() when clickable != null:
        return clickable(_that);
      case CustomUI_Expanded() when expanded != null:
        return expanded(_that);
      case CustomUI_SizedBox() when sizedBox != null:
        return sizedBox(_that);
      case CustomUI_Spacer() when spacer != null:
        return spacer(_that);
      case CustomUI_Wrap() when wrap != null:
        return wrap(_that);
      case CustomUI_Center() when center != null:
        return center(_that);
      case CustomUI_Align() when align != null:
        return align(_that);
      case CustomUI_Stack() when stack != null:
        return stack(_that);
      case CustomUI_Divider() when divider != null:
        return divider(_that);
      case CustomUI_ListTile() when listTile != null:
        return listTile(_that);
      case CustomUI_Badge() when badge != null:
        return badge(_that);
      case CustomUI_FoldableText() when foldableText != null:
        return foldableText(_that);
      case CustomUI_StarDisplay() when starDisplay != null:
        return starDisplay(_that);
      case CustomUI_Dropdown() when dropdown != null:
        return dropdown(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, TextStyle? style)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(DateTime timestamp, TimestampType display)? timestamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(
            Link image, CustomUI top, CustomUI bottom, Interaction? onClick)?
        card,
    TResult Function()? spinner,
    TResult Function(String handler, String data)? feed,
    TResult Function(String label, Interaction? onClick, ButtonType? buttonType,
            ColorToken? color)?
        button,
    TResult Function(
            String settingId, SettingKind settingKind, Interaction? onCommit)?
        inlineSetting,
    TResult Function(String handler, CustomUI child, String staticData,
            List<Subscription> subscriptions)?
        slot,
    TResult Function(
            List<CustomUI> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            MainAxisSize? mainAxisSize,
            bool scrollable)?
        column,
    TResult Function(
            List<CustomUI> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            MainAxisSize? mainAxisSize,
            bool scrollable)?
        row,
    TResult Function(Interaction? onChange, int? debounceMs, String? initial,
            Interaction? onCommit)?
        textInput,
    TResult Function(EdgeInsets padding, CustomUI child)? padding,
    TResult Function(
            CustomUI child,
            ContainerType? containerType,
            ColorToken? color,
            ColorToken? borderColor,
            EdgeInsets? padding,
            double? width,
            double? height,
            Alignment? alignment,
            bool? emphasized)?
        container,
    TResult Function(
            CustomUI child, Interaction? onClick, Interaction? onLongClick)?
        clickable,
    TResult Function(CustomUI child, int flex)? expanded,
    TResult Function(double? width, double? height, CustomUI? child)? sizedBox,
    TResult Function(int flex)? spacer,
    TResult Function(List<CustomUI> children, double? spacing,
            double? runSpacing, WrapAlignment? alignment)?
        wrap,
    TResult Function(CustomUI child)? center,
    TResult Function(Alignment alignment, CustomUI child)? align,
    TResult Function(
            List<CustomUI> children, Alignment? alignment, StackFit? fit)?
        stack,
    TResult Function()? divider,
    TResult Function(CustomUI? leading, CustomUI? title, CustomUI? subtitle,
            CustomUI? trailing, Interaction? onClick, Interaction? onLongClick)?
        listTile,
    TResult Function(CustomUI child, ColorToken? color)? badge,
    TResult Function(String text, int maxLines, TextStyle? style, bool animate)?
        foldableText,
    TResult Function(double fill, int maxStars)? starDisplay,
    TResult Function(List<DropdownItem> items, String? initialValue,
            Interaction? onChange)?
        dropdown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CustomUI_Text() when text != null:
        return text(_that.text, _that.style);
      case CustomUI_Image() when image != null:
        return image(_that.image, _that.width, _that.height);
      case CustomUI_Link() when link != null:
        return link(_that.link, _that.label);
      case CustomUI_Timestamp() when timestamp != null:
        return timestamp(_that.timestamp, _that.display);
      case CustomUI_EntryCard() when entryCard != null:
        return entryCard(_that.entry);
      case CustomUI_Card() when card != null:
        return card(_that.image, _that.top, _that.bottom, _that.onClick);
      case CustomUI_Spinner() when spinner != null:
        return spinner();
      case CustomUI_Feed() when feed != null:
        return feed(_that.handler, _that.data);
      case CustomUI_Button() when button != null:
        return button(
            _that.label, _that.onClick, _that.buttonType, _that.color);
      case CustomUI_InlineSetting() when inlineSetting != null:
        return inlineSetting(
            _that.settingId, _that.settingKind, _that.onCommit);
      case CustomUI_Slot() when slot != null:
        return slot(
            _that.handler, _that.child, _that.staticData, _that.subscriptions);
      case CustomUI_Column() when column != null:
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.mainAxisSize, _that.scrollable);
      case CustomUI_Row() when row != null:
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.mainAxisSize, _that.scrollable);
      case CustomUI_TextInput() when textInput != null:
        return textInput(
            _that.onChange, _that.debounceMs, _that.initial, _that.onCommit);
      case CustomUI_Padding() when padding != null:
        return padding(_that.padding, _that.child);
      case CustomUI_Container() when container != null:
        return container(
            _that.child,
            _that.containerType,
            _that.color,
            _that.borderColor,
            _that.padding,
            _that.width,
            _that.height,
            _that.alignment,
            _that.emphasized);
      case CustomUI_Clickable() when clickable != null:
        return clickable(_that.child, _that.onClick, _that.onLongClick);
      case CustomUI_Expanded() when expanded != null:
        return expanded(_that.child, _that.flex);
      case CustomUI_SizedBox() when sizedBox != null:
        return sizedBox(_that.width, _that.height, _that.child);
      case CustomUI_Spacer() when spacer != null:
        return spacer(_that.flex);
      case CustomUI_Wrap() when wrap != null:
        return wrap(
            _that.children, _that.spacing, _that.runSpacing, _that.alignment);
      case CustomUI_Center() when center != null:
        return center(_that.child);
      case CustomUI_Align() when align != null:
        return align(_that.alignment, _that.child);
      case CustomUI_Stack() when stack != null:
        return stack(_that.children, _that.alignment, _that.fit);
      case CustomUI_Divider() when divider != null:
        return divider();
      case CustomUI_ListTile() when listTile != null:
        return listTile(_that.leading, _that.title, _that.subtitle,
            _that.trailing, _that.onClick, _that.onLongClick);
      case CustomUI_Badge() when badge != null:
        return badge(_that.child, _that.color);
      case CustomUI_FoldableText() when foldableText != null:
        return foldableText(
            _that.text, _that.maxLines, _that.style, _that.animate);
      case CustomUI_StarDisplay() when starDisplay != null:
        return starDisplay(_that.fill, _that.maxStars);
      case CustomUI_Dropdown() when dropdown != null:
        return dropdown(_that.items, _that.initialValue, _that.onChange);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, TextStyle? style) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(DateTime timestamp, TimestampType display)
        timestamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(
            Link image, CustomUI top, CustomUI bottom, Interaction? onClick)
        card,
    required TResult Function() spinner,
    required TResult Function(String handler, String data) feed,
    required TResult Function(String label, Interaction? onClick,
            ButtonType? buttonType, ColorToken? color)
        button,
    required TResult Function(
            String settingId, SettingKind settingKind, Interaction? onCommit)
        inlineSetting,
    required TResult Function(String handler, CustomUI child, String staticData,
            List<Subscription> subscriptions)
        slot,
    required TResult Function(
            List<CustomUI> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            MainAxisSize? mainAxisSize,
            bool scrollable)
        column,
    required TResult Function(
            List<CustomUI> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            MainAxisSize? mainAxisSize,
            bool scrollable)
        row,
    required TResult Function(Interaction? onChange, int? debounceMs,
            String? initial, Interaction? onCommit)
        textInput,
    required TResult Function(EdgeInsets padding, CustomUI child) padding,
    required TResult Function(
            CustomUI child,
            ContainerType? containerType,
            ColorToken? color,
            ColorToken? borderColor,
            EdgeInsets? padding,
            double? width,
            double? height,
            Alignment? alignment,
            bool? emphasized)
        container,
    required TResult Function(
            CustomUI child, Interaction? onClick, Interaction? onLongClick)
        clickable,
    required TResult Function(CustomUI child, int flex) expanded,
    required TResult Function(double? width, double? height, CustomUI? child)
        sizedBox,
    required TResult Function(int flex) spacer,
    required TResult Function(List<CustomUI> children, double? spacing,
            double? runSpacing, WrapAlignment? alignment)
        wrap,
    required TResult Function(CustomUI child) center,
    required TResult Function(Alignment alignment, CustomUI child) align,
    required TResult Function(
            List<CustomUI> children, Alignment? alignment, StackFit? fit)
        stack,
    required TResult Function() divider,
    required TResult Function(
            CustomUI? leading,
            CustomUI? title,
            CustomUI? subtitle,
            CustomUI? trailing,
            Interaction? onClick,
            Interaction? onLongClick)
        listTile,
    required TResult Function(CustomUI child, ColorToken? color) badge,
    required TResult Function(
            String text, int maxLines, TextStyle? style, bool animate)
        foldableText,
    required TResult Function(double fill, int maxStars) starDisplay,
    required TResult Function(List<DropdownItem> items, String? initialValue,
            Interaction? onChange)
        dropdown,
  }) {
    final _that = this;
    switch (_that) {
      case CustomUI_Text():
        return text(_that.text, _that.style);
      case CustomUI_Image():
        return image(_that.image, _that.width, _that.height);
      case CustomUI_Link():
        return link(_that.link, _that.label);
      case CustomUI_Timestamp():
        return timestamp(_that.timestamp, _that.display);
      case CustomUI_EntryCard():
        return entryCard(_that.entry);
      case CustomUI_Card():
        return card(_that.image, _that.top, _that.bottom, _that.onClick);
      case CustomUI_Spinner():
        return spinner();
      case CustomUI_Feed():
        return feed(_that.handler, _that.data);
      case CustomUI_Button():
        return button(
            _that.label, _that.onClick, _that.buttonType, _that.color);
      case CustomUI_InlineSetting():
        return inlineSetting(
            _that.settingId, _that.settingKind, _that.onCommit);
      case CustomUI_Slot():
        return slot(
            _that.handler, _that.child, _that.staticData, _that.subscriptions);
      case CustomUI_Column():
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.mainAxisSize, _that.scrollable);
      case CustomUI_Row():
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.mainAxisSize, _that.scrollable);
      case CustomUI_TextInput():
        return textInput(
            _that.onChange, _that.debounceMs, _that.initial, _that.onCommit);
      case CustomUI_Padding():
        return padding(_that.padding, _that.child);
      case CustomUI_Container():
        return container(
            _that.child,
            _that.containerType,
            _that.color,
            _that.borderColor,
            _that.padding,
            _that.width,
            _that.height,
            _that.alignment,
            _that.emphasized);
      case CustomUI_Clickable():
        return clickable(_that.child, _that.onClick, _that.onLongClick);
      case CustomUI_Expanded():
        return expanded(_that.child, _that.flex);
      case CustomUI_SizedBox():
        return sizedBox(_that.width, _that.height, _that.child);
      case CustomUI_Spacer():
        return spacer(_that.flex);
      case CustomUI_Wrap():
        return wrap(
            _that.children, _that.spacing, _that.runSpacing, _that.alignment);
      case CustomUI_Center():
        return center(_that.child);
      case CustomUI_Align():
        return align(_that.alignment, _that.child);
      case CustomUI_Stack():
        return stack(_that.children, _that.alignment, _that.fit);
      case CustomUI_Divider():
        return divider();
      case CustomUI_ListTile():
        return listTile(_that.leading, _that.title, _that.subtitle,
            _that.trailing, _that.onClick, _that.onLongClick);
      case CustomUI_Badge():
        return badge(_that.child, _that.color);
      case CustomUI_FoldableText():
        return foldableText(
            _that.text, _that.maxLines, _that.style, _that.animate);
      case CustomUI_StarDisplay():
        return starDisplay(_that.fill, _that.maxStars);
      case CustomUI_Dropdown():
        return dropdown(_that.items, _that.initialValue, _that.onChange);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, TextStyle? style)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(DateTime timestamp, TimestampType display)? timestamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(
            Link image, CustomUI top, CustomUI bottom, Interaction? onClick)?
        card,
    TResult? Function()? spinner,
    TResult? Function(String handler, String data)? feed,
    TResult? Function(String label, Interaction? onClick,
            ButtonType? buttonType, ColorToken? color)?
        button,
    TResult? Function(
            String settingId, SettingKind settingKind, Interaction? onCommit)?
        inlineSetting,
    TResult? Function(String handler, CustomUI child, String staticData,
            List<Subscription> subscriptions)?
        slot,
    TResult? Function(
            List<CustomUI> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            MainAxisSize? mainAxisSize,
            bool scrollable)?
        column,
    TResult? Function(
            List<CustomUI> children,
            MainAxisAlignment? mainAxisAlignment,
            CrossAxisAlignment? crossAxisAlignment,
            MainAxisSize? mainAxisSize,
            bool scrollable)?
        row,
    TResult? Function(Interaction? onChange, int? debounceMs, String? initial,
            Interaction? onCommit)?
        textInput,
    TResult? Function(EdgeInsets padding, CustomUI child)? padding,
    TResult? Function(
            CustomUI child,
            ContainerType? containerType,
            ColorToken? color,
            ColorToken? borderColor,
            EdgeInsets? padding,
            double? width,
            double? height,
            Alignment? alignment,
            bool? emphasized)?
        container,
    TResult? Function(
            CustomUI child, Interaction? onClick, Interaction? onLongClick)?
        clickable,
    TResult? Function(CustomUI child, int flex)? expanded,
    TResult? Function(double? width, double? height, CustomUI? child)? sizedBox,
    TResult? Function(int flex)? spacer,
    TResult? Function(List<CustomUI> children, double? spacing,
            double? runSpacing, WrapAlignment? alignment)?
        wrap,
    TResult? Function(CustomUI child)? center,
    TResult? Function(Alignment alignment, CustomUI child)? align,
    TResult? Function(
            List<CustomUI> children, Alignment? alignment, StackFit? fit)?
        stack,
    TResult? Function()? divider,
    TResult? Function(CustomUI? leading, CustomUI? title, CustomUI? subtitle,
            CustomUI? trailing, Interaction? onClick, Interaction? onLongClick)?
        listTile,
    TResult? Function(CustomUI child, ColorToken? color)? badge,
    TResult? Function(
            String text, int maxLines, TextStyle? style, bool animate)?
        foldableText,
    TResult? Function(double fill, int maxStars)? starDisplay,
    TResult? Function(List<DropdownItem> items, String? initialValue,
            Interaction? onChange)?
        dropdown,
  }) {
    final _that = this;
    switch (_that) {
      case CustomUI_Text() when text != null:
        return text(_that.text, _that.style);
      case CustomUI_Image() when image != null:
        return image(_that.image, _that.width, _that.height);
      case CustomUI_Link() when link != null:
        return link(_that.link, _that.label);
      case CustomUI_Timestamp() when timestamp != null:
        return timestamp(_that.timestamp, _that.display);
      case CustomUI_EntryCard() when entryCard != null:
        return entryCard(_that.entry);
      case CustomUI_Card() when card != null:
        return card(_that.image, _that.top, _that.bottom, _that.onClick);
      case CustomUI_Spinner() when spinner != null:
        return spinner();
      case CustomUI_Feed() when feed != null:
        return feed(_that.handler, _that.data);
      case CustomUI_Button() when button != null:
        return button(
            _that.label, _that.onClick, _that.buttonType, _that.color);
      case CustomUI_InlineSetting() when inlineSetting != null:
        return inlineSetting(
            _that.settingId, _that.settingKind, _that.onCommit);
      case CustomUI_Slot() when slot != null:
        return slot(
            _that.handler, _that.child, _that.staticData, _that.subscriptions);
      case CustomUI_Column() when column != null:
        return column(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.mainAxisSize, _that.scrollable);
      case CustomUI_Row() when row != null:
        return row(_that.children, _that.mainAxisAlignment,
            _that.crossAxisAlignment, _that.mainAxisSize, _that.scrollable);
      case CustomUI_TextInput() when textInput != null:
        return textInput(
            _that.onChange, _that.debounceMs, _that.initial, _that.onCommit);
      case CustomUI_Padding() when padding != null:
        return padding(_that.padding, _that.child);
      case CustomUI_Container() when container != null:
        return container(
            _that.child,
            _that.containerType,
            _that.color,
            _that.borderColor,
            _that.padding,
            _that.width,
            _that.height,
            _that.alignment,
            _that.emphasized);
      case CustomUI_Clickable() when clickable != null:
        return clickable(_that.child, _that.onClick, _that.onLongClick);
      case CustomUI_Expanded() when expanded != null:
        return expanded(_that.child, _that.flex);
      case CustomUI_SizedBox() when sizedBox != null:
        return sizedBox(_that.width, _that.height, _that.child);
      case CustomUI_Spacer() when spacer != null:
        return spacer(_that.flex);
      case CustomUI_Wrap() when wrap != null:
        return wrap(
            _that.children, _that.spacing, _that.runSpacing, _that.alignment);
      case CustomUI_Center() when center != null:
        return center(_that.child);
      case CustomUI_Align() when align != null:
        return align(_that.alignment, _that.child);
      case CustomUI_Stack() when stack != null:
        return stack(_that.children, _that.alignment, _that.fit);
      case CustomUI_Divider() when divider != null:
        return divider();
      case CustomUI_ListTile() when listTile != null:
        return listTile(_that.leading, _that.title, _that.subtitle,
            _that.trailing, _that.onClick, _that.onLongClick);
      case CustomUI_Badge() when badge != null:
        return badge(_that.child, _that.color);
      case CustomUI_FoldableText() when foldableText != null:
        return foldableText(
            _that.text, _that.maxLines, _that.style, _that.animate);
      case CustomUI_StarDisplay() when starDisplay != null:
        return starDisplay(_that.fill, _that.maxStars);
      case CustomUI_Dropdown() when dropdown != null:
        return dropdown(_that.items, _that.initialValue, _that.onChange);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CustomUI_Text extends CustomUI {
  const CustomUI_Text({required this.text, this.style}) : super._();

  final String text;
  final TextStyle? style;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_TextCopyWith<CustomUI_Text> get copyWith =>
      _$CustomUI_TextCopyWithImpl<CustomUI_Text>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Text &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.style, style) || other.style == style));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, style);

  @override
  String toString() {
    return 'CustomUI.text(text: $text, style: $style)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_TextCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_TextCopyWith(
          CustomUI_Text value, $Res Function(CustomUI_Text) _then) =
      _$CustomUI_TextCopyWithImpl;
  @useResult
  $Res call({String text, TextStyle? style});
}

/// @nodoc
class _$CustomUI_TextCopyWithImpl<$Res>
    implements $CustomUI_TextCopyWith<$Res> {
  _$CustomUI_TextCopyWithImpl(this._self, this._then);

  final CustomUI_Text _self;
  final $Res Function(CustomUI_Text) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? style = freezed,
  }) {
    return _then(CustomUI_Text(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyle?,
    ));
  }
}

/// @nodoc

class CustomUI_Image extends CustomUI {
  const CustomUI_Image({required this.image, this.width, this.height})
      : super._();

  final Link image;
  final int? width;
  final int? height;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ImageCopyWith<CustomUI_Image> get copyWith =>
      _$CustomUI_ImageCopyWithImpl<CustomUI_Image>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Image &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, width, height);

  @override
  String toString() {
    return 'CustomUI.image(image: $image, width: $width, height: $height)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ImageCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ImageCopyWith(
          CustomUI_Image value, $Res Function(CustomUI_Image) _then) =
      _$CustomUI_ImageCopyWithImpl;
  @useResult
  $Res call({Link image, int? width, int? height});
}

/// @nodoc
class _$CustomUI_ImageCopyWithImpl<$Res>
    implements $CustomUI_ImageCopyWith<$Res> {
  _$CustomUI_ImageCopyWithImpl(this._self, this._then);

  final CustomUI_Image _self;
  final $Res Function(CustomUI_Image) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? image = null,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(CustomUI_Image(
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as Link,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class CustomUI_Link extends CustomUI {
  const CustomUI_Link({required this.link, this.label}) : super._();

  final String link;
  final String? label;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_LinkCopyWith<CustomUI_Link> get copyWith =>
      _$CustomUI_LinkCopyWithImpl<CustomUI_Link>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Link &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link, label);

  @override
  String toString() {
    return 'CustomUI.link(link: $link, label: $label)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_LinkCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_LinkCopyWith(
          CustomUI_Link value, $Res Function(CustomUI_Link) _then) =
      _$CustomUI_LinkCopyWithImpl;
  @useResult
  $Res call({String link, String? label});
}

/// @nodoc
class _$CustomUI_LinkCopyWithImpl<$Res>
    implements $CustomUI_LinkCopyWith<$Res> {
  _$CustomUI_LinkCopyWithImpl(this._self, this._then);

  final CustomUI_Link _self;
  final $Res Function(CustomUI_Link) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? link = null,
    Object? label = freezed,
  }) {
    return _then(CustomUI_Link(
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class CustomUI_Timestamp extends CustomUI {
  const CustomUI_Timestamp({required this.timestamp, required this.display})
      : super._();

  /// ISO-8601 on the wire (`DateTime` in Dart).
  final DateTime timestamp;
  final TimestampType display;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_TimestampCopyWith<CustomUI_Timestamp> get copyWith =>
      _$CustomUI_TimestampCopyWithImpl<CustomUI_Timestamp>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Timestamp &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.display, display) || other.display == display));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, display);

  @override
  String toString() {
    return 'CustomUI.timestamp(timestamp: $timestamp, display: $display)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_TimestampCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_TimestampCopyWith(
          CustomUI_Timestamp value, $Res Function(CustomUI_Timestamp) _then) =
      _$CustomUI_TimestampCopyWithImpl;
  @useResult
  $Res call({DateTime timestamp, TimestampType display});
}

/// @nodoc
class _$CustomUI_TimestampCopyWithImpl<$Res>
    implements $CustomUI_TimestampCopyWith<$Res> {
  _$CustomUI_TimestampCopyWithImpl(this._self, this._then);

  final CustomUI_Timestamp _self;
  final $Res Function(CustomUI_Timestamp) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? timestamp = null,
    Object? display = null,
  }) {
    return _then(CustomUI_Timestamp(
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      display: null == display
          ? _self.display
          : display // ignore: cast_nullable_to_non_nullable
              as TimestampType,
    ));
  }
}

/// @nodoc

class CustomUI_EntryCard extends CustomUI {
  const CustomUI_EntryCard({required this.entry}) : super._();

  final Entry entry;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_EntryCardCopyWith<CustomUI_EntryCard> get copyWith =>
      _$CustomUI_EntryCardCopyWithImpl<CustomUI_EntryCard>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_EntryCard &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry);

  @override
  String toString() {
    return 'CustomUI.entryCard(entry: $entry)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_EntryCardCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_EntryCardCopyWith(
          CustomUI_EntryCard value, $Res Function(CustomUI_EntryCard) _then) =
      _$CustomUI_EntryCardCopyWithImpl;
  @useResult
  $Res call({Entry entry});
}

/// @nodoc
class _$CustomUI_EntryCardCopyWithImpl<$Res>
    implements $CustomUI_EntryCardCopyWith<$Res> {
  _$CustomUI_EntryCardCopyWithImpl(this._self, this._then);

  final CustomUI_EntryCard _self;
  final $Res Function(CustomUI_EntryCard) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? entry = null,
  }) {
    return _then(CustomUI_EntryCard(
      entry: null == entry
          ? _self.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as Entry,
    ));
  }
}

/// @nodoc

class CustomUI_Card extends CustomUI {
  const CustomUI_Card(
      {required this.image,
      required this.top,
      required this.bottom,
      this.onClick})
      : super._();

  final Link image;
  final CustomUI top;
  final CustomUI bottom;
  final Interaction? onClick;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_CardCopyWith<CustomUI_Card> get copyWith =>
      _$CustomUI_CardCopyWithImpl<CustomUI_Card>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Card &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.top, top) || other.top == top) &&
            (identical(other.bottom, bottom) || other.bottom == bottom) &&
            (identical(other.onClick, onClick) || other.onClick == onClick));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, top, bottom, onClick);

  @override
  String toString() {
    return 'CustomUI.card(image: $image, top: $top, bottom: $bottom, onClick: $onClick)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_CardCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_CardCopyWith(
          CustomUI_Card value, $Res Function(CustomUI_Card) _then) =
      _$CustomUI_CardCopyWithImpl;
  @useResult
  $Res call({Link image, CustomUI top, CustomUI bottom, Interaction? onClick});

  $CustomUICopyWith<$Res> get top;
  $CustomUICopyWith<$Res> get bottom;
  $InteractionCopyWith<$Res>? get onClick;
}

/// @nodoc
class _$CustomUI_CardCopyWithImpl<$Res>
    implements $CustomUI_CardCopyWith<$Res> {
  _$CustomUI_CardCopyWithImpl(this._self, this._then);

  final CustomUI_Card _self;
  final $Res Function(CustomUI_Card) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? image = null,
    Object? top = null,
    Object? bottom = null,
    Object? onClick = freezed,
  }) {
    return _then(CustomUI_Card(
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as Link,
      top: null == top
          ? _self.top
          : top // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      bottom: null == bottom
          ? _self.bottom
          : bottom // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      onClick: freezed == onClick
          ? _self.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as Interaction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get top {
    return $CustomUICopyWith<$Res>(_self.top, (value) {
      return _then(_self.copyWith(top: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get bottom {
    return $CustomUICopyWith<$Res>(_self.bottom, (value) {
      return _then(_self.copyWith(bottom: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onClick {
    if (_self.onClick == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onClick!, (value) {
      return _then(_self.copyWith(onClick: value));
    });
  }
}

/// @nodoc

class CustomUI_Spinner extends CustomUI {
  const CustomUI_Spinner() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CustomUI_Spinner);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CustomUI.spinner()';
  }
}

/// @nodoc

class CustomUI_Feed extends CustomUI {
  const CustomUI_Feed({required this.handler, required this.data}) : super._();

  final String handler;
  final String data;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_FeedCopyWith<CustomUI_Feed> get copyWith =>
      _$CustomUI_FeedCopyWithImpl<CustomUI_Feed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Feed &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, data);

  @override
  String toString() {
    return 'CustomUI.feed(handler: $handler, data: $data)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_FeedCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_FeedCopyWith(
          CustomUI_Feed value, $Res Function(CustomUI_Feed) _then) =
      _$CustomUI_FeedCopyWithImpl;
  @useResult
  $Res call({String handler, String data});
}

/// @nodoc
class _$CustomUI_FeedCopyWithImpl<$Res>
    implements $CustomUI_FeedCopyWith<$Res> {
  _$CustomUI_FeedCopyWithImpl(this._self, this._then);

  final CustomUI_Feed _self;
  final $Res Function(CustomUI_Feed) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? handler = null,
    Object? data = null,
  }) {
    return _then(CustomUI_Feed(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class CustomUI_Button extends CustomUI {
  const CustomUI_Button(
      {required this.label, this.onClick, this.buttonType, this.color})
      : super._();

  final String label;
  final Interaction? onClick;
  final ButtonType? buttonType;
  final ColorToken? color;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ButtonCopyWith<CustomUI_Button> get copyWith =>
      _$CustomUI_ButtonCopyWithImpl<CustomUI_Button>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Button &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onClick, onClick) || other.onClick == onClick) &&
            (identical(other.buttonType, buttonType) ||
                other.buttonType == buttonType) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, label, onClick, buttonType, color);

  @override
  String toString() {
    return 'CustomUI.button(label: $label, onClick: $onClick, buttonType: $buttonType, color: $color)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ButtonCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ButtonCopyWith(
          CustomUI_Button value, $Res Function(CustomUI_Button) _then) =
      _$CustomUI_ButtonCopyWithImpl;
  @useResult
  $Res call(
      {String label,
      Interaction? onClick,
      ButtonType? buttonType,
      ColorToken? color});

  $InteractionCopyWith<$Res>? get onClick;
}

/// @nodoc
class _$CustomUI_ButtonCopyWithImpl<$Res>
    implements $CustomUI_ButtonCopyWith<$Res> {
  _$CustomUI_ButtonCopyWithImpl(this._self, this._then);

  final CustomUI_Button _self;
  final $Res Function(CustomUI_Button) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? label = null,
    Object? onClick = freezed,
    Object? buttonType = freezed,
    Object? color = freezed,
  }) {
    return _then(CustomUI_Button(
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onClick: freezed == onClick
          ? _self.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as Interaction?,
      buttonType: freezed == buttonType
          ? _self.buttonType
          : buttonType // ignore: cast_nullable_to_non_nullable
              as ButtonType?,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorToken?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onClick {
    if (_self.onClick == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onClick!, (value) {
      return _then(_self.copyWith(onClick: value));
    });
  }
}

/// @nodoc

class CustomUI_InlineSetting extends CustomUI {
  const CustomUI_InlineSetting(
      {required this.settingId, required this.settingKind, this.onCommit})
      : super._();

  final String settingId;
  final SettingKind settingKind;
  final Interaction? onCommit;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_InlineSettingCopyWith<CustomUI_InlineSetting> get copyWith =>
      _$CustomUI_InlineSettingCopyWithImpl<CustomUI_InlineSetting>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_InlineSetting &&
            (identical(other.settingId, settingId) ||
                other.settingId == settingId) &&
            (identical(other.settingKind, settingKind) ||
                other.settingKind == settingKind) &&
            (identical(other.onCommit, onCommit) ||
                other.onCommit == onCommit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, settingId, settingKind, onCommit);

  @override
  String toString() {
    return 'CustomUI.inlineSetting(settingId: $settingId, settingKind: $settingKind, onCommit: $onCommit)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_InlineSettingCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_InlineSettingCopyWith(CustomUI_InlineSetting value,
          $Res Function(CustomUI_InlineSetting) _then) =
      _$CustomUI_InlineSettingCopyWithImpl;
  @useResult
  $Res call({String settingId, SettingKind settingKind, Interaction? onCommit});

  $InteractionCopyWith<$Res>? get onCommit;
}

/// @nodoc
class _$CustomUI_InlineSettingCopyWithImpl<$Res>
    implements $CustomUI_InlineSettingCopyWith<$Res> {
  _$CustomUI_InlineSettingCopyWithImpl(this._self, this._then);

  final CustomUI_InlineSetting _self;
  final $Res Function(CustomUI_InlineSetting) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settingId = null,
    Object? settingKind = null,
    Object? onCommit = freezed,
  }) {
    return _then(CustomUI_InlineSetting(
      settingId: null == settingId
          ? _self.settingId
          : settingId // ignore: cast_nullable_to_non_nullable
              as String,
      settingKind: null == settingKind
          ? _self.settingKind
          : settingKind // ignore: cast_nullable_to_non_nullable
              as SettingKind,
      onCommit: freezed == onCommit
          ? _self.onCommit
          : onCommit // ignore: cast_nullable_to_non_nullable
              as Interaction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onCommit {
    if (_self.onCommit == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onCommit!, (value) {
      return _then(_self.copyWith(onCommit: value));
    });
  }
}

/// @nodoc

class CustomUI_Slot extends CustomUI {
  const CustomUI_Slot(
      {required this.handler,
      required this.child,
      required this.staticData,
      required final List<Subscription> subscriptions})
      : _subscriptions = subscriptions,
        super._();

  final String handler;
  final CustomUI child;
  final String staticData;
  final List<Subscription> _subscriptions;
  List<Subscription> get subscriptions {
    if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subscriptions);
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_SlotCopyWith<CustomUI_Slot> get copyWith =>
      _$CustomUI_SlotCopyWithImpl<CustomUI_Slot>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Slot &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.staticData, staticData) ||
                other.staticData == staticData) &&
            const DeepCollectionEquality()
                .equals(other._subscriptions, _subscriptions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, child, staticData,
      const DeepCollectionEquality().hash(_subscriptions));

  @override
  String toString() {
    return 'CustomUI.slot(handler: $handler, child: $child, staticData: $staticData, subscriptions: $subscriptions)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_SlotCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_SlotCopyWith(
          CustomUI_Slot value, $Res Function(CustomUI_Slot) _then) =
      _$CustomUI_SlotCopyWithImpl;
  @useResult
  $Res call(
      {String handler,
      CustomUI child,
      String staticData,
      List<Subscription> subscriptions});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_SlotCopyWithImpl<$Res>
    implements $CustomUI_SlotCopyWith<$Res> {
  _$CustomUI_SlotCopyWithImpl(this._self, this._then);

  final CustomUI_Slot _self;
  final $Res Function(CustomUI_Slot) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? handler = null,
    Object? child = null,
    Object? staticData = null,
    Object? subscriptions = null,
  }) {
    return _then(CustomUI_Slot(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      staticData: null == staticData
          ? _self.staticData
          : staticData // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptions: null == subscriptions
          ? _self._subscriptions
          : subscriptions // ignore: cast_nullable_to_non_nullable
              as List<Subscription>,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_Column extends CustomUI {
  const CustomUI_Column(
      {required final List<CustomUI> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.mainAxisSize,
      required this.scrollable})
      : _children = children,
        super._();

  final List<CustomUI> _children;
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final bool scrollable;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ColumnCopyWith<CustomUI_Column> get copyWith =>
      _$CustomUI_ColumnCopyWithImpl<CustomUI_Column>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Column &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.mainAxisAlignment, mainAxisAlignment) ||
                other.mainAxisAlignment == mainAxisAlignment) &&
            (identical(other.crossAxisAlignment, crossAxisAlignment) ||
                other.crossAxisAlignment == crossAxisAlignment) &&
            (identical(other.mainAxisSize, mainAxisSize) ||
                other.mainAxisSize == mainAxisSize) &&
            (identical(other.scrollable, scrollable) ||
                other.scrollable == scrollable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      mainAxisSize,
      scrollable);

  @override
  String toString() {
    return 'CustomUI.column(children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, mainAxisSize: $mainAxisSize, scrollable: $scrollable)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ColumnCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ColumnCopyWith(
          CustomUI_Column value, $Res Function(CustomUI_Column) _then) =
      _$CustomUI_ColumnCopyWithImpl;
  @useResult
  $Res call(
      {List<CustomUI> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      MainAxisSize? mainAxisSize,
      bool scrollable});
}

/// @nodoc
class _$CustomUI_ColumnCopyWithImpl<$Res>
    implements $CustomUI_ColumnCopyWith<$Res> {
  _$CustomUI_ColumnCopyWithImpl(this._self, this._then);

  final CustomUI_Column _self;
  final $Res Function(CustomUI_Column) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? mainAxisSize = freezed,
    Object? scrollable = null,
  }) {
    return _then(CustomUI_Column(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _self.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _self.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      mainAxisSize: freezed == mainAxisSize
          ? _self.mainAxisSize
          : mainAxisSize // ignore: cast_nullable_to_non_nullable
              as MainAxisSize?,
      scrollable: null == scrollable
          ? _self.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class CustomUI_Row extends CustomUI {
  const CustomUI_Row(
      {required final List<CustomUI> children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.mainAxisSize,
      required this.scrollable})
      : _children = children,
        super._();

  final List<CustomUI> _children;
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final bool scrollable;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_RowCopyWith<CustomUI_Row> get copyWith =>
      _$CustomUI_RowCopyWithImpl<CustomUI_Row>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Row &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.mainAxisAlignment, mainAxisAlignment) ||
                other.mainAxisAlignment == mainAxisAlignment) &&
            (identical(other.crossAxisAlignment, crossAxisAlignment) ||
                other.crossAxisAlignment == crossAxisAlignment) &&
            (identical(other.mainAxisSize, mainAxisSize) ||
                other.mainAxisSize == mainAxisSize) &&
            (identical(other.scrollable, scrollable) ||
                other.scrollable == scrollable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      mainAxisAlignment,
      crossAxisAlignment,
      mainAxisSize,
      scrollable);

  @override
  String toString() {
    return 'CustomUI.row(children: $children, mainAxisAlignment: $mainAxisAlignment, crossAxisAlignment: $crossAxisAlignment, mainAxisSize: $mainAxisSize, scrollable: $scrollable)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_RowCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_RowCopyWith(
          CustomUI_Row value, $Res Function(CustomUI_Row) _then) =
      _$CustomUI_RowCopyWithImpl;
  @useResult
  $Res call(
      {List<CustomUI> children,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      MainAxisSize? mainAxisSize,
      bool scrollable});
}

/// @nodoc
class _$CustomUI_RowCopyWithImpl<$Res> implements $CustomUI_RowCopyWith<$Res> {
  _$CustomUI_RowCopyWithImpl(this._self, this._then);

  final CustomUI_Row _self;
  final $Res Function(CustomUI_Row) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? mainAxisAlignment = freezed,
    Object? crossAxisAlignment = freezed,
    Object? mainAxisSize = freezed,
    Object? scrollable = null,
  }) {
    return _then(CustomUI_Row(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      mainAxisAlignment: freezed == mainAxisAlignment
          ? _self.mainAxisAlignment
          : mainAxisAlignment // ignore: cast_nullable_to_non_nullable
              as MainAxisAlignment?,
      crossAxisAlignment: freezed == crossAxisAlignment
          ? _self.crossAxisAlignment
          : crossAxisAlignment // ignore: cast_nullable_to_non_nullable
              as CrossAxisAlignment?,
      mainAxisSize: freezed == mainAxisSize
          ? _self.mainAxisSize
          : mainAxisSize // ignore: cast_nullable_to_non_nullable
              as MainAxisSize?,
      scrollable: null == scrollable
          ? _self.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class CustomUI_TextInput extends CustomUI {
  const CustomUI_TextInput(
      {this.onChange, this.debounceMs, this.initial, this.onCommit})
      : super._();

  final Interaction? onChange;
  final int? debounceMs;
  final String? initial;
  final Interaction? onCommit;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_TextInputCopyWith<CustomUI_TextInput> get copyWith =>
      _$CustomUI_TextInputCopyWithImpl<CustomUI_TextInput>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_TextInput &&
            (identical(other.onChange, onChange) ||
                other.onChange == onChange) &&
            (identical(other.debounceMs, debounceMs) ||
                other.debounceMs == debounceMs) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.onCommit, onCommit) ||
                other.onCommit == onCommit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, onChange, debounceMs, initial, onCommit);

  @override
  String toString() {
    return 'CustomUI.textInput(onChange: $onChange, debounceMs: $debounceMs, initial: $initial, onCommit: $onCommit)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_TextInputCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_TextInputCopyWith(
          CustomUI_TextInput value, $Res Function(CustomUI_TextInput) _then) =
      _$CustomUI_TextInputCopyWithImpl;
  @useResult
  $Res call(
      {Interaction? onChange,
      int? debounceMs,
      String? initial,
      Interaction? onCommit});

  $InteractionCopyWith<$Res>? get onChange;
  $InteractionCopyWith<$Res>? get onCommit;
}

/// @nodoc
class _$CustomUI_TextInputCopyWithImpl<$Res>
    implements $CustomUI_TextInputCopyWith<$Res> {
  _$CustomUI_TextInputCopyWithImpl(this._self, this._then);

  final CustomUI_TextInput _self;
  final $Res Function(CustomUI_TextInput) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? onChange = freezed,
    Object? debounceMs = freezed,
    Object? initial = freezed,
    Object? onCommit = freezed,
  }) {
    return _then(CustomUI_TextInput(
      onChange: freezed == onChange
          ? _self.onChange
          : onChange // ignore: cast_nullable_to_non_nullable
              as Interaction?,
      debounceMs: freezed == debounceMs
          ? _self.debounceMs
          : debounceMs // ignore: cast_nullable_to_non_nullable
              as int?,
      initial: freezed == initial
          ? _self.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as String?,
      onCommit: freezed == onCommit
          ? _self.onCommit
          : onCommit // ignore: cast_nullable_to_non_nullable
              as Interaction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onChange {
    if (_self.onChange == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onChange!, (value) {
      return _then(_self.copyWith(onChange: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onCommit {
    if (_self.onCommit == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onCommit!, (value) {
      return _then(_self.copyWith(onCommit: value));
    });
  }
}

/// @nodoc

class CustomUI_Padding extends CustomUI {
  const CustomUI_Padding({required this.padding, required this.child})
      : super._();

  final EdgeInsets padding;
  final CustomUI child;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_PaddingCopyWith<CustomUI_Padding> get copyWith =>
      _$CustomUI_PaddingCopyWithImpl<CustomUI_Padding>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Padding &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.child, child) || other.child == child));
  }

  @override
  int get hashCode => Object.hash(runtimeType, padding, child);

  @override
  String toString() {
    return 'CustomUI.padding(padding: $padding, child: $child)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_PaddingCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_PaddingCopyWith(
          CustomUI_Padding value, $Res Function(CustomUI_Padding) _then) =
      _$CustomUI_PaddingCopyWithImpl;
  @useResult
  $Res call({EdgeInsets padding, CustomUI child});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_PaddingCopyWithImpl<$Res>
    implements $CustomUI_PaddingCopyWith<$Res> {
  _$CustomUI_PaddingCopyWithImpl(this._self, this._then);

  final CustomUI_Padding _self;
  final $Res Function(CustomUI_Padding) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? padding = null,
    Object? child = null,
  }) {
    return _then(CustomUI_Padding(
      padding: null == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as EdgeInsets,
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_Container extends CustomUI {
  const CustomUI_Container(
      {required this.child,
      this.containerType,
      this.color,
      this.borderColor,
      this.padding,
      this.width,
      this.height,
      this.alignment,
      this.emphasized})
      : super._();

  final CustomUI child;
  final ContainerType? containerType;
  final ColorToken? color;
  final ColorToken? borderColor;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final bool? emphasized;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ContainerCopyWith<CustomUI_Container> get copyWith =>
      _$CustomUI_ContainerCopyWithImpl<CustomUI_Container>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Container &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.containerType, containerType) ||
                other.containerType == containerType) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.padding, padding) || other.padding == padding) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment) &&
            (identical(other.emphasized, emphasized) ||
                other.emphasized == emphasized));
  }

  @override
  int get hashCode => Object.hash(runtimeType, child, containerType, color,
      borderColor, padding, width, height, alignment, emphasized);

  @override
  String toString() {
    return 'CustomUI.container(child: $child, containerType: $containerType, color: $color, borderColor: $borderColor, padding: $padding, width: $width, height: $height, alignment: $alignment, emphasized: $emphasized)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ContainerCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ContainerCopyWith(
          CustomUI_Container value, $Res Function(CustomUI_Container) _then) =
      _$CustomUI_ContainerCopyWithImpl;
  @useResult
  $Res call(
      {CustomUI child,
      ContainerType? containerType,
      ColorToken? color,
      ColorToken? borderColor,
      EdgeInsets? padding,
      double? width,
      double? height,
      Alignment? alignment,
      bool? emphasized});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_ContainerCopyWithImpl<$Res>
    implements $CustomUI_ContainerCopyWith<$Res> {
  _$CustomUI_ContainerCopyWithImpl(this._self, this._then);

  final CustomUI_Container _self;
  final $Res Function(CustomUI_Container) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? containerType = freezed,
    Object? color = freezed,
    Object? borderColor = freezed,
    Object? padding = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? alignment = freezed,
    Object? emphasized = freezed,
  }) {
    return _then(CustomUI_Container(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      containerType: freezed == containerType
          ? _self.containerType
          : containerType // ignore: cast_nullable_to_non_nullable
              as ContainerType?,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorToken?,
      borderColor: freezed == borderColor
          ? _self.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as ColorToken?,
      padding: freezed == padding
          ? _self.padding
          : padding // ignore: cast_nullable_to_non_nullable
              as EdgeInsets?,
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      alignment: freezed == alignment
          ? _self.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as Alignment?,
      emphasized: freezed == emphasized
          ? _self.emphasized
          : emphasized // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_Clickable extends CustomUI {
  const CustomUI_Clickable(
      {required this.child, this.onClick, this.onLongClick})
      : super._();

  final CustomUI child;
  final Interaction? onClick;
  final Interaction? onLongClick;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ClickableCopyWith<CustomUI_Clickable> get copyWith =>
      _$CustomUI_ClickableCopyWithImpl<CustomUI_Clickable>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Clickable &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.onClick, onClick) || other.onClick == onClick) &&
            (identical(other.onLongClick, onLongClick) ||
                other.onLongClick == onLongClick));
  }

  @override
  int get hashCode => Object.hash(runtimeType, child, onClick, onLongClick);

  @override
  String toString() {
    return 'CustomUI.clickable(child: $child, onClick: $onClick, onLongClick: $onLongClick)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ClickableCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ClickableCopyWith(
          CustomUI_Clickable value, $Res Function(CustomUI_Clickable) _then) =
      _$CustomUI_ClickableCopyWithImpl;
  @useResult
  $Res call({CustomUI child, Interaction? onClick, Interaction? onLongClick});

  $CustomUICopyWith<$Res> get child;
  $InteractionCopyWith<$Res>? get onClick;
  $InteractionCopyWith<$Res>? get onLongClick;
}

/// @nodoc
class _$CustomUI_ClickableCopyWithImpl<$Res>
    implements $CustomUI_ClickableCopyWith<$Res> {
  _$CustomUI_ClickableCopyWithImpl(this._self, this._then);

  final CustomUI_Clickable _self;
  final $Res Function(CustomUI_Clickable) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? onClick = freezed,
    Object? onLongClick = freezed,
  }) {
    return _then(CustomUI_Clickable(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      onClick: freezed == onClick
          ? _self.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as Interaction?,
      onLongClick: freezed == onLongClick
          ? _self.onLongClick
          : onLongClick // ignore: cast_nullable_to_non_nullable
              as Interaction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onClick {
    if (_self.onClick == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onClick!, (value) {
      return _then(_self.copyWith(onClick: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onLongClick {
    if (_self.onLongClick == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onLongClick!, (value) {
      return _then(_self.copyWith(onLongClick: value));
    });
  }
}

/// @nodoc

class CustomUI_Expanded extends CustomUI {
  const CustomUI_Expanded({required this.child, required this.flex})
      : super._();

  final CustomUI child;
  final int flex;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ExpandedCopyWith<CustomUI_Expanded> get copyWith =>
      _$CustomUI_ExpandedCopyWithImpl<CustomUI_Expanded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Expanded &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, child, flex);

  @override
  String toString() {
    return 'CustomUI.expanded(child: $child, flex: $flex)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ExpandedCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ExpandedCopyWith(
          CustomUI_Expanded value, $Res Function(CustomUI_Expanded) _then) =
      _$CustomUI_ExpandedCopyWithImpl;
  @useResult
  $Res call({CustomUI child, int flex});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_ExpandedCopyWithImpl<$Res>
    implements $CustomUI_ExpandedCopyWith<$Res> {
  _$CustomUI_ExpandedCopyWithImpl(this._self, this._then);

  final CustomUI_Expanded _self;
  final $Res Function(CustomUI_Expanded) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? flex = null,
  }) {
    return _then(CustomUI_Expanded(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      flex: null == flex
          ? _self.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_SizedBox extends CustomUI {
  const CustomUI_SizedBox({this.width, this.height, this.child}) : super._();

  final double? width;
  final double? height;
  final CustomUI? child;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_SizedBoxCopyWith<CustomUI_SizedBox> get copyWith =>
      _$CustomUI_SizedBoxCopyWithImpl<CustomUI_SizedBox>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_SizedBox &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.child, child) || other.child == child));
  }

  @override
  int get hashCode => Object.hash(runtimeType, width, height, child);

  @override
  String toString() {
    return 'CustomUI.sizedBox(width: $width, height: $height, child: $child)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_SizedBoxCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_SizedBoxCopyWith(
          CustomUI_SizedBox value, $Res Function(CustomUI_SizedBox) _then) =
      _$CustomUI_SizedBoxCopyWithImpl;
  @useResult
  $Res call({double? width, double? height, CustomUI? child});

  $CustomUICopyWith<$Res>? get child;
}

/// @nodoc
class _$CustomUI_SizedBoxCopyWithImpl<$Res>
    implements $CustomUI_SizedBoxCopyWith<$Res> {
  _$CustomUI_SizedBoxCopyWithImpl(this._self, this._then);

  final CustomUI_SizedBox _self;
  final $Res Function(CustomUI_SizedBox) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? width = freezed,
    Object? height = freezed,
    Object? child = freezed,
  }) {
    return _then(CustomUI_SizedBox(
      width: freezed == width
          ? _self.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      child: freezed == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get child {
    if (_self.child == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_self.child!, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_Spacer extends CustomUI {
  const CustomUI_Spacer({required this.flex}) : super._();

  final int flex;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_SpacerCopyWith<CustomUI_Spacer> get copyWith =>
      _$CustomUI_SpacerCopyWithImpl<CustomUI_Spacer>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Spacer &&
            (identical(other.flex, flex) || other.flex == flex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flex);

  @override
  String toString() {
    return 'CustomUI.spacer(flex: $flex)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_SpacerCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_SpacerCopyWith(
          CustomUI_Spacer value, $Res Function(CustomUI_Spacer) _then) =
      _$CustomUI_SpacerCopyWithImpl;
  @useResult
  $Res call({int flex});
}

/// @nodoc
class _$CustomUI_SpacerCopyWithImpl<$Res>
    implements $CustomUI_SpacerCopyWith<$Res> {
  _$CustomUI_SpacerCopyWithImpl(this._self, this._then);

  final CustomUI_Spacer _self;
  final $Res Function(CustomUI_Spacer) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? flex = null,
  }) {
    return _then(CustomUI_Spacer(
      flex: null == flex
          ? _self.flex
          : flex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class CustomUI_Wrap extends CustomUI {
  const CustomUI_Wrap(
      {required final List<CustomUI> children,
      this.spacing,
      this.runSpacing,
      this.alignment})
      : _children = children,
        super._();

  final List<CustomUI> _children;
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final double? spacing;
  final double? runSpacing;
  final WrapAlignment? alignment;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_WrapCopyWith<CustomUI_Wrap> get copyWith =>
      _$CustomUI_WrapCopyWithImpl<CustomUI_Wrap>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Wrap &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.spacing, spacing) || other.spacing == spacing) &&
            (identical(other.runSpacing, runSpacing) ||
                other.runSpacing == runSpacing) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_children),
      spacing,
      runSpacing,
      alignment);

  @override
  String toString() {
    return 'CustomUI.wrap(children: $children, spacing: $spacing, runSpacing: $runSpacing, alignment: $alignment)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_WrapCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_WrapCopyWith(
          CustomUI_Wrap value, $Res Function(CustomUI_Wrap) _then) =
      _$CustomUI_WrapCopyWithImpl;
  @useResult
  $Res call(
      {List<CustomUI> children,
      double? spacing,
      double? runSpacing,
      WrapAlignment? alignment});
}

/// @nodoc
class _$CustomUI_WrapCopyWithImpl<$Res>
    implements $CustomUI_WrapCopyWith<$Res> {
  _$CustomUI_WrapCopyWithImpl(this._self, this._then);

  final CustomUI_Wrap _self;
  final $Res Function(CustomUI_Wrap) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? spacing = freezed,
    Object? runSpacing = freezed,
    Object? alignment = freezed,
  }) {
    return _then(CustomUI_Wrap(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      spacing: freezed == spacing
          ? _self.spacing
          : spacing // ignore: cast_nullable_to_non_nullable
              as double?,
      runSpacing: freezed == runSpacing
          ? _self.runSpacing
          : runSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      alignment: freezed == alignment
          ? _self.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as WrapAlignment?,
    ));
  }
}

/// @nodoc

class CustomUI_Center extends CustomUI {
  const CustomUI_Center({required this.child}) : super._();

  final CustomUI child;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_CenterCopyWith<CustomUI_Center> get copyWith =>
      _$CustomUI_CenterCopyWithImpl<CustomUI_Center>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Center &&
            (identical(other.child, child) || other.child == child));
  }

  @override
  int get hashCode => Object.hash(runtimeType, child);

  @override
  String toString() {
    return 'CustomUI.center(child: $child)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_CenterCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_CenterCopyWith(
          CustomUI_Center value, $Res Function(CustomUI_Center) _then) =
      _$CustomUI_CenterCopyWithImpl;
  @useResult
  $Res call({CustomUI child});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_CenterCopyWithImpl<$Res>
    implements $CustomUI_CenterCopyWith<$Res> {
  _$CustomUI_CenterCopyWithImpl(this._self, this._then);

  final CustomUI_Center _self;
  final $Res Function(CustomUI_Center) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
  }) {
    return _then(CustomUI_Center(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_Align extends CustomUI {
  const CustomUI_Align({required this.alignment, required this.child})
      : super._();

  final Alignment alignment;
  final CustomUI child;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_AlignCopyWith<CustomUI_Align> get copyWith =>
      _$CustomUI_AlignCopyWithImpl<CustomUI_Align>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Align &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment) &&
            (identical(other.child, child) || other.child == child));
  }

  @override
  int get hashCode => Object.hash(runtimeType, alignment, child);

  @override
  String toString() {
    return 'CustomUI.align(alignment: $alignment, child: $child)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_AlignCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_AlignCopyWith(
          CustomUI_Align value, $Res Function(CustomUI_Align) _then) =
      _$CustomUI_AlignCopyWithImpl;
  @useResult
  $Res call({Alignment alignment, CustomUI child});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_AlignCopyWithImpl<$Res>
    implements $CustomUI_AlignCopyWith<$Res> {
  _$CustomUI_AlignCopyWithImpl(this._self, this._then);

  final CustomUI_Align _self;
  final $Res Function(CustomUI_Align) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? alignment = null,
    Object? child = null,
  }) {
    return _then(CustomUI_Align(
      alignment: null == alignment
          ? _self.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as Alignment,
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_Stack extends CustomUI {
  const CustomUI_Stack(
      {required final List<CustomUI> children, this.alignment, this.fit})
      : _children = children,
        super._();

  final List<CustomUI> _children;
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final Alignment? alignment;
  final StackFit? fit;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_StackCopyWith<CustomUI_Stack> get copyWith =>
      _$CustomUI_StackCopyWithImpl<CustomUI_Stack>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Stack &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment) &&
            (identical(other.fit, fit) || other.fit == fit));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_children), alignment, fit);

  @override
  String toString() {
    return 'CustomUI.stack(children: $children, alignment: $alignment, fit: $fit)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_StackCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_StackCopyWith(
          CustomUI_Stack value, $Res Function(CustomUI_Stack) _then) =
      _$CustomUI_StackCopyWithImpl;
  @useResult
  $Res call({List<CustomUI> children, Alignment? alignment, StackFit? fit});
}

/// @nodoc
class _$CustomUI_StackCopyWithImpl<$Res>
    implements $CustomUI_StackCopyWith<$Res> {
  _$CustomUI_StackCopyWithImpl(this._self, this._then);

  final CustomUI_Stack _self;
  final $Res Function(CustomUI_Stack) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? children = null,
    Object? alignment = freezed,
    Object? fit = freezed,
  }) {
    return _then(CustomUI_Stack(
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      alignment: freezed == alignment
          ? _self.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as Alignment?,
      fit: freezed == fit
          ? _self.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as StackFit?,
    ));
  }
}

/// @nodoc

class CustomUI_Divider extends CustomUI {
  const CustomUI_Divider() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CustomUI_Divider);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CustomUI.divider()';
  }
}

/// @nodoc

class CustomUI_ListTile extends CustomUI {
  const CustomUI_ListTile(
      {this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onClick,
      this.onLongClick})
      : super._();

  final CustomUI? leading;
  final CustomUI? title;
  final CustomUI? subtitle;
  final CustomUI? trailing;
  final Interaction? onClick;
  final Interaction? onLongClick;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_ListTileCopyWith<CustomUI_ListTile> get copyWith =>
      _$CustomUI_ListTileCopyWithImpl<CustomUI_ListTile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_ListTile &&
            (identical(other.leading, leading) || other.leading == leading) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.trailing, trailing) ||
                other.trailing == trailing) &&
            (identical(other.onClick, onClick) || other.onClick == onClick) &&
            (identical(other.onLongClick, onLongClick) ||
                other.onLongClick == onLongClick));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, leading, title, subtitle, trailing, onClick, onLongClick);

  @override
  String toString() {
    return 'CustomUI.listTile(leading: $leading, title: $title, subtitle: $subtitle, trailing: $trailing, onClick: $onClick, onLongClick: $onLongClick)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_ListTileCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_ListTileCopyWith(
          CustomUI_ListTile value, $Res Function(CustomUI_ListTile) _then) =
      _$CustomUI_ListTileCopyWithImpl;
  @useResult
  $Res call(
      {CustomUI? leading,
      CustomUI? title,
      CustomUI? subtitle,
      CustomUI? trailing,
      Interaction? onClick,
      Interaction? onLongClick});

  $CustomUICopyWith<$Res>? get leading;
  $CustomUICopyWith<$Res>? get title;
  $CustomUICopyWith<$Res>? get subtitle;
  $CustomUICopyWith<$Res>? get trailing;
  $InteractionCopyWith<$Res>? get onClick;
  $InteractionCopyWith<$Res>? get onLongClick;
}

/// @nodoc
class _$CustomUI_ListTileCopyWithImpl<$Res>
    implements $CustomUI_ListTileCopyWith<$Res> {
  _$CustomUI_ListTileCopyWithImpl(this._self, this._then);

  final CustomUI_ListTile _self;
  final $Res Function(CustomUI_ListTile) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? leading = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? trailing = freezed,
    Object? onClick = freezed,
    Object? onLongClick = freezed,
  }) {
    return _then(CustomUI_ListTile(
      leading: freezed == leading
          ? _self.leading
          : leading // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      trailing: freezed == trailing
          ? _self.trailing
          : trailing // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      onClick: freezed == onClick
          ? _self.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as Interaction?,
      onLongClick: freezed == onLongClick
          ? _self.onLongClick
          : onLongClick // ignore: cast_nullable_to_non_nullable
              as Interaction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get leading {
    if (_self.leading == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_self.leading!, (value) {
      return _then(_self.copyWith(leading: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get title {
    if (_self.title == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_self.title!, (value) {
      return _then(_self.copyWith(title: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get subtitle {
    if (_self.subtitle == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_self.subtitle!, (value) {
      return _then(_self.copyWith(subtitle: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get trailing {
    if (_self.trailing == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_self.trailing!, (value) {
      return _then(_self.copyWith(trailing: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onClick {
    if (_self.onClick == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onClick!, (value) {
      return _then(_self.copyWith(onClick: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onLongClick {
    if (_self.onLongClick == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onLongClick!, (value) {
      return _then(_self.copyWith(onLongClick: value));
    });
  }
}

/// @nodoc

class CustomUI_Badge extends CustomUI {
  const CustomUI_Badge({required this.child, this.color}) : super._();

  final CustomUI child;
  final ColorToken? color;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_BadgeCopyWith<CustomUI_Badge> get copyWith =>
      _$CustomUI_BadgeCopyWithImpl<CustomUI_Badge>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Badge &&
            (identical(other.child, child) || other.child == child) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, child, color);

  @override
  String toString() {
    return 'CustomUI.badge(child: $child, color: $color)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_BadgeCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_BadgeCopyWith(
          CustomUI_Badge value, $Res Function(CustomUI_Badge) _then) =
      _$CustomUI_BadgeCopyWithImpl;
  @useResult
  $Res call({CustomUI child, ColorToken? color});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class _$CustomUI_BadgeCopyWithImpl<$Res>
    implements $CustomUI_BadgeCopyWith<$Res> {
  _$CustomUI_BadgeCopyWithImpl(this._self, this._then);

  final CustomUI_Badge _self;
  final $Res Function(CustomUI_Badge) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? child = null,
    Object? color = freezed,
  }) {
    return _then(CustomUI_Badge(
      child: null == child
          ? _self.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as ColorToken?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_self.child, (value) {
      return _then(_self.copyWith(child: value));
    });
  }
}

/// @nodoc

class CustomUI_FoldableText extends CustomUI {
  const CustomUI_FoldableText(
      {required this.text,
      required this.maxLines,
      this.style,
      required this.animate})
      : super._();

  final String text;
  final int maxLines;
  final TextStyle? style;
  final bool animate;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_FoldableTextCopyWith<CustomUI_FoldableText> get copyWith =>
      _$CustomUI_FoldableTextCopyWithImpl<CustomUI_FoldableText>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_FoldableText &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.animate, animate) || other.animate == animate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, maxLines, style, animate);

  @override
  String toString() {
    return 'CustomUI.foldableText(text: $text, maxLines: $maxLines, style: $style, animate: $animate)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_FoldableTextCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_FoldableTextCopyWith(CustomUI_FoldableText value,
          $Res Function(CustomUI_FoldableText) _then) =
      _$CustomUI_FoldableTextCopyWithImpl;
  @useResult
  $Res call({String text, int maxLines, TextStyle? style, bool animate});
}

/// @nodoc
class _$CustomUI_FoldableTextCopyWithImpl<$Res>
    implements $CustomUI_FoldableTextCopyWith<$Res> {
  _$CustomUI_FoldableTextCopyWithImpl(this._self, this._then);

  final CustomUI_FoldableText _self;
  final $Res Function(CustomUI_FoldableText) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? maxLines = null,
    Object? style = freezed,
    Object? animate = null,
  }) {
    return _then(CustomUI_FoldableText(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      maxLines: null == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyle?,
      animate: null == animate
          ? _self.animate
          : animate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class CustomUI_StarDisplay extends CustomUI {
  const CustomUI_StarDisplay({required this.fill, required this.maxStars})
      : super._();

  final double fill;
  final int maxStars;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_StarDisplayCopyWith<CustomUI_StarDisplay> get copyWith =>
      _$CustomUI_StarDisplayCopyWithImpl<CustomUI_StarDisplay>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_StarDisplay &&
            (identical(other.fill, fill) || other.fill == fill) &&
            (identical(other.maxStars, maxStars) ||
                other.maxStars == maxStars));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fill, maxStars);

  @override
  String toString() {
    return 'CustomUI.starDisplay(fill: $fill, maxStars: $maxStars)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_StarDisplayCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_StarDisplayCopyWith(CustomUI_StarDisplay value,
          $Res Function(CustomUI_StarDisplay) _then) =
      _$CustomUI_StarDisplayCopyWithImpl;
  @useResult
  $Res call({double fill, int maxStars});
}

/// @nodoc
class _$CustomUI_StarDisplayCopyWithImpl<$Res>
    implements $CustomUI_StarDisplayCopyWith<$Res> {
  _$CustomUI_StarDisplayCopyWithImpl(this._self, this._then);

  final CustomUI_StarDisplay _self;
  final $Res Function(CustomUI_StarDisplay) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fill = null,
    Object? maxStars = null,
  }) {
    return _then(CustomUI_StarDisplay(
      fill: null == fill
          ? _self.fill
          : fill // ignore: cast_nullable_to_non_nullable
              as double,
      maxStars: null == maxStars
          ? _self.maxStars
          : maxStars // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class CustomUI_Dropdown extends CustomUI {
  const CustomUI_Dropdown(
      {required final List<DropdownItem> items,
      this.initialValue,
      this.onChange})
      : _items = items,
        super._();

  final List<DropdownItem> _items;
  List<DropdownItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final String? initialValue;
  final Interaction? onChange;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomUI_DropdownCopyWith<CustomUI_Dropdown> get copyWith =>
      _$CustomUI_DropdownCopyWithImpl<CustomUI_Dropdown>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomUI_Dropdown &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.initialValue, initialValue) ||
                other.initialValue == initialValue) &&
            (identical(other.onChange, onChange) ||
                other.onChange == onChange));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), initialValue, onChange);

  @override
  String toString() {
    return 'CustomUI.dropdown(items: $items, initialValue: $initialValue, onChange: $onChange)';
  }
}

/// @nodoc
abstract mixin class $CustomUI_DropdownCopyWith<$Res>
    implements $CustomUICopyWith<$Res> {
  factory $CustomUI_DropdownCopyWith(
          CustomUI_Dropdown value, $Res Function(CustomUI_Dropdown) _then) =
      _$CustomUI_DropdownCopyWithImpl;
  @useResult
  $Res call(
      {List<DropdownItem> items, String? initialValue, Interaction? onChange});

  $InteractionCopyWith<$Res>? get onChange;
}

/// @nodoc
class _$CustomUI_DropdownCopyWithImpl<$Res>
    implements $CustomUI_DropdownCopyWith<$Res> {
  _$CustomUI_DropdownCopyWithImpl(this._self, this._then);

  final CustomUI_Dropdown _self;
  final $Res Function(CustomUI_Dropdown) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? initialValue = freezed,
    Object? onChange = freezed,
  }) {
    return _then(CustomUI_Dropdown(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<DropdownItem>,
      initialValue: freezed == initialValue
          ? _self.initialValue
          : initialValue // ignore: cast_nullable_to_non_nullable
              as String?,
      onChange: freezed == onChange
          ? _self.onChange
          : onChange // ignore: cast_nullable_to_non_nullable
              as Interaction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InteractionCopyWith<$Res>? get onChange {
    if (_self.onChange == null) {
      return null;
    }

    return $InteractionCopyWith<$Res>(_self.onChange!, (value) {
      return _then(_self.copyWith(onChange: value));
    });
  }
}

/// @nodoc
mixin _$SubscriptionSource {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SubscriptionSource);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SubscriptionSource()';
  }
}

/// @nodoc
class $SubscriptionSourceCopyWith<$Res> {
  $SubscriptionSourceCopyWith(
      SubscriptionSource _, $Res Function(SubscriptionSource) __);
}

/// Adds pattern-matching-related methods to [SubscriptionSource].
extension SubscriptionSourcePatterns on SubscriptionSource {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionSource_Store value)? store,
    TResult Function(SubscriptionSource_Setting value)? setting,
    TResult Function(SubscriptionSource_EntrySetting value)? entrySetting,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SubscriptionSource_Store() when store != null:
        return store(_that);
      case SubscriptionSource_Setting() when setting != null:
        return setting(_that);
      case SubscriptionSource_EntrySetting() when entrySetting != null:
        return entrySetting(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionSource_Store value) store,
    required TResult Function(SubscriptionSource_Setting value) setting,
    required TResult Function(SubscriptionSource_EntrySetting value)
        entrySetting,
  }) {
    final _that = this;
    switch (_that) {
      case SubscriptionSource_Store():
        return store(_that);
      case SubscriptionSource_Setting():
        return setting(_that);
      case SubscriptionSource_EntrySetting():
        return entrySetting(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubscriptionSource_Store value)? store,
    TResult? Function(SubscriptionSource_Setting value)? setting,
    TResult? Function(SubscriptionSource_EntrySetting value)? entrySetting,
  }) {
    final _that = this;
    switch (_that) {
      case SubscriptionSource_Store() when store != null:
        return store(_that);
      case SubscriptionSource_Setting() when setting != null:
        return setting(_that);
      case SubscriptionSource_EntrySetting() when entrySetting != null:
        return entrySetting(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? store,
    TResult Function(SettingKind kind)? setting,
    TResult Function()? entrySetting,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SubscriptionSource_Store() when store != null:
        return store();
      case SubscriptionSource_Setting() when setting != null:
        return setting(_that.kind);
      case SubscriptionSource_EntrySetting() when entrySetting != null:
        return entrySetting();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() store,
    required TResult Function(SettingKind kind) setting,
    required TResult Function() entrySetting,
  }) {
    final _that = this;
    switch (_that) {
      case SubscriptionSource_Store():
        return store();
      case SubscriptionSource_Setting():
        return setting(_that.kind);
      case SubscriptionSource_EntrySetting():
        return entrySetting();
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? store,
    TResult? Function(SettingKind kind)? setting,
    TResult? Function()? entrySetting,
  }) {
    final _that = this;
    switch (_that) {
      case SubscriptionSource_Store() when store != null:
        return store();
      case SubscriptionSource_Setting() when setting != null:
        return setting(_that.kind);
      case SubscriptionSource_EntrySetting() when entrySetting != null:
        return entrySetting();
      case _:
        return null;
    }
  }
}

/// @nodoc

class SubscriptionSource_Store extends SubscriptionSource {
  const SubscriptionSource_Store() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SubscriptionSource_Store);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SubscriptionSource.store()';
  }
}

/// @nodoc

class SubscriptionSource_Setting extends SubscriptionSource {
  const SubscriptionSource_Setting({required this.kind}) : super._();

  final SettingKind kind;

  /// Create a copy of SubscriptionSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubscriptionSource_SettingCopyWith<SubscriptionSource_Setting>
      get copyWith =>
          _$SubscriptionSource_SettingCopyWithImpl<SubscriptionSource_Setting>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubscriptionSource_Setting &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @override
  int get hashCode => Object.hash(runtimeType, kind);

  @override
  String toString() {
    return 'SubscriptionSource.setting(kind: $kind)';
  }
}

/// @nodoc
abstract mixin class $SubscriptionSource_SettingCopyWith<$Res>
    implements $SubscriptionSourceCopyWith<$Res> {
  factory $SubscriptionSource_SettingCopyWith(SubscriptionSource_Setting value,
          $Res Function(SubscriptionSource_Setting) _then) =
      _$SubscriptionSource_SettingCopyWithImpl;
  @useResult
  $Res call({SettingKind kind});
}

/// @nodoc
class _$SubscriptionSource_SettingCopyWithImpl<$Res>
    implements $SubscriptionSource_SettingCopyWith<$Res> {
  _$SubscriptionSource_SettingCopyWithImpl(this._self, this._then);

  final SubscriptionSource_Setting _self;
  final $Res Function(SubscriptionSource_Setting) _then;

  /// Create a copy of SubscriptionSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? kind = null,
  }) {
    return _then(SubscriptionSource_Setting(
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as SettingKind,
    ));
  }
}

/// @nodoc

class SubscriptionSource_EntrySetting extends SubscriptionSource {
  const SubscriptionSource_EntrySetting() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubscriptionSource_EntrySetting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SubscriptionSource.entrySetting()';
  }
}

// dart format on
