// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Permission_StorageImpl _$$Permission_StorageImplFromJson(
        Map<String, dynamic> json) =>
    _$Permission_StorageImpl(
      path: json['path'] as String,
      write: json['write'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Permission_StorageImplToJson(
        _$Permission_StorageImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'write': instance.write,
      'runtimeType': instance.$type,
    };

_$Permission_NetworkImpl _$$Permission_NetworkImplFromJson(
        Map<String, dynamic> json) =>
    _$Permission_NetworkImpl(
      domain: json['domain'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Permission_NetworkImplToJson(
        _$Permission_NetworkImpl instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'runtimeType': instance.$type,
    };

_$Permission_ActionPopupImpl _$$Permission_ActionPopupImplFromJson(
        Map<String, dynamic> json) =>
    _$Permission_ActionPopupImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Permission_ActionPopupImplToJson(
        _$Permission_ActionPopupImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$Permission_ArbitraryNetworkImpl _$$Permission_ArbitraryNetworkImplFromJson(
        Map<String, dynamic> json) =>
    _$Permission_ArbitraryNetworkImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$Permission_ArbitraryNetworkImplToJson(
        _$Permission_ArbitraryNetworkImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
