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

DropdownItem _$DropdownItemFromJson(Map<String, dynamic> json) {
  return _DropdownItem.fromJson(json);
}

/// @nodoc
mixin _$DropdownItem {
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  /// Serializes this DropdownItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropdownItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropdownItemCopyWith<DropdownItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropdownItemCopyWith<$Res> {
  factory $DropdownItemCopyWith(
          DropdownItem value, $Res Function(DropdownItem) then) =
      _$DropdownItemCopyWithImpl<$Res, DropdownItem>;
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class _$DropdownItemCopyWithImpl<$Res, $Val extends DropdownItem>
    implements $DropdownItemCopyWith<$Res> {
  _$DropdownItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropdownItem
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
abstract class _$$DropdownItemImplCopyWith<$Res>
    implements $DropdownItemCopyWith<$Res> {
  factory _$$DropdownItemImplCopyWith(
          _$DropdownItemImpl value, $Res Function(_$DropdownItemImpl) then) =
      __$$DropdownItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, String value});
}

/// @nodoc
class __$$DropdownItemImplCopyWithImpl<$Res>
    extends _$DropdownItemCopyWithImpl<$Res, _$DropdownItemImpl>
    implements _$$DropdownItemImplCopyWith<$Res> {
  __$$DropdownItemImplCopyWithImpl(
      _$DropdownItemImpl _value, $Res Function(_$DropdownItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of DropdownItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_$DropdownItemImpl(
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
class _$DropdownItemImpl implements _DropdownItem {
  const _$DropdownItemImpl({required this.label, required this.value});

  factory _$DropdownItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropdownItemImplFromJson(json);

  @override
  final String label;
  @override
  final String value;

  @override
  String toString() {
    return 'DropdownItem(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropdownItemImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of DropdownItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropdownItemImplCopyWith<_$DropdownItemImpl> get copyWith =>
      __$$DropdownItemImplCopyWithImpl<_$DropdownItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DropdownItemImplToJson(
      this,
    );
  }
}

abstract class _DropdownItem implements DropdownItem {
  const factory _DropdownItem(
      {required final String label,
      required final String value}) = _$DropdownItemImpl;

  factory _DropdownItem.fromJson(Map<String, dynamic> json) =
      _$DropdownItemImpl.fromJson;

  @override
  String get label;
  @override
  String get value;

  /// Create a copy of DropdownItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropdownItemImplCopyWith<_$DropdownItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExtensionSetting _$ExtensionSettingFromJson(Map<String, dynamic> json) {
  return _ExtensionSetting.fromJson(json);
}

/// @nodoc
mixin _$ExtensionSetting {
  Setting get setting => throw _privateConstructorUsedError;
  Settingtype get settingtype => throw _privateConstructorUsedError;

  /// Serializes this ExtensionSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExtensionSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtensionSettingCopyWith<ExtensionSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtensionSettingCopyWith<$Res> {
  factory $ExtensionSettingCopyWith(
          ExtensionSetting value, $Res Function(ExtensionSetting) then) =
      _$ExtensionSettingCopyWithImpl<$Res, ExtensionSetting>;
  @useResult
  $Res call({Setting setting, Settingtype settingtype});

  $SettingCopyWith<$Res> get setting;
}

/// @nodoc
class _$ExtensionSettingCopyWithImpl<$Res, $Val extends ExtensionSetting>
    implements $ExtensionSettingCopyWith<$Res> {
  _$ExtensionSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtensionSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setting = null,
    Object? settingtype = null,
  }) {
    return _then(_value.copyWith(
      setting: null == setting
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as Setting,
      settingtype: null == settingtype
          ? _value.settingtype
          : settingtype // ignore: cast_nullable_to_non_nullable
              as Settingtype,
    ) as $Val);
  }

  /// Create a copy of ExtensionSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingCopyWith<$Res> get setting {
    return $SettingCopyWith<$Res>(_value.setting, (value) {
      return _then(_value.copyWith(setting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExtensionSettingImplCopyWith<$Res>
    implements $ExtensionSettingCopyWith<$Res> {
  factory _$$ExtensionSettingImplCopyWith(_$ExtensionSettingImpl value,
          $Res Function(_$ExtensionSettingImpl) then) =
      __$$ExtensionSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Setting setting, Settingtype settingtype});

  @override
  $SettingCopyWith<$Res> get setting;
}

/// @nodoc
class __$$ExtensionSettingImplCopyWithImpl<$Res>
    extends _$ExtensionSettingCopyWithImpl<$Res, _$ExtensionSettingImpl>
    implements _$$ExtensionSettingImplCopyWith<$Res> {
  __$$ExtensionSettingImplCopyWithImpl(_$ExtensionSettingImpl _value,
      $Res Function(_$ExtensionSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setting = null,
    Object? settingtype = null,
  }) {
    return _then(_$ExtensionSettingImpl(
      setting: null == setting
          ? _value.setting
          : setting // ignore: cast_nullable_to_non_nullable
              as Setting,
      settingtype: null == settingtype
          ? _value.settingtype
          : settingtype // ignore: cast_nullable_to_non_nullable
              as Settingtype,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtensionSettingImpl implements _ExtensionSetting {
  const _$ExtensionSettingImpl(
      {required this.setting, required this.settingtype});

  factory _$ExtensionSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtensionSettingImplFromJson(json);

  @override
  final Setting setting;
  @override
  final Settingtype settingtype;

  @override
  String toString() {
    return 'ExtensionSetting(setting: $setting, settingtype: $settingtype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionSettingImpl &&
            (identical(other.setting, setting) || other.setting == setting) &&
            (identical(other.settingtype, settingtype) ||
                other.settingtype == settingtype));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, setting, settingtype);

  /// Create a copy of ExtensionSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionSettingImplCopyWith<_$ExtensionSettingImpl> get copyWith =>
      __$$ExtensionSettingImplCopyWithImpl<_$ExtensionSettingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtensionSettingImplToJson(
      this,
    );
  }
}

abstract class _ExtensionSetting implements ExtensionSetting {
  const factory _ExtensionSetting(
      {required final Setting setting,
      required final Settingtype settingtype}) = _$ExtensionSettingImpl;

  factory _ExtensionSetting.fromJson(Map<String, dynamic> json) =
      _$ExtensionSettingImpl.fromJson;

  @override
  Setting get setting;
  @override
  Settingtype get settingtype;

  /// Create a copy of ExtensionSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionSettingImplCopyWith<_$ExtensionSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Setting _$SettingFromJson(Map<String, dynamic> json) {
  return _Setting.fromJson(json);
}

/// @nodoc
mixin _$Setting {
  Settingvalue get val => throw _privateConstructorUsedError;
  SettingUI? get ui => throw _privateConstructorUsedError;

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
  $Res call({Settingvalue val, SettingUI? ui});

  $SettingvalueCopyWith<$Res> get val;
  $SettingUICopyWith<$Res>? get ui;
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
    Object? val = null,
    Object? ui = freezed,
  }) {
    return _then(_value.copyWith(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as Settingvalue,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as SettingUI?,
    ) as $Val);
  }

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingvalueCopyWith<$Res> get val {
    return $SettingvalueCopyWith<$Res>(_value.val, (value) {
      return _then(_value.copyWith(val: value) as $Val);
    });
  }

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingUICopyWith<$Res>? get ui {
    if (_value.ui == null) {
      return null;
    }

    return $SettingUICopyWith<$Res>(_value.ui!, (value) {
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
  $Res call({Settingvalue val, SettingUI? ui});

  @override
  $SettingvalueCopyWith<$Res> get val;
  @override
  $SettingUICopyWith<$Res>? get ui;
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
    Object? val = null,
    Object? ui = freezed,
  }) {
    return _then(_$SettingImpl(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as Settingvalue,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as SettingUI?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingImpl implements _Setting {
  const _$SettingImpl({required this.val, this.ui});

  factory _$SettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingImplFromJson(json);

  @override
  final Settingvalue val;
  @override
  final SettingUI? ui;

  @override
  String toString() {
    return 'Setting(val: $val, ui: $ui)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingImpl &&
            (identical(other.val, val) || other.val == val) &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, val, ui);

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
      {required final Settingvalue val, final SettingUI? ui}) = _$SettingImpl;

  factory _Setting.fromJson(Map<String, dynamic> json) = _$SettingImpl.fromJson;

  @override
  Settingvalue get val;
  @override
  SettingUI? get ui;

  /// Create a copy of Setting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SettingUI _$SettingUIFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'pathSelection':
      return SettingUI_PathSelection.fromJson(json);
    case 'slider':
      return SettingUI_Slider.fromJson(json);
    case 'checkbox':
      return SettingUI_Checkbox.fromJson(json);
    case 'textbox':
      return SettingUI_Textbox.fromJson(json);
    case 'dropdown':
      return SettingUI_Dropdown.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SettingUI',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

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
    required TResult Function(String label, List<DropdownItem> options)
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
    TResult? Function(String label, List<DropdownItem> options)? dropdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String label, bool pickfolder)? pathSelection,
    TResult Function(String label, double min, double max, double step)? slider,
    TResult Function(String label)? checkbox,
    TResult Function(String label)? textbox,
    TResult Function(String label, List<DropdownItem> options)? dropdown,
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

  /// Serializes this SettingUI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
@JsonSerializable()
class _$SettingUI_PathSelectionImpl extends SettingUI_PathSelection {
  const _$SettingUI_PathSelectionImpl(
      {required this.label, required this.pickfolder, final String? $type})
      : $type = $type ?? 'pathSelection',
        super._();

  factory _$SettingUI_PathSelectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingUI_PathSelectionImplFromJson(json);

  @override
  final String label;
  @override
  final bool pickfolder;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(String label, List<DropdownItem> options)
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
    TResult? Function(String label, List<DropdownItem> options)? dropdown,
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
    TResult Function(String label, List<DropdownItem> options)? dropdown,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingUI_PathSelectionImplToJson(
      this,
    );
  }
}

abstract class SettingUI_PathSelection extends SettingUI {
  const factory SettingUI_PathSelection(
      {required final String label,
      required final bool pickfolder}) = _$SettingUI_PathSelectionImpl;
  const SettingUI_PathSelection._() : super._();

  factory SettingUI_PathSelection.fromJson(Map<String, dynamic> json) =
      _$SettingUI_PathSelectionImpl.fromJson;

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
@JsonSerializable()
class _$SettingUI_SliderImpl extends SettingUI_Slider {
  const _$SettingUI_SliderImpl(
      {required this.label,
      required this.min,
      required this.max,
      required this.step,
      final String? $type})
      : $type = $type ?? 'slider',
        super._();

  factory _$SettingUI_SliderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingUI_SliderImplFromJson(json);

  @override
  final String label;
  @override
  final double min;
  @override
  final double max;
  @override
  final double step;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(String label, List<DropdownItem> options)
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
    TResult? Function(String label, List<DropdownItem> options)? dropdown,
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
    TResult Function(String label, List<DropdownItem> options)? dropdown,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingUI_SliderImplToJson(
      this,
    );
  }
}

abstract class SettingUI_Slider extends SettingUI {
  const factory SettingUI_Slider(
      {required final String label,
      required final double min,
      required final double max,
      required final double step}) = _$SettingUI_SliderImpl;
  const SettingUI_Slider._() : super._();

  factory SettingUI_Slider.fromJson(Map<String, dynamic> json) =
      _$SettingUI_SliderImpl.fromJson;

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
@JsonSerializable()
class _$SettingUI_CheckboxImpl extends SettingUI_Checkbox {
  const _$SettingUI_CheckboxImpl({required this.label, final String? $type})
      : $type = $type ?? 'checkbox',
        super._();

  factory _$SettingUI_CheckboxImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingUI_CheckboxImplFromJson(json);

  @override
  final String label;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(String label, List<DropdownItem> options)
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
    TResult? Function(String label, List<DropdownItem> options)? dropdown,
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
    TResult Function(String label, List<DropdownItem> options)? dropdown,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingUI_CheckboxImplToJson(
      this,
    );
  }
}

abstract class SettingUI_Checkbox extends SettingUI {
  const factory SettingUI_Checkbox({required final String label}) =
      _$SettingUI_CheckboxImpl;
  const SettingUI_Checkbox._() : super._();

  factory SettingUI_Checkbox.fromJson(Map<String, dynamic> json) =
      _$SettingUI_CheckboxImpl.fromJson;

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
@JsonSerializable()
class _$SettingUI_TextboxImpl extends SettingUI_Textbox {
  const _$SettingUI_TextboxImpl({required this.label, final String? $type})
      : $type = $type ?? 'textbox',
        super._();

  factory _$SettingUI_TextboxImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingUI_TextboxImplFromJson(json);

  @override
  final String label;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(String label, List<DropdownItem> options)
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
    TResult? Function(String label, List<DropdownItem> options)? dropdown,
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
    TResult Function(String label, List<DropdownItem> options)? dropdown,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingUI_TextboxImplToJson(
      this,
    );
  }
}

abstract class SettingUI_Textbox extends SettingUI {
  const factory SettingUI_Textbox({required final String label}) =
      _$SettingUI_TextboxImpl;
  const SettingUI_Textbox._() : super._();

  factory SettingUI_Textbox.fromJson(Map<String, dynamic> json) =
      _$SettingUI_TextboxImpl.fromJson;

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
  $Res call({String label, List<DropdownItem> options});
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
              as List<DropdownItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingUI_DropdownImpl extends SettingUI_Dropdown {
  const _$SettingUI_DropdownImpl(
      {required this.label,
      required final List<DropdownItem> options,
      final String? $type})
      : _options = options,
        $type = $type ?? 'dropdown',
        super._();

  factory _$SettingUI_DropdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingUI_DropdownImplFromJson(json);

  @override
  final String label;
  final List<DropdownItem> _options;
  @override
  List<DropdownItem> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(String label, List<DropdownItem> options)
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
    TResult? Function(String label, List<DropdownItem> options)? dropdown,
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
    TResult Function(String label, List<DropdownItem> options)? dropdown,
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

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingUI_DropdownImplToJson(
      this,
    );
  }
}

abstract class SettingUI_Dropdown extends SettingUI {
  const factory SettingUI_Dropdown(
      {required final String label,
      required final List<DropdownItem> options}) = _$SettingUI_DropdownImpl;
  const SettingUI_Dropdown._() : super._();

  factory SettingUI_Dropdown.fromJson(Map<String, dynamic> json) =
      _$SettingUI_DropdownImpl.fromJson;

  @override
  String get label;
  List<DropdownItem> get options;

  /// Create a copy of SettingUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingUI_DropdownImplCopyWith<_$SettingUI_DropdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Settingvalue _$SettingvalueFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'string':
      return Settingvalue_String.fromJson(json);
    case 'number':
      return Settingvalue_Number.fromJson(json);
    case 'boolean':
      return Settingvalue_Boolean.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Settingvalue',
          'Invalid union type "${json['runtimeType']}"!');
  }
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

  /// Serializes this Settingvalue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
@JsonSerializable()
class _$Settingvalue_StringImpl extends Settingvalue_String {
  const _$Settingvalue_StringImpl(
      {required this.val, required this.defaultVal, final String? $type})
      : $type = $type ?? 'string',
        super._();

  factory _$Settingvalue_StringImpl.fromJson(Map<String, dynamic> json) =>
      _$$Settingvalue_StringImplFromJson(json);

  @override
  final String val;
  @override
  final String defaultVal;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$Settingvalue_StringImplToJson(
      this,
    );
  }
}

abstract class Settingvalue_String extends Settingvalue {
  const factory Settingvalue_String(
      {required final String val,
      required final String defaultVal}) = _$Settingvalue_StringImpl;
  const Settingvalue_String._() : super._();

  factory Settingvalue_String.fromJson(Map<String, dynamic> json) =
      _$Settingvalue_StringImpl.fromJson;

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
@JsonSerializable()
class _$Settingvalue_NumberImpl extends Settingvalue_Number {
  const _$Settingvalue_NumberImpl(
      {required this.val, required this.defaultVal, final String? $type})
      : $type = $type ?? 'number',
        super._();

  factory _$Settingvalue_NumberImpl.fromJson(Map<String, dynamic> json) =>
      _$$Settingvalue_NumberImplFromJson(json);

  @override
  final double val;
  @override
  final double defaultVal;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$Settingvalue_NumberImplToJson(
      this,
    );
  }
}

abstract class Settingvalue_Number extends Settingvalue {
  const factory Settingvalue_Number(
      {required final double val,
      required final double defaultVal}) = _$Settingvalue_NumberImpl;
  const Settingvalue_Number._() : super._();

  factory Settingvalue_Number.fromJson(Map<String, dynamic> json) =
      _$Settingvalue_NumberImpl.fromJson;

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
@JsonSerializable()
class _$Settingvalue_BooleanImpl extends Settingvalue_Boolean {
  const _$Settingvalue_BooleanImpl(
      {required this.val, required this.defaultVal, final String? $type})
      : $type = $type ?? 'boolean',
        super._();

  factory _$Settingvalue_BooleanImpl.fromJson(Map<String, dynamic> json) =>
      _$$Settingvalue_BooleanImplFromJson(json);

  @override
  final bool val;
  @override
  final bool defaultVal;

  @JsonKey(name: 'runtimeType')
  final String $type;

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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  Map<String, dynamic> toJson() {
    return _$$Settingvalue_BooleanImplToJson(
      this,
    );
  }
}

abstract class Settingvalue_Boolean extends Settingvalue {
  const factory Settingvalue_Boolean(
      {required final bool val,
      required final bool defaultVal}) = _$Settingvalue_BooleanImpl;
  const Settingvalue_Boolean._() : super._();

  factory Settingvalue_Boolean.fromJson(Map<String, dynamic> json) =
      _$Settingvalue_BooleanImpl.fromJson;

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
