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

/// @nodoc
mixin _$Permission {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(List<String> domains) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(List<String> domains)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(List<String> domains)? network,
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

class _$Permission_StorageImpl extends Permission_Storage {
  const _$Permission_StorageImpl({required this.path, required this.write})
      : super._();

  @override
  final String path;
  @override
  final bool write;

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
    required TResult Function(List<String> domains) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return storage(path, write);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(List<String> domains)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return storage?.call(path, write);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(List<String> domains)? network,
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
}

abstract class Permission_Storage extends Permission {
  const factory Permission_Storage(
      {required final String path,
      required final bool write}) = _$Permission_StorageImpl;
  const Permission_Storage._() : super._();

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
  $Res call({List<String> domains});
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
    Object? domains = null,
  }) {
    return _then(_$Permission_NetworkImpl(
      domains: null == domains
          ? _value._domains
          : domains // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$Permission_NetworkImpl extends Permission_Network {
  const _$Permission_NetworkImpl({required final List<String> domains})
      : _domains = domains,
        super._();

  final List<String> _domains;
  @override
  List<String> get domains {
    if (_domains is EqualUnmodifiableListView) return _domains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_domains);
  }

  @override
  String toString() {
    return 'Permission.network(domains: $domains)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Permission_NetworkImpl &&
            const DeepCollectionEquality().equals(other._domains, _domains));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_domains));

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
    required TResult Function(List<String> domains) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return network(domains);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(List<String> domains)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return network?.call(domains);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(List<String> domains)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(domains);
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
}

abstract class Permission_Network extends Permission {
  const factory Permission_Network({required final List<String> domains}) =
      _$Permission_NetworkImpl;
  const Permission_Network._() : super._();

  List<String> get domains;

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

class _$Permission_ActionPopupImpl extends Permission_ActionPopup {
  const _$Permission_ActionPopupImpl() : super._();

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

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(List<String> domains) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return actionPopup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(List<String> domains)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return actionPopup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(List<String> domains)? network,
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
}

abstract class Permission_ActionPopup extends Permission {
  const factory Permission_ActionPopup() = _$Permission_ActionPopupImpl;
  const Permission_ActionPopup._() : super._();
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

class _$Permission_ArbitraryNetworkImpl extends Permission_ArbitraryNetwork {
  const _$Permission_ArbitraryNetworkImpl() : super._();

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

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storage,
    required TResult Function(List<String> domains) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    return arbitraryNetwork();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storage,
    TResult? Function(List<String> domains)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    return arbitraryNetwork?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storage,
    TResult Function(List<String> domains)? network,
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
}

abstract class Permission_ArbitraryNetwork extends Permission {
  const factory Permission_ArbitraryNetwork() =
      _$Permission_ArbitraryNetworkImpl;
  const Permission_ArbitraryNetwork._() : super._();
}
