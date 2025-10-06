// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthDataCopyWith<$Res> {
  factory $AuthDataCopyWith(AuthData value, $Res Function(AuthData) then) =
      _$AuthDataCopyWithImpl<$Res, AuthData>;
}

/// @nodoc
class _$AuthDataCopyWithImpl<$Res, $Val extends AuthData>
    implements $AuthDataCopyWith<$Res> {
  _$AuthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthData_CookieImplCopyWith<$Res> {
  factory _$$AuthData_CookieImplCopyWith(_$AuthData_CookieImpl value,
          $Res Function(_$AuthData_CookieImpl) then) =
      __$$AuthData_CookieImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String loginpage, String logonpage});
}

/// @nodoc
class __$$AuthData_CookieImplCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$AuthData_CookieImpl>
    implements _$$AuthData_CookieImplCopyWith<$Res> {
  __$$AuthData_CookieImplCopyWithImpl(
      _$AuthData_CookieImpl _value, $Res Function(_$AuthData_CookieImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginpage = null,
    Object? logonpage = null,
  }) {
    return _then(_$AuthData_CookieImpl(
      loginpage: null == loginpage
          ? _value.loginpage
          : loginpage // ignore: cast_nullable_to_non_nullable
              as String,
      logonpage: null == logonpage
          ? _value.logonpage
          : logonpage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthData_CookieImpl extends AuthData_Cookie {
  const _$AuthData_CookieImpl(
      {required this.loginpage, required this.logonpage})
      : super._();

  @override
  final String loginpage;
  @override
  final String logonpage;

  @override
  String toString() {
    return 'AuthData.cookie(loginpage: $loginpage, logonpage: $logonpage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthData_CookieImpl &&
            (identical(other.loginpage, loginpage) ||
                other.loginpage == loginpage) &&
            (identical(other.logonpage, logonpage) ||
                other.logonpage == logonpage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loginpage, logonpage);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthData_CookieImplCopyWith<_$AuthData_CookieImpl> get copyWith =>
      __$$AuthData_CookieImplCopyWithImpl<_$AuthData_CookieImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
  }) {
    return cookie(loginpage, logonpage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
  }) {
    return cookie?.call(loginpage, logonpage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    required TResult orElse(),
  }) {
    if (cookie != null) {
      return cookie(loginpage, logonpage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
  }) {
    return cookie(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
  }) {
    return cookie?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    required TResult orElse(),
  }) {
    if (cookie != null) {
      return cookie(this);
    }
    return orElse();
  }
}

abstract class AuthData_Cookie extends AuthData {
  const factory AuthData_Cookie(
      {required final String loginpage,
      required final String logonpage}) = _$AuthData_CookieImpl;
  const AuthData_Cookie._() : super._();

  String get loginpage;
  String get logonpage;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthData_CookieImplCopyWith<_$AuthData_CookieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthData_ApiKeyImplCopyWith<$Res> {
  factory _$$AuthData_ApiKeyImplCopyWith(_$AuthData_ApiKeyImpl value,
          $Res Function(_$AuthData_ApiKeyImpl) then) =
      __$$AuthData_ApiKeyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthData_ApiKeyImplCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$AuthData_ApiKeyImpl>
    implements _$$AuthData_ApiKeyImplCopyWith<$Res> {
  __$$AuthData_ApiKeyImplCopyWithImpl(
      _$AuthData_ApiKeyImpl _value, $Res Function(_$AuthData_ApiKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthData_ApiKeyImpl extends AuthData_ApiKey {
  const _$AuthData_ApiKeyImpl() : super._();

  @override
  String toString() {
    return 'AuthData.apiKey()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthData_ApiKeyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
  }) {
    return apiKey();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
  }) {
    return apiKey?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    required TResult orElse(),
  }) {
    if (apiKey != null) {
      return apiKey();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
  }) {
    return apiKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
  }) {
    return apiKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    required TResult orElse(),
  }) {
    if (apiKey != null) {
      return apiKey(this);
    }
    return orElse();
  }
}

abstract class AuthData_ApiKey extends AuthData {
  const factory AuthData_ApiKey() = _$AuthData_ApiKeyImpl;
  const AuthData_ApiKey._() : super._();
}

/// @nodoc
abstract class _$$AuthData_UserPassImplCopyWith<$Res> {
  factory _$$AuthData_UserPassImplCopyWith(_$AuthData_UserPassImpl value,
          $Res Function(_$AuthData_UserPassImpl) then) =
      __$$AuthData_UserPassImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthData_UserPassImplCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$AuthData_UserPassImpl>
    implements _$$AuthData_UserPassImplCopyWith<$Res> {
  __$$AuthData_UserPassImplCopyWithImpl(_$AuthData_UserPassImpl _value,
      $Res Function(_$AuthData_UserPassImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthData_UserPassImpl extends AuthData_UserPass {
  const _$AuthData_UserPassImpl() : super._();

  @override
  String toString() {
    return 'AuthData.userPass()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthData_UserPassImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
  }) {
    return userPass();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
  }) {
    return userPass?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    required TResult orElse(),
  }) {
    if (userPass != null) {
      return userPass();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
  }) {
    return userPass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
  }) {
    return userPass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    required TResult orElse(),
  }) {
    if (userPass != null) {
      return userPass(this);
    }
    return orElse();
  }
}

abstract class AuthData_UserPass extends AuthData {
  const factory AuthData_UserPass() = _$AuthData_UserPassImpl;
  const AuthData_UserPass._() : super._();
}
