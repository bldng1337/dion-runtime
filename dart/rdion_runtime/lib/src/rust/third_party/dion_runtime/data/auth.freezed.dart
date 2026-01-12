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
mixin _$AuthCreds {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, List<String>> cookies) cookies,
    required TResult Function(String key) apiKey,
    required TResult Function(String username, String password) userPass,
    required TResult Function(
            String accessToken, String? refreshToken, int? expiresAt)
        oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> cookies)? cookies,
    TResult? Function(String key)? apiKey,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> cookies)? cookies,
    TResult Function(String key)? apiKey,
    TResult Function(String username, String password)? userPass,
    TResult Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCreds_Cookies value) cookies,
    required TResult Function(AuthCreds_ApiKey value) apiKey,
    required TResult Function(AuthCreds_UserPass value) userPass,
    required TResult Function(AuthCreds_OAuth value) oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCreds_Cookies value)? cookies,
    TResult? Function(AuthCreds_ApiKey value)? apiKey,
    TResult? Function(AuthCreds_UserPass value)? userPass,
    TResult? Function(AuthCreds_OAuth value)? oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCreds_Cookies value)? cookies,
    TResult Function(AuthCreds_ApiKey value)? apiKey,
    TResult Function(AuthCreds_UserPass value)? userPass,
    TResult Function(AuthCreds_OAuth value)? oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCredsCopyWith<$Res> {
  factory $AuthCredsCopyWith(AuthCreds value, $Res Function(AuthCreds) then) =
      _$AuthCredsCopyWithImpl<$Res, AuthCreds>;
}

/// @nodoc
class _$AuthCredsCopyWithImpl<$Res, $Val extends AuthCreds>
    implements $AuthCredsCopyWith<$Res> {
  _$AuthCredsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthCreds_CookiesImplCopyWith<$Res> {
  factory _$$AuthCreds_CookiesImplCopyWith(_$AuthCreds_CookiesImpl value,
          $Res Function(_$AuthCreds_CookiesImpl) then) =
      __$$AuthCreds_CookiesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, List<String>> cookies});
}

/// @nodoc
class __$$AuthCreds_CookiesImplCopyWithImpl<$Res>
    extends _$AuthCredsCopyWithImpl<$Res, _$AuthCreds_CookiesImpl>
    implements _$$AuthCreds_CookiesImplCopyWith<$Res> {
  __$$AuthCreds_CookiesImplCopyWithImpl(_$AuthCreds_CookiesImpl _value,
      $Res Function(_$AuthCreds_CookiesImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cookies = null,
  }) {
    return _then(_$AuthCreds_CookiesImpl(
      cookies: null == cookies
          ? _value._cookies
          : cookies // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$AuthCreds_CookiesImpl extends AuthCreds_Cookies {
  const _$AuthCreds_CookiesImpl(
      {required final Map<String, List<String>> cookies})
      : _cookies = cookies,
        super._();

  final Map<String, List<String>> _cookies;
  @override
  Map<String, List<String>> get cookies {
    if (_cookies is EqualUnmodifiableMapView) return _cookies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cookies);
  }

  @override
  String toString() {
    return 'AuthCreds.cookies(cookies: $cookies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCreds_CookiesImpl &&
            const DeepCollectionEquality().equals(other._cookies, _cookies));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cookies));

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCreds_CookiesImplCopyWith<_$AuthCreds_CookiesImpl> get copyWith =>
      __$$AuthCreds_CookiesImplCopyWithImpl<_$AuthCreds_CookiesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, List<String>> cookies) cookies,
    required TResult Function(String key) apiKey,
    required TResult Function(String username, String password) userPass,
    required TResult Function(
            String accessToken, String? refreshToken, int? expiresAt)
        oAuth,
  }) {
    return cookies(this.cookies);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> cookies)? cookies,
    TResult? Function(String key)? apiKey,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
  }) {
    return cookies?.call(this.cookies);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> cookies)? cookies,
    TResult Function(String key)? apiKey,
    TResult Function(String username, String password)? userPass,
    TResult Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
    required TResult orElse(),
  }) {
    if (cookies != null) {
      return cookies(this.cookies);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCreds_Cookies value) cookies,
    required TResult Function(AuthCreds_ApiKey value) apiKey,
    required TResult Function(AuthCreds_UserPass value) userPass,
    required TResult Function(AuthCreds_OAuth value) oAuth,
  }) {
    return cookies(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCreds_Cookies value)? cookies,
    TResult? Function(AuthCreds_ApiKey value)? apiKey,
    TResult? Function(AuthCreds_UserPass value)? userPass,
    TResult? Function(AuthCreds_OAuth value)? oAuth,
  }) {
    return cookies?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCreds_Cookies value)? cookies,
    TResult Function(AuthCreds_ApiKey value)? apiKey,
    TResult Function(AuthCreds_UserPass value)? userPass,
    TResult Function(AuthCreds_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (cookies != null) {
      return cookies(this);
    }
    return orElse();
  }
}

abstract class AuthCreds_Cookies extends AuthCreds {
  const factory AuthCreds_Cookies(
          {required final Map<String, List<String>> cookies}) =
      _$AuthCreds_CookiesImpl;
  const AuthCreds_Cookies._() : super._();

  Map<String, List<String>> get cookies;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCreds_CookiesImplCopyWith<_$AuthCreds_CookiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthCreds_ApiKeyImplCopyWith<$Res> {
  factory _$$AuthCreds_ApiKeyImplCopyWith(_$AuthCreds_ApiKeyImpl value,
          $Res Function(_$AuthCreds_ApiKeyImpl) then) =
      __$$AuthCreds_ApiKeyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String key});
}

/// @nodoc
class __$$AuthCreds_ApiKeyImplCopyWithImpl<$Res>
    extends _$AuthCredsCopyWithImpl<$Res, _$AuthCreds_ApiKeyImpl>
    implements _$$AuthCreds_ApiKeyImplCopyWith<$Res> {
  __$$AuthCreds_ApiKeyImplCopyWithImpl(_$AuthCreds_ApiKeyImpl _value,
      $Res Function(_$AuthCreds_ApiKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$AuthCreds_ApiKeyImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthCreds_ApiKeyImpl extends AuthCreds_ApiKey {
  const _$AuthCreds_ApiKeyImpl({required this.key}) : super._();

  @override
  final String key;

  @override
  String toString() {
    return 'AuthCreds.apiKey(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCreds_ApiKeyImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCreds_ApiKeyImplCopyWith<_$AuthCreds_ApiKeyImpl> get copyWith =>
      __$$AuthCreds_ApiKeyImplCopyWithImpl<_$AuthCreds_ApiKeyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, List<String>> cookies) cookies,
    required TResult Function(String key) apiKey,
    required TResult Function(String username, String password) userPass,
    required TResult Function(
            String accessToken, String? refreshToken, int? expiresAt)
        oAuth,
  }) {
    return apiKey(key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> cookies)? cookies,
    TResult? Function(String key)? apiKey,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
  }) {
    return apiKey?.call(key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> cookies)? cookies,
    TResult Function(String key)? apiKey,
    TResult Function(String username, String password)? userPass,
    TResult Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
    required TResult orElse(),
  }) {
    if (apiKey != null) {
      return apiKey(key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCreds_Cookies value) cookies,
    required TResult Function(AuthCreds_ApiKey value) apiKey,
    required TResult Function(AuthCreds_UserPass value) userPass,
    required TResult Function(AuthCreds_OAuth value) oAuth,
  }) {
    return apiKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCreds_Cookies value)? cookies,
    TResult? Function(AuthCreds_ApiKey value)? apiKey,
    TResult? Function(AuthCreds_UserPass value)? userPass,
    TResult? Function(AuthCreds_OAuth value)? oAuth,
  }) {
    return apiKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCreds_Cookies value)? cookies,
    TResult Function(AuthCreds_ApiKey value)? apiKey,
    TResult Function(AuthCreds_UserPass value)? userPass,
    TResult Function(AuthCreds_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (apiKey != null) {
      return apiKey(this);
    }
    return orElse();
  }
}

abstract class AuthCreds_ApiKey extends AuthCreds {
  const factory AuthCreds_ApiKey({required final String key}) =
      _$AuthCreds_ApiKeyImpl;
  const AuthCreds_ApiKey._() : super._();

  String get key;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCreds_ApiKeyImplCopyWith<_$AuthCreds_ApiKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthCreds_UserPassImplCopyWith<$Res> {
  factory _$$AuthCreds_UserPassImplCopyWith(_$AuthCreds_UserPassImpl value,
          $Res Function(_$AuthCreds_UserPassImpl) then) =
      __$$AuthCreds_UserPassImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$AuthCreds_UserPassImplCopyWithImpl<$Res>
    extends _$AuthCredsCopyWithImpl<$Res, _$AuthCreds_UserPassImpl>
    implements _$$AuthCreds_UserPassImplCopyWith<$Res> {
  __$$AuthCreds_UserPassImplCopyWithImpl(_$AuthCreds_UserPassImpl _value,
      $Res Function(_$AuthCreds_UserPassImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$AuthCreds_UserPassImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthCreds_UserPassImpl extends AuthCreds_UserPass {
  const _$AuthCreds_UserPassImpl(
      {required this.username, required this.password})
      : super._();

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthCreds.userPass(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCreds_UserPassImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCreds_UserPassImplCopyWith<_$AuthCreds_UserPassImpl> get copyWith =>
      __$$AuthCreds_UserPassImplCopyWithImpl<_$AuthCreds_UserPassImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, List<String>> cookies) cookies,
    required TResult Function(String key) apiKey,
    required TResult Function(String username, String password) userPass,
    required TResult Function(
            String accessToken, String? refreshToken, int? expiresAt)
        oAuth,
  }) {
    return userPass(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> cookies)? cookies,
    TResult? Function(String key)? apiKey,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
  }) {
    return userPass?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> cookies)? cookies,
    TResult Function(String key)? apiKey,
    TResult Function(String username, String password)? userPass,
    TResult Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
    required TResult orElse(),
  }) {
    if (userPass != null) {
      return userPass(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCreds_Cookies value) cookies,
    required TResult Function(AuthCreds_ApiKey value) apiKey,
    required TResult Function(AuthCreds_UserPass value) userPass,
    required TResult Function(AuthCreds_OAuth value) oAuth,
  }) {
    return userPass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCreds_Cookies value)? cookies,
    TResult? Function(AuthCreds_ApiKey value)? apiKey,
    TResult? Function(AuthCreds_UserPass value)? userPass,
    TResult? Function(AuthCreds_OAuth value)? oAuth,
  }) {
    return userPass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCreds_Cookies value)? cookies,
    TResult Function(AuthCreds_ApiKey value)? apiKey,
    TResult Function(AuthCreds_UserPass value)? userPass,
    TResult Function(AuthCreds_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (userPass != null) {
      return userPass(this);
    }
    return orElse();
  }
}

abstract class AuthCreds_UserPass extends AuthCreds {
  const factory AuthCreds_UserPass(
      {required final String username,
      required final String password}) = _$AuthCreds_UserPassImpl;
  const AuthCreds_UserPass._() : super._();

  String get username;
  String get password;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCreds_UserPassImplCopyWith<_$AuthCreds_UserPassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthCreds_OAuthImplCopyWith<$Res> {
  factory _$$AuthCreds_OAuthImplCopyWith(_$AuthCreds_OAuthImpl value,
          $Res Function(_$AuthCreds_OAuthImpl) then) =
      __$$AuthCreds_OAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String accessToken, String? refreshToken, int? expiresAt});
}

/// @nodoc
class __$$AuthCreds_OAuthImplCopyWithImpl<$Res>
    extends _$AuthCredsCopyWithImpl<$Res, _$AuthCreds_OAuthImpl>
    implements _$$AuthCreds_OAuthImplCopyWith<$Res> {
  __$$AuthCreds_OAuthImplCopyWithImpl(
      _$AuthCreds_OAuthImpl _value, $Res Function(_$AuthCreds_OAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$AuthCreds_OAuthImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AuthCreds_OAuthImpl extends AuthCreds_OAuth {
  const _$AuthCreds_OAuthImpl(
      {required this.accessToken, this.refreshToken, this.expiresAt})
      : super._();

  @override
  final String accessToken;
  @override
  final String? refreshToken;
  @override
  final int? expiresAt;

  @override
  String toString() {
    return 'AuthCreds.oAuth(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCreds_OAuthImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresAt);

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCreds_OAuthImplCopyWith<_$AuthCreds_OAuthImpl> get copyWith =>
      __$$AuthCreds_OAuthImplCopyWithImpl<_$AuthCreds_OAuthImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, List<String>> cookies) cookies,
    required TResult Function(String key) apiKey,
    required TResult Function(String username, String password) userPass,
    required TResult Function(
            String accessToken, String? refreshToken, int? expiresAt)
        oAuth,
  }) {
    return oAuth(accessToken, refreshToken, expiresAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> cookies)? cookies,
    TResult? Function(String key)? apiKey,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
  }) {
    return oAuth?.call(accessToken, refreshToken, expiresAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> cookies)? cookies,
    TResult Function(String key)? apiKey,
    TResult Function(String username, String password)? userPass,
    TResult Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(accessToken, refreshToken, expiresAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthCreds_Cookies value) cookies,
    required TResult Function(AuthCreds_ApiKey value) apiKey,
    required TResult Function(AuthCreds_UserPass value) userPass,
    required TResult Function(AuthCreds_OAuth value) oAuth,
  }) {
    return oAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthCreds_Cookies value)? cookies,
    TResult? Function(AuthCreds_ApiKey value)? apiKey,
    TResult? Function(AuthCreds_UserPass value)? userPass,
    TResult? Function(AuthCreds_OAuth value)? oAuth,
  }) {
    return oAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthCreds_Cookies value)? cookies,
    TResult Function(AuthCreds_ApiKey value)? apiKey,
    TResult Function(AuthCreds_UserPass value)? userPass,
    TResult Function(AuthCreds_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(this);
    }
    return orElse();
  }
}

abstract class AuthCreds_OAuth extends AuthCreds {
  const factory AuthCreds_OAuth(
      {required final String accessToken,
      final String? refreshToken,
      final int? expiresAt}) = _$AuthCreds_OAuthImpl;
  const AuthCreds_OAuth._() : super._();

  String get accessToken;
  String? get refreshToken;
  int? get expiresAt;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCreds_OAuthImplCopyWith<_$AuthCreds_OAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
    required TResult Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)
        oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
    TResult? Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)?
        oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    TResult Function(String authorizationUrl, String? tokenUrl, String clientId,
            String clientSecret, String? scope)?
        oAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
    required TResult Function(AuthData_OAuth value) oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
    TResult? Function(AuthData_OAuth value)? oAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    TResult Function(AuthData_OAuth value)? oAuth,
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
    required TResult Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)
        oAuth,
  }) {
    return cookie(loginpage, logonpage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
    TResult? Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)?
        oAuth,
  }) {
    return cookie?.call(loginpage, logonpage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    TResult Function(String authorizationUrl, String? tokenUrl, String clientId,
            String clientSecret, String? scope)?
        oAuth,
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
    required TResult Function(AuthData_OAuth value) oAuth,
  }) {
    return cookie(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
    TResult? Function(AuthData_OAuth value)? oAuth,
  }) {
    return cookie?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    TResult Function(AuthData_OAuth value)? oAuth,
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
    required TResult Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)
        oAuth,
  }) {
    return apiKey();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
    TResult? Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)?
        oAuth,
  }) {
    return apiKey?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    TResult Function(String authorizationUrl, String? tokenUrl, String clientId,
            String clientSecret, String? scope)?
        oAuth,
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
    required TResult Function(AuthData_OAuth value) oAuth,
  }) {
    return apiKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
    TResult? Function(AuthData_OAuth value)? oAuth,
  }) {
    return apiKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    TResult Function(AuthData_OAuth value)? oAuth,
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
    required TResult Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)
        oAuth,
  }) {
    return userPass();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
    TResult? Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)?
        oAuth,
  }) {
    return userPass?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    TResult Function(String authorizationUrl, String? tokenUrl, String clientId,
            String clientSecret, String? scope)?
        oAuth,
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
    required TResult Function(AuthData_OAuth value) oAuth,
  }) {
    return userPass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
    TResult? Function(AuthData_OAuth value)? oAuth,
  }) {
    return userPass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    TResult Function(AuthData_OAuth value)? oAuth,
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

/// @nodoc
abstract class _$$AuthData_OAuthImplCopyWith<$Res> {
  factory _$$AuthData_OAuthImplCopyWith(_$AuthData_OAuthImpl value,
          $Res Function(_$AuthData_OAuthImpl) then) =
      __$$AuthData_OAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String authorizationUrl,
      String? tokenUrl,
      String clientId,
      String clientSecret,
      String? scope});
}

/// @nodoc
class __$$AuthData_OAuthImplCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$AuthData_OAuthImpl>
    implements _$$AuthData_OAuthImplCopyWith<$Res> {
  __$$AuthData_OAuthImplCopyWithImpl(
      _$AuthData_OAuthImpl _value, $Res Function(_$AuthData_OAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorizationUrl = null,
    Object? tokenUrl = freezed,
    Object? clientId = null,
    Object? clientSecret = null,
    Object? scope = freezed,
  }) {
    return _then(_$AuthData_OAuthImpl(
      authorizationUrl: null == authorizationUrl
          ? _value.authorizationUrl
          : authorizationUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tokenUrl: freezed == tokenUrl
          ? _value.tokenUrl
          : tokenUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthData_OAuthImpl extends AuthData_OAuth {
  const _$AuthData_OAuthImpl(
      {required this.authorizationUrl,
      this.tokenUrl,
      required this.clientId,
      required this.clientSecret,
      this.scope})
      : super._();

  @override
  final String authorizationUrl;
  @override
  final String? tokenUrl;
  @override
  final String clientId;
  @override
  final String clientSecret;
  @override
  final String? scope;

  @override
  String toString() {
    return 'AuthData.oAuth(authorizationUrl: $authorizationUrl, tokenUrl: $tokenUrl, clientId: $clientId, clientSecret: $clientSecret, scope: $scope)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthData_OAuthImpl &&
            (identical(other.authorizationUrl, authorizationUrl) ||
                other.authorizationUrl == authorizationUrl) &&
            (identical(other.tokenUrl, tokenUrl) ||
                other.tokenUrl == tokenUrl) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.scope, scope) || other.scope == scope));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, authorizationUrl, tokenUrl, clientId, clientSecret, scope);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthData_OAuthImplCopyWith<_$AuthData_OAuthImpl> get copyWith =>
      __$$AuthData_OAuthImplCopyWithImpl<_$AuthData_OAuthImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
    required TResult Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)
        oAuth,
  }) {
    return oAuth(authorizationUrl, tokenUrl, clientId, clientSecret, scope);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
    TResult? Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)?
        oAuth,
  }) {
    return oAuth?.call(
        authorizationUrl, tokenUrl, clientId, clientSecret, scope);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    TResult Function(String authorizationUrl, String? tokenUrl, String clientId,
            String clientSecret, String? scope)?
        oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(authorizationUrl, tokenUrl, clientId, clientSecret, scope);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
    required TResult Function(AuthData_OAuth value) oAuth,
  }) {
    return oAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
    TResult? Function(AuthData_OAuth value)? oAuth,
  }) {
    return oAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    TResult Function(AuthData_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    if (oAuth != null) {
      return oAuth(this);
    }
    return orElse();
  }
}

abstract class AuthData_OAuth extends AuthData {
  const factory AuthData_OAuth(
      {required final String authorizationUrl,
      final String? tokenUrl,
      required final String clientId,
      required final String clientSecret,
      final String? scope}) = _$AuthData_OAuthImpl;
  const AuthData_OAuth._() : super._();

  String get authorizationUrl;
  String? get tokenUrl;
  String get clientId;
  String get clientSecret;
  String? get scope;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthData_OAuthImplCopyWith<_$AuthData_OAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
