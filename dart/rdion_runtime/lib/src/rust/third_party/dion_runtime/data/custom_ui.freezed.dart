// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_ui.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomUI {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomUICopyWith<$Res> {
  factory $CustomUICopyWith(CustomUI value, $Res Function(CustomUI) then) =
      _$CustomUICopyWithImpl<$Res, CustomUI>;
}

/// @nodoc
class _$CustomUICopyWithImpl<$Res, $Val extends CustomUI>
    implements $CustomUICopyWith<$Res> {
  _$CustomUICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CustomUI_TextImplCopyWith<$Res> {
  factory _$$CustomUI_TextImplCopyWith(
          _$CustomUI_TextImpl value, $Res Function(_$CustomUI_TextImpl) then) =
      __$$CustomUI_TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$CustomUI_TextImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_TextImpl>
    implements _$$CustomUI_TextImplCopyWith<$Res> {
  __$$CustomUI_TextImplCopyWithImpl(
      _$CustomUI_TextImpl _value, $Res Function(_$CustomUI_TextImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$CustomUI_TextImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CustomUI_TextImpl extends CustomUI_Text {
  const _$CustomUI_TextImpl({required this.text}) : super._();

  @override
  final String text;

  @override
  String toString() {
    return 'CustomUI.text(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_TextImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_TextImplCopyWith<_$CustomUI_TextImpl> get copyWith =>
      __$$CustomUI_TextImplCopyWithImpl<_$CustomUI_TextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return text(this.text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return text?.call(this.text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this.text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Text extends CustomUI {
  const factory CustomUI_Text({required final String text}) =
      _$CustomUI_TextImpl;
  const CustomUI_Text._() : super._();

  String get text;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_TextImplCopyWith<_$CustomUI_TextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_ImageImplCopyWith<$Res> {
  factory _$$CustomUI_ImageImplCopyWith(_$CustomUI_ImageImpl value,
          $Res Function(_$CustomUI_ImageImpl) then) =
      __$$CustomUI_ImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Link image, int? width, int? height});
}

/// @nodoc
class __$$CustomUI_ImageImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_ImageImpl>
    implements _$$CustomUI_ImageImplCopyWith<$Res> {
  __$$CustomUI_ImageImplCopyWithImpl(
      _$CustomUI_ImageImpl _value, $Res Function(_$CustomUI_ImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$CustomUI_ImageImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Link,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CustomUI_ImageImpl extends CustomUI_Image {
  const _$CustomUI_ImageImpl({required this.image, this.width, this.height})
      : super._();

  @override
  final Link image;
  @override
  final int? width;
  @override
  final int? height;

  @override
  String toString() {
    return 'CustomUI.image(image: $image, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ImageImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, width, height);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_ImageImplCopyWith<_$CustomUI_ImageImpl> get copyWith =>
      __$$CustomUI_ImageImplCopyWithImpl<_$CustomUI_ImageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return image(this.image, width, height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return image?.call(this.image, width, height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this.image, width, height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Image extends CustomUI {
  const factory CustomUI_Image(
      {required final Link image,
      final int? width,
      final int? height}) = _$CustomUI_ImageImpl;
  const CustomUI_Image._() : super._();

  Link get image;
  int? get width;
  int? get height;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_ImageImplCopyWith<_$CustomUI_ImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_LinkImplCopyWith<$Res> {
  factory _$$CustomUI_LinkImplCopyWith(
          _$CustomUI_LinkImpl value, $Res Function(_$CustomUI_LinkImpl) then) =
      __$$CustomUI_LinkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link, String? label});
}

/// @nodoc
class __$$CustomUI_LinkImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_LinkImpl>
    implements _$$CustomUI_LinkImplCopyWith<$Res> {
  __$$CustomUI_LinkImplCopyWithImpl(
      _$CustomUI_LinkImpl _value, $Res Function(_$CustomUI_LinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? label = freezed,
  }) {
    return _then(_$CustomUI_LinkImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CustomUI_LinkImpl extends CustomUI_Link {
  const _$CustomUI_LinkImpl({required this.link, this.label}) : super._();

  @override
  final String link;
  @override
  final String? label;

  @override
  String toString() {
    return 'CustomUI.link(link: $link, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_LinkImpl &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link, label);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_LinkImplCopyWith<_$CustomUI_LinkImpl> get copyWith =>
      __$$CustomUI_LinkImplCopyWithImpl<_$CustomUI_LinkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return link(this.link, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return link?.call(this.link, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (link != null) {
      return link(this.link, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return link(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return link?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (link != null) {
      return link(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Link extends CustomUI {
  const factory CustomUI_Link(
      {required final String link, final String? label}) = _$CustomUI_LinkImpl;
  const CustomUI_Link._() : super._();

  String get link;
  String? get label;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_LinkImplCopyWith<_$CustomUI_LinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_TimeStampImplCopyWith<$Res> {
  factory _$$CustomUI_TimeStampImplCopyWith(_$CustomUI_TimeStampImpl value,
          $Res Function(_$CustomUI_TimeStampImpl) then) =
      __$$CustomUI_TimeStampImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String timestamp, TimestampType display});
}

/// @nodoc
class __$$CustomUI_TimeStampImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_TimeStampImpl>
    implements _$$CustomUI_TimeStampImplCopyWith<$Res> {
  __$$CustomUI_TimeStampImplCopyWithImpl(_$CustomUI_TimeStampImpl _value,
      $Res Function(_$CustomUI_TimeStampImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? display = null,
  }) {
    return _then(_$CustomUI_TimeStampImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as TimestampType,
    ));
  }
}

/// @nodoc

class _$CustomUI_TimeStampImpl extends CustomUI_TimeStamp {
  const _$CustomUI_TimeStampImpl(
      {required this.timestamp, required this.display})
      : super._();

  @override
  final String timestamp;
  @override
  final TimestampType display;

  @override
  String toString() {
    return 'CustomUI.timeStamp(timestamp: $timestamp, display: $display)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_TimeStampImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.display, display) || other.display == display));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, display);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_TimeStampImplCopyWith<_$CustomUI_TimeStampImpl> get copyWith =>
      __$$CustomUI_TimeStampImplCopyWithImpl<_$CustomUI_TimeStampImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return timeStamp(timestamp, display);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return timeStamp?.call(timestamp, display);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (timeStamp != null) {
      return timeStamp(timestamp, display);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return timeStamp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return timeStamp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (timeStamp != null) {
      return timeStamp(this);
    }
    return orElse();
  }
}

abstract class CustomUI_TimeStamp extends CustomUI {
  const factory CustomUI_TimeStamp(
      {required final String timestamp,
      required final TimestampType display}) = _$CustomUI_TimeStampImpl;
  const CustomUI_TimeStamp._() : super._();

  String get timestamp;
  TimestampType get display;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_TimeStampImplCopyWith<_$CustomUI_TimeStampImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_EntryCardImplCopyWith<$Res> {
  factory _$$CustomUI_EntryCardImplCopyWith(_$CustomUI_EntryCardImpl value,
          $Res Function(_$CustomUI_EntryCardImpl) then) =
      __$$CustomUI_EntryCardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Entry entry});
}

/// @nodoc
class __$$CustomUI_EntryCardImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_EntryCardImpl>
    implements _$$CustomUI_EntryCardImplCopyWith<$Res> {
  __$$CustomUI_EntryCardImplCopyWithImpl(_$CustomUI_EntryCardImpl _value,
      $Res Function(_$CustomUI_EntryCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
  }) {
    return _then(_$CustomUI_EntryCardImpl(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as Entry,
    ));
  }
}

/// @nodoc

class _$CustomUI_EntryCardImpl extends CustomUI_EntryCard {
  const _$CustomUI_EntryCardImpl({required this.entry}) : super._();

  @override
  final Entry entry;

  @override
  String toString() {
    return 'CustomUI.entryCard(entry: $entry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_EntryCardImpl &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_EntryCardImplCopyWith<_$CustomUI_EntryCardImpl> get copyWith =>
      __$$CustomUI_EntryCardImplCopyWithImpl<_$CustomUI_EntryCardImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return entryCard(entry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return entryCard?.call(entry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (entryCard != null) {
      return entryCard(entry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return entryCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return entryCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (entryCard != null) {
      return entryCard(this);
    }
    return orElse();
  }
}

abstract class CustomUI_EntryCard extends CustomUI {
  const factory CustomUI_EntryCard({required final Entry entry}) =
      _$CustomUI_EntryCardImpl;
  const CustomUI_EntryCard._() : super._();

  Entry get entry;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_EntryCardImplCopyWith<_$CustomUI_EntryCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_CardImplCopyWith<$Res> {
  factory _$$CustomUI_CardImplCopyWith(
          _$CustomUI_CardImpl value, $Res Function(_$CustomUI_CardImpl) then) =
      __$$CustomUI_CardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Link image, CustomUI top, CustomUI bottom});

  $CustomUICopyWith<$Res> get top;
  $CustomUICopyWith<$Res> get bottom;
}

/// @nodoc
class __$$CustomUI_CardImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_CardImpl>
    implements _$$CustomUI_CardImplCopyWith<$Res> {
  __$$CustomUI_CardImplCopyWithImpl(
      _$CustomUI_CardImpl _value, $Res Function(_$CustomUI_CardImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? top = null,
    Object? bottom = null,
  }) {
    return _then(_$CustomUI_CardImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Link,
      top: null == top
          ? _value.top
          : top // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      bottom: null == bottom
          ? _value.bottom
          : bottom // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get top {
    return $CustomUICopyWith<$Res>(_value.top, (value) {
      return _then(_value.copyWith(top: value));
    });
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get bottom {
    return $CustomUICopyWith<$Res>(_value.bottom, (value) {
      return _then(_value.copyWith(bottom: value));
    });
  }
}

/// @nodoc

class _$CustomUI_CardImpl extends CustomUI_Card {
  const _$CustomUI_CardImpl(
      {required this.image, required this.top, required this.bottom})
      : super._();

  @override
  final Link image;
  @override
  final CustomUI top;
  @override
  final CustomUI bottom;

  @override
  String toString() {
    return 'CustomUI.card(image: $image, top: $top, bottom: $bottom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_CardImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.top, top) || other.top == top) &&
            (identical(other.bottom, bottom) || other.bottom == bottom));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, top, bottom);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_CardImplCopyWith<_$CustomUI_CardImpl> get copyWith =>
      __$$CustomUI_CardImplCopyWithImpl<_$CustomUI_CardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return card(this.image, top, bottom);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return card?.call(this.image, top, bottom);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (card != null) {
      return card(this.image, top, bottom);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return card(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return card?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (card != null) {
      return card(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Card extends CustomUI {
  const factory CustomUI_Card(
      {required final Link image,
      required final CustomUI top,
      required final CustomUI bottom}) = _$CustomUI_CardImpl;
  const CustomUI_Card._() : super._();

  Link get image;
  CustomUI get top;
  CustomUI get bottom;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_CardImplCopyWith<_$CustomUI_CardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_FeedImplCopyWith<$Res> {
  factory _$$CustomUI_FeedImplCopyWith(
          _$CustomUI_FeedImpl value, $Res Function(_$CustomUI_FeedImpl) then) =
      __$$CustomUI_FeedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String event, String data});
}

/// @nodoc
class __$$CustomUI_FeedImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_FeedImpl>
    implements _$$CustomUI_FeedImplCopyWith<$Res> {
  __$$CustomUI_FeedImplCopyWithImpl(
      _$CustomUI_FeedImpl _value, $Res Function(_$CustomUI_FeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_$CustomUI_FeedImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CustomUI_FeedImpl extends CustomUI_Feed {
  const _$CustomUI_FeedImpl({required this.event, required this.data})
      : super._();

  @override
  final String event;
  @override
  final String data;

  @override
  String toString() {
    return 'CustomUI.feed(event: $event, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_FeedImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event, data);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_FeedImplCopyWith<_$CustomUI_FeedImpl> get copyWith =>
      __$$CustomUI_FeedImplCopyWithImpl<_$CustomUI_FeedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return feed(event, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return feed?.call(event, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (feed != null) {
      return feed(event, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return feed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return feed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (feed != null) {
      return feed(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Feed extends CustomUI {
  const factory CustomUI_Feed(
      {required final String event,
      required final String data}) = _$CustomUI_FeedImpl;
  const CustomUI_Feed._() : super._();

  String get event;
  String get data;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_FeedImplCopyWith<_$CustomUI_FeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_ButtonImplCopyWith<$Res> {
  factory _$$CustomUI_ButtonImplCopyWith(_$CustomUI_ButtonImpl value,
          $Res Function(_$CustomUI_ButtonImpl) then) =
      __$$CustomUI_ButtonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String label, UIAction? onClick});

  $UIActionCopyWith<$Res>? get onClick;
}

/// @nodoc
class __$$CustomUI_ButtonImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_ButtonImpl>
    implements _$$CustomUI_ButtonImplCopyWith<$Res> {
  __$$CustomUI_ButtonImplCopyWithImpl(
      _$CustomUI_ButtonImpl _value, $Res Function(_$CustomUI_ButtonImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? onClick = freezed,
  }) {
    return _then(_$CustomUI_ButtonImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onClick: freezed == onClick
          ? _value.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as UIAction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UIActionCopyWith<$Res>? get onClick {
    if (_value.onClick == null) {
      return null;
    }

    return $UIActionCopyWith<$Res>(_value.onClick!, (value) {
      return _then(_value.copyWith(onClick: value));
    });
  }
}

/// @nodoc

class _$CustomUI_ButtonImpl extends CustomUI_Button {
  const _$CustomUI_ButtonImpl({required this.label, this.onClick}) : super._();

  @override
  final String label;
  @override
  final UIAction? onClick;

  @override
  String toString() {
    return 'CustomUI.button(label: $label, onClick: $onClick)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ButtonImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onClick, onClick) || other.onClick == onClick));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, onClick);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_ButtonImplCopyWith<_$CustomUI_ButtonImpl> get copyWith =>
      __$$CustomUI_ButtonImplCopyWithImpl<_$CustomUI_ButtonImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return button(label, onClick);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return button?.call(label, onClick);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (button != null) {
      return button(label, onClick);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return button(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return button?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (button != null) {
      return button(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Button extends CustomUI {
  const factory CustomUI_Button(
      {required final String label,
      final UIAction? onClick}) = _$CustomUI_ButtonImpl;
  const CustomUI_Button._() : super._();

  String get label;
  UIAction? get onClick;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_ButtonImplCopyWith<_$CustomUI_ButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_InlineSettingImplCopyWith<$Res> {
  factory _$$CustomUI_InlineSettingImplCopyWith(
          _$CustomUI_InlineSettingImpl value,
          $Res Function(_$CustomUI_InlineSettingImpl) then) =
      __$$CustomUI_InlineSettingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String settingId, SettingKind settingKind, UIAction? onCommit});

  $UIActionCopyWith<$Res>? get onCommit;
}

/// @nodoc
class __$$CustomUI_InlineSettingImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_InlineSettingImpl>
    implements _$$CustomUI_InlineSettingImplCopyWith<$Res> {
  __$$CustomUI_InlineSettingImplCopyWithImpl(
      _$CustomUI_InlineSettingImpl _value,
      $Res Function(_$CustomUI_InlineSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settingId = null,
    Object? settingKind = null,
    Object? onCommit = freezed,
  }) {
    return _then(_$CustomUI_InlineSettingImpl(
      settingId: null == settingId
          ? _value.settingId
          : settingId // ignore: cast_nullable_to_non_nullable
              as String,
      settingKind: null == settingKind
          ? _value.settingKind
          : settingKind // ignore: cast_nullable_to_non_nullable
              as SettingKind,
      onCommit: freezed == onCommit
          ? _value.onCommit
          : onCommit // ignore: cast_nullable_to_non_nullable
              as UIAction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UIActionCopyWith<$Res>? get onCommit {
    if (_value.onCommit == null) {
      return null;
    }

    return $UIActionCopyWith<$Res>(_value.onCommit!, (value) {
      return _then(_value.copyWith(onCommit: value));
    });
  }
}

/// @nodoc

class _$CustomUI_InlineSettingImpl extends CustomUI_InlineSetting {
  const _$CustomUI_InlineSettingImpl(
      {required this.settingId, required this.settingKind, this.onCommit})
      : super._();

  @override
  final String settingId;
  @override
  final SettingKind settingKind;
  @override
  final UIAction? onCommit;

  @override
  String toString() {
    return 'CustomUI.inlineSetting(settingId: $settingId, settingKind: $settingKind, onCommit: $onCommit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_InlineSettingImpl &&
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

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_InlineSettingImplCopyWith<_$CustomUI_InlineSettingImpl>
      get copyWith => __$$CustomUI_InlineSettingImplCopyWithImpl<
          _$CustomUI_InlineSettingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return inlineSetting(settingId, settingKind, onCommit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return inlineSetting?.call(settingId, settingKind, onCommit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (inlineSetting != null) {
      return inlineSetting(settingId, settingKind, onCommit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return inlineSetting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return inlineSetting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (inlineSetting != null) {
      return inlineSetting(this);
    }
    return orElse();
  }
}

abstract class CustomUI_InlineSetting extends CustomUI {
  const factory CustomUI_InlineSetting(
      {required final String settingId,
      required final SettingKind settingKind,
      final UIAction? onCommit}) = _$CustomUI_InlineSettingImpl;
  const CustomUI_InlineSetting._() : super._();

  String get settingId;
  SettingKind get settingKind;
  UIAction? get onCommit;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_InlineSettingImplCopyWith<_$CustomUI_InlineSettingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_SlotImplCopyWith<$Res> {
  factory _$$CustomUI_SlotImplCopyWith(
          _$CustomUI_SlotImpl value, $Res Function(_$CustomUI_SlotImpl) then) =
      __$$CustomUI_SlotImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, CustomUI child});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class __$$CustomUI_SlotImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_SlotImpl>
    implements _$$CustomUI_SlotImplCopyWith<$Res> {
  __$$CustomUI_SlotImplCopyWithImpl(
      _$CustomUI_SlotImpl _value, $Res Function(_$CustomUI_SlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? child = null,
  }) {
    return _then(_$CustomUI_SlotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_value.child, (value) {
      return _then(_value.copyWith(child: value));
    });
  }
}

/// @nodoc

class _$CustomUI_SlotImpl extends CustomUI_Slot {
  const _$CustomUI_SlotImpl({required this.id, required this.child})
      : super._();

  @override
  final String id;
  @override
  final CustomUI child;

  @override
  String toString() {
    return 'CustomUI.slot(id: $id, child: $child)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_SlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.child, child) || other.child == child));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, child);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_SlotImplCopyWith<_$CustomUI_SlotImpl> get copyWith =>
      __$$CustomUI_SlotImplCopyWithImpl<_$CustomUI_SlotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return slot(id, child);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return slot?.call(id, child);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (slot != null) {
      return slot(id, child);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return slot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return slot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (slot != null) {
      return slot(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Slot extends CustomUI {
  const factory CustomUI_Slot(
      {required final String id,
      required final CustomUI child}) = _$CustomUI_SlotImpl;
  const CustomUI_Slot._() : super._();

  String get id;
  CustomUI get child;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_SlotImplCopyWith<_$CustomUI_SlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_ColumnImplCopyWith<$Res> {
  factory _$$CustomUI_ColumnImplCopyWith(_$CustomUI_ColumnImpl value,
          $Res Function(_$CustomUI_ColumnImpl) then) =
      __$$CustomUI_ColumnImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomUI> children});
}

/// @nodoc
class __$$CustomUI_ColumnImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_ColumnImpl>
    implements _$$CustomUI_ColumnImplCopyWith<$Res> {
  __$$CustomUI_ColumnImplCopyWithImpl(
      _$CustomUI_ColumnImpl _value, $Res Function(_$CustomUI_ColumnImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? children = null,
  }) {
    return _then(_$CustomUI_ColumnImpl(
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
    ));
  }
}

/// @nodoc

class _$CustomUI_ColumnImpl extends CustomUI_Column {
  const _$CustomUI_ColumnImpl({required final List<CustomUI> children})
      : _children = children,
        super._();

  final List<CustomUI> _children;
  @override
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'CustomUI.column(children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ColumnImpl &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_ColumnImplCopyWith<_$CustomUI_ColumnImpl> get copyWith =>
      __$$CustomUI_ColumnImplCopyWithImpl<_$CustomUI_ColumnImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return column(children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return column?.call(children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (column != null) {
      return column(children);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return column(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return column?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (column != null) {
      return column(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Column extends CustomUI {
  const factory CustomUI_Column({required final List<CustomUI> children}) =
      _$CustomUI_ColumnImpl;
  const CustomUI_Column._() : super._();

  List<CustomUI> get children;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_ColumnImplCopyWith<_$CustomUI_ColumnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_RowImplCopyWith<$Res> {
  factory _$$CustomUI_RowImplCopyWith(
          _$CustomUI_RowImpl value, $Res Function(_$CustomUI_RowImpl) then) =
      __$$CustomUI_RowImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomUI> children});
}

/// @nodoc
class __$$CustomUI_RowImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_RowImpl>
    implements _$$CustomUI_RowImplCopyWith<$Res> {
  __$$CustomUI_RowImplCopyWithImpl(
      _$CustomUI_RowImpl _value, $Res Function(_$CustomUI_RowImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? children = null,
  }) {
    return _then(_$CustomUI_RowImpl(
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
    ));
  }
}

/// @nodoc

class _$CustomUI_RowImpl extends CustomUI_Row {
  const _$CustomUI_RowImpl({required final List<CustomUI> children})
      : _children = children,
        super._();

  final List<CustomUI> _children;
  @override
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'CustomUI.row(children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_RowImpl &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_RowImplCopyWith<_$CustomUI_RowImpl> get copyWith =>
      __$$CustomUI_RowImplCopyWithImpl<_$CustomUI_RowImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(Link image, CustomUI top, CustomUI bottom) card,
    required TResult Function(String event, String data) feed,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return row(children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult? Function(String event, String data)? feed,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return row?.call(children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(Link image, CustomUI top, CustomUI bottom)? card,
    TResult Function(String event, String data)? feed,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(
            String settingId, SettingKind settingKind, UIAction? onCommit)?
        inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (row != null) {
      return row(children);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Card value) card,
    required TResult Function(CustomUI_Feed value) feed,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return row(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Card value)? card,
    TResult? Function(CustomUI_Feed value)? feed,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return row?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Card value)? card,
    TResult Function(CustomUI_Feed value)? feed,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (row != null) {
      return row(this);
    }
    return orElse();
  }
}

abstract class CustomUI_Row extends CustomUI {
  const factory CustomUI_Row({required final List<CustomUI> children}) =
      _$CustomUI_RowImpl;
  const CustomUI_Row._() : super._();

  List<CustomUI> get children;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_RowImplCopyWith<_$CustomUI_RowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
