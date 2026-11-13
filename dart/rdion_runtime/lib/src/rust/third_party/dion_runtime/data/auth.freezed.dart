// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthCreds {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthCreds);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthCreds()';
  }
}

/// @nodoc
class $AuthCredsCopyWith<$Res> {
  $AuthCredsCopyWith(AuthCreds _, $Res Function(AuthCreds) __);
}

/// Adds pattern-matching-related methods to [AuthCreds].
extension AuthCredsPatterns on AuthCreds {
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
    TResult Function(AuthCreds_Cookies value)? cookies,
    TResult Function(AuthCreds_ApiKey value)? apiKey,
    TResult Function(AuthCreds_UserPass value)? userPass,
    TResult Function(AuthCreds_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthCreds_Cookies() when cookies != null:
        return cookies(_that);
      case AuthCreds_ApiKey() when apiKey != null:
        return apiKey(_that);
      case AuthCreds_UserPass() when userPass != null:
        return userPass(_that);
      case AuthCreds_OAuth() when oAuth != null:
        return oAuth(_that);
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
    required TResult Function(AuthCreds_Cookies value) cookies,
    required TResult Function(AuthCreds_ApiKey value) apiKey,
    required TResult Function(AuthCreds_UserPass value) userPass,
    required TResult Function(AuthCreds_OAuth value) oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCreds_Cookies():
        return cookies(_that);
      case AuthCreds_ApiKey():
        return apiKey(_that);
      case AuthCreds_UserPass():
        return userPass(_that);
      case AuthCreds_OAuth():
        return oAuth(_that);
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
    TResult? Function(AuthCreds_Cookies value)? cookies,
    TResult? Function(AuthCreds_ApiKey value)? apiKey,
    TResult? Function(AuthCreds_UserPass value)? userPass,
    TResult? Function(AuthCreds_OAuth value)? oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCreds_Cookies() when cookies != null:
        return cookies(_that);
      case AuthCreds_ApiKey() when apiKey != null:
        return apiKey(_that);
      case AuthCreds_UserPass() when userPass != null:
        return userPass(_that);
      case AuthCreds_OAuth() when oAuth != null:
        return oAuth(_that);
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
    TResult Function(Map<String, List<String>> cookies)? cookies,
    TResult Function(String key)? apiKey,
    TResult Function(String username, String password)? userPass,
    TResult Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthCreds_Cookies() when cookies != null:
        return cookies(_that.cookies);
      case AuthCreds_ApiKey() when apiKey != null:
        return apiKey(_that.key);
      case AuthCreds_UserPass() when userPass != null:
        return userPass(_that.username, _that.password);
      case AuthCreds_OAuth() when oAuth != null:
        return oAuth(_that.accessToken, _that.refreshToken, _that.expiresAt);
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
    required TResult Function(Map<String, List<String>> cookies) cookies,
    required TResult Function(String key) apiKey,
    required TResult Function(String username, String password) userPass,
    required TResult Function(
            String accessToken, String? refreshToken, int? expiresAt)
        oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCreds_Cookies():
        return cookies(_that.cookies);
      case AuthCreds_ApiKey():
        return apiKey(_that.key);
      case AuthCreds_UserPass():
        return userPass(_that.username, _that.password);
      case AuthCreds_OAuth():
        return oAuth(_that.accessToken, _that.refreshToken, _that.expiresAt);
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
    TResult? Function(Map<String, List<String>> cookies)? cookies,
    TResult? Function(String key)? apiKey,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String accessToken, String? refreshToken, int? expiresAt)?
        oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCreds_Cookies() when cookies != null:
        return cookies(_that.cookies);
      case AuthCreds_ApiKey() when apiKey != null:
        return apiKey(_that.key);
      case AuthCreds_UserPass() when userPass != null:
        return userPass(_that.username, _that.password);
      case AuthCreds_OAuth() when oAuth != null:
        return oAuth(_that.accessToken, _that.refreshToken, _that.expiresAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AuthCreds_Cookies extends AuthCreds {
  const AuthCreds_Cookies({required final Map<String, List<String>> cookies})
      : _cookies = cookies,
        super._();

  final Map<String, List<String>> _cookies;
  Map<String, List<String>> get cookies {
    if (_cookies is EqualUnmodifiableMapView) return _cookies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cookies);
  }

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthCreds_CookiesCopyWith<AuthCreds_Cookies> get copyWith =>
      _$AuthCreds_CookiesCopyWithImpl<AuthCreds_Cookies>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthCreds_Cookies &&
            const DeepCollectionEquality().equals(other._cookies, _cookies));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cookies));

  @override
  String toString() {
    return 'AuthCreds.cookies(cookies: $cookies)';
  }
}

/// @nodoc
abstract mixin class $AuthCreds_CookiesCopyWith<$Res>
    implements $AuthCredsCopyWith<$Res> {
  factory $AuthCreds_CookiesCopyWith(
          AuthCreds_Cookies value, $Res Function(AuthCreds_Cookies) _then) =
      _$AuthCreds_CookiesCopyWithImpl;
  @useResult
  $Res call({Map<String, List<String>> cookies});
}

/// @nodoc
class _$AuthCreds_CookiesCopyWithImpl<$Res>
    implements $AuthCreds_CookiesCopyWith<$Res> {
  _$AuthCreds_CookiesCopyWithImpl(this._self, this._then);

  final AuthCreds_Cookies _self;
  final $Res Function(AuthCreds_Cookies) _then;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cookies = null,
  }) {
    return _then(AuthCreds_Cookies(
      cookies: null == cookies
          ? _self._cookies
          : cookies // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class AuthCreds_ApiKey extends AuthCreds {
  const AuthCreds_ApiKey({required this.key}) : super._();

  final String key;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthCreds_ApiKeyCopyWith<AuthCreds_ApiKey> get copyWith =>
      _$AuthCreds_ApiKeyCopyWithImpl<AuthCreds_ApiKey>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthCreds_ApiKey &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'AuthCreds.apiKey(key: $key)';
  }
}

/// @nodoc
abstract mixin class $AuthCreds_ApiKeyCopyWith<$Res>
    implements $AuthCredsCopyWith<$Res> {
  factory $AuthCreds_ApiKeyCopyWith(
          AuthCreds_ApiKey value, $Res Function(AuthCreds_ApiKey) _then) =
      _$AuthCreds_ApiKeyCopyWithImpl;
  @useResult
  $Res call({String key});
}

/// @nodoc
class _$AuthCreds_ApiKeyCopyWithImpl<$Res>
    implements $AuthCreds_ApiKeyCopyWith<$Res> {
  _$AuthCreds_ApiKeyCopyWithImpl(this._self, this._then);

  final AuthCreds_ApiKey _self;
  final $Res Function(AuthCreds_ApiKey) _then;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(AuthCreds_ApiKey(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthCreds_UserPass extends AuthCreds {
  const AuthCreds_UserPass({required this.username, required this.password})
      : super._();

  final String username;
  final String password;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthCreds_UserPassCopyWith<AuthCreds_UserPass> get copyWith =>
      _$AuthCreds_UserPassCopyWithImpl<AuthCreds_UserPass>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthCreds_UserPass &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @override
  String toString() {
    return 'AuthCreds.userPass(username: $username, password: $password)';
  }
}

/// @nodoc
abstract mixin class $AuthCreds_UserPassCopyWith<$Res>
    implements $AuthCredsCopyWith<$Res> {
  factory $AuthCreds_UserPassCopyWith(
          AuthCreds_UserPass value, $Res Function(AuthCreds_UserPass) _then) =
      _$AuthCreds_UserPassCopyWithImpl;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$AuthCreds_UserPassCopyWithImpl<$Res>
    implements $AuthCreds_UserPassCopyWith<$Res> {
  _$AuthCreds_UserPassCopyWithImpl(this._self, this._then);

  final AuthCreds_UserPass _self;
  final $Res Function(AuthCreds_UserPass) _then;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(AuthCreds_UserPass(
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthCreds_OAuth extends AuthCreds {
  const AuthCreds_OAuth(
      {required this.accessToken, this.refreshToken, this.expiresAt})
      : super._();

  final String accessToken;
  final String? refreshToken;
  final int? expiresAt;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthCreds_OAuthCopyWith<AuthCreds_OAuth> get copyWith =>
      _$AuthCreds_OAuthCopyWithImpl<AuthCreds_OAuth>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthCreds_OAuth &&
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

  @override
  String toString() {
    return 'AuthCreds.oAuth(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt)';
  }
}

/// @nodoc
abstract mixin class $AuthCreds_OAuthCopyWith<$Res>
    implements $AuthCredsCopyWith<$Res> {
  factory $AuthCreds_OAuthCopyWith(
          AuthCreds_OAuth value, $Res Function(AuthCreds_OAuth) _then) =
      _$AuthCreds_OAuthCopyWithImpl;
  @useResult
  $Res call({String accessToken, String? refreshToken, int? expiresAt});
}

/// @nodoc
class _$AuthCreds_OAuthCopyWithImpl<$Res>
    implements $AuthCreds_OAuthCopyWith<$Res> {
  _$AuthCreds_OAuthCopyWithImpl(this._self, this._then);

  final AuthCreds_OAuth _self;
  final $Res Function(AuthCreds_OAuth) _then;

  /// Create a copy of AuthCreds
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(AuthCreds_OAuth(
      accessToken: null == accessToken
          ? _self.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _self.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$AuthData {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthData()';
  }
}

/// @nodoc
class $AuthDataCopyWith<$Res> {
  $AuthDataCopyWith(AuthData _, $Res Function(AuthData) __);
}

/// Adds pattern-matching-related methods to [AuthData].
extension AuthDataPatterns on AuthData {
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
    TResult Function(AuthData_Cookie value)? cookie,
    TResult Function(AuthData_ApiKey value)? apiKey,
    TResult Function(AuthData_UserPass value)? userPass,
    TResult Function(AuthData_OAuth value)? oAuth,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthData_Cookie() when cookie != null:
        return cookie(_that);
      case AuthData_ApiKey() when apiKey != null:
        return apiKey(_that);
      case AuthData_UserPass() when userPass != null:
        return userPass(_that);
      case AuthData_OAuth() when oAuth != null:
        return oAuth(_that);
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
    required TResult Function(AuthData_Cookie value) cookie,
    required TResult Function(AuthData_ApiKey value) apiKey,
    required TResult Function(AuthData_UserPass value) userPass,
    required TResult Function(AuthData_OAuth value) oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthData_Cookie():
        return cookie(_that);
      case AuthData_ApiKey():
        return apiKey(_that);
      case AuthData_UserPass():
        return userPass(_that);
      case AuthData_OAuth():
        return oAuth(_that);
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
    TResult? Function(AuthData_Cookie value)? cookie,
    TResult? Function(AuthData_ApiKey value)? apiKey,
    TResult? Function(AuthData_UserPass value)? userPass,
    TResult? Function(AuthData_OAuth value)? oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthData_Cookie() when cookie != null:
        return cookie(_that);
      case AuthData_ApiKey() when apiKey != null:
        return apiKey(_that);
      case AuthData_UserPass() when userPass != null:
        return userPass(_that);
      case AuthData_OAuth() when oAuth != null:
        return oAuth(_that);
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
    TResult Function(String loginpage, String logonpage)? cookie,
    TResult Function()? apiKey,
    TResult Function()? userPass,
    TResult Function(String authorizationUrl, String? tokenUrl, String clientId,
            String clientSecret, String? scope)?
        oAuth,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthData_Cookie() when cookie != null:
        return cookie(_that.loginpage, _that.logonpage);
      case AuthData_ApiKey() when apiKey != null:
        return apiKey();
      case AuthData_UserPass() when userPass != null:
        return userPass();
      case AuthData_OAuth() when oAuth != null:
        return oAuth(_that.authorizationUrl, _that.tokenUrl, _that.clientId,
            _that.clientSecret, _that.scope);
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
    required TResult Function(String loginpage, String logonpage) cookie,
    required TResult Function() apiKey,
    required TResult Function() userPass,
    required TResult Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)
        oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthData_Cookie():
        return cookie(_that.loginpage, _that.logonpage);
      case AuthData_ApiKey():
        return apiKey();
      case AuthData_UserPass():
        return userPass();
      case AuthData_OAuth():
        return oAuth(_that.authorizationUrl, _that.tokenUrl, _that.clientId,
            _that.clientSecret, _that.scope);
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
    TResult? Function(String loginpage, String logonpage)? cookie,
    TResult? Function()? apiKey,
    TResult? Function()? userPass,
    TResult? Function(String authorizationUrl, String? tokenUrl,
            String clientId, String clientSecret, String? scope)?
        oAuth,
  }) {
    final _that = this;
    switch (_that) {
      case AuthData_Cookie() when cookie != null:
        return cookie(_that.loginpage, _that.logonpage);
      case AuthData_ApiKey() when apiKey != null:
        return apiKey();
      case AuthData_UserPass() when userPass != null:
        return userPass();
      case AuthData_OAuth() when oAuth != null:
        return oAuth(_that.authorizationUrl, _that.tokenUrl, _that.clientId,
            _that.clientSecret, _that.scope);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AuthData_Cookie extends AuthData {
  const AuthData_Cookie({required this.loginpage, required this.logonpage})
      : super._();

  final String loginpage;
  final String logonpage;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthData_CookieCopyWith<AuthData_Cookie> get copyWith =>
      _$AuthData_CookieCopyWithImpl<AuthData_Cookie>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthData_Cookie &&
            (identical(other.loginpage, loginpage) ||
                other.loginpage == loginpage) &&
            (identical(other.logonpage, logonpage) ||
                other.logonpage == logonpage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loginpage, logonpage);

  @override
  String toString() {
    return 'AuthData.cookie(loginpage: $loginpage, logonpage: $logonpage)';
  }
}

/// @nodoc
abstract mixin class $AuthData_CookieCopyWith<$Res>
    implements $AuthDataCopyWith<$Res> {
  factory $AuthData_CookieCopyWith(
          AuthData_Cookie value, $Res Function(AuthData_Cookie) _then) =
      _$AuthData_CookieCopyWithImpl;
  @useResult
  $Res call({String loginpage, String logonpage});
}

/// @nodoc
class _$AuthData_CookieCopyWithImpl<$Res>
    implements $AuthData_CookieCopyWith<$Res> {
  _$AuthData_CookieCopyWithImpl(this._self, this._then);

  final AuthData_Cookie _self;
  final $Res Function(AuthData_Cookie) _then;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? loginpage = null,
    Object? logonpage = null,
  }) {
    return _then(AuthData_Cookie(
      loginpage: null == loginpage
          ? _self.loginpage
          : loginpage // ignore: cast_nullable_to_non_nullable
              as String,
      logonpage: null == logonpage
          ? _self.logonpage
          : logonpage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AuthData_ApiKey extends AuthData {
  const AuthData_ApiKey() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthData_ApiKey);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthData.apiKey()';
  }
}

/// @nodoc

class AuthData_UserPass extends AuthData {
  const AuthData_UserPass() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthData_UserPass);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthData.userPass()';
  }
}

/// @nodoc

class AuthData_OAuth extends AuthData {
  const AuthData_OAuth(
      {required this.authorizationUrl,
      this.tokenUrl,
      required this.clientId,
      required this.clientSecret,
      this.scope})
      : super._();

  final String authorizationUrl;
  final String? tokenUrl;
  final String clientId;
  final String clientSecret;
  final String? scope;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthData_OAuthCopyWith<AuthData_OAuth> get copyWith =>
      _$AuthData_OAuthCopyWithImpl<AuthData_OAuth>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthData_OAuth &&
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

  @override
  String toString() {
    return 'AuthData.oAuth(authorizationUrl: $authorizationUrl, tokenUrl: $tokenUrl, clientId: $clientId, clientSecret: $clientSecret, scope: $scope)';
  }
}

/// @nodoc
abstract mixin class $AuthData_OAuthCopyWith<$Res>
    implements $AuthDataCopyWith<$Res> {
  factory $AuthData_OAuthCopyWith(
          AuthData_OAuth value, $Res Function(AuthData_OAuth) _then) =
      _$AuthData_OAuthCopyWithImpl;
  @useResult
  $Res call(
      {String authorizationUrl,
      String? tokenUrl,
      String clientId,
      String clientSecret,
      String? scope});
}

/// @nodoc
class _$AuthData_OAuthCopyWithImpl<$Res>
    implements $AuthData_OAuthCopyWith<$Res> {
  _$AuthData_OAuthCopyWithImpl(this._self, this._then);

  final AuthData_OAuth _self;
  final $Res Function(AuthData_OAuth) _then;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? authorizationUrl = null,
    Object? tokenUrl = freezed,
    Object? clientId = null,
    Object? clientSecret = null,
    Object? scope = freezed,
  }) {
    return _then(AuthData_OAuth(
      authorizationUrl: null == authorizationUrl
          ? _self.authorizationUrl
          : authorizationUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tokenUrl: freezed == tokenUrl
          ? _self.tokenUrl
          : tokenUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _self.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      scope: freezed == scope
          ? _self.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
