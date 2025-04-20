// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datastructs.dart';

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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return text(this.text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return text?.call(this.text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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
  $Res call({String image, Map<String, String>? header});
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
    Object? header = freezed,
  }) {
    return _then(_$CustomUI_ImageImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      header: freezed == header
          ? _value._header
          : header // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc

class _$CustomUI_ImageImpl extends CustomUI_Image {
  const _$CustomUI_ImageImpl(
      {required this.image, final Map<String, String>? header})
      : _header = header,
        super._();

  @override
  final String image;
  final Map<String, String>? _header;
  @override
  Map<String, String>? get header {
    final value = _header;
    if (value == null) return null;
    if (_header is EqualUnmodifiableMapView) return _header;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CustomUI.image(image: $image, header: $header)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ImageImpl &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._header, _header));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, image, const DeepCollectionEquality().hash(_header));

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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return image(this.image, header);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return image?.call(this.image, header);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this.image, header);
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
      {required final String image,
      final Map<String, String>? header}) = _$CustomUI_ImageImpl;
  const CustomUI_Image._() : super._();

  String get image;
  Map<String, String>? get header;

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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return link(this.link, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return link?.call(this.link, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return timeStamp(timestamp, display);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return timeStamp?.call(timestamp, display);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return entryCard(entry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return entryCard?.call(entry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return column(children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return column?.call(children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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
    required TResult Function(String image, Map<String, String>? header) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return row(children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(String image, Map<String, String>? header)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return row?.call(children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(String image, Map<String, String>? header)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
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

/// @nodoc
mixin _$DataSource {
  List<String> get paragraphs => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> paragraphs) paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> paragraphs)? paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataSource_Paragraphlist value) paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataSource_Paragraphlist value)? paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSource_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataSourceCopyWith<DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceCopyWith<$Res> {
  factory $DataSourceCopyWith(
          DataSource value, $Res Function(DataSource) then) =
      _$DataSourceCopyWithImpl<$Res, DataSource>;
  @useResult
  $Res call({List<String> paragraphs});
}

/// @nodoc
class _$DataSourceCopyWithImpl<$Res, $Val extends DataSource>
    implements $DataSourceCopyWith<$Res> {
  _$DataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paragraphs = null,
  }) {
    return _then(_value.copyWith(
      paragraphs: null == paragraphs
          ? _value.paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataSource_ParagraphlistImplCopyWith<$Res>
    implements $DataSourceCopyWith<$Res> {
  factory _$$DataSource_ParagraphlistImplCopyWith(
          _$DataSource_ParagraphlistImpl value,
          $Res Function(_$DataSource_ParagraphlistImpl) then) =
      __$$DataSource_ParagraphlistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> paragraphs});
}

/// @nodoc
class __$$DataSource_ParagraphlistImplCopyWithImpl<$Res>
    extends _$DataSourceCopyWithImpl<$Res, _$DataSource_ParagraphlistImpl>
    implements _$$DataSource_ParagraphlistImplCopyWith<$Res> {
  __$$DataSource_ParagraphlistImplCopyWithImpl(
      _$DataSource_ParagraphlistImpl _value,
      $Res Function(_$DataSource_ParagraphlistImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paragraphs = null,
  }) {
    return _then(_$DataSource_ParagraphlistImpl(
      paragraphs: null == paragraphs
          ? _value._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$DataSource_ParagraphlistImpl extends DataSource_Paragraphlist {
  const _$DataSource_ParagraphlistImpl({required final List<String> paragraphs})
      : _paragraphs = paragraphs,
        super._();

  final List<String> _paragraphs;
  @override
  List<String> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

  @override
  String toString() {
    return 'DataSource.paragraphlist(paragraphs: $paragraphs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSource_ParagraphlistImpl &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_paragraphs));

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSource_ParagraphlistImplCopyWith<_$DataSource_ParagraphlistImpl>
      get copyWith => __$$DataSource_ParagraphlistImplCopyWithImpl<
          _$DataSource_ParagraphlistImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> paragraphs) paragraphlist,
  }) {
    return paragraphlist(paragraphs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> paragraphs)? paragraphlist,
  }) {
    return paragraphlist?.call(paragraphs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (paragraphlist != null) {
      return paragraphlist(paragraphs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataSource_Paragraphlist value) paragraphlist,
  }) {
    return paragraphlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataSource_Paragraphlist value)? paragraphlist,
  }) {
    return paragraphlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSource_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (paragraphlist != null) {
      return paragraphlist(this);
    }
    return orElse();
  }
}

abstract class DataSource_Paragraphlist extends DataSource {
  const factory DataSource_Paragraphlist(
          {required final List<String> paragraphs}) =
      _$DataSource_ParagraphlistImpl;
  const DataSource_Paragraphlist._() : super._();

  @override
  List<String> get paragraphs;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataSource_ParagraphlistImplCopyWith<_$DataSource_ParagraphlistImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LinkSource {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
    required TResult Function(LinkSource_Mp3 value) mp3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
    TResult? Function(LinkSource_Mp3 value)? mp3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    TResult Function(LinkSource_Mp3 value)? mp3,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkSourceCopyWith<$Res> {
  factory $LinkSourceCopyWith(
          LinkSource value, $Res Function(LinkSource) then) =
      _$LinkSourceCopyWithImpl<$Res, LinkSource>;
}

/// @nodoc
class _$LinkSourceCopyWithImpl<$Res, $Val extends LinkSource>
    implements $LinkSourceCopyWith<$Res> {
  _$LinkSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LinkSource_EpubImplCopyWith<$Res> {
  factory _$$LinkSource_EpubImplCopyWith(_$LinkSource_EpubImpl value,
          $Res Function(_$LinkSource_EpubImpl) then) =
      __$$LinkSource_EpubImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link});
}

/// @nodoc
class __$$LinkSource_EpubImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_EpubImpl>
    implements _$$LinkSource_EpubImplCopyWith<$Res> {
  __$$LinkSource_EpubImplCopyWithImpl(
      _$LinkSource_EpubImpl _value, $Res Function(_$LinkSource_EpubImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$LinkSource_EpubImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LinkSource_EpubImpl extends LinkSource_Epub {
  const _$LinkSource_EpubImpl({required this.link}) : super._();

  @override
  final String link;

  @override
  String toString() {
    return 'LinkSource.epub(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_EpubImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_EpubImplCopyWith<_$LinkSource_EpubImpl> get copyWith =>
      __$$LinkSource_EpubImplCopyWithImpl<_$LinkSource_EpubImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) {
    return epub(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) {
    return epub?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) {
    if (epub != null) {
      return epub(link);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
    required TResult Function(LinkSource_Mp3 value) mp3,
  }) {
    return epub(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
    TResult? Function(LinkSource_Mp3 value)? mp3,
  }) {
    return epub?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    TResult Function(LinkSource_Mp3 value)? mp3,
    required TResult orElse(),
  }) {
    if (epub != null) {
      return epub(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Epub extends LinkSource {
  const factory LinkSource_Epub({required final String link}) =
      _$LinkSource_EpubImpl;
  const LinkSource_Epub._() : super._();

  String get link;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_EpubImplCopyWith<_$LinkSource_EpubImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_PdfImplCopyWith<$Res> {
  factory _$$LinkSource_PdfImplCopyWith(_$LinkSource_PdfImpl value,
          $Res Function(_$LinkSource_PdfImpl) then) =
      __$$LinkSource_PdfImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link});
}

/// @nodoc
class __$$LinkSource_PdfImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_PdfImpl>
    implements _$$LinkSource_PdfImplCopyWith<$Res> {
  __$$LinkSource_PdfImplCopyWithImpl(
      _$LinkSource_PdfImpl _value, $Res Function(_$LinkSource_PdfImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$LinkSource_PdfImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LinkSource_PdfImpl extends LinkSource_Pdf {
  const _$LinkSource_PdfImpl({required this.link}) : super._();

  @override
  final String link;

  @override
  String toString() {
    return 'LinkSource.pdf(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_PdfImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_PdfImplCopyWith<_$LinkSource_PdfImpl> get copyWith =>
      __$$LinkSource_PdfImplCopyWithImpl<_$LinkSource_PdfImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) {
    return pdf(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) {
    return pdf?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) {
    if (pdf != null) {
      return pdf(link);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
    required TResult Function(LinkSource_Mp3 value) mp3,
  }) {
    return pdf(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
    TResult? Function(LinkSource_Mp3 value)? mp3,
  }) {
    return pdf?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    TResult Function(LinkSource_Mp3 value)? mp3,
    required TResult orElse(),
  }) {
    if (pdf != null) {
      return pdf(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Pdf extends LinkSource {
  const factory LinkSource_Pdf({required final String link}) =
      _$LinkSource_PdfImpl;
  const LinkSource_Pdf._() : super._();

  String get link;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_PdfImplCopyWith<_$LinkSource_PdfImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_ImagelistImplCopyWith<$Res> {
  factory _$$LinkSource_ImagelistImplCopyWith(_$LinkSource_ImagelistImpl value,
          $Res Function(_$LinkSource_ImagelistImpl) then) =
      __$$LinkSource_ImagelistImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<String> links,
      Map<String, String>? header,
      List<ImageListAudio>? audio});
}

/// @nodoc
class __$$LinkSource_ImagelistImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_ImagelistImpl>
    implements _$$LinkSource_ImagelistImplCopyWith<$Res> {
  __$$LinkSource_ImagelistImplCopyWithImpl(_$LinkSource_ImagelistImpl _value,
      $Res Function(_$LinkSource_ImagelistImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = null,
    Object? header = freezed,
    Object? audio = freezed,
  }) {
    return _then(_$LinkSource_ImagelistImpl(
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<String>,
      header: freezed == header
          ? _value._header
          : header // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      audio: freezed == audio
          ? _value._audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<ImageListAudio>?,
    ));
  }
}

/// @nodoc

class _$LinkSource_ImagelistImpl extends LinkSource_Imagelist {
  const _$LinkSource_ImagelistImpl(
      {required final List<String> links,
      final Map<String, String>? header,
      final List<ImageListAudio>? audio})
      : _links = links,
        _header = header,
        _audio = audio,
        super._();

  final List<String> _links;
  @override
  List<String> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final Map<String, String>? _header;
  @override
  Map<String, String>? get header {
    final value = _header;
    if (value == null) return null;
    if (_header is EqualUnmodifiableMapView) return _header;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<ImageListAudio>? _audio;
  @override
  List<ImageListAudio>? get audio {
    final value = _audio;
    if (value == null) return null;
    if (_audio is EqualUnmodifiableListView) return _audio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LinkSource.imagelist(links: $links, header: $header, audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_ImagelistImpl &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._header, _header) &&
            const DeepCollectionEquality().equals(other._audio, _audio));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_header),
      const DeepCollectionEquality().hash(_audio));

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_ImagelistImplCopyWith<_$LinkSource_ImagelistImpl>
      get copyWith =>
          __$$LinkSource_ImagelistImplCopyWithImpl<_$LinkSource_ImagelistImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) {
    return imagelist(links, header, audio);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) {
    return imagelist?.call(links, header, audio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) {
    if (imagelist != null) {
      return imagelist(links, header, audio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
    required TResult Function(LinkSource_Mp3 value) mp3,
  }) {
    return imagelist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
    TResult? Function(LinkSource_Mp3 value)? mp3,
  }) {
    return imagelist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    TResult Function(LinkSource_Mp3 value)? mp3,
    required TResult orElse(),
  }) {
    if (imagelist != null) {
      return imagelist(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Imagelist extends LinkSource {
  const factory LinkSource_Imagelist(
      {required final List<String> links,
      final Map<String, String>? header,
      final List<ImageListAudio>? audio}) = _$LinkSource_ImagelistImpl;
  const LinkSource_Imagelist._() : super._();

  List<String> get links;
  Map<String, String>? get header;
  List<ImageListAudio>? get audio;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_ImagelistImplCopyWith<_$LinkSource_ImagelistImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_M3u8ImplCopyWith<$Res> {
  factory _$$LinkSource_M3u8ImplCopyWith(_$LinkSource_M3u8Impl value,
          $Res Function(_$LinkSource_M3u8Impl) then) =
      __$$LinkSource_M3u8ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link, List<Subtitles> sub});
}

/// @nodoc
class __$$LinkSource_M3u8ImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_M3u8Impl>
    implements _$$LinkSource_M3u8ImplCopyWith<$Res> {
  __$$LinkSource_M3u8ImplCopyWithImpl(
      _$LinkSource_M3u8Impl _value, $Res Function(_$LinkSource_M3u8Impl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? sub = null,
  }) {
    return _then(_$LinkSource_M3u8Impl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      sub: null == sub
          ? _value._sub
          : sub // ignore: cast_nullable_to_non_nullable
              as List<Subtitles>,
    ));
  }
}

/// @nodoc

class _$LinkSource_M3u8Impl extends LinkSource_M3u8 {
  const _$LinkSource_M3u8Impl(
      {required this.link, required final List<Subtitles> sub})
      : _sub = sub,
        super._();

  @override
  final String link;
  final List<Subtitles> _sub;
  @override
  List<Subtitles> get sub {
    if (_sub is EqualUnmodifiableListView) return _sub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sub);
  }

  @override
  String toString() {
    return 'LinkSource.m3U8(link: $link, sub: $sub)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_M3u8Impl &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality().equals(other._sub, _sub));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, link, const DeepCollectionEquality().hash(_sub));

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_M3u8ImplCopyWith<_$LinkSource_M3u8Impl> get copyWith =>
      __$$LinkSource_M3u8ImplCopyWithImpl<_$LinkSource_M3u8Impl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) {
    return m3U8(link, sub);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) {
    return m3U8?.call(link, sub);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) {
    if (m3U8 != null) {
      return m3U8(link, sub);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
    required TResult Function(LinkSource_Mp3 value) mp3,
  }) {
    return m3U8(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
    TResult? Function(LinkSource_Mp3 value)? mp3,
  }) {
    return m3U8?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    TResult Function(LinkSource_Mp3 value)? mp3,
    required TResult orElse(),
  }) {
    if (m3U8 != null) {
      return m3U8(this);
    }
    return orElse();
  }
}

abstract class LinkSource_M3u8 extends LinkSource {
  const factory LinkSource_M3u8(
      {required final String link,
      required final List<Subtitles> sub}) = _$LinkSource_M3u8Impl;
  const LinkSource_M3u8._() : super._();

  String get link;
  List<Subtitles> get sub;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_M3u8ImplCopyWith<_$LinkSource_M3u8Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_Mp3ImplCopyWith<$Res> {
  factory _$$LinkSource_Mp3ImplCopyWith(_$LinkSource_Mp3Impl value,
          $Res Function(_$LinkSource_Mp3Impl) then) =
      __$$LinkSource_Mp3ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UrlChapter> chapters});
}

/// @nodoc
class __$$LinkSource_Mp3ImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_Mp3Impl>
    implements _$$LinkSource_Mp3ImplCopyWith<$Res> {
  __$$LinkSource_Mp3ImplCopyWithImpl(
      _$LinkSource_Mp3Impl _value, $Res Function(_$LinkSource_Mp3Impl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapters = null,
  }) {
    return _then(_$LinkSource_Mp3Impl(
      chapters: null == chapters
          ? _value._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<UrlChapter>,
    ));
  }
}

/// @nodoc

class _$LinkSource_Mp3Impl extends LinkSource_Mp3 {
  const _$LinkSource_Mp3Impl({required final List<UrlChapter> chapters})
      : _chapters = chapters,
        super._();

  final List<UrlChapter> _chapters;
  @override
  List<UrlChapter> get chapters {
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chapters);
  }

  @override
  String toString() {
    return 'LinkSource.mp3(chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_Mp3Impl &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_chapters));

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_Mp3ImplCopyWith<_$LinkSource_Mp3Impl> get copyWith =>
      __$$LinkSource_Mp3ImplCopyWithImpl<_$LinkSource_Mp3Impl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) {
    return mp3(chapters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) {
    return mp3?.call(chapters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) {
    if (mp3 != null) {
      return mp3(chapters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
    required TResult Function(LinkSource_Mp3 value) mp3,
  }) {
    return mp3(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
    TResult? Function(LinkSource_Mp3 value)? mp3,
  }) {
    return mp3?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    TResult Function(LinkSource_Mp3 value)? mp3,
    required TResult orElse(),
  }) {
    if (mp3 != null) {
      return mp3(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Mp3 extends LinkSource {
  const factory LinkSource_Mp3({required final List<UrlChapter> chapters}) =
      _$LinkSource_Mp3Impl;
  const LinkSource_Mp3._() : super._();

  List<UrlChapter> get chapters;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_Mp3ImplCopyWith<_$LinkSource_Mp3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Source {
  Object get sourcedata => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataSource sourcedata) data,
    required TResult Function(LinkSource sourcedata) directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataSource sourcedata)? data,
    TResult? Function(LinkSource sourcedata)? directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataSource sourcedata)? data,
    TResult Function(LinkSource sourcedata)? directlink,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Data value) data,
    required TResult Function(Source_Directlink value) directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Data value)? data,
    TResult? Function(Source_Directlink value)? directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Data value)? data,
    TResult Function(Source_Directlink value)? directlink,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceCopyWith<$Res> {
  factory $SourceCopyWith(Source value, $Res Function(Source) then) =
      _$SourceCopyWithImpl<$Res, Source>;
}

/// @nodoc
class _$SourceCopyWithImpl<$Res, $Val extends Source>
    implements $SourceCopyWith<$Res> {
  _$SourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Source_DataImplCopyWith<$Res> {
  factory _$$Source_DataImplCopyWith(
          _$Source_DataImpl value, $Res Function(_$Source_DataImpl) then) =
      __$$Source_DataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DataSource sourcedata});

  $DataSourceCopyWith<$Res> get sourcedata;
}

/// @nodoc
class __$$Source_DataImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_DataImpl>
    implements _$$Source_DataImplCopyWith<$Res> {
  __$$Source_DataImplCopyWithImpl(
      _$Source_DataImpl _value, $Res Function(_$Source_DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourcedata = null,
  }) {
    return _then(_$Source_DataImpl(
      sourcedata: null == sourcedata
          ? _value.sourcedata
          : sourcedata // ignore: cast_nullable_to_non_nullable
              as DataSource,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataSourceCopyWith<$Res> get sourcedata {
    return $DataSourceCopyWith<$Res>(_value.sourcedata, (value) {
      return _then(_value.copyWith(sourcedata: value));
    });
  }
}

/// @nodoc

class _$Source_DataImpl extends Source_Data {
  const _$Source_DataImpl({required this.sourcedata}) : super._();

  @override
  final DataSource sourcedata;

  @override
  String toString() {
    return 'Source.data(sourcedata: $sourcedata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_DataImpl &&
            (identical(other.sourcedata, sourcedata) ||
                other.sourcedata == sourcedata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourcedata);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_DataImplCopyWith<_$Source_DataImpl> get copyWith =>
      __$$Source_DataImplCopyWithImpl<_$Source_DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataSource sourcedata) data,
    required TResult Function(LinkSource sourcedata) directlink,
  }) {
    return data(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataSource sourcedata)? data,
    TResult? Function(LinkSource sourcedata)? directlink,
  }) {
    return data?.call(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataSource sourcedata)? data,
    TResult Function(LinkSource sourcedata)? directlink,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(sourcedata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Data value) data,
    required TResult Function(Source_Directlink value) directlink,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Data value)? data,
    TResult? Function(Source_Directlink value)? directlink,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Data value)? data,
    TResult Function(Source_Directlink value)? directlink,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class Source_Data extends Source {
  const factory Source_Data({required final DataSource sourcedata}) =
      _$Source_DataImpl;
  const Source_Data._() : super._();

  @override
  DataSource get sourcedata;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_DataImplCopyWith<_$Source_DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_DirectlinkImplCopyWith<$Res> {
  factory _$$Source_DirectlinkImplCopyWith(_$Source_DirectlinkImpl value,
          $Res Function(_$Source_DirectlinkImpl) then) =
      __$$Source_DirectlinkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LinkSource sourcedata});

  $LinkSourceCopyWith<$Res> get sourcedata;
}

/// @nodoc
class __$$Source_DirectlinkImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_DirectlinkImpl>
    implements _$$Source_DirectlinkImplCopyWith<$Res> {
  __$$Source_DirectlinkImplCopyWithImpl(_$Source_DirectlinkImpl _value,
      $Res Function(_$Source_DirectlinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourcedata = null,
  }) {
    return _then(_$Source_DirectlinkImpl(
      sourcedata: null == sourcedata
          ? _value.sourcedata
          : sourcedata // ignore: cast_nullable_to_non_nullable
              as LinkSource,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkSourceCopyWith<$Res> get sourcedata {
    return $LinkSourceCopyWith<$Res>(_value.sourcedata, (value) {
      return _then(_value.copyWith(sourcedata: value));
    });
  }
}

/// @nodoc

class _$Source_DirectlinkImpl extends Source_Directlink {
  const _$Source_DirectlinkImpl({required this.sourcedata}) : super._();

  @override
  final LinkSource sourcedata;

  @override
  String toString() {
    return 'Source.directlink(sourcedata: $sourcedata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_DirectlinkImpl &&
            (identical(other.sourcedata, sourcedata) ||
                other.sourcedata == sourcedata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourcedata);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_DirectlinkImplCopyWith<_$Source_DirectlinkImpl> get copyWith =>
      __$$Source_DirectlinkImplCopyWithImpl<_$Source_DirectlinkImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataSource sourcedata) data,
    required TResult Function(LinkSource sourcedata) directlink,
  }) {
    return directlink(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataSource sourcedata)? data,
    TResult? Function(LinkSource sourcedata)? directlink,
  }) {
    return directlink?.call(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataSource sourcedata)? data,
    TResult Function(LinkSource sourcedata)? directlink,
    required TResult orElse(),
  }) {
    if (directlink != null) {
      return directlink(sourcedata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Data value) data,
    required TResult Function(Source_Directlink value) directlink,
  }) {
    return directlink(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Data value)? data,
    TResult? Function(Source_Directlink value)? directlink,
  }) {
    return directlink?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Data value)? data,
    TResult Function(Source_Directlink value)? directlink,
    required TResult orElse(),
  }) {
    if (directlink != null) {
      return directlink(this);
    }
    return orElse();
  }
}

abstract class Source_Directlink extends Source {
  const factory Source_Directlink({required final LinkSource sourcedata}) =
      _$Source_DirectlinkImpl;
  const Source_Directlink._() : super._();

  @override
  LinkSource get sourcedata;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_DirectlinkImplCopyWith<_$Source_DirectlinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
