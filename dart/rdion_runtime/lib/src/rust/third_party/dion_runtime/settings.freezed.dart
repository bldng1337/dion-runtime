// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DropdownOption _$DropdownOptionFromJson(Map<String, dynamic> json) {
  return _DropdownOption.fromJson(json);
}

/// @nodoc
mixin _$DropdownOption {
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  /// Serializes this DropdownOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropdownOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropdownOptionCopyWith<DropdownOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropdownOptionCopyWith<$Res> {
  factory $DropdownOptionCopyWith(
          DropdownOption value, $Res Function(DropdownOption) then) =
      _$DropdownOptionCopyWithImpl<$Res, DropdownOption>;
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class _$DropdownOptionCopyWithImpl<$Res, $Val extends DropdownOption>
    implements $DropdownOptionCopyWith<$Res> {
  _$DropdownOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropdownOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DropdownOptionImplCopyWith<$Res>
    implements $DropdownOptionCopyWith<$Res> {
  factory _$$DropdownOptionImplCopyWith(_$DropdownOptionImpl value,
          $Res Function(_$DropdownOptionImpl) then) =
      __$$DropdownOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class __$$DropdownOptionImplCopyWithImpl<$Res>
    extends _$DropdownOptionCopyWithImpl<$Res, _$DropdownOptionImpl>
    implements _$$DropdownOptionImplCopyWith<$Res> {
  __$$DropdownOptionImplCopyWithImpl(
      _$DropdownOptionImpl _value, $Res Function(_$DropdownOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DropdownOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_$DropdownOptionImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DropdownOptionImpl implements _DropdownOption {
  const _$DropdownOptionImpl({required this.label, required this.value});

  factory _$DropdownOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropdownOptionImplFromJson(json);

  @override
  final String label;
  @override
  final String value;

  @override
  String toString() {
    return 'DropdownOption(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropdownOptionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of DropdownOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropdownOptionImplCopyWith<_$DropdownOptionImpl> get copyWith =>
      __$$DropdownOptionImplCopyWithImpl<_$DropdownOptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DropdownOptionImplToJson(
      this,
    );
  }
}

abstract class _DropdownOption implements DropdownOption {
  const factory _DropdownOption(
      {required final String label,
      required final String value}) = _$DropdownOptionImpl;

  factory _DropdownOption.fromJson(Map<String, dynamic> json) =
      _$DropdownOptionImpl.fromJson;

  @override
  String get label;
  @override
  String get value;

  /// Create a copy of DropdownOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropdownOptionImplCopyWith<_$DropdownOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return _Setting.fromJson(json);
}

/// @nodoc
mixin _$Setting {
  String get label => throw _privateConstructorUsedError;
  SettingValue get value => throw _privateConstructorUsedError;
  SettingValue get default_ => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  SettingsUI? get ui => throw _privateConstructorUsedError;

  /// Serializes this Setting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingCopyWith<Setting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingCopyWith<$Res> {
  factory $SettingCopyWith(Setting value, $Res Function(Setting) then) =
      _$SettingCopyWithImpl<$Res, Setting>;
  @useResult
  $Res call(
      {String label,
      SettingValue value,
      SettingValue default_,
      bool visible,
      SettingsUI? ui});

  $SettingValueCopyWith<$Res> get value;
  $SettingValueCopyWith<$Res> get default_;
  $SettingsUICopyWith<$Res>? get ui;
}

/// @nodoc
class _$SettingCopyWithImpl<$Res, $Val extends Setting>
    implements $SettingCopyWith<$Res> {
  _$SettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? default_ = null,
    Object? visible = null,
    Object? ui = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as SettingValue,
      default_: null == default_
          ? _value.default_
          : default_ // ignore: cast_nullable_to_non_nullable
              as SettingValue,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as SettingsUI?,
    ) as $Val);
  }

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingValueCopyWith<$Res> get value {
    return $SettingValueCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingValueCopyWith<$Res> get default_ {
    return $SettingValueCopyWith<$Res>(_value.default_, (value) {
      return _then(_value.copyWith(default_: value) as $Val);
    });
  }

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingsUICopyWith<$Res>? get ui {
    if (_value.ui == null) {
      return null;
    }

    return $SettingsUICopyWith<$Res>(_value.ui!, (value) {
      return _then(_value.copyWith(ui: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SettingImplCopyWith<$Res> implements $SettingCopyWith<$Res> {
  factory _$$SettingImplCopyWith(
          _$SettingImpl value, $Res Function(_$SettingImpl) then) =
      __$$SettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      SettingValue value,
      SettingValue default_,
      bool visible,
      SettingsUI? ui});

  @override
  $SettingValueCopyWith<$Res> get value;
  @override
  $SettingValueCopyWith<$Res> get default_;
  @override
  $SettingsUICopyWith<$Res>? get ui;
}

/// @nodoc
class __$$SettingImplCopyWithImpl<$Res>
    extends _$SettingCopyWithImpl<$Res, _$SettingImpl>
    implements _$$SettingImplCopyWith<$Res> {
  __$$SettingImplCopyWithImpl(
      _$SettingImpl _value, $Res Function(_$SettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? default_ = null,
    Object? visible = null,
    Object? ui = freezed,
  }) {
    return _then(_$SettingImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as SettingValue,
      default_: null == default_
          ? _value.default_
          : default_ // ignore: cast_nullable_to_non_nullable
              as SettingValue,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as SettingsUI?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingImpl implements _Setting {
  const _$SettingImpl(
      {required this.label,
      required this.value,
      required this.default_,
      required this.visible,
      this.ui});

  factory _$SettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingImplFromJson(json);

  @override
  final String label;
  @override
  final SettingValue value;
  @override
  final SettingValue default_;
  @override
  final bool visible;
  @override
  final SettingsUI? ui;

  @override
  String toString() {
    return 'Setting(label: $label, value: $value, default_: $default_, visible: $visible, ui: $ui)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.default_, default_) ||
                other.default_ == default_) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, label, value, default_, visible, ui);

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      __$$SettingImplCopyWithImpl<_$SettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingImplToJson(
      this,
    );
  }
}

abstract class _Setting implements Setting {
  const factory _Setting(
      {required final String label,
      required final SettingValue value,
      required final SettingValue default_,
      required final bool visible,
      final SettingsUI? ui}) = _$SettingImpl;

  factory _Setting.fromJson(Map<String, dynamic> json) = _$SettingImpl.fromJson;

  @override
  String get label;
  @override
  SettingValue get value;
  @override
  SettingValue get default_;
  @override
  bool get visible;
  @override
  SettingsUI? get ui;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SettingValue _$SettingValueFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'string':
      return SettingValue_String.fromJson(json);
    case 'number':
      return SettingValue_Number.fromJson(json);
    case 'boolean':
      return SettingValue_Boolean.fromJson(json);
    case 'stringList':
      return SettingValue_StringList.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SettingValue',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SettingValue {
  Object get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String data) string,
    required TResult Function(double data) number,
    required TResult Function(bool data) boolean,
    required TResult Function(List<String> data) stringList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String data)? string,
    TResult? Function(double data)? number,
    TResult? Function(bool data)? boolean,
    TResult? Function(List<String> data)? stringList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String data)? string,
    TResult Function(double data)? number,
    TResult Function(bool data)? boolean,
    TResult Function(List<String> data)? stringList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingValue_String value) string,
    required TResult Function(SettingValue_Number value) number,
    required TResult Function(SettingValue_Boolean value) boolean,
    required TResult Function(SettingValue_StringList value) stringList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingValue_String value)? string,
    TResult? Function(SettingValue_Number value)? number,
    TResult? Function(SettingValue_Boolean value)? boolean,
    TResult? Function(SettingValue_StringList value)? stringList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingValue_String value)? string,
    TResult Function(SettingValue_Number value)? number,
    TResult Function(SettingValue_Boolean value)? boolean,
    TResult Function(SettingValue_StringList value)? stringList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SettingValue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingValueCopyWith<$Res> {
  factory $SettingValueCopyWith(
          SettingValue value, $Res Function(SettingValue) then) =
      _$SettingValueCopyWithImpl<$Res, SettingValue>;
}

/// @nodoc
class _$SettingValueCopyWithImpl<$Res, $Val extends SettingValue>
    implements $SettingValueCopyWith<$Res> {
  _$SettingValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SettingValue_StringImplCopyWith<$Res> {
  factory _$$SettingValue_StringImplCopyWith(_$SettingValue_StringImpl value,
          $Res Function(_$SettingValue_StringImpl) then) =
      __$$SettingValue_StringImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String data});
}

/// @nodoc
class __$$SettingValue_StringImplCopyWithImpl<$Res>
    extends _$SettingValueCopyWithImpl<$Res, _$SettingValue_StringImpl>
    implements _$$SettingValue_StringImplCopyWith<$Res> {
  __$$SettingValue_StringImplCopyWithImpl(_$SettingValue_StringImpl _value,
      $Res Function(_$SettingValue_StringImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SettingValue_StringImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingValue_StringImpl extends SettingValue_String {
  const _$SettingValue_StringImpl({required this.data, final String? $type})
      : $type = $type ?? 'string',
        super._();

  factory _$SettingValue_StringImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingValue_StringImplFromJson(json);

  @override
  final String data;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingValue.string(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingValue_StringImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingValue_StringImplCopyWith<_$SettingValue_StringImpl> get copyWith =>
      __$$SettingValue_StringImplCopyWithImpl<_$SettingValue_StringImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String data) string,
    required TResult Function(double data) number,
    required TResult Function(bool data) boolean,
    required TResult Function(List<String> data) stringList,
  }) {
    return string(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String data)? string,
    TResult? Function(double data)? number,
    TResult? Function(bool data)? boolean,
    TResult? Function(List<String> data)? stringList,
  }) {
    return string?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String data)? string,
    TResult Function(double data)? number,
    TResult Function(bool data)? boolean,
    TResult Function(List<String> data)? stringList,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingValue_String value) string,
    required TResult Function(SettingValue_Number value) number,
    required TResult Function(SettingValue_Boolean value) boolean,
    required TResult Function(SettingValue_StringList value) stringList,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingValue_String value)? string,
    TResult? Function(SettingValue_Number value)? number,
    TResult? Function(SettingValue_Boolean value)? boolean,
    TResult? Function(SettingValue_StringList value)? stringList,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingValue_String value)? string,
    TResult Function(SettingValue_Number value)? number,
    TResult Function(SettingValue_Boolean value)? boolean,
    TResult Function(SettingValue_StringList value)? stringList,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingValue_StringImplToJson(
      this,
    );
  }
}

abstract class SettingValue_String extends SettingValue {
  const factory SettingValue_String({required final String data}) =
      _$SettingValue_StringImpl;
  const SettingValue_String._() : super._();

  factory SettingValue_String.fromJson(Map<String, dynamic> json) =
      _$SettingValue_StringImpl.fromJson;

  @override
  String get data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingValue_StringImplCopyWith<_$SettingValue_StringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingValue_NumberImplCopyWith<$Res> {
  factory _$$SettingValue_NumberImplCopyWith(_$SettingValue_NumberImpl value,
          $Res Function(_$SettingValue_NumberImpl) then) =
      __$$SettingValue_NumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double data});
}

/// @nodoc
class __$$SettingValue_NumberImplCopyWithImpl<$Res>
    extends _$SettingValueCopyWithImpl<$Res, _$SettingValue_NumberImpl>
    implements _$$SettingValue_NumberImplCopyWith<$Res> {
  __$$SettingValue_NumberImplCopyWithImpl(_$SettingValue_NumberImpl _value,
      $Res Function(_$SettingValue_NumberImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SettingValue_NumberImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingValue_NumberImpl extends SettingValue_Number {
  const _$SettingValue_NumberImpl({required this.data, final String? $type})
      : $type = $type ?? 'number',
        super._();

  factory _$SettingValue_NumberImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingValue_NumberImplFromJson(json);

  @override
  final double data;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingValue.number(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingValue_NumberImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingValue_NumberImplCopyWith<_$SettingValue_NumberImpl> get copyWith =>
      __$$SettingValue_NumberImplCopyWithImpl<_$SettingValue_NumberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String data) string,
    required TResult Function(double data) number,
    required TResult Function(bool data) boolean,
    required TResult Function(List<String> data) stringList,
  }) {
    return number(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String data)? string,
    TResult? Function(double data)? number,
    TResult? Function(bool data)? boolean,
    TResult? Function(List<String> data)? stringList,
  }) {
    return number?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String data)? string,
    TResult Function(double data)? number,
    TResult Function(bool data)? boolean,
    TResult Function(List<String> data)? stringList,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingValue_String value) string,
    required TResult Function(SettingValue_Number value) number,
    required TResult Function(SettingValue_Boolean value) boolean,
    required TResult Function(SettingValue_StringList value) stringList,
  }) {
    return number(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingValue_String value)? string,
    TResult? Function(SettingValue_Number value)? number,
    TResult? Function(SettingValue_Boolean value)? boolean,
    TResult? Function(SettingValue_StringList value)? stringList,
  }) {
    return number?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingValue_String value)? string,
    TResult Function(SettingValue_Number value)? number,
    TResult Function(SettingValue_Boolean value)? boolean,
    TResult Function(SettingValue_StringList value)? stringList,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingValue_NumberImplToJson(
      this,
    );
  }
}

abstract class SettingValue_Number extends SettingValue {
  const factory SettingValue_Number({required final double data}) =
      _$SettingValue_NumberImpl;
  const SettingValue_Number._() : super._();

  factory SettingValue_Number.fromJson(Map<String, dynamic> json) =
      _$SettingValue_NumberImpl.fromJson;

  @override
  double get data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingValue_NumberImplCopyWith<_$SettingValue_NumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingValue_BooleanImplCopyWith<$Res> {
  factory _$$SettingValue_BooleanImplCopyWith(_$SettingValue_BooleanImpl value,
          $Res Function(_$SettingValue_BooleanImpl) then) =
      __$$SettingValue_BooleanImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool data});
}

/// @nodoc
class __$$SettingValue_BooleanImplCopyWithImpl<$Res>
    extends _$SettingValueCopyWithImpl<$Res, _$SettingValue_BooleanImpl>
    implements _$$SettingValue_BooleanImplCopyWith<$Res> {
  __$$SettingValue_BooleanImplCopyWithImpl(_$SettingValue_BooleanImpl _value,
      $Res Function(_$SettingValue_BooleanImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SettingValue_BooleanImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingValue_BooleanImpl extends SettingValue_Boolean {
  const _$SettingValue_BooleanImpl({required this.data, final String? $type})
      : $type = $type ?? 'boolean',
        super._();

  factory _$SettingValue_BooleanImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingValue_BooleanImplFromJson(json);

  @override
  final bool data;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingValue.boolean(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingValue_BooleanImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingValue_BooleanImplCopyWith<_$SettingValue_BooleanImpl>
      get copyWith =>
          __$$SettingValue_BooleanImplCopyWithImpl<_$SettingValue_BooleanImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String data) string,
    required TResult Function(double data) number,
    required TResult Function(bool data) boolean,
    required TResult Function(List<String> data) stringList,
  }) {
    return boolean(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String data)? string,
    TResult? Function(double data)? number,
    TResult? Function(bool data)? boolean,
    TResult? Function(List<String> data)? stringList,
  }) {
    return boolean?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String data)? string,
    TResult Function(double data)? number,
    TResult Function(bool data)? boolean,
    TResult Function(List<String> data)? stringList,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingValue_String value) string,
    required TResult Function(SettingValue_Number value) number,
    required TResult Function(SettingValue_Boolean value) boolean,
    required TResult Function(SettingValue_StringList value) stringList,
  }) {
    return boolean(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingValue_String value)? string,
    TResult? Function(SettingValue_Number value)? number,
    TResult? Function(SettingValue_Boolean value)? boolean,
    TResult? Function(SettingValue_StringList value)? stringList,
  }) {
    return boolean?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingValue_String value)? string,
    TResult Function(SettingValue_Number value)? number,
    TResult Function(SettingValue_Boolean value)? boolean,
    TResult Function(SettingValue_StringList value)? stringList,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingValue_BooleanImplToJson(
      this,
    );
  }
}

abstract class SettingValue_Boolean extends SettingValue {
  const factory SettingValue_Boolean({required final bool data}) =
      _$SettingValue_BooleanImpl;
  const SettingValue_Boolean._() : super._();

  factory SettingValue_Boolean.fromJson(Map<String, dynamic> json) =
      _$SettingValue_BooleanImpl.fromJson;

  @override
  bool get data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingValue_BooleanImplCopyWith<_$SettingValue_BooleanImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingValue_StringListImplCopyWith<$Res> {
  factory _$$SettingValue_StringListImplCopyWith(
          _$SettingValue_StringListImpl value,
          $Res Function(_$SettingValue_StringListImpl) then) =
      __$$SettingValue_StringListImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> data});
}

/// @nodoc
class __$$SettingValue_StringListImplCopyWithImpl<$Res>
    extends _$SettingValueCopyWithImpl<$Res, _$SettingValue_StringListImpl>
    implements _$$SettingValue_StringListImplCopyWith<$Res> {
  __$$SettingValue_StringListImplCopyWithImpl(
      _$SettingValue_StringListImpl _value,
      $Res Function(_$SettingValue_StringListImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SettingValue_StringListImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingValue_StringListImpl extends SettingValue_StringList {
  const _$SettingValue_StringListImpl(
      {required final List<String> data, final String? $type})
      : _data = data,
        $type = $type ?? 'stringList',
        super._();

  factory _$SettingValue_StringListImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingValue_StringListImplFromJson(json);

  final List<String> _data;
  @override
  List<String> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingValue.stringList(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingValue_StringListImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingValue_StringListImplCopyWith<_$SettingValue_StringListImpl>
      get copyWith => __$$SettingValue_StringListImplCopyWithImpl<
          _$SettingValue_StringListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String data) string,
    required TResult Function(double data) number,
    required TResult Function(bool data) boolean,
    required TResult Function(List<String> data) stringList,
  }) {
    return stringList(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String data)? string,
    TResult? Function(double data)? number,
    TResult? Function(bool data)? boolean,
    TResult? Function(List<String> data)? stringList,
  }) {
    return stringList?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String data)? string,
    TResult Function(double data)? number,
    TResult Function(bool data)? boolean,
    TResult Function(List<String> data)? stringList,
    required TResult orElse(),
  }) {
    if (stringList != null) {
      return stringList(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingValue_String value) string,
    required TResult Function(SettingValue_Number value) number,
    required TResult Function(SettingValue_Boolean value) boolean,
    required TResult Function(SettingValue_StringList value) stringList,
  }) {
    return stringList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingValue_String value)? string,
    TResult? Function(SettingValue_Number value)? number,
    TResult? Function(SettingValue_Boolean value)? boolean,
    TResult? Function(SettingValue_StringList value)? stringList,
  }) {
    return stringList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingValue_String value)? string,
    TResult Function(SettingValue_Number value)? number,
    TResult Function(SettingValue_Boolean value)? boolean,
    TResult Function(SettingValue_StringList value)? stringList,
    required TResult orElse(),
  }) {
    if (stringList != null) {
      return stringList(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingValue_StringListImplToJson(
      this,
    );
  }
}

abstract class SettingValue_StringList extends SettingValue {
  const factory SettingValue_StringList({required final List<String> data}) =
      _$SettingValue_StringListImpl;
  const SettingValue_StringList._() : super._();

  factory SettingValue_StringList.fromJson(Map<String, dynamic> json) =
      _$SettingValue_StringListImpl.fromJson;

  @override
  List<String> get data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingValue_StringListImplCopyWith<_$SettingValue_StringListImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SettingsUI _$SettingsUIFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'checkBox':
      return SettingsUI_CheckBox.fromJson(json);
    case 'slider':
      return SettingsUI_Slider.fromJson(json);
    case 'dropdown':
      return SettingsUI_Dropdown.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SettingsUI',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SettingsUI {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SettingsUI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsUICopyWith<$Res> {
  factory $SettingsUICopyWith(
          SettingsUI value, $Res Function(SettingsUI) then) =
      _$SettingsUICopyWithImpl<$Res, SettingsUI>;
}

/// @nodoc
class _$SettingsUICopyWithImpl<$Res, $Val extends SettingsUI>
    implements $SettingsUICopyWith<$Res> {
  _$SettingsUICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SettingsUI_CheckBoxImplCopyWith<$Res> {
  factory _$$SettingsUI_CheckBoxImplCopyWith(_$SettingsUI_CheckBoxImpl value,
          $Res Function(_$SettingsUI_CheckBoxImpl) then) =
      __$$SettingsUI_CheckBoxImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SettingsUI_CheckBoxImplCopyWithImpl<$Res>
    extends _$SettingsUICopyWithImpl<$Res, _$SettingsUI_CheckBoxImpl>
    implements _$$SettingsUI_CheckBoxImplCopyWith<$Res> {
  __$$SettingsUI_CheckBoxImplCopyWithImpl(_$SettingsUI_CheckBoxImpl _value,
      $Res Function(_$SettingsUI_CheckBoxImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$SettingsUI_CheckBoxImpl extends SettingsUI_CheckBox {
  const _$SettingsUI_CheckBoxImpl({final String? $type})
      : $type = $type ?? 'checkBox',
        super._();

  factory _$SettingsUI_CheckBoxImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsUI_CheckBoxImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsUI.checkBox()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsUI_CheckBoxImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
  }) {
    return checkBox();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
  }) {
    return checkBox?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    required TResult orElse(),
  }) {
    if (checkBox != null) {
      return checkBox();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
  }) {
    return checkBox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
  }) {
    return checkBox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (checkBox != null) {
      return checkBox(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsUI_CheckBoxImplToJson(
      this,
    );
  }
}

abstract class SettingsUI_CheckBox extends SettingsUI {
  const factory SettingsUI_CheckBox() = _$SettingsUI_CheckBoxImpl;
  const SettingsUI_CheckBox._() : super._();

  factory SettingsUI_CheckBox.fromJson(Map<String, dynamic> json) =
      _$SettingsUI_CheckBoxImpl.fromJson;
}

/// @nodoc
abstract class _$$SettingsUI_SliderImplCopyWith<$Res> {
  factory _$$SettingsUI_SliderImplCopyWith(_$SettingsUI_SliderImpl value,
          $Res Function(_$SettingsUI_SliderImpl) then) =
      __$$SettingsUI_SliderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double min, double max, int step});
}

/// @nodoc
class __$$SettingsUI_SliderImplCopyWithImpl<$Res>
    extends _$SettingsUICopyWithImpl<$Res, _$SettingsUI_SliderImpl>
    implements _$$SettingsUI_SliderImplCopyWith<$Res> {
  __$$SettingsUI_SliderImplCopyWithImpl(_$SettingsUI_SliderImpl _value,
      $Res Function(_$SettingsUI_SliderImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? step = null,
  }) {
    return _then(_$SettingsUI_SliderImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsUI_SliderImpl extends SettingsUI_Slider {
  const _$SettingsUI_SliderImpl(
      {required this.min,
      required this.max,
      required this.step,
      final String? $type})
      : $type = $type ?? 'slider',
        super._();

  factory _$SettingsUI_SliderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsUI_SliderImplFromJson(json);

  @override
  final double min;
  @override
  final double max;
  @override
  final int step;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsUI.slider(min: $min, max: $max, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsUI_SliderImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.step, step) || other.step == step));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max, step);

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsUI_SliderImplCopyWith<_$SettingsUI_SliderImpl> get copyWith =>
      __$$SettingsUI_SliderImplCopyWithImpl<_$SettingsUI_SliderImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
  }) {
    return slider(min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
  }) {
    return slider?.call(min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    required TResult orElse(),
  }) {
    if (slider != null) {
      return slider(min, max, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
  }) {
    return slider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
  }) {
    return slider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (slider != null) {
      return slider(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsUI_SliderImplToJson(
      this,
    );
  }
}

abstract class SettingsUI_Slider extends SettingsUI {
  const factory SettingsUI_Slider(
      {required final double min,
      required final double max,
      required final int step}) = _$SettingsUI_SliderImpl;
  const SettingsUI_Slider._() : super._();

  factory SettingsUI_Slider.fromJson(Map<String, dynamic> json) =
      _$SettingsUI_SliderImpl.fromJson;

  double get min;
  double get max;
  int get step;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsUI_SliderImplCopyWith<_$SettingsUI_SliderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingsUI_DropdownImplCopyWith<$Res> {
  factory _$$SettingsUI_DropdownImplCopyWith(_$SettingsUI_DropdownImpl value,
          $Res Function(_$SettingsUI_DropdownImpl) then) =
      __$$SettingsUI_DropdownImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DropdownOption> options});
}

/// @nodoc
class __$$SettingsUI_DropdownImplCopyWithImpl<$Res>
    extends _$SettingsUICopyWithImpl<$Res, _$SettingsUI_DropdownImpl>
    implements _$$SettingsUI_DropdownImplCopyWith<$Res> {
  __$$SettingsUI_DropdownImplCopyWithImpl(_$SettingsUI_DropdownImpl _value,
      $Res Function(_$SettingsUI_DropdownImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
  }) {
    return _then(_$SettingsUI_DropdownImpl(
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DropdownOption>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsUI_DropdownImpl extends SettingsUI_Dropdown {
  const _$SettingsUI_DropdownImpl(
      {required final List<DropdownOption> options, final String? $type})
      : _options = options,
        $type = $type ?? 'dropdown',
        super._();

  factory _$SettingsUI_DropdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsUI_DropdownImplFromJson(json);

  final List<DropdownOption> _options;
  @override
  List<DropdownOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SettingsUI.dropdown(options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsUI_DropdownImpl &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_options));

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsUI_DropdownImplCopyWith<_$SettingsUI_DropdownImpl> get copyWith =>
      __$$SettingsUI_DropdownImplCopyWithImpl<_$SettingsUI_DropdownImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
  }) {
    return dropdown(options);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
  }) {
    return dropdown?.call(options);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    required TResult orElse(),
  }) {
    if (dropdown != null) {
      return dropdown(options);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
  }) {
    return dropdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
  }) {
    return dropdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (dropdown != null) {
      return dropdown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsUI_DropdownImplToJson(
      this,
    );
  }
}

abstract class SettingsUI_Dropdown extends SettingsUI {
  const factory SettingsUI_Dropdown(
          {required final List<DropdownOption> options}) =
      _$SettingsUI_DropdownImpl;
  const SettingsUI_Dropdown._() : super._();

  factory SettingsUI_Dropdown.fromJson(Map<String, dynamic> json) =
      _$SettingsUI_DropdownImpl.fromJson;

  List<DropdownOption> get options;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsUI_DropdownImplCopyWith<_$SettingsUI_DropdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
