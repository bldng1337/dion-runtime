// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Permission {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Permission);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Permission()';
  }
}

/// @nodoc
class $PermissionCopyWith<$Res> {
  $PermissionCopyWith(Permission _, $Res Function(Permission) __);
}

/// Adds pattern-matching-related methods to [Permission].
extension PermissionPatterns on Permission {
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
    TResult Function(Permission_Storage value)? storage,
    TResult Function(Permission_Network value)? network,
    TResult Function(Permission_ActionPopup value)? actionPopup,
    TResult Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Permission_Storage() when storage != null:
        return storage(_that);
      case Permission_Network() when network != null:
        return network(_that);
      case Permission_ActionPopup() when actionPopup != null:
        return actionPopup(_that);
      case Permission_ArbitraryNetwork() when arbitraryNetwork != null:
        return arbitraryNetwork(_that);
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
    required TResult Function(Permission_Storage value) storage,
    required TResult Function(Permission_Network value) network,
    required TResult Function(Permission_ActionPopup value) actionPopup,
    required TResult Function(Permission_ArbitraryNetwork value)
        arbitraryNetwork,
  }) {
    final _that = this;
    switch (_that) {
      case Permission_Storage():
        return storage(_that);
      case Permission_Network():
        return network(_that);
      case Permission_ActionPopup():
        return actionPopup(_that);
      case Permission_ArbitraryNetwork():
        return arbitraryNetwork(_that);
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
    TResult? Function(Permission_Storage value)? storage,
    TResult? Function(Permission_Network value)? network,
    TResult? Function(Permission_ActionPopup value)? actionPopup,
    TResult? Function(Permission_ArbitraryNetwork value)? arbitraryNetwork,
  }) {
    final _that = this;
    switch (_that) {
      case Permission_Storage() when storage != null:
        return storage(_that);
      case Permission_Network() when network != null:
        return network(_that);
      case Permission_ActionPopup() when actionPopup != null:
        return actionPopup(_that);
      case Permission_ArbitraryNetwork() when arbitraryNetwork != null:
        return arbitraryNetwork(_that);
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
    TResult Function(String path, bool write)? storage,
    TResult Function(List<String> domains)? network,
    TResult Function()? actionPopup,
    TResult Function()? arbitraryNetwork,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Permission_Storage() when storage != null:
        return storage(_that.path, _that.write);
      case Permission_Network() when network != null:
        return network(_that.domains);
      case Permission_ActionPopup() when actionPopup != null:
        return actionPopup();
      case Permission_ArbitraryNetwork() when arbitraryNetwork != null:
        return arbitraryNetwork();
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
    required TResult Function(String path, bool write) storage,
    required TResult Function(List<String> domains) network,
    required TResult Function() actionPopup,
    required TResult Function() arbitraryNetwork,
  }) {
    final _that = this;
    switch (_that) {
      case Permission_Storage():
        return storage(_that.path, _that.write);
      case Permission_Network():
        return network(_that.domains);
      case Permission_ActionPopup():
        return actionPopup();
      case Permission_ArbitraryNetwork():
        return arbitraryNetwork();
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
    TResult? Function(String path, bool write)? storage,
    TResult? Function(List<String> domains)? network,
    TResult? Function()? actionPopup,
    TResult? Function()? arbitraryNetwork,
  }) {
    final _that = this;
    switch (_that) {
      case Permission_Storage() when storage != null:
        return storage(_that.path, _that.write);
      case Permission_Network() when network != null:
        return network(_that.domains);
      case Permission_ActionPopup() when actionPopup != null:
        return actionPopup();
      case Permission_ArbitraryNetwork() when arbitraryNetwork != null:
        return arbitraryNetwork();
      case _:
        return null;
    }
  }
}

/// @nodoc

class Permission_Storage extends Permission {
  const Permission_Storage({required this.path, required this.write})
      : super._();

  final String path;
  final bool write;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Permission_StorageCopyWith<Permission_Storage> get copyWith =>
      _$Permission_StorageCopyWithImpl<Permission_Storage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Permission_Storage &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.write, write) || other.write == write));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, write);

  @override
  String toString() {
    return 'Permission.storage(path: $path, write: $write)';
  }
}

/// @nodoc
abstract mixin class $Permission_StorageCopyWith<$Res>
    implements $PermissionCopyWith<$Res> {
  factory $Permission_StorageCopyWith(
          Permission_Storage value, $Res Function(Permission_Storage) _then) =
      _$Permission_StorageCopyWithImpl;
  @useResult
  $Res call({String path, bool write});
}

/// @nodoc
class _$Permission_StorageCopyWithImpl<$Res>
    implements $Permission_StorageCopyWith<$Res> {
  _$Permission_StorageCopyWithImpl(this._self, this._then);

  final Permission_Storage _self;
  final $Res Function(Permission_Storage) _then;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? write = null,
  }) {
    return _then(Permission_Storage(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      write: null == write
          ? _self.write
          : write // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class Permission_Network extends Permission {
  const Permission_Network({required final List<String> domains})
      : _domains = domains,
        super._();

  final List<String> _domains;
  List<String> get domains {
    if (_domains is EqualUnmodifiableListView) return _domains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_domains);
  }

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Permission_NetworkCopyWith<Permission_Network> get copyWith =>
      _$Permission_NetworkCopyWithImpl<Permission_Network>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Permission_Network &&
            const DeepCollectionEquality().equals(other._domains, _domains));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_domains));

  @override
  String toString() {
    return 'Permission.network(domains: $domains)';
  }
}

/// @nodoc
abstract mixin class $Permission_NetworkCopyWith<$Res>
    implements $PermissionCopyWith<$Res> {
  factory $Permission_NetworkCopyWith(
          Permission_Network value, $Res Function(Permission_Network) _then) =
      _$Permission_NetworkCopyWithImpl;
  @useResult
  $Res call({List<String> domains});
}

/// @nodoc
class _$Permission_NetworkCopyWithImpl<$Res>
    implements $Permission_NetworkCopyWith<$Res> {
  _$Permission_NetworkCopyWithImpl(this._self, this._then);

  final Permission_Network _self;
  final $Res Function(Permission_Network) _then;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? domains = null,
  }) {
    return _then(Permission_Network(
      domains: null == domains
          ? _self._domains
          : domains // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class Permission_ActionPopup extends Permission {
  const Permission_ActionPopup() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Permission_ActionPopup);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Permission.actionPopup()';
  }
}

/// @nodoc

class Permission_ArbitraryNetwork extends Permission {
  const Permission_ArbitraryNetwork() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Permission_ArbitraryNetwork);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Permission.arbitraryNetwork()';
  }
}

// dart format on
