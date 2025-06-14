// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropdownItemImpl _$$DropdownItemImplFromJson(Map<String, dynamic> json) =>
    _$DropdownItemImpl(
      label: json['label'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$DropdownItemImplToJson(_$DropdownItemImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

_$ExtensionSettingImpl _$$ExtensionSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$ExtensionSettingImpl(
      setting: Setting.fromJson(json['setting'] as Map<String, dynamic>),
      settingtype: $enumDecode(_$SettingtypeEnumMap, json['settingtype']),
    );

Map<String, dynamic> _$$ExtensionSettingImplToJson(
        _$ExtensionSettingImpl instance) =>
    <String, dynamic>{
      'setting': instance.setting,
      'settingtype': _$SettingtypeEnumMap[instance.settingtype]!,
    };

const _$SettingtypeEnumMap = {
  Settingtype.extension_: 'extension_',
  Settingtype.search: 'search',
};

_$SettingImpl _$$SettingImplFromJson(Map<String, dynamic> json) =>
    _$SettingImpl(
      val: Settingvalue.fromJson(json['val'] as Map<String, dynamic>),
      ui: json['ui'] == null
          ? null
          : SettingUI.fromJson(json['ui'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SettingImplToJson(_$SettingImpl instance) =>
    <String, dynamic>{
      'val': instance.val,
      'ui': instance.ui,
    };

_$SettingUI_PathSelectionImpl _$$SettingUI_PathSelectionImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingUI_PathSelectionImpl(
      label: json['label'] as String,
      pickfolder: json['pickfolder'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingUI_PathSelectionImplToJson(
        _$SettingUI_PathSelectionImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'pickfolder': instance.pickfolder,
      'runtimeType': instance.$type,
    };

_$SettingUI_SliderImpl _$$SettingUI_SliderImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingUI_SliderImpl(
      label: json['label'] as String,
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      step: (json['step'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingUI_SliderImplToJson(
        _$SettingUI_SliderImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'min': instance.min,
      'max': instance.max,
      'step': instance.step,
      'runtimeType': instance.$type,
    };

_$SettingUI_CheckboxImpl _$$SettingUI_CheckboxImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingUI_CheckboxImpl(
      label: json['label'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingUI_CheckboxImplToJson(
        _$SettingUI_CheckboxImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'runtimeType': instance.$type,
    };

_$SettingUI_TextboxImpl _$$SettingUI_TextboxImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingUI_TextboxImpl(
      label: json['label'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingUI_TextboxImplToJson(
        _$SettingUI_TextboxImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'runtimeType': instance.$type,
    };

_$SettingUI_DropdownImpl _$$SettingUI_DropdownImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingUI_DropdownImpl(
      label: json['label'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => DropdownItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingUI_DropdownImplToJson(
        _$SettingUI_DropdownImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'options': instance.options,
      'runtimeType': instance.$type,
    };

_$Settingvalue_StringImpl _$$Settingvalue_StringImplFromJson(
        Map<String, dynamic> json) =>
    _$Settingvalue_StringImpl(
      val: json['val'] as String,
      defaultVal: json['defaultVal'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Settingvalue_StringImplToJson(
        _$Settingvalue_StringImpl instance) =>
    <String, dynamic>{
      'val': instance.val,
      'defaultVal': instance.defaultVal,
      'runtimeType': instance.$type,
    };

_$Settingvalue_NumberImpl _$$Settingvalue_NumberImplFromJson(
        Map<String, dynamic> json) =>
    _$Settingvalue_NumberImpl(
      val: (json['val'] as num).toDouble(),
      defaultVal: (json['defaultVal'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Settingvalue_NumberImplToJson(
        _$Settingvalue_NumberImpl instance) =>
    <String, dynamic>{
      'val': instance.val,
      'defaultVal': instance.defaultVal,
      'runtimeType': instance.$type,
    };

_$Settingvalue_BooleanImpl _$$Settingvalue_BooleanImplFromJson(
        Map<String, dynamic> json) =>
    _$Settingvalue_BooleanImpl(
      val: json['val'] as bool,
      defaultVal: json['defaultVal'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Settingvalue_BooleanImplToJson(
        _$Settingvalue_BooleanImpl instance) =>
    <String, dynamic>{
      'val': instance.val,
      'defaultVal': instance.defaultVal,
      'runtimeType': instance.$type,
    };
