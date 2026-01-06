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

class _$SettingValue_StringImpl extends SettingValue_String {
  const _$SettingValue_StringImpl({required this.data}) : super._();

  @override
  final String data;

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
}

abstract class SettingValue_String extends SettingValue {
  const factory SettingValue_String({required final String data}) =
      _$SettingValue_StringImpl;
  const SettingValue_String._() : super._();

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

class _$SettingValue_NumberImpl extends SettingValue_Number {
  const _$SettingValue_NumberImpl({required this.data}) : super._();

  @override
  final double data;

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
}

abstract class SettingValue_Number extends SettingValue {
  const factory SettingValue_Number({required final double data}) =
      _$SettingValue_NumberImpl;
  const SettingValue_Number._() : super._();

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

class _$SettingValue_BooleanImpl extends SettingValue_Boolean {
  const _$SettingValue_BooleanImpl({required this.data}) : super._();

  @override
  final bool data;

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
}

abstract class SettingValue_Boolean extends SettingValue {
  const factory SettingValue_Boolean({required final bool data}) =
      _$SettingValue_BooleanImpl;
  const SettingValue_Boolean._() : super._();

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

class _$SettingValue_StringListImpl extends SettingValue_StringList {
  const _$SettingValue_StringListImpl({required final List<String> data})
      : _data = data,
        super._();

  final List<String> _data;
  @override
  List<String> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

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
}

abstract class SettingValue_StringList extends SettingValue {
  const factory SettingValue_StringList({required final List<String> data}) =
      _$SettingValue_StringListImpl;
  const SettingValue_StringList._() : super._();

  @override
  List<String> get data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingValue_StringListImplCopyWith<_$SettingValue_StringListImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SettingsUI {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
    required TResult Function(List<DropdownOption> options) multiDropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
    TResult? Function(List<DropdownOption> options)? multiDropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    TResult Function(List<DropdownOption> options)? multiDropdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
    required TResult Function(SettingsUI_MultiDropdown value) multiDropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
    TResult? Function(SettingsUI_MultiDropdown value)? multiDropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    TResult Function(SettingsUI_MultiDropdown value)? multiDropdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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

class _$SettingsUI_CheckBoxImpl extends SettingsUI_CheckBox {
  const _$SettingsUI_CheckBoxImpl() : super._();

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

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
    required TResult Function(List<DropdownOption> options) multiDropdown,
  }) {
    return checkBox();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
    TResult? Function(List<DropdownOption> options)? multiDropdown,
  }) {
    return checkBox?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    TResult Function(List<DropdownOption> options)? multiDropdown,
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
    required TResult Function(SettingsUI_MultiDropdown value) multiDropdown,
  }) {
    return checkBox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
    TResult? Function(SettingsUI_MultiDropdown value)? multiDropdown,
  }) {
    return checkBox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    TResult Function(SettingsUI_MultiDropdown value)? multiDropdown,
    required TResult orElse(),
  }) {
    if (checkBox != null) {
      return checkBox(this);
    }
    return orElse();
  }
}

abstract class SettingsUI_CheckBox extends SettingsUI {
  const factory SettingsUI_CheckBox() = _$SettingsUI_CheckBoxImpl;
  const SettingsUI_CheckBox._() : super._();
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

class _$SettingsUI_SliderImpl extends SettingsUI_Slider {
  const _$SettingsUI_SliderImpl(
      {required this.min, required this.max, required this.step})
      : super._();

  @override
  final double min;
  @override
  final double max;
  @override
  final int step;

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
    required TResult Function(List<DropdownOption> options) multiDropdown,
  }) {
    return slider(min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
    TResult? Function(List<DropdownOption> options)? multiDropdown,
  }) {
    return slider?.call(min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    TResult Function(List<DropdownOption> options)? multiDropdown,
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
    required TResult Function(SettingsUI_MultiDropdown value) multiDropdown,
  }) {
    return slider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
    TResult? Function(SettingsUI_MultiDropdown value)? multiDropdown,
  }) {
    return slider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    TResult Function(SettingsUI_MultiDropdown value)? multiDropdown,
    required TResult orElse(),
  }) {
    if (slider != null) {
      return slider(this);
    }
    return orElse();
  }
}

abstract class SettingsUI_Slider extends SettingsUI {
  const factory SettingsUI_Slider(
      {required final double min,
      required final double max,
      required final int step}) = _$SettingsUI_SliderImpl;
  const SettingsUI_Slider._() : super._();

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

class _$SettingsUI_DropdownImpl extends SettingsUI_Dropdown {
  const _$SettingsUI_DropdownImpl({required final List<DropdownOption> options})
      : _options = options,
        super._();

  final List<DropdownOption> _options;
  @override
  List<DropdownOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

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
    required TResult Function(List<DropdownOption> options) multiDropdown,
  }) {
    return dropdown(options);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
    TResult? Function(List<DropdownOption> options)? multiDropdown,
  }) {
    return dropdown?.call(options);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    TResult Function(List<DropdownOption> options)? multiDropdown,
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
    required TResult Function(SettingsUI_MultiDropdown value) multiDropdown,
  }) {
    return dropdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
    TResult? Function(SettingsUI_MultiDropdown value)? multiDropdown,
  }) {
    return dropdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    TResult Function(SettingsUI_MultiDropdown value)? multiDropdown,
    required TResult orElse(),
  }) {
    if (dropdown != null) {
      return dropdown(this);
    }
    return orElse();
  }
}

abstract class SettingsUI_Dropdown extends SettingsUI {
  const factory SettingsUI_Dropdown(
          {required final List<DropdownOption> options}) =
      _$SettingsUI_DropdownImpl;
  const SettingsUI_Dropdown._() : super._();

  List<DropdownOption> get options;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsUI_DropdownImplCopyWith<_$SettingsUI_DropdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingsUI_MultiDropdownImplCopyWith<$Res> {
  factory _$$SettingsUI_MultiDropdownImplCopyWith(
          _$SettingsUI_MultiDropdownImpl value,
          $Res Function(_$SettingsUI_MultiDropdownImpl) then) =
      __$$SettingsUI_MultiDropdownImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DropdownOption> options});
}

/// @nodoc
class __$$SettingsUI_MultiDropdownImplCopyWithImpl<$Res>
    extends _$SettingsUICopyWithImpl<$Res, _$SettingsUI_MultiDropdownImpl>
    implements _$$SettingsUI_MultiDropdownImplCopyWith<$Res> {
  __$$SettingsUI_MultiDropdownImplCopyWithImpl(
      _$SettingsUI_MultiDropdownImpl _value,
      $Res Function(_$SettingsUI_MultiDropdownImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
  }) {
    return _then(_$SettingsUI_MultiDropdownImpl(
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DropdownOption>,
    ));
  }
}

/// @nodoc

class _$SettingsUI_MultiDropdownImpl extends SettingsUI_MultiDropdown {
  const _$SettingsUI_MultiDropdownImpl(
      {required final List<DropdownOption> options})
      : _options = options,
        super._();

  final List<DropdownOption> _options;
  @override
  List<DropdownOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'SettingsUI.multiDropdown(options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsUI_MultiDropdownImpl &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_options));

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsUI_MultiDropdownImplCopyWith<_$SettingsUI_MultiDropdownImpl>
      get copyWith => __$$SettingsUI_MultiDropdownImplCopyWithImpl<
          _$SettingsUI_MultiDropdownImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
    required TResult Function(List<DropdownOption> options) multiDropdown,
  }) {
    return multiDropdown(options);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
    TResult? Function(List<DropdownOption> options)? multiDropdown,
  }) {
    return multiDropdown?.call(options);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    TResult Function(List<DropdownOption> options)? multiDropdown,
    required TResult orElse(),
  }) {
    if (multiDropdown != null) {
      return multiDropdown(options);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
    required TResult Function(SettingsUI_MultiDropdown value) multiDropdown,
  }) {
    return multiDropdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
    TResult? Function(SettingsUI_MultiDropdown value)? multiDropdown,
  }) {
    return multiDropdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    TResult Function(SettingsUI_MultiDropdown value)? multiDropdown,
    required TResult orElse(),
  }) {
    if (multiDropdown != null) {
      return multiDropdown(this);
    }
    return orElse();
  }
}

abstract class SettingsUI_MultiDropdown extends SettingsUI {
  const factory SettingsUI_MultiDropdown(
          {required final List<DropdownOption> options}) =
      _$SettingsUI_MultiDropdownImpl;
  const SettingsUI_MultiDropdown._() : super._();

  List<DropdownOption> get options;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsUI_MultiDropdownImplCopyWith<_$SettingsUI_MultiDropdownImpl>
      get copyWith => throw _privateConstructorUsedError;
}
