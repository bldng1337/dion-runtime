// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Permission _$PermissionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'storage':
      return Permission_Storage.fromJson(json);
    case 'network':
      return Permission_Network.fromJson(json);
    case 'actionPopup':
      return Permission_ActionPopup.fromJson(json);
    case 'arbitraryNetwork':
      return Permission_ArbitraryNetwork.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Permission',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Permission {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(String domain) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(String domain)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(String domain)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_Storage value) storage,
    required TResult Function(Permission_Network value) network,
    required TResult Function(Permission_ActionPopup value) actionPopup,
    required TResult Function(Permission_ArbitraryNetwork value)
        arbitraryNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_Storage value)? storage,
    TResult? Function(Permission_Network value)? network,
    TResult? Function(Permission_ActionPopup value)? actionPopup,
    TResult? Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_Storage value)? storage,
    TResult Function(Permission_Network value)? network,
    TResult Function(Permission_ActionPopup value)? actionPopup,
    TResult Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Permission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionCopyWith<$Res> {
  factory $PermissionCopyWith(
          Permission value, $Res Function(Permission) then) =
      _$PermissionCopyWithImpl<$Res, Permission>;
}

/// @nodoc
class _$PermissionCopyWithImpl<$Res, $Val extends Permission>
    implements $PermissionCopyWith<$Res> {
  _$PermissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Permission_StorageImplCopyWith<$Res> {
  factory _$$Permission_StorageImplCopyWith(_$Permission_StorageImpl value,
          $Res Function(_$Permission_StorageImpl) then) =
      __$$Permission_StorageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String path, bool write});
}

/// @nodoc
class __$$Permission_StorageImplCopyWithImpl<$Res>
    extends _$PermissionCopyWithImpl<$Res, _$Permission_StorageImpl>
    implements _$$Permission_StorageImplCopyWith<$Res> {
  __$$Permission_StorageImplCopyWithImpl(_$Permission_StorageImpl _value,
      $Res Function(_$Permission_StorageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? write = null,
  }) {
    return _then(_$Permission_StorageImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      write: null == write
          ? _value.write
          : write // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Permission_StorageImpl extends Permission_Storage {
  const _$Permission_StorageImpl(
      {required this.path, required this.write, final String? $type})
      : $type = $type ?? 'storage',
        super._();

  factory _$Permission_StorageImpl.fromJson(Map<String, dynamic> json) =>
      _$$Permission_StorageImplFromJson(json);

  @override
  final String path;
  @override
  final bool write;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Permission.storage(path: $path, write: $write)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Permission_StorageImpl &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.write, write) || other.write == write));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, path, write);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Permission_StorageImplCopyWith<_$Permission_StorageImpl> get copyWith =>
      __$$Permission_StorageImplCopyWithImpl<_$Permission_StorageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(String domain) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return storage(path, write);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(String domain)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return storage?.call(path, write);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(String domain)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(path, write);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_Storage value) storage,
    required TResult Function(Permission_Network value) network,
    required TResult Function(Permission_ActionPopup value) actionPopup,
    required TResult Function(Permission_ArbitraryNetwork value)
        arbitraryNetwork,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_Storage value)? storage,
    TResult? Function(Permission_Network value)? network,
    TResult? Function(Permission_ActionPopup value)? actionPopup,
    TResult? Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_Storage value)? storage,
    TResult Function(Permission_Network value)? network,
    TResult Function(Permission_ActionPopup value)? actionPopup,
    TResult Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Permission_StorageImplToJson(
      this,
    );
  }
}

abstract class Permission_Storage extends Permission {
  const factory Permission_Storage(
      {required final String path,
      required final bool write}) = _$Permission_StorageImpl;
  const Permission_Storage._() : super._();

  factory Permission_Storage.fromJson(Map<String, dynamic> json) =
      _$Permission_StorageImpl.fromJson;

  String get path;
  bool get write;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Permission_StorageImplCopyWith<_$Permission_StorageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Permission_NetworkImplCopyWith<$Res> {
  factory _$$Permission_NetworkImplCopyWith(_$Permission_NetworkImpl value,
          $Res Function(_$Permission_NetworkImpl) then) =
      __$$Permission_NetworkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String domain});
}

/// @nodoc
class __$$Permission_NetworkImplCopyWithImpl<$Res>
    extends _$PermissionCopyWithImpl<$Res, _$Permission_NetworkImpl>
    implements _$$Permission_NetworkImplCopyWith<$Res> {
  __$$Permission_NetworkImplCopyWithImpl(_$Permission_NetworkImpl _value,
      $Res Function(_$Permission_NetworkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
  }) {
    return _then(_$Permission_NetworkImpl(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Permission_NetworkImpl extends Permission_Network {
  const _$Permission_NetworkImpl({required this.domain, final String? $type})
      : $type = $type ?? 'network',
        super._();

  factory _$Permission_NetworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$Permission_NetworkImplFromJson(json);

  @override
  final String domain;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Permission.network(domain: $domain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Permission_NetworkImpl &&
            (identical(other.domain, domain) || other.domain == domain));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, domain);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Permission_NetworkImplCopyWith<_$Permission_NetworkImpl> get copyWith =>
      __$$Permission_NetworkImplCopyWithImpl<_$Permission_NetworkImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(String domain) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return network(domain);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(String domain)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return network?.call(domain);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(String domain)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(domain);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_Storage value) storage,
    required TResult Function(Permission_Network value) network,
    required TResult Function(Permission_ActionPopup value) actionPopup,
    required TResult Function(Permission_ArbitraryNetwork value)
        arbitraryNetwork,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_Storage value)? storage,
    TResult? Function(Permission_Network value)? network,
    TResult? Function(Permission_ActionPopup value)? actionPopup,
    TResult? Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_Storage value)? storage,
    TResult Function(Permission_Network value)? network,
    TResult Function(Permission_ActionPopup value)? actionPopup,
    TResult Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Permission_NetworkImplToJson(
      this,
    );
  }
}

abstract class Permission_Network extends Permission {
  const factory Permission_Network({required final String domain}) =
      _$Permission_NetworkImpl;
  const Permission_Network._() : super._();

  factory Permission_Network.fromJson(Map<String, dynamic> json) =
      _$Permission_NetworkImpl.fromJson;

  String get domain;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Permission_NetworkImplCopyWith<_$Permission_NetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Permission_ActionPopupImplCopyWith<$Res> {
  factory _$$Permission_ActionPopupImplCopyWith(
          _$Permission_ActionPopupImpl value,
          $Res Function(_$Permission_ActionPopupImpl) then) =
      __$$Permission_ActionPopupImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$Permission_ActionPopupImplCopyWithImpl<$Res>
    extends _$PermissionCopyWithImpl<$Res, _$Permission_ActionPopupImpl>
    implements _$$Permission_ActionPopupImplCopyWith<$Res> {
  __$$Permission_ActionPopupImplCopyWithImpl(
      _$Permission_ActionPopupImpl _value,
      $Res Function(_$Permission_ActionPopupImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$Permission_ActionPopupImpl extends Permission_ActionPopup {
  const _$Permission_ActionPopupImpl({final String? $type})
      : $type = $type ?? 'actionPopup',
        super._();

  factory _$Permission_ActionPopupImpl.fromJson(Map<String, dynamic> json) =>
      _$$Permission_ActionPopupImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Permission.actionPopup()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Permission_ActionPopupImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(String domain) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return actionPopup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(String domain)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return actionPopup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(String domain)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (actionPopup != null) {
      return actionPopup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_Storage value) storage,
    required TResult Function(Permission_Network value) network,
    required TResult Function(Permission_ActionPopup value) actionPopup,
    required TResult Function(Permission_ArbitraryNetwork value)
        arbitraryNetwork,
  }) {
    return actionPopup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_Storage value)? storage,
    TResult? Function(Permission_Network value)? network,
    TResult? Function(Permission_ActionPopup value)? actionPopup,
    TResult? Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
  }) {
    return actionPopup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_Storage value)? storage,
    TResult Function(Permission_Network value)? network,
    TResult Function(Permission_ActionPopup value)? actionPopup,
    TResult Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (actionPopup != null) {
      return actionPopup(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Permission_ActionPopupImplToJson(
      this,
    );
  }
}

abstract class Permission_ActionPopup extends Permission {
  const factory Permission_ActionPopup() = _$Permission_ActionPopupImpl;
  const Permission_ActionPopup._() : super._();

  factory Permission_ActionPopup.fromJson(Map<String, dynamic> json) =
      _$Permission_ActionPopupImpl.fromJson;
}

/// @nodoc
abstract class _$$Permission_ArbitraryNetworkImplCopyWith<$Res> {
  factory _$$Permission_ArbitraryNetworkImplCopyWith(
          _$Permission_ArbitraryNetworkImpl value,
          $Res Function(_$Permission_ArbitraryNetworkImpl) then) =
      __$$Permission_ArbitraryNetworkImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$Permission_ArbitraryNetworkImplCopyWithImpl<$Res>
    extends _$PermissionCopyWithImpl<$Res, _$Permission_ArbitraryNetworkImpl>
    implements _$$Permission_ArbitraryNetworkImplCopyWith<$Res> {
  __$$Permission_ArbitraryNetworkImplCopyWithImpl(
      _$Permission_ArbitraryNetworkImpl _value,
      $Res Function(_$Permission_ArbitraryNetworkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$Permission_ArbitraryNetworkImpl extends Permission_ArbitraryNetwork {
  const _$Permission_ArbitraryNetworkImpl({final String? $type})
      : $type = $type ?? 'arbitraryNetwork',
        super._();

  factory _$Permission_ArbitraryNetworkImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$Permission_ArbitraryNetworkImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Permission.arbitraryNetwork()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Permission_ArbitraryNetworkImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(String domain) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return arbitraryNetwork();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(String domain)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return arbitraryNetwork?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(String domain)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (arbitraryNetwork != null) {
      return arbitraryNetwork();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_Storage value) storage,
    required TResult Function(Permission_Network value) network,
    required TResult Function(Permission_ActionPopup value) actionPopup,
    required TResult Function(Permission_ArbitraryNetwork value)
        arbitraryNetwork,
  }) {
    return arbitraryNetwork(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_Storage value)? storage,
    TResult? Function(Permission_Network value)? network,
    TResult? Function(Permission_ActionPopup value)? actionPopup,
    TResult? Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
  }) {
    return arbitraryNetwork?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_Storage value)? storage,
    TResult Function(Permission_Network value)? network,
    TResult Function(Permission_ActionPopup value)? actionPopup,
    TResult Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (arbitraryNetwork != null) {
      return arbitraryNetwork(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Permission_ArbitraryNetworkImplToJson(
      this,
    );
  }
}

abstract class Permission_ArbitraryNetwork extends Permission {
  const factory Permission_ArbitraryNetwork() =
      _$Permission_ArbitraryNetworkImpl;
  const Permission_ArbitraryNetwork._() : super._();

  factory Permission_ArbitraryNetwork.fromJson(Map<String, dynamic> json) =
      _$Permission_ArbitraryNetworkImpl.fromJson;
}
