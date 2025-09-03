// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DropdownOptionImpl _$$DropdownOptionImplFromJson(Map<String, dynamic> json) =>
    _$DropdownOptionImpl(
      label: json['label'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$DropdownOptionImplToJson(
        _$DropdownOptionImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

_$SettingImpl _$$SettingImplFromJson(Map<String, dynamic> json) =>
    _$SettingImpl(
      label: json['label'] as String,
      value: SettingValue.fromJson(json['value'] as Map<String, dynamic>),
      default_: SettingValue.fromJson(json['default_'] as Map<String, dynamic>),
      visible: json['visible'] as bool,
      ui: json['ui'] == null
          ? null
          : SettingsUI.fromJson(json['ui'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SettingImplToJson(_$SettingImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'default_': instance.default_,
      'visible': instance.visible,
      'ui': instance.ui,
    };

_$SettingValue_StringImpl _$$SettingValue_StringImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingValue_StringImpl(
      data: json['data'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingValue_StringImplToJson(
        _$SettingValue_StringImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$SettingValue_NumberImpl _$$SettingValue_NumberImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingValue_NumberImpl(
      data: (json['data'] as num).toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingValue_NumberImplToJson(
        _$SettingValue_NumberImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$SettingValue_BooleanImpl _$$SettingValue_BooleanImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingValue_BooleanImpl(
      data: json['data'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingValue_BooleanImplToJson(
        _$SettingValue_BooleanImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$SettingValue_StringListImpl _$$SettingValue_StringListImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingValue_StringListImpl(
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingValue_StringListImplToJson(
        _$SettingValue_StringListImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$SettingsUI_CheckBoxImpl _$$SettingsUI_CheckBoxImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsUI_CheckBoxImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingsUI_CheckBoxImplToJson(
        _$SettingsUI_CheckBoxImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SettingsUI_SliderImpl _$$SettingsUI_SliderImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsUI_SliderImpl(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      step: (json['step'] as num).toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingsUI_SliderImplToJson(
        _$SettingsUI_SliderImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'step': instance.step,
      'runtimeType': instance.$type,
    };

_$SettingsUI_DropdownImpl _$$SettingsUI_DropdownImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsUI_DropdownImpl(
      options: (json['options'] as List<dynamic>)
          .map((e) => DropdownOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SettingsUI_DropdownImplToJson(
        _$SettingsUI_DropdownImpl instance) =>
    <String, dynamic>{
      'options': instance.options,
      'runtimeType': instance.$type,
    };
