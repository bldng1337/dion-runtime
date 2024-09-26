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
mixin _$SettingUI {
  String get label => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String label, bool pickfolder) pathSelection,
    required TResult Function(String label, double min, double max, double step)
        slider,
    required TResult Function(String label) checkbox,
    required TResult Function(String label) textbox,
    required TResult Function(String label, List<(String, String)> options)
        dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, bool pickfolder)? pathSelection,
    TResult? Function(String label, double min, double max, double step)?
        slider,
    TResult? Function(String label)? checkbox,
    TResult? Function(String label)? textbox,
    TResult? Function(String label, List<(String, String)> options)? dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<(String, String)> options)? dropdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingUI_PathSelection value) pathSelection,
    required TResult Function(SettingUI_Slider value) slider,
    required TResult Function(SettingUI_Checkbox value) checkbox,
    required TResult Function(SettingUI_Textbox value) textbox,
    required TResult Function(SettingUI_Dropdown value) dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingUI_PathSelection value)? pathSelection,
    TResult? Function(SettingUI_Slider value)? slider,
    TResult? Function(SettingUI_Checkbox value)? checkbox,
    TResult? Function(SettingUI_Textbox value)? textbox,
    TResult? Function(SettingUI_Dropdown value)? dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingUI_PathSelection value)? pathSelection,
    TResult Function(SettingUI_Slider value)? slider,
    TResult Function(SettingUI_Checkbox value)? checkbox,
    TResult Function(SettingUI_Textbox value)? textbox,
    TResult Function(SettingUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingUICopyWith<SettingUI> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingUICopyWith<$Res> {
  factory $SettingUICopyWith(SettingUI value, $Res Function(SettingUI) then) =
      _$SettingUICopyWithImpl<$Res, SettingUI>;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$SettingUICopyWithImpl<$Res, $Val extends SettingUI>
    implements $SettingUICopyWith<$Res> {
  _$SettingUICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingUI_PathSelectionImplCopyWith<$Res>
    implements $SettingUICopyWith<$Res> {
  factory _$$SettingUI_PathSelectionImplCopyWith(
          _$SettingUI_PathSelectionImpl value,
          $Res Function(_$SettingUI_PathSelectionImpl) then) =
      __$$SettingUI_PathSelectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, bool pickfolder});
}

/// @nodoc
class __$$SettingUI_PathSelectionImplCopyWithImpl<$Res>
    extends _$SettingUICopyWithImpl<$Res, _$SettingUI_PathSelectionImpl>
    implements _$$SettingUI_PathSelectionImplCopyWith<$Res> {
  __$$SettingUI_PathSelectionImplCopyWithImpl(
      _$SettingUI_PathSelectionImpl _value,
      $Res Function(_$SettingUI_PathSelectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? pickfolder = null,
  }) {
    return _then(_$SettingUI_PathSelectionImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      pickfolder: null == pickfolder
          ? _value.pickfolder
          : pickfolder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SettingUI_PathSelectionImpl extends SettingUI_PathSelection {
  const _$SettingUI_PathSelectionImpl(
      {required this.label, required this.pickfolder})
      : super._();

  @override
  final String label;
  @override
  final bool pickfolder;

  @override
  String toString() {
    return 'SettingUI.pathSelection(label: $label, pickfolder: $pickfolder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingUI_PathSelectionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.pickfolder, pickfolder) ||
                other.pickfolder == pickfolder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, pickfolder);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingUI_PathSelectionImplCopyWith<_$SettingUI_PathSelectionImpl>
      get copyWith => __$$SettingUI_PathSelectionImplCopyWithImpl<
          _$SettingUI_PathSelectionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String label, bool pickfolder) pathSelection,
    required TResult Function(String label, double min, double max, double step)
        slider,
    required TResult Function(String label) checkbox,
    required TResult Function(String label) textbox,
    required TResult Function(String label, List<(String, String)> options)
        dropdown,
  }) {
    return pathSelection(label, pickfolder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, bool pickfolder)? pathSelection,
    TResult? Function(String label, double min, double max, double step)?
        slider,
    TResult? Function(String label)? checkbox,
    TResult? Function(String label)? textbox,
    TResult? Function(String label, List<(String, String)> options)? dropdown,
  }) {
    return pathSelection?.call(label, pickfolder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<(String, String)> options)? dropdown,
    required TResult orElse(),
  }) {
    if (pathSelection != null) {
      return pathSelection(label, pickfolder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingUI_PathSelection value) pathSelection,
    required TResult Function(SettingUI_Slider value) slider,
    required TResult Function(SettingUI_Checkbox value) checkbox,
    required TResult Function(SettingUI_Textbox value) textbox,
    required TResult Function(SettingUI_Dropdown value) dropdown,
  }) {
    return pathSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingUI_PathSelection value)? pathSelection,
    TResult? Function(SettingUI_Slider value)? slider,
    TResult? Function(SettingUI_Checkbox value)? checkbox,
    TResult? Function(SettingUI_Textbox value)? textbox,
    TResult? Function(SettingUI_Dropdown value)? dropdown,
  }) {
    return pathSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingUI_PathSelection value)? pathSelection,
    TResult Function(SettingUI_Slider value)? slider,
    TResult Function(SettingUI_Checkbox value)? checkbox,
    TResult Function(SettingUI_Textbox value)? textbox,
    TResult Function(SettingUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (pathSelection != null) {
      return pathSelection(this);
    }
    return orElse();
  }
}

abstract class SettingUI_PathSelection extends SettingUI {
  const factory SettingUI_PathSelection(
      {required final String label,
      required final bool pickfolder}) = _$SettingUI_PathSelectionImpl;
  const SettingUI_PathSelection._() : super._();

  @override
  String get label;
  bool get pickfolder;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingUI_PathSelectionImplCopyWith<_$SettingUI_PathSelectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingUI_SliderImplCopyWith<$Res>
    implements $SettingUICopyWith<$Res> {
  factory _$$SettingUI_SliderImplCopyWith(_$SettingUI_SliderImpl value,
          $Res Function(_$SettingUI_SliderImpl) then) =
      __$$SettingUI_SliderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double min, double max, double step});
}

/// @nodoc
class __$$SettingUI_SliderImplCopyWithImpl<$Res>
    extends _$SettingUICopyWithImpl<$Res, _$SettingUI_SliderImpl>
    implements _$$SettingUI_SliderImplCopyWith<$Res> {
  __$$SettingUI_SliderImplCopyWithImpl(_$SettingUI_SliderImpl _value,
      $Res Function(_$SettingUI_SliderImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? min = null,
    Object? max = null,
    Object? step = null,
  }) {
    return _then(_$SettingUI_SliderImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
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
              as double,
    ));
  }
}

/// @nodoc

class _$SettingUI_SliderImpl extends SettingUI_Slider {
  const _$SettingUI_SliderImpl(
      {required this.label,
      required this.min,
      required this.max,
      required this.step})
      : super._();

  @override
  final String label;
  @override
  final double min;
  @override
  final double max;
  @override
  final double step;

  @override
  String toString() {
    return 'SettingUI.slider(label: $label, min: $min, max: $max, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingUI_SliderImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, min, max, step);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingUI_SliderImplCopyWith<_$SettingUI_SliderImpl> get copyWith =>
      __$$SettingUI_SliderImplCopyWithImpl<_$SettingUI_SliderImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String label, bool pickfolder) pathSelection,
    required TResult Function(String label, double min, double max, double step)
        slider,
    required TResult Function(String label) checkbox,
    required TResult Function(String label) textbox,
    required TResult Function(String label, List<(String, String)> options)
        dropdown,
  }) {
    return slider(label, min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, bool pickfolder)? pathSelection,
    TResult? Function(String label, double min, double max, double step)?
        slider,
    TResult? Function(String label)? checkbox,
    TResult? Function(String label)? textbox,
    TResult? Function(String label, List<(String, String)> options)? dropdown,
  }) {
    return slider?.call(label, min, max, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<(String, String)> options)? dropdown,
    required TResult orElse(),
  }) {
    if (slider != null) {
      return slider(label, min, max, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingUI_PathSelection value) pathSelection,
    required TResult Function(SettingUI_Slider value) slider,
    required TResult Function(SettingUI_Checkbox value) checkbox,
    required TResult Function(SettingUI_Textbox value) textbox,
    required TResult Function(SettingUI_Dropdown value) dropdown,
  }) {
    return slider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingUI_PathSelection value)? pathSelection,
    TResult? Function(SettingUI_Slider value)? slider,
    TResult? Function(SettingUI_Checkbox value)? checkbox,
    TResult? Function(SettingUI_Textbox value)? textbox,
    TResult? Function(SettingUI_Dropdown value)? dropdown,
  }) {
    return slider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingUI_PathSelection value)? pathSelection,
    TResult Function(SettingUI_Slider value)? slider,
    TResult Function(SettingUI_Checkbox value)? checkbox,
    TResult Function(SettingUI_Textbox value)? textbox,
    TResult Function(SettingUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (slider != null) {
      return slider(this);
    }
    return orElse();
  }
}

abstract class SettingUI_Slider extends SettingUI {
  const factory SettingUI_Slider(
      {required final String label,
      required final double min,
      required final double max,
      required final double step}) = _$SettingUI_SliderImpl;
  const SettingUI_Slider._() : super._();

  @override
  String get label;
  double get min;
  double get max;
  double get step;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingUI_SliderImplCopyWith<_$SettingUI_SliderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingUI_CheckboxImplCopyWith<$Res>
    implements $SettingUICopyWith<$Res> {
  factory _$$SettingUI_CheckboxImplCopyWith(_$SettingUI_CheckboxImpl value,
          $Res Function(_$SettingUI_CheckboxImpl) then) =
      __$$SettingUI_CheckboxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$$SettingUI_CheckboxImplCopyWithImpl<$Res>
    extends _$SettingUICopyWithImpl<$Res, _$SettingUI_CheckboxImpl>
    implements _$$SettingUI_CheckboxImplCopyWith<$Res> {
  __$$SettingUI_CheckboxImplCopyWithImpl(_$SettingUI_CheckboxImpl _value,
      $Res Function(_$SettingUI_CheckboxImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_$SettingUI_CheckboxImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SettingUI_CheckboxImpl extends SettingUI_Checkbox {
  const _$SettingUI_CheckboxImpl({required this.label}) : super._();

  @override
  final String label;

  @override
  String toString() {
    return 'SettingUI.checkbox(label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingUI_CheckboxImpl &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingUI_CheckboxImplCopyWith<_$SettingUI_CheckboxImpl> get copyWith =>
      __$$SettingUI_CheckboxImplCopyWithImpl<_$SettingUI_CheckboxImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String label, bool pickfolder) pathSelection,
    required TResult Function(String label, double min, double max, double step)
        slider,
    required TResult Function(String label) checkbox,
    required TResult Function(String label) textbox,
    required TResult Function(String label, List<(String, String)> options)
        dropdown,
  }) {
    return checkbox(label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, bool pickfolder)? pathSelection,
    TResult? Function(String label, double min, double max, double step)?
        slider,
    TResult? Function(String label)? checkbox,
    TResult? Function(String label)? textbox,
    TResult? Function(String label, List<(String, String)> options)? dropdown,
  }) {
    return checkbox?.call(label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<(String, String)> options)? dropdown,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingUI_PathSelection value) pathSelection,
    required TResult Function(SettingUI_Slider value) slider,
    required TResult Function(SettingUI_Checkbox value) checkbox,
    required TResult Function(SettingUI_Textbox value) textbox,
    required TResult Function(SettingUI_Dropdown value) dropdown,
  }) {
    return checkbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingUI_PathSelection value)? pathSelection,
    TResult? Function(SettingUI_Slider value)? slider,
    TResult? Function(SettingUI_Checkbox value)? checkbox,
    TResult? Function(SettingUI_Textbox value)? textbox,
    TResult? Function(SettingUI_Dropdown value)? dropdown,
  }) {
    return checkbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingUI_PathSelection value)? pathSelection,
    TResult Function(SettingUI_Slider value)? slider,
    TResult Function(SettingUI_Checkbox value)? checkbox,
    TResult Function(SettingUI_Textbox value)? textbox,
    TResult Function(SettingUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (checkbox != null) {
      return checkbox(this);
    }
    return orElse();
  }
}

abstract class SettingUI_Checkbox extends SettingUI {
  const factory SettingUI_Checkbox({required final String label}) =
      _$SettingUI_CheckboxImpl;
  const SettingUI_Checkbox._() : super._();

  @override
  String get label;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingUI_CheckboxImplCopyWith<_$SettingUI_CheckboxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingUI_TextboxImplCopyWith<$Res>
    implements $SettingUICopyWith<$Res> {
  factory _$$SettingUI_TextboxImplCopyWith(_$SettingUI_TextboxImpl value,
          $Res Function(_$SettingUI_TextboxImpl) then) =
      __$$SettingUI_TextboxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$$SettingUI_TextboxImplCopyWithImpl<$Res>
    extends _$SettingUICopyWithImpl<$Res, _$SettingUI_TextboxImpl>
    implements _$$SettingUI_TextboxImplCopyWith<$Res> {
  __$$SettingUI_TextboxImplCopyWithImpl(_$SettingUI_TextboxImpl _value,
      $Res Function(_$SettingUI_TextboxImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_$SettingUI_TextboxImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SettingUI_TextboxImpl extends SettingUI_Textbox {
  const _$SettingUI_TextboxImpl({required this.label}) : super._();

  @override
  final String label;

  @override
  String toString() {
    return 'SettingUI.textbox(label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingUI_TextboxImpl &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingUI_TextboxImplCopyWith<_$SettingUI_TextboxImpl> get copyWith =>
      __$$SettingUI_TextboxImplCopyWithImpl<_$SettingUI_TextboxImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String label, bool pickfolder) pathSelection,
    required TResult Function(String label, double min, double max, double step)
        slider,
    required TResult Function(String label) checkbox,
    required TResult Function(String label) textbox,
    required TResult Function(String label, List<(String, String)> options)
        dropdown,
  }) {
    return textbox(label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, bool pickfolder)? pathSelection,
    TResult? Function(String label, double min, double max, double step)?
        slider,
    TResult? Function(String label)? checkbox,
    TResult? Function(String label)? textbox,
    TResult? Function(String label, List<(String, String)> options)? dropdown,
  }) {
    return textbox?.call(label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<(String, String)> options)? dropdown,
    required TResult orElse(),
  }) {
    if (textbox != null) {
      return textbox(label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingUI_PathSelection value) pathSelection,
    required TResult Function(SettingUI_Slider value) slider,
    required TResult Function(SettingUI_Checkbox value) checkbox,
    required TResult Function(SettingUI_Textbox value) textbox,
    required TResult Function(SettingUI_Dropdown value) dropdown,
  }) {
    return textbox(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingUI_PathSelection value)? pathSelection,
    TResult? Function(SettingUI_Slider value)? slider,
    TResult? Function(SettingUI_Checkbox value)? checkbox,
    TResult? Function(SettingUI_Textbox value)? textbox,
    TResult? Function(SettingUI_Dropdown value)? dropdown,
  }) {
    return textbox?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingUI_PathSelection value)? pathSelection,
    TResult Function(SettingUI_Slider value)? slider,
    TResult Function(SettingUI_Checkbox value)? checkbox,
    TResult Function(SettingUI_Textbox value)? textbox,
    TResult Function(SettingUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (textbox != null) {
      return textbox(this);
    }
    return orElse();
  }
}

abstract class SettingUI_Textbox extends SettingUI {
  const factory SettingUI_Textbox({required final String label}) =
      _$SettingUI_TextboxImpl;
  const SettingUI_Textbox._() : super._();

  @override
  String get label;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingUI_TextboxImplCopyWith<_$SettingUI_TextboxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingUI_DropdownImplCopyWith<$Res>
    implements $SettingUICopyWith<$Res> {
  factory _$$SettingUI_DropdownImplCopyWith(_$SettingUI_DropdownImpl value,
          $Res Function(_$SettingUI_DropdownImpl) then) =
      __$$SettingUI_DropdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, List<(String, String)> options});
}

/// @nodoc
class __$$SettingUI_DropdownImplCopyWithImpl<$Res>
    extends _$SettingUICopyWithImpl<$Res, _$SettingUI_DropdownImpl>
    implements _$$SettingUI_DropdownImplCopyWith<$Res> {
  __$$SettingUI_DropdownImplCopyWithImpl(_$SettingUI_DropdownImpl _value,
      $Res Function(_$SettingUI_DropdownImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? options = null,
  }) {
    return _then(_$SettingUI_DropdownImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<(String, String)>,
    ));
  }
}

/// @nodoc

class _$SettingUI_DropdownImpl extends SettingUI_Dropdown {
  const _$SettingUI_DropdownImpl(
      {required this.label, required final List<(String, String)> options})
      : _options = options,
        super._();

  @override
  final String label;
  final List<(String, String)> _options;
  @override
  List<(String, String)> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'SettingUI.dropdown(label: $label, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingUI_DropdownImpl &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, label, const DeepCollectionEquality().hash(_options));

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingUI_DropdownImplCopyWith<_$SettingUI_DropdownImpl> get copyWith =>
      __$$SettingUI_DropdownImplCopyWithImpl<_$SettingUI_DropdownImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String label, bool pickfolder) pathSelection,
    required TResult Function(String label, double min, double max, double step)
        slider,
    required TResult Function(String label) checkbox,
    required TResult Function(String label) textbox,
    required TResult Function(String label, List<(String, String)> options)
        dropdown,
  }) {
    return dropdown(label, options);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String label, bool pickfolder)? pathSelection,
    TResult? Function(String label, double min, double max, double step)?
        slider,
    TResult? Function(String label)? checkbox,
    TResult? Function(String label)? textbox,
    TResult? Function(String label, List<(String, String)> options)? dropdown,
  }) {
    return dropdown?.call(label, options);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<(String, String)> options)? dropdown,
    required TResult orElse(),
  }) {
    if (dropdown != null) {
      return dropdown(label, options);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingUI_PathSelection value) pathSelection,
    required TResult Function(SettingUI_Slider value) slider,
    required TResult Function(SettingUI_Checkbox value) checkbox,
    required TResult Function(SettingUI_Textbox value) textbox,
    required TResult Function(SettingUI_Dropdown value) dropdown,
  }) {
    return dropdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingUI_PathSelection value)? pathSelection,
    TResult? Function(SettingUI_Slider value)? slider,
    TResult? Function(SettingUI_Checkbox value)? checkbox,
    TResult? Function(SettingUI_Textbox value)? textbox,
    TResult? Function(SettingUI_Dropdown value)? dropdown,
  }) {
    return dropdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingUI_PathSelection value)? pathSelection,
    TResult Function(SettingUI_Slider value)? slider,
    TResult Function(SettingUI_Checkbox value)? checkbox,
    TResult Function(SettingUI_Textbox value)? textbox,
    TResult Function(SettingUI_Dropdown value)? dropdown,
    required TResult orElse(),
  }) {
    if (dropdown != null) {
      return dropdown(this);
    }
    return orElse();
  }
}

abstract class SettingUI_Dropdown extends SettingUI {
  const factory SettingUI_Dropdown(
          {required final String label,
          required final List<(String, String)> options}) =
      _$SettingUI_DropdownImpl;
  const SettingUI_Dropdown._() : super._();

  @override
  String get label;
  List<(String, String)> get options;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingUI_DropdownImplCopyWith<_$SettingUI_DropdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Settingvalue {
  Object get val => throw _privateConstructorUsedError;
  Object get defaultVal => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String val, String defaultVal) string,
    required TResult Function(double val, double defaultVal) number,
    required TResult Function(bool val, bool defaultVal) boolean,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String val, String defaultVal)? string,
    TResult? Function(double val, double defaultVal)? number,
    TResult? Function(bool val, bool defaultVal)? boolean,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String val, String defaultVal)? string,
    TResult Function(double val, double defaultVal)? number,
    TResult Function(bool val, bool defaultVal)? boolean,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Settingvalue_String value) string,
    required TResult Function(Settingvalue_Number value) number,
    required TResult Function(Settingvalue_Boolean value) boolean,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Settingvalue_String value)? string,
    TResult? Function(Settingvalue_Number value)? number,
    TResult? Function(Settingvalue_Boolean value)? boolean,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Settingvalue_String value)? string,
    TResult Function(Settingvalue_Number value)? number,
    TResult Function(Settingvalue_Boolean value)? boolean,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingvalueCopyWith<$Res> {
  factory $SettingvalueCopyWith(
          Settingvalue value, $Res Function(Settingvalue) then) =
      _$SettingvalueCopyWithImpl<$Res, Settingvalue>;
}

/// @nodoc
class _$SettingvalueCopyWithImpl<$Res, $Val extends Settingvalue>
    implements $SettingvalueCopyWith<$Res> {
  _$SettingvalueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Settingvalue_StringImplCopyWith<$Res> {
  factory _$$Settingvalue_StringImplCopyWith(_$Settingvalue_StringImpl value,
          $Res Function(_$Settingvalue_StringImpl) then) =
      __$$Settingvalue_StringImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String val, String defaultVal});
}

/// @nodoc
class __$$Settingvalue_StringImplCopyWithImpl<$Res>
    extends _$SettingvalueCopyWithImpl<$Res, _$Settingvalue_StringImpl>
    implements _$$Settingvalue_StringImplCopyWith<$Res> {
  __$$Settingvalue_StringImplCopyWithImpl(_$Settingvalue_StringImpl _value,
      $Res Function(_$Settingvalue_StringImpl) _then)
      : super(_value, _then);

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? val = null,
    Object? defaultVal = null,
  }) {
    return _then(_$Settingvalue_StringImpl(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as String,
      defaultVal: null == defaultVal
          ? _value.defaultVal
          : defaultVal // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Settingvalue_StringImpl extends Settingvalue_String {
  const _$Settingvalue_StringImpl({required this.val, required this.defaultVal})
      : super._();

  @override
  final String val;
  @override
  final String defaultVal;

  @override
  String toString() {
    return 'Settingvalue.string(val: $val, defaultVal: $defaultVal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Settingvalue_StringImpl &&
            (identical(other.val, val) || other.val == val) &&
            (identical(other.defaultVal, defaultVal) ||
                other.defaultVal == defaultVal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, val, defaultVal);

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Settingvalue_StringImplCopyWith<_$Settingvalue_StringImpl> get copyWith =>
      __$$Settingvalue_StringImplCopyWithImpl<_$Settingvalue_StringImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String val, String defaultVal) string,
    required TResult Function(double val, double defaultVal) number,
    required TResult Function(bool val, bool defaultVal) boolean,
  }) {
    return string(val, defaultVal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String val, String defaultVal)? string,
    TResult? Function(double val, double defaultVal)? number,
    TResult? Function(bool val, bool defaultVal)? boolean,
  }) {
    return string?.call(val, defaultVal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String val, String defaultVal)? string,
    TResult Function(double val, double defaultVal)? number,
    TResult Function(bool val, bool defaultVal)? boolean,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(val, defaultVal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Settingvalue_String value) string,
    required TResult Function(Settingvalue_Number value) number,
    required TResult Function(Settingvalue_Boolean value) boolean,
  }) {
    return string(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Settingvalue_String value)? string,
    TResult? Function(Settingvalue_Number value)? number,
    TResult? Function(Settingvalue_Boolean value)? boolean,
  }) {
    return string?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Settingvalue_String value)? string,
    TResult Function(Settingvalue_Number value)? number,
    TResult Function(Settingvalue_Boolean value)? boolean,
    required TResult orElse(),
  }) {
    if (string != null) {
      return string(this);
    }
    return orElse();
  }
}

abstract class Settingvalue_String extends Settingvalue {
  const factory Settingvalue_String(
      {required final String val,
      required final String defaultVal}) = _$Settingvalue_StringImpl;
  const Settingvalue_String._() : super._();

  @override
  String get val;
  @override
  String get defaultVal;

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Settingvalue_StringImplCopyWith<_$Settingvalue_StringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Settingvalue_NumberImplCopyWith<$Res> {
  factory _$$Settingvalue_NumberImplCopyWith(_$Settingvalue_NumberImpl value,
          $Res Function(_$Settingvalue_NumberImpl) then) =
      __$$Settingvalue_NumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double val, double defaultVal});
}

/// @nodoc
class __$$Settingvalue_NumberImplCopyWithImpl<$Res>
    extends _$SettingvalueCopyWithImpl<$Res, _$Settingvalue_NumberImpl>
    implements _$$Settingvalue_NumberImplCopyWith<$Res> {
  __$$Settingvalue_NumberImplCopyWithImpl(_$Settingvalue_NumberImpl _value,
      $Res Function(_$Settingvalue_NumberImpl) _then)
      : super(_value, _then);

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? val = null,
    Object? defaultVal = null,
  }) {
    return _then(_$Settingvalue_NumberImpl(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as double,
      defaultVal: null == defaultVal
          ? _value.defaultVal
          : defaultVal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$Settingvalue_NumberImpl extends Settingvalue_Number {
  const _$Settingvalue_NumberImpl({required this.val, required this.defaultVal})
      : super._();

  @override
  final double val;
  @override
  final double defaultVal;

  @override
  String toString() {
    return 'Settingvalue.number(val: $val, defaultVal: $defaultVal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Settingvalue_NumberImpl &&
            (identical(other.val, val) || other.val == val) &&
            (identical(other.defaultVal, defaultVal) ||
                other.defaultVal == defaultVal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, val, defaultVal);

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Settingvalue_NumberImplCopyWith<_$Settingvalue_NumberImpl> get copyWith =>
      __$$Settingvalue_NumberImplCopyWithImpl<_$Settingvalue_NumberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String val, String defaultVal) string,
    required TResult Function(double val, double defaultVal) number,
    required TResult Function(bool val, bool defaultVal) boolean,
  }) {
    return number(val, defaultVal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String val, String defaultVal)? string,
    TResult? Function(double val, double defaultVal)? number,
    TResult? Function(bool val, bool defaultVal)? boolean,
  }) {
    return number?.call(val, defaultVal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String val, String defaultVal)? string,
    TResult Function(double val, double defaultVal)? number,
    TResult Function(bool val, bool defaultVal)? boolean,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(val, defaultVal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Settingvalue_String value) string,
    required TResult Function(Settingvalue_Number value) number,
    required TResult Function(Settingvalue_Boolean value) boolean,
  }) {
    return number(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Settingvalue_String value)? string,
    TResult? Function(Settingvalue_Number value)? number,
    TResult? Function(Settingvalue_Boolean value)? boolean,
  }) {
    return number?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Settingvalue_String value)? string,
    TResult Function(Settingvalue_Number value)? number,
    TResult Function(Settingvalue_Boolean value)? boolean,
    required TResult orElse(),
  }) {
    if (number != null) {
      return number(this);
    }
    return orElse();
  }
}

abstract class Settingvalue_Number extends Settingvalue {
  const factory Settingvalue_Number(
      {required final double val,
      required final double defaultVal}) = _$Settingvalue_NumberImpl;
  const Settingvalue_Number._() : super._();

  @override
  double get val;
  @override
  double get defaultVal;

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Settingvalue_NumberImplCopyWith<_$Settingvalue_NumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Settingvalue_BooleanImplCopyWith<$Res> {
  factory _$$Settingvalue_BooleanImplCopyWith(_$Settingvalue_BooleanImpl value,
          $Res Function(_$Settingvalue_BooleanImpl) then) =
      __$$Settingvalue_BooleanImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool val, bool defaultVal});
}

/// @nodoc
class __$$Settingvalue_BooleanImplCopyWithImpl<$Res>
    extends _$SettingvalueCopyWithImpl<$Res, _$Settingvalue_BooleanImpl>
    implements _$$Settingvalue_BooleanImplCopyWith<$Res> {
  __$$Settingvalue_BooleanImplCopyWithImpl(_$Settingvalue_BooleanImpl _value,
      $Res Function(_$Settingvalue_BooleanImpl) _then)
      : super(_value, _then);

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? val = null,
    Object? defaultVal = null,
  }) {
    return _then(_$Settingvalue_BooleanImpl(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultVal: null == defaultVal
          ? _value.defaultVal
          : defaultVal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Settingvalue_BooleanImpl extends Settingvalue_Boolean {
  const _$Settingvalue_BooleanImpl(
      {required this.val, required this.defaultVal})
      : super._();

  @override
  final bool val;
  @override
  final bool defaultVal;

  @override
  String toString() {
    return 'Settingvalue.boolean(val: $val, defaultVal: $defaultVal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Settingvalue_BooleanImpl &&
            (identical(other.val, val) || other.val == val) &&
            (identical(other.defaultVal, defaultVal) ||
                other.defaultVal == defaultVal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, val, defaultVal);

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Settingvalue_BooleanImplCopyWith<_$Settingvalue_BooleanImpl>
      get copyWith =>
          __$$Settingvalue_BooleanImplCopyWithImpl<_$Settingvalue_BooleanImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String val, String defaultVal) string,
    required TResult Function(double val, double defaultVal) number,
    required TResult Function(bool val, bool defaultVal) boolean,
  }) {
    return boolean(val, defaultVal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String val, String defaultVal)? string,
    TResult? Function(double val, double defaultVal)? number,
    TResult? Function(bool val, bool defaultVal)? boolean,
  }) {
    return boolean?.call(val, defaultVal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String val, String defaultVal)? string,
    TResult Function(double val, double defaultVal)? number,
    TResult Function(bool val, bool defaultVal)? boolean,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(val, defaultVal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Settingvalue_String value) string,
    required TResult Function(Settingvalue_Number value) number,
    required TResult Function(Settingvalue_Boolean value) boolean,
  }) {
    return boolean(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Settingvalue_String value)? string,
    TResult? Function(Settingvalue_Number value)? number,
    TResult? Function(Settingvalue_Boolean value)? boolean,
  }) {
    return boolean?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Settingvalue_String value)? string,
    TResult Function(Settingvalue_Number value)? number,
    TResult Function(Settingvalue_Boolean value)? boolean,
    required TResult orElse(),
  }) {
    if (boolean != null) {
      return boolean(this);
    }
    return orElse();
  }
}

abstract class Settingvalue_Boolean extends Settingvalue {
  const factory Settingvalue_Boolean(
      {required final bool val,
      required final bool defaultVal}) = _$Settingvalue_BooleanImpl;
  const Settingvalue_Boolean._() : super._();

  @override
  bool get val;
  @override
  bool get defaultVal;

  /// Create a copy of Settingvalue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Settingvalue_BooleanImplCopyWith<_$Settingvalue_BooleanImpl>
      get copyWith => throw _privateConstructorUsedError;
}
