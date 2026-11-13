// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingValue {
  Object get data;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingValue &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'SettingValue(data: $data)';
  }
}

/// @nodoc
class $SettingValueCopyWith<$Res> {
  $SettingValueCopyWith(SettingValue _, $Res Function(SettingValue) __);
}

/// Adds pattern-matching-related methods to [SettingValue].
extension SettingValuePatterns on SettingValue {
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
    TResult Function(SettingValue_String value)? string,
    TResult Function(SettingValue_Number value)? number,
    TResult Function(SettingValue_Boolean value)? boolean,
    TResult Function(SettingValue_StringList value)? stringList,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingValue_String() when string != null:
        return string(_that);
      case SettingValue_Number() when number != null:
        return number(_that);
      case SettingValue_Boolean() when boolean != null:
        return boolean(_that);
      case SettingValue_StringList() when stringList != null:
        return stringList(_that);
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
    required TResult Function(SettingValue_String value) string,
    required TResult Function(SettingValue_Number value) number,
    required TResult Function(SettingValue_Boolean value) boolean,
    required TResult Function(SettingValue_StringList value) stringList,
  }) {
    final _that = this;
    switch (_that) {
      case SettingValue_String():
        return string(_that);
      case SettingValue_Number():
        return number(_that);
      case SettingValue_Boolean():
        return boolean(_that);
      case SettingValue_StringList():
        return stringList(_that);
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
    TResult? Function(SettingValue_String value)? string,
    TResult? Function(SettingValue_Number value)? number,
    TResult? Function(SettingValue_Boolean value)? boolean,
    TResult? Function(SettingValue_StringList value)? stringList,
  }) {
    final _that = this;
    switch (_that) {
      case SettingValue_String() when string != null:
        return string(_that);
      case SettingValue_Number() when number != null:
        return number(_that);
      case SettingValue_Boolean() when boolean != null:
        return boolean(_that);
      case SettingValue_StringList() when stringList != null:
        return stringList(_that);
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
    TResult Function(String data)? string,
    TResult Function(double data)? number,
    TResult Function(bool data)? boolean,
    TResult Function(List<String> data)? stringList,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingValue_String() when string != null:
        return string(_that.data);
      case SettingValue_Number() when number != null:
        return number(_that.data);
      case SettingValue_Boolean() when boolean != null:
        return boolean(_that.data);
      case SettingValue_StringList() when stringList != null:
        return stringList(_that.data);
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
    required TResult Function(String data) string,
    required TResult Function(double data) number,
    required TResult Function(bool data) boolean,
    required TResult Function(List<String> data) stringList,
  }) {
    final _that = this;
    switch (_that) {
      case SettingValue_String():
        return string(_that.data);
      case SettingValue_Number():
        return number(_that.data);
      case SettingValue_Boolean():
        return boolean(_that.data);
      case SettingValue_StringList():
        return stringList(_that.data);
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
    TResult? Function(String data)? string,
    TResult? Function(double data)? number,
    TResult? Function(bool data)? boolean,
    TResult? Function(List<String> data)? stringList,
  }) {
    final _that = this;
    switch (_that) {
      case SettingValue_String() when string != null:
        return string(_that.data);
      case SettingValue_Number() when number != null:
        return number(_that.data);
      case SettingValue_Boolean() when boolean != null:
        return boolean(_that.data);
      case SettingValue_StringList() when stringList != null:
        return stringList(_that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SettingValue_String extends SettingValue {
  const SettingValue_String({required this.data}) : super._();

  @override
  final String data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingValue_StringCopyWith<SettingValue_String> get copyWith =>
      _$SettingValue_StringCopyWithImpl<SettingValue_String>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingValue_String &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'SettingValue.string(data: $data)';
  }
}

/// @nodoc
abstract mixin class $SettingValue_StringCopyWith<$Res>
    implements $SettingValueCopyWith<$Res> {
  factory $SettingValue_StringCopyWith(
          SettingValue_String value, $Res Function(SettingValue_String) _then) =
      _$SettingValue_StringCopyWithImpl;
  @useResult
  $Res call({String data});
}

/// @nodoc
class _$SettingValue_StringCopyWithImpl<$Res>
    implements $SettingValue_StringCopyWith<$Res> {
  _$SettingValue_StringCopyWithImpl(this._self, this._then);

  final SettingValue_String _self;
  final $Res Function(SettingValue_String) _then;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(SettingValue_String(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SettingValue_Number extends SettingValue {
  const SettingValue_Number({required this.data}) : super._();

  @override
  final double data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingValue_NumberCopyWith<SettingValue_Number> get copyWith =>
      _$SettingValue_NumberCopyWithImpl<SettingValue_Number>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingValue_Number &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'SettingValue.number(data: $data)';
  }
}

/// @nodoc
abstract mixin class $SettingValue_NumberCopyWith<$Res>
    implements $SettingValueCopyWith<$Res> {
  factory $SettingValue_NumberCopyWith(
          SettingValue_Number value, $Res Function(SettingValue_Number) _then) =
      _$SettingValue_NumberCopyWithImpl;
  @useResult
  $Res call({double data});
}

/// @nodoc
class _$SettingValue_NumberCopyWithImpl<$Res>
    implements $SettingValue_NumberCopyWith<$Res> {
  _$SettingValue_NumberCopyWithImpl(this._self, this._then);

  final SettingValue_Number _self;
  final $Res Function(SettingValue_Number) _then;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(SettingValue_Number(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class SettingValue_Boolean extends SettingValue {
  const SettingValue_Boolean({required this.data}) : super._();

  @override
  final bool data;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingValue_BooleanCopyWith<SettingValue_Boolean> get copyWith =>
      _$SettingValue_BooleanCopyWithImpl<SettingValue_Boolean>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingValue_Boolean &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'SettingValue.boolean(data: $data)';
  }
}

/// @nodoc
abstract mixin class $SettingValue_BooleanCopyWith<$Res>
    implements $SettingValueCopyWith<$Res> {
  factory $SettingValue_BooleanCopyWith(SettingValue_Boolean value,
          $Res Function(SettingValue_Boolean) _then) =
      _$SettingValue_BooleanCopyWithImpl;
  @useResult
  $Res call({bool data});
}

/// @nodoc
class _$SettingValue_BooleanCopyWithImpl<$Res>
    implements $SettingValue_BooleanCopyWith<$Res> {
  _$SettingValue_BooleanCopyWithImpl(this._self, this._then);

  final SettingValue_Boolean _self;
  final $Res Function(SettingValue_Boolean) _then;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(SettingValue_Boolean(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class SettingValue_StringList extends SettingValue {
  const SettingValue_StringList({required final List<String> data})
      : _data = data,
        super._();

  final List<String> _data;
  @override
  List<String> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingValue_StringListCopyWith<SettingValue_StringList> get copyWith =>
      _$SettingValue_StringListCopyWithImpl<SettingValue_StringList>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingValue_StringList &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'SettingValue.stringList(data: $data)';
  }
}

/// @nodoc
abstract mixin class $SettingValue_StringListCopyWith<$Res>
    implements $SettingValueCopyWith<$Res> {
  factory $SettingValue_StringListCopyWith(SettingValue_StringList value,
          $Res Function(SettingValue_StringList) _then) =
      _$SettingValue_StringListCopyWithImpl;
  @useResult
  $Res call({List<String> data});
}

/// @nodoc
class _$SettingValue_StringListCopyWithImpl<$Res>
    implements $SettingValue_StringListCopyWith<$Res> {
  _$SettingValue_StringListCopyWithImpl(this._self, this._then);

  final SettingValue_StringList _self;
  final $Res Function(SettingValue_StringList) _then;

  /// Create a copy of SettingValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(SettingValue_StringList(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$SettingsUI {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsUI);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsUI()';
  }
}

/// @nodoc
class $SettingsUICopyWith<$Res> {
  $SettingsUICopyWith(SettingsUI _, $Res Function(SettingsUI) __);
}

/// Adds pattern-matching-related methods to [SettingsUI].
extension SettingsUIPatterns on SettingsUI {
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
    TResult Function(SettingsUI_CheckBox value)? checkBox,
    TResult Function(SettingsUI_Slider value)? slider,
    TResult Function(SettingsUI_Dropdown value)? dropdown,
    TResult Function(SettingsUI_MultiDropdown value)? multiDropdown,
    TResult Function(SettingsUI_Directory value)? directory,
    TResult Function(SettingsUI_CustomUI value)? customUi,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingsUI_CheckBox() when checkBox != null:
        return checkBox(_that);
      case SettingsUI_Slider() when slider != null:
        return slider(_that);
      case SettingsUI_Dropdown() when dropdown != null:
        return dropdown(_that);
      case SettingsUI_MultiDropdown() when multiDropdown != null:
        return multiDropdown(_that);
      case SettingsUI_Directory() when directory != null:
        return directory(_that);
      case SettingsUI_CustomUI() when customUi != null:
        return customUi(_that);
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
    required TResult Function(SettingsUI_CheckBox value) checkBox,
    required TResult Function(SettingsUI_Slider value) slider,
    required TResult Function(SettingsUI_Dropdown value) dropdown,
    required TResult Function(SettingsUI_MultiDropdown value) multiDropdown,
    required TResult Function(SettingsUI_Directory value) directory,
    required TResult Function(SettingsUI_CustomUI value) customUi,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsUI_CheckBox():
        return checkBox(_that);
      case SettingsUI_Slider():
        return slider(_that);
      case SettingsUI_Dropdown():
        return dropdown(_that);
      case SettingsUI_MultiDropdown():
        return multiDropdown(_that);
      case SettingsUI_Directory():
        return directory(_that);
      case SettingsUI_CustomUI():
        return customUi(_that);
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
    TResult? Function(SettingsUI_CheckBox value)? checkBox,
    TResult? Function(SettingsUI_Slider value)? slider,
    TResult? Function(SettingsUI_Dropdown value)? dropdown,
    TResult? Function(SettingsUI_MultiDropdown value)? multiDropdown,
    TResult? Function(SettingsUI_Directory value)? directory,
    TResult? Function(SettingsUI_CustomUI value)? customUi,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsUI_CheckBox() when checkBox != null:
        return checkBox(_that);
      case SettingsUI_Slider() when slider != null:
        return slider(_that);
      case SettingsUI_Dropdown() when dropdown != null:
        return dropdown(_that);
      case SettingsUI_MultiDropdown() when multiDropdown != null:
        return multiDropdown(_that);
      case SettingsUI_Directory() when directory != null:
        return directory(_that);
      case SettingsUI_CustomUI() when customUi != null:
        return customUi(_that);
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
    TResult Function()? checkBox,
    TResult Function(double min, double max, int step)? slider,
    TResult Function(List<DropdownOption> options)? dropdown,
    TResult Function(List<DropdownOption> options)? multiDropdown,
    TResult Function(bool write)? directory,
    TResult Function(CustomUI ui)? customUi,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SettingsUI_CheckBox() when checkBox != null:
        return checkBox();
      case SettingsUI_Slider() when slider != null:
        return slider(_that.min, _that.max, _that.step);
      case SettingsUI_Dropdown() when dropdown != null:
        return dropdown(_that.options);
      case SettingsUI_MultiDropdown() when multiDropdown != null:
        return multiDropdown(_that.options);
      case SettingsUI_Directory() when directory != null:
        return directory(_that.write);
      case SettingsUI_CustomUI() when customUi != null:
        return customUi(_that.ui);
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
    required TResult Function() checkBox,
    required TResult Function(double min, double max, int step) slider,
    required TResult Function(List<DropdownOption> options) dropdown,
    required TResult Function(List<DropdownOption> options) multiDropdown,
    required TResult Function(bool write) directory,
    required TResult Function(CustomUI ui) customUi,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsUI_CheckBox():
        return checkBox();
      case SettingsUI_Slider():
        return slider(_that.min, _that.max, _that.step);
      case SettingsUI_Dropdown():
        return dropdown(_that.options);
      case SettingsUI_MultiDropdown():
        return multiDropdown(_that.options);
      case SettingsUI_Directory():
        return directory(_that.write);
      case SettingsUI_CustomUI():
        return customUi(_that.ui);
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
    TResult? Function()? checkBox,
    TResult? Function(double min, double max, int step)? slider,
    TResult? Function(List<DropdownOption> options)? dropdown,
    TResult? Function(List<DropdownOption> options)? multiDropdown,
    TResult? Function(bool write)? directory,
    TResult? Function(CustomUI ui)? customUi,
  }) {
    final _that = this;
    switch (_that) {
      case SettingsUI_CheckBox() when checkBox != null:
        return checkBox();
      case SettingsUI_Slider() when slider != null:
        return slider(_that.min, _that.max, _that.step);
      case SettingsUI_Dropdown() when dropdown != null:
        return dropdown(_that.options);
      case SettingsUI_MultiDropdown() when multiDropdown != null:
        return multiDropdown(_that.options);
      case SettingsUI_Directory() when directory != null:
        return directory(_that.write);
      case SettingsUI_CustomUI() when customUi != null:
        return customUi(_that.ui);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SettingsUI_CheckBox extends SettingsUI {
  const SettingsUI_CheckBox() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SettingsUI_CheckBox);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SettingsUI.checkBox()';
  }
}

/// @nodoc

class SettingsUI_Slider extends SettingsUI {
  const SettingsUI_Slider(
      {required this.min, required this.max, required this.step})
      : super._();

  final double min;
  final double max;
  final int step;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsUI_SliderCopyWith<SettingsUI_Slider> get copyWith =>
      _$SettingsUI_SliderCopyWithImpl<SettingsUI_Slider>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUI_Slider &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, min, max, step);

  @override
  String toString() {
    return 'SettingsUI.slider(min: $min, max: $max, step: $step)';
  }
}

/// @nodoc
abstract mixin class $SettingsUI_SliderCopyWith<$Res>
    implements $SettingsUICopyWith<$Res> {
  factory $SettingsUI_SliderCopyWith(
          SettingsUI_Slider value, $Res Function(SettingsUI_Slider) _then) =
      _$SettingsUI_SliderCopyWithImpl;
  @useResult
  $Res call({double min, double max, int step});
}

/// @nodoc
class _$SettingsUI_SliderCopyWithImpl<$Res>
    implements $SettingsUI_SliderCopyWith<$Res> {
  _$SettingsUI_SliderCopyWithImpl(this._self, this._then);

  final SettingsUI_Slider _self;
  final $Res Function(SettingsUI_Slider) _then;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? min = null,
    Object? max = null,
    Object? step = null,
  }) {
    return _then(SettingsUI_Slider(
      min: null == min
          ? _self.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _self.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class SettingsUI_Dropdown extends SettingsUI {
  const SettingsUI_Dropdown({required final List<DropdownOption> options})
      : _options = options,
        super._();

  final List<DropdownOption> _options;
  List<DropdownOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsUI_DropdownCopyWith<SettingsUI_Dropdown> get copyWith =>
      _$SettingsUI_DropdownCopyWithImpl<SettingsUI_Dropdown>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUI_Dropdown &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_options));

  @override
  String toString() {
    return 'SettingsUI.dropdown(options: $options)';
  }
}

/// @nodoc
abstract mixin class $SettingsUI_DropdownCopyWith<$Res>
    implements $SettingsUICopyWith<$Res> {
  factory $SettingsUI_DropdownCopyWith(
          SettingsUI_Dropdown value, $Res Function(SettingsUI_Dropdown) _then) =
      _$SettingsUI_DropdownCopyWithImpl;
  @useResult
  $Res call({List<DropdownOption> options});
}

/// @nodoc
class _$SettingsUI_DropdownCopyWithImpl<$Res>
    implements $SettingsUI_DropdownCopyWith<$Res> {
  _$SettingsUI_DropdownCopyWithImpl(this._self, this._then);

  final SettingsUI_Dropdown _self;
  final $Res Function(SettingsUI_Dropdown) _then;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? options = null,
  }) {
    return _then(SettingsUI_Dropdown(
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DropdownOption>,
    ));
  }
}

/// @nodoc

class SettingsUI_MultiDropdown extends SettingsUI {
  const SettingsUI_MultiDropdown({required final List<DropdownOption> options})
      : _options = options,
        super._();

  final List<DropdownOption> _options;
  List<DropdownOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsUI_MultiDropdownCopyWith<SettingsUI_MultiDropdown> get copyWith =>
      _$SettingsUI_MultiDropdownCopyWithImpl<SettingsUI_MultiDropdown>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUI_MultiDropdown &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_options));

  @override
  String toString() {
    return 'SettingsUI.multiDropdown(options: $options)';
  }
}

/// @nodoc
abstract mixin class $SettingsUI_MultiDropdownCopyWith<$Res>
    implements $SettingsUICopyWith<$Res> {
  factory $SettingsUI_MultiDropdownCopyWith(SettingsUI_MultiDropdown value,
          $Res Function(SettingsUI_MultiDropdown) _then) =
      _$SettingsUI_MultiDropdownCopyWithImpl;
  @useResult
  $Res call({List<DropdownOption> options});
}

/// @nodoc
class _$SettingsUI_MultiDropdownCopyWithImpl<$Res>
    implements $SettingsUI_MultiDropdownCopyWith<$Res> {
  _$SettingsUI_MultiDropdownCopyWithImpl(this._self, this._then);

  final SettingsUI_MultiDropdown _self;
  final $Res Function(SettingsUI_MultiDropdown) _then;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? options = null,
  }) {
    return _then(SettingsUI_MultiDropdown(
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<DropdownOption>,
    ));
  }
}

/// @nodoc

class SettingsUI_Directory extends SettingsUI {
  const SettingsUI_Directory({required this.write}) : super._();

  final bool write;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsUI_DirectoryCopyWith<SettingsUI_Directory> get copyWith =>
      _$SettingsUI_DirectoryCopyWithImpl<SettingsUI_Directory>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUI_Directory &&
            (identical(other.write, write) || other.write == write));
  }

  @override
  int get hashCode => Object.hash(runtimeType, write);

  @override
  String toString() {
    return 'SettingsUI.directory(write: $write)';
  }
}

/// @nodoc
abstract mixin class $SettingsUI_DirectoryCopyWith<$Res>
    implements $SettingsUICopyWith<$Res> {
  factory $SettingsUI_DirectoryCopyWith(SettingsUI_Directory value,
          $Res Function(SettingsUI_Directory) _then) =
      _$SettingsUI_DirectoryCopyWithImpl;
  @useResult
  $Res call({bool write});
}

/// @nodoc
class _$SettingsUI_DirectoryCopyWithImpl<$Res>
    implements $SettingsUI_DirectoryCopyWith<$Res> {
  _$SettingsUI_DirectoryCopyWithImpl(this._self, this._then);

  final SettingsUI_Directory _self;
  final $Res Function(SettingsUI_Directory) _then;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? write = null,
  }) {
    return _then(SettingsUI_Directory(
      write: null == write
          ? _self.write
          : write // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class SettingsUI_CustomUI extends SettingsUI {
  const SettingsUI_CustomUI({required this.ui}) : super._();

  final CustomUI ui;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsUI_CustomUICopyWith<SettingsUI_CustomUI> get copyWith =>
      _$SettingsUI_CustomUICopyWithImpl<SettingsUI_CustomUI>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsUI_CustomUI &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ui);

  @override
  String toString() {
    return 'SettingsUI.customUi(ui: $ui)';
  }
}

/// @nodoc
abstract mixin class $SettingsUI_CustomUICopyWith<$Res>
    implements $SettingsUICopyWith<$Res> {
  factory $SettingsUI_CustomUICopyWith(
          SettingsUI_CustomUI value, $Res Function(SettingsUI_CustomUI) _then) =
      _$SettingsUI_CustomUICopyWithImpl;
  @useResult
  $Res call({CustomUI ui});

  $CustomUICopyWith<$Res> get ui;
}

/// @nodoc
class _$SettingsUI_CustomUICopyWithImpl<$Res>
    implements $SettingsUI_CustomUICopyWith<$Res> {
  _$SettingsUI_CustomUICopyWithImpl(this._self, this._then);

  final SettingsUI_CustomUI _self;
  final $Res Function(SettingsUI_CustomUI) _then;

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ui = null,
  }) {
    return _then(SettingsUI_CustomUI(
      ui: null == ui
          ? _self.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of SettingsUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get ui {
    return $CustomUICopyWith<$Res>(_self.ui, (value) {
      return _then(_self.copyWith(ui: value));
    });
  }
}

// dart format on
