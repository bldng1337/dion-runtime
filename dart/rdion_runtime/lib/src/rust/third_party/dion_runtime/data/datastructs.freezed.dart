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

CustomUI _$CustomUIFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'text':
      return CustomUI_Text.fromJson(json);
    case 'image':
      return CustomUI_Image.fromJson(json);
    case 'link':
      return CustomUI_Link.fromJson(json);
    case 'timeStamp':
      return CustomUI_TimeStamp.fromJson(json);
    case 'entryCard':
      return CustomUI_EntryCard.fromJson(json);
    case 'column':
      return CustomUI_Column.fromJson(json);
    case 'row':
      return CustomUI_Row.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CustomUI',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

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

  /// Serializes this CustomUI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
@JsonSerializable()
class _$CustomUI_TextImpl extends CustomUI_Text {
  const _$CustomUI_TextImpl({required this.text, final String? $type})
      : $type = $type ?? 'text',
        super._();

  factory _$CustomUI_TextImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_TextImplFromJson(json);

  @override
  final String text;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_TextImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Text extends CustomUI {
  const factory CustomUI_Text({required final String text}) =
      _$CustomUI_TextImpl;
  const CustomUI_Text._() : super._();

  factory CustomUI_Text.fromJson(Map<String, dynamic> json) =
      _$CustomUI_TextImpl.fromJson;

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
@JsonSerializable()
class _$CustomUI_ImageImpl extends CustomUI_Image {
  const _$CustomUI_ImageImpl(
      {required this.image,
      final Map<String, String>? header,
      final String? $type})
      : _header = header,
        $type = $type ?? 'image',
        super._();

  factory _$CustomUI_ImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_ImageImplFromJson(json);

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

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_ImageImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Image extends CustomUI {
  const factory CustomUI_Image(
      {required final String image,
      final Map<String, String>? header}) = _$CustomUI_ImageImpl;
  const CustomUI_Image._() : super._();

  factory CustomUI_Image.fromJson(Map<String, dynamic> json) =
      _$CustomUI_ImageImpl.fromJson;

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
@JsonSerializable()
class _$CustomUI_LinkImpl extends CustomUI_Link {
  const _$CustomUI_LinkImpl(
      {required this.link, this.label, final String? $type})
      : $type = $type ?? 'link',
        super._();

  factory _$CustomUI_LinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_LinkImplFromJson(json);

  @override
  final String link;
  @override
  final String? label;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_LinkImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Link extends CustomUI {
  const factory CustomUI_Link(
      {required final String link, final String? label}) = _$CustomUI_LinkImpl;
  const CustomUI_Link._() : super._();

  factory CustomUI_Link.fromJson(Map<String, dynamic> json) =
      _$CustomUI_LinkImpl.fromJson;

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
@JsonSerializable()
class _$CustomUI_TimeStampImpl extends CustomUI_TimeStamp {
  const _$CustomUI_TimeStampImpl(
      {required this.timestamp, required this.display, final String? $type})
      : $type = $type ?? 'timeStamp',
        super._();

  factory _$CustomUI_TimeStampImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_TimeStampImplFromJson(json);

  @override
  final String timestamp;
  @override
  final TimestampType display;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_TimeStampImplToJson(
      this,
    );
  }
}

abstract class CustomUI_TimeStamp extends CustomUI {
  const factory CustomUI_TimeStamp(
      {required final String timestamp,
      required final TimestampType display}) = _$CustomUI_TimeStampImpl;
  const CustomUI_TimeStamp._() : super._();

  factory CustomUI_TimeStamp.fromJson(Map<String, dynamic> json) =
      _$CustomUI_TimeStampImpl.fromJson;

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

  $EntryCopyWith<$Res> get entry;
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

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EntryCopyWith<$Res> get entry {
    return $EntryCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_EntryCardImpl extends CustomUI_EntryCard {
  const _$CustomUI_EntryCardImpl({required this.entry, final String? $type})
      : $type = $type ?? 'entryCard',
        super._();

  factory _$CustomUI_EntryCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_EntryCardImplFromJson(json);

  @override
  final Entry entry;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_EntryCardImplToJson(
      this,
    );
  }
}

abstract class CustomUI_EntryCard extends CustomUI {
  const factory CustomUI_EntryCard({required final Entry entry}) =
      _$CustomUI_EntryCardImpl;
  const CustomUI_EntryCard._() : super._();

  factory CustomUI_EntryCard.fromJson(Map<String, dynamic> json) =
      _$CustomUI_EntryCardImpl.fromJson;

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
@JsonSerializable()
class _$CustomUI_ColumnImpl extends CustomUI_Column {
  const _$CustomUI_ColumnImpl(
      {required final List<CustomUI> children, final String? $type})
      : _children = children,
        $type = $type ?? 'column',
        super._();

  factory _$CustomUI_ColumnImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_ColumnImplFromJson(json);

  final List<CustomUI> _children;
  @override
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_ColumnImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Column extends CustomUI {
  const factory CustomUI_Column({required final List<CustomUI> children}) =
      _$CustomUI_ColumnImpl;
  const CustomUI_Column._() : super._();

  factory CustomUI_Column.fromJson(Map<String, dynamic> json) =
      _$CustomUI_ColumnImpl.fromJson;

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
@JsonSerializable()
class _$CustomUI_RowImpl extends CustomUI_Row {
  const _$CustomUI_RowImpl(
      {required final List<CustomUI> children, final String? $type})
      : _children = children,
        $type = $type ?? 'row',
        super._();

  factory _$CustomUI_RowImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_RowImplFromJson(json);

  final List<CustomUI> _children;
  @override
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_RowImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Row extends CustomUI {
  const factory CustomUI_Row({required final List<CustomUI> children}) =
      _$CustomUI_RowImpl;
  const CustomUI_Row._() : super._();

  factory CustomUI_Row.fromJson(Map<String, dynamic> json) =
      _$CustomUI_RowImpl.fromJson;

  List<CustomUI> get children;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_RowImplCopyWith<_$CustomUI_RowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataSource _$DataSourceFromJson(Map<String, dynamic> json) {
  return DataSource_Paragraphlist.fromJson(json);
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

  /// Serializes this DataSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
@JsonSerializable()
class _$DataSource_ParagraphlistImpl extends DataSource_Paragraphlist {
  const _$DataSource_ParagraphlistImpl({required final List<String> paragraphs})
      : _paragraphs = paragraphs,
        super._();

  factory _$DataSource_ParagraphlistImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSource_ParagraphlistImplFromJson(json);

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSource_ParagraphlistImplToJson(
      this,
    );
  }
}

abstract class DataSource_Paragraphlist extends DataSource {
  const factory DataSource_Paragraphlist(
          {required final List<String> paragraphs}) =
      _$DataSource_ParagraphlistImpl;
  const DataSource_Paragraphlist._() : super._();

  factory DataSource_Paragraphlist.fromJson(Map<String, dynamic> json) =
      _$DataSource_ParagraphlistImpl.fromJson;

  @override
  List<String> get paragraphs;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataSource_ParagraphlistImplCopyWith<_$DataSource_ParagraphlistImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

/// @nodoc
mixin _$Entry {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  Map<String, String>? get coverHeader => throw _privateConstructorUsedError;
  List<String>? get author => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  double? get views => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;

  /// Serializes this Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res, Entry>;
  @useResult
  $Res call(
      {String id,
      String url,
      String title,
      MediaType mediaType,
      String? cover,
      Map<String, String>? coverHeader,
      List<String>? author,
      double? rating,
      double? views,
      int? length});
}

/// @nodoc
class _$EntryCopyWithImpl<$Res, $Val extends Entry>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? mediaType = null,
    Object? cover = freezed,
    Object? coverHeader = freezed,
    Object? author = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      coverHeader: freezed == coverHeader
          ? _value.coverHeader
          : coverHeader // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntryImplCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$$EntryImplCopyWith(
          _$EntryImpl value, $Res Function(_$EntryImpl) then) =
      __$$EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String title,
      MediaType mediaType,
      String? cover,
      Map<String, String>? coverHeader,
      List<String>? author,
      double? rating,
      double? views,
      int? length});
}

/// @nodoc
class __$$EntryImplCopyWithImpl<$Res>
    extends _$EntryCopyWithImpl<$Res, _$EntryImpl>
    implements _$$EntryImplCopyWith<$Res> {
  __$$EntryImplCopyWithImpl(
      _$EntryImpl _value, $Res Function(_$EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? mediaType = null,
    Object? cover = freezed,
    Object? coverHeader = freezed,
    Object? author = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
  }) {
    return _then(_$EntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      coverHeader: freezed == coverHeader
          ? _value._coverHeader
          : coverHeader // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      author: freezed == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryImpl implements _Entry {
  const _$EntryImpl(
      {required this.id,
      required this.url,
      required this.title,
      required this.mediaType,
      this.cover,
      final Map<String, String>? coverHeader,
      final List<String>? author,
      this.rating,
      this.views,
      this.length})
      : _coverHeader = coverHeader,
        _author = author;

  factory _$EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String title;
  @override
  final MediaType mediaType;
  @override
  final String? cover;
  final Map<String, String>? _coverHeader;
  @override
  Map<String, String>? get coverHeader {
    final value = _coverHeader;
    if (value == null) return null;
    if (_coverHeader is EqualUnmodifiableMapView) return _coverHeader;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _author;
  @override
  List<String>? get author {
    final value = _author;
    if (value == null) return null;
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? rating;
  @override
  final double? views;
  @override
  final int? length;

  @override
  String toString() {
    return 'Entry(id: $id, url: $url, title: $title, mediaType: $mediaType, cover: $cover, coverHeader: $coverHeader, author: $author, rating: $rating, views: $views, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality()
                .equals(other._coverHeader, _coverHeader) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      title,
      mediaType,
      cover,
      const DeepCollectionEquality().hash(_coverHeader),
      const DeepCollectionEquality().hash(_author),
      rating,
      views,
      length);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      __$$EntryImplCopyWithImpl<_$EntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryImplToJson(
      this,
    );
  }
}

abstract class _Entry implements Entry {
  const factory _Entry(
      {required final String id,
      required final String url,
      required final String title,
      required final MediaType mediaType,
      final String? cover,
      final Map<String, String>? coverHeader,
      final List<String>? author,
      final double? rating,
      final double? views,
      final int? length}) = _$EntryImpl;

  factory _Entry.fromJson(Map<String, dynamic> json) = _$EntryImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get title;
  @override
  MediaType get mediaType;
  @override
  String? get cover;
  @override
  Map<String, String>? get coverHeader;
  @override
  List<String>? get author;
  @override
  double? get rating;
  @override
  double? get views;
  @override
  int? get length;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntryDetailed _$EntryDetailedFromJson(Map<String, dynamic> json) {
  return _EntryDetailed.fromJson(json);
}

/// @nodoc
mixin _$EntryDetailed {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String>? get author => throw _privateConstructorUsedError;
  CustomUI? get ui => throw _privateConstructorUsedError;
  List<MetaData>? get meta => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  ReleaseStatus get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  Map<String, String>? get coverHeader => throw _privateConstructorUsedError;
  List<Episode> get episodes => throw _privateConstructorUsedError;
  List<String>? get genres => throw _privateConstructorUsedError;
  List<String>? get alttitles => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  double? get views => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;
  Map<String, Setting>? get settings => throw _privateConstructorUsedError;

  /// Serializes this EntryDetailed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryDetailedCopyWith<EntryDetailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryDetailedCopyWith<$Res> {
  factory $EntryDetailedCopyWith(
          EntryDetailed value, $Res Function(EntryDetailed) then) =
      _$EntryDetailedCopyWithImpl<$Res, EntryDetailed>;
  @useResult
  $Res call(
      {String id,
      String url,
      String title,
      List<String>? author,
      CustomUI? ui,
      List<MetaData>? meta,
      MediaType mediaType,
      ReleaseStatus status,
      String description,
      String language,
      String? cover,
      Map<String, String>? coverHeader,
      List<Episode> episodes,
      List<String>? genres,
      List<String>? alttitles,
      double? rating,
      double? views,
      int? length,
      Map<String, Setting>? settings});

  $CustomUICopyWith<$Res>? get ui;
}

/// @nodoc
class _$EntryDetailedCopyWithImpl<$Res, $Val extends EntryDetailed>
    implements $EntryDetailedCopyWith<$Res> {
  _$EntryDetailedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? author = freezed,
    Object? ui = freezed,
    Object? meta = freezed,
    Object? mediaType = null,
    Object? status = null,
    Object? description = null,
    Object? language = null,
    Object? cover = freezed,
    Object? coverHeader = freezed,
    Object? episodes = null,
    Object? genres = freezed,
    Object? alttitles = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
    Object? settings = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as List<MetaData>?,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReleaseStatus,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      coverHeader: freezed == coverHeader
          ? _value.coverHeader
          : coverHeader // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      alttitles: freezed == alttitles
          ? _value.alttitles
          : alttitles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, Setting>?,
    ) as $Val);
  }

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get ui {
    if (_value.ui == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_value.ui!, (value) {
      return _then(_value.copyWith(ui: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryDetailedImplCopyWith<$Res>
    implements $EntryDetailedCopyWith<$Res> {
  factory _$$EntryDetailedImplCopyWith(
          _$EntryDetailedImpl value, $Res Function(_$EntryDetailedImpl) then) =
      __$$EntryDetailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String title,
      List<String>? author,
      CustomUI? ui,
      List<MetaData>? meta,
      MediaType mediaType,
      ReleaseStatus status,
      String description,
      String language,
      String? cover,
      Map<String, String>? coverHeader,
      List<Episode> episodes,
      List<String>? genres,
      List<String>? alttitles,
      double? rating,
      double? views,
      int? length,
      Map<String, Setting>? settings});

  @override
  $CustomUICopyWith<$Res>? get ui;
}

/// @nodoc
class __$$EntryDetailedImplCopyWithImpl<$Res>
    extends _$EntryDetailedCopyWithImpl<$Res, _$EntryDetailedImpl>
    implements _$$EntryDetailedImplCopyWith<$Res> {
  __$$EntryDetailedImplCopyWithImpl(
      _$EntryDetailedImpl _value, $Res Function(_$EntryDetailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? author = freezed,
    Object? ui = freezed,
    Object? meta = freezed,
    Object? mediaType = null,
    Object? status = null,
    Object? description = null,
    Object? language = null,
    Object? cover = freezed,
    Object? coverHeader = freezed,
    Object? episodes = null,
    Object? genres = freezed,
    Object? alttitles = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
    Object? settings = freezed,
  }) {
    return _then(_$EntryDetailedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      meta: freezed == meta
          ? _value._meta
          : meta // ignore: cast_nullable_to_non_nullable
              as List<MetaData>?,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReleaseStatus,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      coverHeader: freezed == coverHeader
          ? _value._coverHeader
          : coverHeader // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      alttitles: freezed == alttitles
          ? _value._alttitles
          : alttitles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      settings: freezed == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, Setting>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryDetailedImpl implements _EntryDetailed {
  const _$EntryDetailedImpl(
      {required this.id,
      required this.url,
      required this.title,
      final List<String>? author,
      this.ui,
      final List<MetaData>? meta,
      required this.mediaType,
      required this.status,
      required this.description,
      required this.language,
      this.cover,
      final Map<String, String>? coverHeader,
      required final List<Episode> episodes,
      final List<String>? genres,
      final List<String>? alttitles,
      this.rating,
      this.views,
      this.length,
      final Map<String, Setting>? settings})
      : _author = author,
        _meta = meta,
        _coverHeader = coverHeader,
        _episodes = episodes,
        _genres = genres,
        _alttitles = alttitles,
        _settings = settings;

  factory _$EntryDetailedImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryDetailedImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String title;
  final List<String>? _author;
  @override
  List<String>? get author {
    final value = _author;
    if (value == null) return null;
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CustomUI? ui;
  final List<MetaData>? _meta;
  @override
  List<MetaData>? get meta {
    final value = _meta;
    if (value == null) return null;
    if (_meta is EqualUnmodifiableListView) return _meta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MediaType mediaType;
  @override
  final ReleaseStatus status;
  @override
  final String description;
  @override
  final String language;
  @override
  final String? cover;
  final Map<String, String>? _coverHeader;
  @override
  Map<String, String>? get coverHeader {
    final value = _coverHeader;
    if (value == null) return null;
    if (_coverHeader is EqualUnmodifiableMapView) return _coverHeader;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<Episode> _episodes;
  @override
  List<Episode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  final List<String>? _genres;
  @override
  List<String>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _alttitles;
  @override
  List<String>? get alttitles {
    final value = _alttitles;
    if (value == null) return null;
    if (_alttitles is EqualUnmodifiableListView) return _alttitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? rating;
  @override
  final double? views;
  @override
  final int? length;
  final Map<String, Setting>? _settings;
  @override
  Map<String, Setting>? get settings {
    final value = _settings;
    if (value == null) return null;
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EntryDetailed(id: $id, url: $url, title: $title, author: $author, ui: $ui, meta: $meta, mediaType: $mediaType, status: $status, description: $description, language: $language, cover: $cover, coverHeader: $coverHeader, episodes: $episodes, genres: $genres, alttitles: $alttitles, rating: $rating, views: $views, length: $length, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryDetailedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            (identical(other.ui, ui) || other.ui == ui) &&
            const DeepCollectionEquality().equals(other._meta, _meta) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality()
                .equals(other._coverHeader, _coverHeader) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality()
                .equals(other._alttitles, _alttitles) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.length, length) || other.length == length) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        url,
        title,
        const DeepCollectionEquality().hash(_author),
        ui,
        const DeepCollectionEquality().hash(_meta),
        mediaType,
        status,
        description,
        language,
        cover,
        const DeepCollectionEquality().hash(_coverHeader),
        const DeepCollectionEquality().hash(_episodes),
        const DeepCollectionEquality().hash(_genres),
        const DeepCollectionEquality().hash(_alttitles),
        rating,
        views,
        length,
        const DeepCollectionEquality().hash(_settings)
      ]);

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryDetailedImplCopyWith<_$EntryDetailedImpl> get copyWith =>
      __$$EntryDetailedImplCopyWithImpl<_$EntryDetailedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryDetailedImplToJson(
      this,
    );
  }
}

abstract class _EntryDetailed implements EntryDetailed {
  const factory _EntryDetailed(
      {required final String id,
      required final String url,
      required final String title,
      final List<String>? author,
      final CustomUI? ui,
      final List<MetaData>? meta,
      required final MediaType mediaType,
      required final ReleaseStatus status,
      required final String description,
      required final String language,
      final String? cover,
      final Map<String, String>? coverHeader,
      required final List<Episode> episodes,
      final List<String>? genres,
      final List<String>? alttitles,
      final double? rating,
      final double? views,
      final int? length,
      final Map<String, Setting>? settings}) = _$EntryDetailedImpl;

  factory _EntryDetailed.fromJson(Map<String, dynamic> json) =
      _$EntryDetailedImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get title;
  @override
  List<String>? get author;
  @override
  CustomUI? get ui;
  @override
  List<MetaData>? get meta;
  @override
  MediaType get mediaType;
  @override
  ReleaseStatus get status;
  @override
  String get description;
  @override
  String get language;
  @override
  String? get cover;
  @override
  Map<String, String>? get coverHeader;
  @override
  List<Episode> get episodes;
  @override
  List<String>? get genres;
  @override
  List<String>? get alttitles;
  @override
  double? get rating;
  @override
  double? get views;
  @override
  int? get length;
  @override
  Map<String, Setting>? get settings;

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryDetailedImplCopyWith<_$EntryDetailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return _Episode.fromJson(json);
}

/// @nodoc
mixin _$Episode {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  Map<String, String>? get coverHeader => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this Episode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodeCopyWith<Episode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) then) =
      _$EpisodeCopyWithImpl<$Res, Episode>;
  @useResult
  $Res call(
      {String id,
      String name,
      String url,
      String? cover,
      Map<String, String>? coverHeader,
      String? timestamp});
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res, $Val extends Episode>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? cover = freezed,
    Object? coverHeader = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      coverHeader: freezed == coverHeader
          ? _value.coverHeader
          : coverHeader // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EpisodeImplCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$EpisodeImplCopyWith(
          _$EpisodeImpl value, $Res Function(_$EpisodeImpl) then) =
      __$$EpisodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String url,
      String? cover,
      Map<String, String>? coverHeader,
      String? timestamp});
}

/// @nodoc
class __$$EpisodeImplCopyWithImpl<$Res>
    extends _$EpisodeCopyWithImpl<$Res, _$EpisodeImpl>
    implements _$$EpisodeImplCopyWith<$Res> {
  __$$EpisodeImplCopyWithImpl(
      _$EpisodeImpl _value, $Res Function(_$EpisodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
    Object? cover = freezed,
    Object? coverHeader = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$EpisodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      coverHeader: freezed == coverHeader
          ? _value._coverHeader
          : coverHeader // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EpisodeImpl implements _Episode {
  const _$EpisodeImpl(
      {required this.id,
      required this.name,
      required this.url,
      this.cover,
      final Map<String, String>? coverHeader,
      this.timestamp})
      : _coverHeader = coverHeader;

  factory _$EpisodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpisodeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String url;
  @override
  final String? cover;
  final Map<String, String>? _coverHeader;
  @override
  Map<String, String>? get coverHeader {
    final value = _coverHeader;
    if (value == null) return null;
    if (_coverHeader is EqualUnmodifiableMapView) return _coverHeader;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? timestamp;

  @override
  String toString() {
    return 'Episode(id: $id, name: $name, url: $url, cover: $cover, coverHeader: $coverHeader, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality()
                .equals(other._coverHeader, _coverHeader) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, url, cover,
      const DeepCollectionEquality().hash(_coverHeader), timestamp);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      __$$EpisodeImplCopyWithImpl<_$EpisodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpisodeImplToJson(
      this,
    );
  }
}

abstract class _Episode implements Episode {
  const factory _Episode(
      {required final String id,
      required final String name,
      required final String url,
      final String? cover,
      final Map<String, String>? coverHeader,
      final String? timestamp}) = _$EpisodeImpl;

  factory _Episode.fromJson(Map<String, dynamic> json) = _$EpisodeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get url;
  @override
  String? get cover;
  @override
  Map<String, String>? get coverHeader;
  @override
  String? get timestamp;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExtensionData _$ExtensionDataFromJson(Map<String, dynamic> json) {
  return _ExtensionData.fromJson(json);
}

/// @nodoc
mixin _$ExtensionData {
  String get id => throw _privateConstructorUsedError;
  String? get repo => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<MediaType>? get mediaType => throw _privateConstructorUsedError;
  String? get giturl => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get license => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool? get nsfw => throw _privateConstructorUsedError;
  List<String> get lang => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this ExtensionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtensionDataCopyWith<ExtensionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtensionDataCopyWith<$Res> {
  factory $ExtensionDataCopyWith(
          ExtensionData value, $Res Function(ExtensionData) then) =
      _$ExtensionDataCopyWithImpl<$Res, ExtensionData>;
  @useResult
  $Res call(
      {String id,
      String? repo,
      String name,
      List<MediaType>? mediaType,
      String? giturl,
      String? version,
      String? desc,
      String? author,
      String? license,
      List<String>? tags,
      bool? nsfw,
      List<String> lang,
      String? url,
      String? icon});
}

/// @nodoc
class _$ExtensionDataCopyWithImpl<$Res, $Val extends ExtensionData>
    implements $ExtensionDataCopyWith<$Res> {
  _$ExtensionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? repo = freezed,
    Object? name = null,
    Object? mediaType = freezed,
    Object? giturl = freezed,
    Object? version = freezed,
    Object? desc = freezed,
    Object? author = freezed,
    Object? license = freezed,
    Object? tags = freezed,
    Object? nsfw = freezed,
    Object? lang = null,
    Object? url = freezed,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      repo: freezed == repo
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as List<MediaType>?,
      giturl: freezed == giturl
          ? _value.giturl
          : giturl // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      license: freezed == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nsfw: freezed == nsfw
          ? _value.nsfw
          : nsfw // ignore: cast_nullable_to_non_nullable
              as bool?,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtensionDataImplCopyWith<$Res>
    implements $ExtensionDataCopyWith<$Res> {
  factory _$$ExtensionDataImplCopyWith(
          _$ExtensionDataImpl value, $Res Function(_$ExtensionDataImpl) then) =
      __$$ExtensionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? repo,
      String name,
      List<MediaType>? mediaType,
      String? giturl,
      String? version,
      String? desc,
      String? author,
      String? license,
      List<String>? tags,
      bool? nsfw,
      List<String> lang,
      String? url,
      String? icon});
}

/// @nodoc
class __$$ExtensionDataImplCopyWithImpl<$Res>
    extends _$ExtensionDataCopyWithImpl<$Res, _$ExtensionDataImpl>
    implements _$$ExtensionDataImplCopyWith<$Res> {
  __$$ExtensionDataImplCopyWithImpl(
      _$ExtensionDataImpl _value, $Res Function(_$ExtensionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? repo = freezed,
    Object? name = null,
    Object? mediaType = freezed,
    Object? giturl = freezed,
    Object? version = freezed,
    Object? desc = freezed,
    Object? author = freezed,
    Object? license = freezed,
    Object? tags = freezed,
    Object? nsfw = freezed,
    Object? lang = null,
    Object? url = freezed,
    Object? icon = freezed,
  }) {
    return _then(_$ExtensionDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      repo: freezed == repo
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: freezed == mediaType
          ? _value._mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as List<MediaType>?,
      giturl: freezed == giturl
          ? _value.giturl
          : giturl // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      license: freezed == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nsfw: freezed == nsfw
          ? _value.nsfw
          : nsfw // ignore: cast_nullable_to_non_nullable
              as bool?,
      lang: null == lang
          ? _value._lang
          : lang // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtensionDataImpl implements _ExtensionData {
  const _$ExtensionDataImpl(
      {required this.id,
      this.repo,
      required this.name,
      final List<MediaType>? mediaType,
      this.giturl,
      this.version,
      this.desc,
      this.author,
      this.license,
      final List<String>? tags,
      this.nsfw,
      required final List<String> lang,
      this.url,
      this.icon})
      : _mediaType = mediaType,
        _tags = tags,
        _lang = lang;

  factory _$ExtensionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtensionDataImplFromJson(json);

  @override
  final String id;
  @override
  final String? repo;
  @override
  final String name;
  final List<MediaType>? _mediaType;
  @override
  List<MediaType>? get mediaType {
    final value = _mediaType;
    if (value == null) return null;
    if (_mediaType is EqualUnmodifiableListView) return _mediaType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? giturl;
  @override
  final String? version;
  @override
  final String? desc;
  @override
  final String? author;
  @override
  final String? license;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? nsfw;
  final List<String> _lang;
  @override
  List<String> get lang {
    if (_lang is EqualUnmodifiableListView) return _lang;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lang);
  }

  @override
  final String? url;
  @override
  final String? icon;

  @override
  String toString() {
    return 'ExtensionData(id: $id, repo: $repo, name: $name, mediaType: $mediaType, giturl: $giturl, version: $version, desc: $desc, author: $author, license: $license, tags: $tags, nsfw: $nsfw, lang: $lang, url: $url, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._mediaType, _mediaType) &&
            (identical(other.giturl, giturl) || other.giturl == giturl) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.license, license) || other.license == license) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.nsfw, nsfw) || other.nsfw == nsfw) &&
            const DeepCollectionEquality().equals(other._lang, _lang) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      repo,
      name,
      const DeepCollectionEquality().hash(_mediaType),
      giturl,
      version,
      desc,
      author,
      license,
      const DeepCollectionEquality().hash(_tags),
      nsfw,
      const DeepCollectionEquality().hash(_lang),
      url,
      icon);

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionDataImplCopyWith<_$ExtensionDataImpl> get copyWith =>
      __$$ExtensionDataImplCopyWithImpl<_$ExtensionDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtensionDataImplToJson(
      this,
    );
  }
}

abstract class _ExtensionData implements ExtensionData {
  const factory _ExtensionData(
      {required final String id,
      final String? repo,
      required final String name,
      final List<MediaType>? mediaType,
      final String? giturl,
      final String? version,
      final String? desc,
      final String? author,
      final String? license,
      final List<String>? tags,
      final bool? nsfw,
      required final List<String> lang,
      final String? url,
      final String? icon}) = _$ExtensionDataImpl;

  factory _ExtensionData.fromJson(Map<String, dynamic> json) =
      _$ExtensionDataImpl.fromJson;

  @override
  String get id;
  @override
  String? get repo;
  @override
  String get name;
  @override
  List<MediaType>? get mediaType;
  @override
  String? get giturl;
  @override
  String? get version;
  @override
  String? get desc;
  @override
  String? get author;
  @override
  String? get license;
  @override
  List<String>? get tags;
  @override
  bool? get nsfw;
  @override
  List<String> get lang;
  @override
  String? get url;
  @override
  String? get icon;

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionDataImplCopyWith<_$ExtensionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageListAudio _$ImageListAudioFromJson(Map<String, dynamic> json) {
  return _ImageListAudio.fromJson(json);
}

/// @nodoc
mixin _$ImageListAudio {
  String get link => throw _privateConstructorUsedError;
  int get from => throw _privateConstructorUsedError;
  int get to => throw _privateConstructorUsedError;

  /// Serializes this ImageListAudio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageListAudioCopyWith<ImageListAudio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageListAudioCopyWith<$Res> {
  factory $ImageListAudioCopyWith(
          ImageListAudio value, $Res Function(ImageListAudio) then) =
      _$ImageListAudioCopyWithImpl<$Res, ImageListAudio>;
  @useResult
  $Res call({String link, int from, int to});
}

/// @nodoc
class _$ImageListAudioCopyWithImpl<$Res, $Val extends ImageListAudio>
    implements $ImageListAudioCopyWith<$Res> {
  _$ImageListAudioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageListAudioImplCopyWith<$Res>
    implements $ImageListAudioCopyWith<$Res> {
  factory _$$ImageListAudioImplCopyWith(_$ImageListAudioImpl value,
          $Res Function(_$ImageListAudioImpl) then) =
      __$$ImageListAudioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String link, int from, int to});
}

/// @nodoc
class __$$ImageListAudioImplCopyWithImpl<$Res>
    extends _$ImageListAudioCopyWithImpl<$Res, _$ImageListAudioImpl>
    implements _$$ImageListAudioImplCopyWith<$Res> {
  __$$ImageListAudioImplCopyWithImpl(
      _$ImageListAudioImpl _value, $Res Function(_$ImageListAudioImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_$ImageListAudioImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageListAudioImpl implements _ImageListAudio {
  const _$ImageListAudioImpl(
      {required this.link, required this.from, required this.to});

  factory _$ImageListAudioImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageListAudioImplFromJson(json);

  @override
  final String link;
  @override
  final int from;
  @override
  final int to;

  @override
  String toString() {
    return 'ImageListAudio(link: $link, from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageListAudioImpl &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, link, from, to);

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageListAudioImplCopyWith<_$ImageListAudioImpl> get copyWith =>
      __$$ImageListAudioImplCopyWithImpl<_$ImageListAudioImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageListAudioImplToJson(
      this,
    );
  }
}

abstract class _ImageListAudio implements ImageListAudio {
  const factory _ImageListAudio(
      {required final String link,
      required final int from,
      required final int to}) = _$ImageListAudioImpl;

  factory _ImageListAudio.fromJson(Map<String, dynamic> json) =
      _$ImageListAudioImpl.fromJson;

  @override
  String get link;
  @override
  int get from;
  @override
  int get to;

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageListAudioImplCopyWith<_$ImageListAudioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LinkSource _$LinkSourceFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'epub':
      return LinkSource_Epub.fromJson(json);
    case 'pdf':
      return LinkSource_Pdf.fromJson(json);
    case 'imagelist':
      return LinkSource_Imagelist.fromJson(json);
    case 'm3U8':
      return LinkSource_M3u8.fromJson(json);
    case 'mp3':
      return LinkSource_Mp3.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'LinkSource',
          'Invalid union type "${json['runtimeType']}"!');
  }
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
    required TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)
        m3U8,
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
    TResult? Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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
    TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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

  /// Serializes this LinkSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
@JsonSerializable()
class _$LinkSource_EpubImpl extends LinkSource_Epub {
  const _$LinkSource_EpubImpl({required this.link, final String? $type})
      : $type = $type ?? 'epub',
        super._();

  factory _$LinkSource_EpubImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkSource_EpubImplFromJson(json);

  @override
  final String link;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)
        m3U8,
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
    TResult? Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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
    TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkSource_EpubImplToJson(
      this,
    );
  }
}

abstract class LinkSource_Epub extends LinkSource {
  const factory LinkSource_Epub({required final String link}) =
      _$LinkSource_EpubImpl;
  const LinkSource_Epub._() : super._();

  factory LinkSource_Epub.fromJson(Map<String, dynamic> json) =
      _$LinkSource_EpubImpl.fromJson;

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
@JsonSerializable()
class _$LinkSource_PdfImpl extends LinkSource_Pdf {
  const _$LinkSource_PdfImpl({required this.link, final String? $type})
      : $type = $type ?? 'pdf',
        super._();

  factory _$LinkSource_PdfImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkSource_PdfImplFromJson(json);

  @override
  final String link;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)
        m3U8,
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
    TResult? Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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
    TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkSource_PdfImplToJson(
      this,
    );
  }
}

abstract class LinkSource_Pdf extends LinkSource {
  const factory LinkSource_Pdf({required final String link}) =
      _$LinkSource_PdfImpl;
  const LinkSource_Pdf._() : super._();

  factory LinkSource_Pdf.fromJson(Map<String, dynamic> json) =
      _$LinkSource_PdfImpl.fromJson;

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
@JsonSerializable()
class _$LinkSource_ImagelistImpl extends LinkSource_Imagelist {
  const _$LinkSource_ImagelistImpl(
      {required final List<String> links,
      final Map<String, String>? header,
      final List<ImageListAudio>? audio,
      final String? $type})
      : _links = links,
        _header = header,
        _audio = audio,
        $type = $type ?? 'imagelist',
        super._();

  factory _$LinkSource_ImagelistImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkSource_ImagelistImplFromJson(json);

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

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)
        m3U8,
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
    TResult? Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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
    TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkSource_ImagelistImplToJson(
      this,
    );
  }
}

abstract class LinkSource_Imagelist extends LinkSource {
  const factory LinkSource_Imagelist(
      {required final List<String> links,
      final Map<String, String>? header,
      final List<ImageListAudio>? audio}) = _$LinkSource_ImagelistImpl;
  const LinkSource_Imagelist._() : super._();

  factory LinkSource_Imagelist.fromJson(Map<String, dynamic> json) =
      _$LinkSource_ImagelistImpl.fromJson;

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
  $Res call({String link, List<Subtitles> sub, Map<String, String>? headers});
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
    Object? headers = freezed,
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
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkSource_M3u8Impl extends LinkSource_M3u8 {
  const _$LinkSource_M3u8Impl(
      {required this.link,
      required final List<Subtitles> sub,
      final Map<String, String>? headers,
      final String? $type})
      : _sub = sub,
        _headers = headers,
        $type = $type ?? 'm3U8',
        super._();

  factory _$LinkSource_M3u8Impl.fromJson(Map<String, dynamic> json) =>
      _$$LinkSource_M3u8ImplFromJson(json);

  @override
  final String link;
  final List<Subtitles> _sub;
  @override
  List<Subtitles> get sub {
    if (_sub is EqualUnmodifiableListView) return _sub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sub);
  }

  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'LinkSource.m3U8(link: $link, sub: $sub, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_M3u8Impl &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality().equals(other._sub, _sub) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      link,
      const DeepCollectionEquality().hash(_sub),
      const DeepCollectionEquality().hash(_headers));

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
    required TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)
        m3U8,
    required TResult Function(List<UrlChapter> chapters) mp3,
  }) {
    return m3U8(link, sub, headers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
    TResult? Function(List<UrlChapter> chapters)? mp3,
  }) {
    return m3U8?.call(link, sub, headers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
    TResult Function(List<UrlChapter> chapters)? mp3,
    required TResult orElse(),
  }) {
    if (m3U8 != null) {
      return m3U8(link, sub, headers);
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

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkSource_M3u8ImplToJson(
      this,
    );
  }
}

abstract class LinkSource_M3u8 extends LinkSource {
  const factory LinkSource_M3u8(
      {required final String link,
      required final List<Subtitles> sub,
      final Map<String, String>? headers}) = _$LinkSource_M3u8Impl;
  const LinkSource_M3u8._() : super._();

  factory LinkSource_M3u8.fromJson(Map<String, dynamic> json) =
      _$LinkSource_M3u8Impl.fromJson;

  String get link;
  List<Subtitles> get sub;
  Map<String, String>? get headers;

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
@JsonSerializable()
class _$LinkSource_Mp3Impl extends LinkSource_Mp3 {
  const _$LinkSource_Mp3Impl(
      {required final List<UrlChapter> chapters, final String? $type})
      : _chapters = chapters,
        $type = $type ?? 'mp3',
        super._();

  factory _$LinkSource_Mp3Impl.fromJson(Map<String, dynamic> json) =>
      _$$LinkSource_Mp3ImplFromJson(json);

  final List<UrlChapter> _chapters;
  @override
  List<UrlChapter> get chapters {
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chapters);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)
        m3U8,
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
    TResult? Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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
    TResult Function(
            String link, List<Subtitles> sub, Map<String, String>? headers)?
        m3U8,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkSource_Mp3ImplToJson(
      this,
    );
  }
}

abstract class LinkSource_Mp3 extends LinkSource {
  const factory LinkSource_Mp3({required final List<UrlChapter> chapters}) =
      _$LinkSource_Mp3Impl;
  const LinkSource_Mp3._() : super._();

  factory LinkSource_Mp3.fromJson(Map<String, dynamic> json) =
      _$LinkSource_Mp3Impl.fromJson;

  List<UrlChapter> get chapters;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_Mp3ImplCopyWith<_$LinkSource_Mp3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

MetaData _$MetaDataFromJson(Map<String, dynamic> json) {
  return _MetaData.fromJson(json);
}

/// @nodoc
mixin _$MetaData {
  String get key => throw _privateConstructorUsedError;

  /// Serializes this MetaData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetaDataCopyWith<MetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaDataCopyWith<$Res> {
  factory $MetaDataCopyWith(MetaData value, $Res Function(MetaData) then) =
      _$MetaDataCopyWithImpl<$Res, MetaData>;
  @useResult
  $Res call({String key});
}

/// @nodoc
class _$MetaDataCopyWithImpl<$Res, $Val extends MetaData>
    implements $MetaDataCopyWith<$Res> {
  _$MetaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetaDataImplCopyWith<$Res>
    implements $MetaDataCopyWith<$Res> {
  factory _$$MetaDataImplCopyWith(
          _$MetaDataImpl value, $Res Function(_$MetaDataImpl) then) =
      __$$MetaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key});
}

/// @nodoc
class __$$MetaDataImplCopyWithImpl<$Res>
    extends _$MetaDataCopyWithImpl<$Res, _$MetaDataImpl>
    implements _$$MetaDataImplCopyWith<$Res> {
  __$$MetaDataImplCopyWithImpl(
      _$MetaDataImpl _value, $Res Function(_$MetaDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$MetaDataImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaDataImpl implements _MetaData {
  const _$MetaDataImpl({required this.key});

  factory _$MetaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaDataImplFromJson(json);

  @override
  final String key;

  @override
  String toString() {
    return 'MetaData(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaDataImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaDataImplCopyWith<_$MetaDataImpl> get copyWith =>
      __$$MetaDataImplCopyWithImpl<_$MetaDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaDataImplToJson(
      this,
    );
  }
}

abstract class _MetaData implements MetaData {
  const factory _MetaData({required final String key}) = _$MetaDataImpl;

  factory _MetaData.fromJson(Map<String, dynamic> json) =
      _$MetaDataImpl.fromJson;

  @override
  String get key;

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetaDataImplCopyWith<_$MetaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Source _$SourceFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'data':
      return Source_Data.fromJson(json);
    case 'directlink':
      return Source_Directlink.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Source',
          'Invalid union type "${json['runtimeType']}"!');
  }
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

  /// Serializes this Source to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
@JsonSerializable()
class _$Source_DataImpl extends Source_Data {
  const _$Source_DataImpl({required this.sourcedata, final String? $type})
      : $type = $type ?? 'data',
        super._();

  factory _$Source_DataImpl.fromJson(Map<String, dynamic> json) =>
      _$$Source_DataImplFromJson(json);

  @override
  final DataSource sourcedata;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_DataImplToJson(
      this,
    );
  }
}

abstract class Source_Data extends Source {
  const factory Source_Data({required final DataSource sourcedata}) =
      _$Source_DataImpl;
  const Source_Data._() : super._();

  factory Source_Data.fromJson(Map<String, dynamic> json) =
      _$Source_DataImpl.fromJson;

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
@JsonSerializable()
class _$Source_DirectlinkImpl extends Source_Directlink {
  const _$Source_DirectlinkImpl({required this.sourcedata, final String? $type})
      : $type = $type ?? 'directlink',
        super._();

  factory _$Source_DirectlinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$Source_DirectlinkImplFromJson(json);

  @override
  final LinkSource sourcedata;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_DirectlinkImplToJson(
      this,
    );
  }
}

abstract class Source_Directlink extends Source {
  const factory Source_Directlink({required final LinkSource sourcedata}) =
      _$Source_DirectlinkImpl;
  const Source_Directlink._() : super._();

  factory Source_Directlink.fromJson(Map<String, dynamic> json) =
      _$Source_DirectlinkImpl.fromJson;

  @override
  LinkSource get sourcedata;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_DirectlinkImplCopyWith<_$Source_DirectlinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Subtitles _$SubtitlesFromJson(Map<String, dynamic> json) {
  return _Subtitles.fromJson(json);
}

/// @nodoc
mixin _$Subtitles {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  Map<String, String>? get headers => throw _privateConstructorUsedError;

  /// Serializes this Subtitles to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtitlesCopyWith<Subtitles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitlesCopyWith<$Res> {
  factory $SubtitlesCopyWith(Subtitles value, $Res Function(Subtitles) then) =
      _$SubtitlesCopyWithImpl<$Res, Subtitles>;
  @useResult
  $Res call({String title, String url, Map<String, String>? headers});
}

/// @nodoc
class _$SubtitlesCopyWithImpl<$Res, $Val extends Subtitles>
    implements $SubtitlesCopyWith<$Res> {
  _$SubtitlesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? headers = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubtitlesImplCopyWith<$Res>
    implements $SubtitlesCopyWith<$Res> {
  factory _$$SubtitlesImplCopyWith(
          _$SubtitlesImpl value, $Res Function(_$SubtitlesImpl) then) =
      __$$SubtitlesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, Map<String, String>? headers});
}

/// @nodoc
class __$$SubtitlesImplCopyWithImpl<$Res>
    extends _$SubtitlesCopyWithImpl<$Res, _$SubtitlesImpl>
    implements _$$SubtitlesImplCopyWith<$Res> {
  __$$SubtitlesImplCopyWithImpl(
      _$SubtitlesImpl _value, $Res Function(_$SubtitlesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? headers = freezed,
  }) {
    return _then(_$SubtitlesImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtitlesImpl implements _Subtitles {
  const _$SubtitlesImpl(
      {required this.title,
      required this.url,
      final Map<String, String>? headers})
      : _headers = headers;

  factory _$SubtitlesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtitlesImplFromJson(json);

  @override
  final String title;
  @override
  final String url;
  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Subtitles(title: $title, url: $url, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtitlesImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, url, const DeepCollectionEquality().hash(_headers));

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtitlesImplCopyWith<_$SubtitlesImpl> get copyWith =>
      __$$SubtitlesImplCopyWithImpl<_$SubtitlesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtitlesImplToJson(
      this,
    );
  }
}

abstract class _Subtitles implements Subtitles {
  const factory _Subtitles(
      {required final String title,
      required final String url,
      final Map<String, String>? headers}) = _$SubtitlesImpl;

  factory _Subtitles.fromJson(Map<String, dynamic> json) =
      _$SubtitlesImpl.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  Map<String, String>? get headers;

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtitlesImplCopyWith<_$SubtitlesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UrlChapter _$UrlChapterFromJson(Map<String, dynamic> json) {
  return _UrlChapter.fromJson(json);
}

/// @nodoc
mixin _$UrlChapter {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  /// Serializes this UrlChapter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UrlChapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UrlChapterCopyWith<UrlChapter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlChapterCopyWith<$Res> {
  factory $UrlChapterCopyWith(
          UrlChapter value, $Res Function(UrlChapter) then) =
      _$UrlChapterCopyWithImpl<$Res, UrlChapter>;
  @useResult
  $Res call({String title, String url});
}

/// @nodoc
class _$UrlChapterCopyWithImpl<$Res, $Val extends UrlChapter>
    implements $UrlChapterCopyWith<$Res> {
  _$UrlChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UrlChapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UrlChapterImplCopyWith<$Res>
    implements $UrlChapterCopyWith<$Res> {
  factory _$$UrlChapterImplCopyWith(
          _$UrlChapterImpl value, $Res Function(_$UrlChapterImpl) then) =
      __$$UrlChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url});
}

/// @nodoc
class __$$UrlChapterImplCopyWithImpl<$Res>
    extends _$UrlChapterCopyWithImpl<$Res, _$UrlChapterImpl>
    implements _$$UrlChapterImplCopyWith<$Res> {
  __$$UrlChapterImplCopyWithImpl(
      _$UrlChapterImpl _value, $Res Function(_$UrlChapterImpl) _then)
      : super(_value, _then);

  /// Create a copy of UrlChapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_$UrlChapterImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UrlChapterImpl implements _UrlChapter {
  const _$UrlChapterImpl({required this.title, required this.url});

  factory _$UrlChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrlChapterImplFromJson(json);

  @override
  final String title;
  @override
  final String url;

  @override
  String toString() {
    return 'UrlChapter(title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlChapterImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, url);

  /// Create a copy of UrlChapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UrlChapterImplCopyWith<_$UrlChapterImpl> get copyWith =>
      __$$UrlChapterImplCopyWithImpl<_$UrlChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UrlChapterImplToJson(
      this,
    );
  }
}

abstract class _UrlChapter implements UrlChapter {
  const factory _UrlChapter(
      {required final String title,
      required final String url}) = _$UrlChapterImpl;

  factory _UrlChapter.fromJson(Map<String, dynamic> json) =
      _$UrlChapterImpl.fromJson;

  @override
  String get title;
  @override
  String get url;

  /// Create a copy of UrlChapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UrlChapterImplCopyWith<_$UrlChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
