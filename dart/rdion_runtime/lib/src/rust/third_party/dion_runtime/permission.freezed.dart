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
  String get path => throw _privateConstructorUsedError;
  bool get write => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storagePermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storagePermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storagePermission,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_StoragePermission value)
        storagePermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_StoragePermission value)? storagePermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_StoragePermission value)? storagePermission,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionCopyWith<Permission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionCopyWith<$Res> {
  factory $PermissionCopyWith(
          Permission value, $Res Function(Permission) then) =
      _$PermissionCopyWithImpl<$Res, Permission>;
  @useResult
  $Res call({String path, bool write});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? write = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      write: null == write
          ? _value.write
          : write // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Permission_StoragePermissionImplCopyWith<$Res>
    implements $PermissionCopyWith<$Res> {
  factory _$$Permission_StoragePermissionImplCopyWith(
          _$Permission_StoragePermissionImpl value,
          $Res Function(_$Permission_StoragePermissionImpl) then) =
      __$$Permission_StoragePermissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, bool write});
}

/// @nodoc
class __$$Permission_StoragePermissionImplCopyWithImpl<$Res>
    extends _$PermissionCopyWithImpl<$Res, _$Permission_StoragePermissionImpl>
    implements _$$Permission_StoragePermissionImplCopyWith<$Res> {
  __$$Permission_StoragePermissionImplCopyWithImpl(
      _$Permission_StoragePermissionImpl _value,
      $Res Function(_$Permission_StoragePermissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? write = null,
  }) {
    return _then(_$Permission_StoragePermissionImpl(
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

class _$Permission_StoragePermissionImpl extends Permission_StoragePermission {
  const _$Permission_StoragePermissionImpl(
      {required this.path, required this.write})
      : super._();

  @override
  final String path;
  @override
  final bool write;

  @override
  String toString() {
    return 'Permission.storagePermission(path: $path, write: $write)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Permission_StoragePermissionImpl &&
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
  _$$Permission_StoragePermissionImplCopyWith<
          _$Permission_StoragePermissionImpl>
      get copyWith => __$$Permission_StoragePermissionImplCopyWithImpl<
          _$Permission_StoragePermissionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String path, bool write) storagePermission,
  }) {
    return storagePermission(path, write);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String path, bool write)? storagePermission,
  }) {
    return storagePermission?.call(path, write);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String path, bool write)? storagePermission,
    required TResult orElse(),
  }) {
    if (storagePermission != null) {
      return storagePermission(path, write);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Permission_StoragePermission value)
        storagePermission,
  }) {
    return storagePermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Permission_StoragePermission value)? storagePermission,
  }) {
    return storagePermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Permission_StoragePermission value)? storagePermission,
    required TResult orElse(),
  }) {
    if (storagePermission != null) {
      return storagePermission(this);
    }
    return orElse();
  }
}

abstract class Permission_StoragePermission extends Permission {
  const factory Permission_StoragePermission(
      {required final String path,
      required final bool write}) = _$Permission_StoragePermissionImpl;
  const Permission_StoragePermission._() : super._();

  @override
  String get path;
  @override
  bool get write;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Permission_StoragePermissionImplCopyWith<
          _$Permission_StoragePermissionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
