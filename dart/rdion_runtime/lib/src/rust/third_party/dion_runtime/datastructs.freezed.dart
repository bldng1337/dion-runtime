// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'datastructs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Action _$ActionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'openBrowser':
      return Action_OpenBrowser.fromJson(json);
    case 'popup':
      return Action_Popup.fromJson(json);
    case 'nav':
      return Action_Nav.fromJson(json);
    case 'triggerEvent':
      return Action_TriggerEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Action',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Action {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function(String event, String data) triggerEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function(String event, String data)? triggerEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function(String event, String data)? triggerEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Action to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionCopyWith<$Res> {
  factory $ActionCopyWith(Action value, $Res Function(Action) then) =
      _$ActionCopyWithImpl<$Res, Action>;
}

/// @nodoc
class _$ActionCopyWithImpl<$Res, $Val extends Action>
    implements $ActionCopyWith<$Res> {
  _$ActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Action_OpenBrowserImplCopyWith<$Res> {
  factory _$$Action_OpenBrowserImplCopyWith(_$Action_OpenBrowserImpl value,
          $Res Function(_$Action_OpenBrowserImpl) then) =
      __$$Action_OpenBrowserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$Action_OpenBrowserImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_OpenBrowserImpl>
    implements _$$Action_OpenBrowserImplCopyWith<$Res> {
  __$$Action_OpenBrowserImplCopyWithImpl(_$Action_OpenBrowserImpl _value,
      $Res Function(_$Action_OpenBrowserImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$Action_OpenBrowserImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Action_OpenBrowserImpl extends Action_OpenBrowser {
  const _$Action_OpenBrowserImpl({required this.url, final String? $type})
      : $type = $type ?? 'openBrowser',
        super._();

  factory _$Action_OpenBrowserImpl.fromJson(Map<String, dynamic> json) =>
      _$$Action_OpenBrowserImplFromJson(json);

  @override
  final String url;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Action.openBrowser(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Action_OpenBrowserImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Action_OpenBrowserImplCopyWith<_$Action_OpenBrowserImpl> get copyWith =>
      __$$Action_OpenBrowserImplCopyWithImpl<_$Action_OpenBrowserImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function(String event, String data) triggerEvent,
  }) {
    return openBrowser(url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function(String event, String data)? triggerEvent,
  }) {
    return openBrowser?.call(url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function(String event, String data)? triggerEvent,
    required TResult orElse(),
  }) {
    if (openBrowser != null) {
      return openBrowser(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
  }) {
    return openBrowser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
  }) {
    return openBrowser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    required TResult orElse(),
  }) {
    if (openBrowser != null) {
      return openBrowser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Action_OpenBrowserImplToJson(
      this,
    );
  }
}

abstract class Action_OpenBrowser extends Action {
  const factory Action_OpenBrowser({required final String url}) =
      _$Action_OpenBrowserImpl;
  const Action_OpenBrowser._() : super._();

  factory Action_OpenBrowser.fromJson(Map<String, dynamic> json) =
      _$Action_OpenBrowserImpl.fromJson;

  String get url;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_OpenBrowserImplCopyWith<_$Action_OpenBrowserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Action_PopupImplCopyWith<$Res> {
  factory _$$Action_PopupImplCopyWith(
          _$Action_PopupImpl value, $Res Function(_$Action_PopupImpl) then) =
      __$$Action_PopupImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, CustomUI content, List<PopupAction> actions});

  $CustomUICopyWith<$Res> get content;
}

/// @nodoc
class __$$Action_PopupImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_PopupImpl>
    implements _$$Action_PopupImplCopyWith<$Res> {
  __$$Action_PopupImplCopyWithImpl(
      _$Action_PopupImpl _value, $Res Function(_$Action_PopupImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? actions = null,
  }) {
    return _then(_$Action_PopupImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<PopupAction>,
    ));
  }

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get content {
    return $CustomUICopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Action_PopupImpl extends Action_Popup {
  const _$Action_PopupImpl(
      {required this.title,
      required this.content,
      required final List<PopupAction> actions,
      final String? $type})
      : _actions = actions,
        $type = $type ?? 'popup',
        super._();

  factory _$Action_PopupImpl.fromJson(Map<String, dynamic> json) =>
      _$$Action_PopupImplFromJson(json);

  @override
  final String title;
  @override
  final CustomUI content;
  final List<PopupAction> _actions;
  @override
  List<PopupAction> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Action.popup(title: $title, content: $content, actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Action_PopupImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content,
      const DeepCollectionEquality().hash(_actions));

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Action_PopupImplCopyWith<_$Action_PopupImpl> get copyWith =>
      __$$Action_PopupImplCopyWithImpl<_$Action_PopupImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function(String event, String data) triggerEvent,
  }) {
    return popup(title, content, actions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function(String event, String data)? triggerEvent,
  }) {
    return popup?.call(title, content, actions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function(String event, String data)? triggerEvent,
    required TResult orElse(),
  }) {
    if (popup != null) {
      return popup(title, content, actions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
  }) {
    return popup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
  }) {
    return popup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    required TResult orElse(),
  }) {
    if (popup != null) {
      return popup(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Action_PopupImplToJson(
      this,
    );
  }
}

abstract class Action_Popup extends Action {
  const factory Action_Popup(
      {required final String title,
      required final CustomUI content,
      required final List<PopupAction> actions}) = _$Action_PopupImpl;
  const Action_Popup._() : super._();

  factory Action_Popup.fromJson(Map<String, dynamic> json) =
      _$Action_PopupImpl.fromJson;

  String get title;
  CustomUI get content;
  List<PopupAction> get actions;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_PopupImplCopyWith<_$Action_PopupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Action_NavImplCopyWith<$Res> {
  factory _$$Action_NavImplCopyWith(
          _$Action_NavImpl value, $Res Function(_$Action_NavImpl) then) =
      __$$Action_NavImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, CustomUI content});

  $CustomUICopyWith<$Res> get content;
}

/// @nodoc
class __$$Action_NavImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_NavImpl>
    implements _$$Action_NavImplCopyWith<$Res> {
  __$$Action_NavImplCopyWithImpl(
      _$Action_NavImpl _value, $Res Function(_$Action_NavImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
  }) {
    return _then(_$Action_NavImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get content {
    return $CustomUICopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Action_NavImpl extends Action_Nav {
  const _$Action_NavImpl(
      {required this.title, required this.content, final String? $type})
      : $type = $type ?? 'nav',
        super._();

  factory _$Action_NavImpl.fromJson(Map<String, dynamic> json) =>
      _$$Action_NavImplFromJson(json);

  @override
  final String title;
  @override
  final CustomUI content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Action.nav(title: $title, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Action_NavImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, content);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Action_NavImplCopyWith<_$Action_NavImpl> get copyWith =>
      __$$Action_NavImplCopyWithImpl<_$Action_NavImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function(String event, String data) triggerEvent,
  }) {
    return nav(title, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function(String event, String data)? triggerEvent,
  }) {
    return nav?.call(title, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function(String event, String data)? triggerEvent,
    required TResult orElse(),
  }) {
    if (nav != null) {
      return nav(title, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
  }) {
    return nav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
  }) {
    return nav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    required TResult orElse(),
  }) {
    if (nav != null) {
      return nav(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Action_NavImplToJson(
      this,
    );
  }
}

abstract class Action_Nav extends Action {
  const factory Action_Nav(
      {required final String title,
      required final CustomUI content}) = _$Action_NavImpl;
  const Action_Nav._() : super._();

  factory Action_Nav.fromJson(Map<String, dynamic> json) =
      _$Action_NavImpl.fromJson;

  String get title;
  CustomUI get content;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_NavImplCopyWith<_$Action_NavImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Action_TriggerEventImplCopyWith<$Res> {
  factory _$$Action_TriggerEventImplCopyWith(_$Action_TriggerEventImpl value,
          $Res Function(_$Action_TriggerEventImpl) then) =
      __$$Action_TriggerEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String event, String data});
}

/// @nodoc
class __$$Action_TriggerEventImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_TriggerEventImpl>
    implements _$$Action_TriggerEventImplCopyWith<$Res> {
  __$$Action_TriggerEventImplCopyWithImpl(_$Action_TriggerEventImpl _value,
      $Res Function(_$Action_TriggerEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_$Action_TriggerEventImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Action_TriggerEventImpl extends Action_TriggerEvent {
  const _$Action_TriggerEventImpl(
      {required this.event, required this.data, final String? $type})
      : $type = $type ?? 'triggerEvent',
        super._();

  factory _$Action_TriggerEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$Action_TriggerEventImplFromJson(json);

  @override
  final String event;
  @override
  final String data;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Action.triggerEvent(event: $event, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Action_TriggerEventImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, event, data);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Action_TriggerEventImplCopyWith<_$Action_TriggerEventImpl> get copyWith =>
      __$$Action_TriggerEventImplCopyWithImpl<_$Action_TriggerEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function(String event, String data) triggerEvent,
  }) {
    return triggerEvent(event, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function(String event, String data)? triggerEvent,
  }) {
    return triggerEvent?.call(event, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function(String event, String data)? triggerEvent,
    required TResult orElse(),
  }) {
    if (triggerEvent != null) {
      return triggerEvent(event, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
  }) {
    return triggerEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
  }) {
    return triggerEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    required TResult orElse(),
  }) {
    if (triggerEvent != null) {
      return triggerEvent(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Action_TriggerEventImplToJson(
      this,
    );
  }
}

abstract class Action_TriggerEvent extends Action {
  const factory Action_TriggerEvent(
      {required final String event,
      required final String data}) = _$Action_TriggerEventImpl;
  const Action_TriggerEvent._() : super._();

  factory Action_TriggerEvent.fromJson(Map<String, dynamic> json) =
      _$Action_TriggerEventImpl.fromJson;

  String get event;
  String get data;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_TriggerEventImplCopyWith<_$Action_TriggerEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomUI _$CustomUIFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'text':
      return CustomUI_Text.fromJson(json);
    case 'image':
      return CustomUI_Image.fromJson(json);
    case 'link':
      return CustomUI_Link.fromJson(json);
    case 'timeStamp':
      return CustomUI_TimeStamp.fromJson(json);
    case 'entryCard':
      return CustomUI_EntryCard.fromJson(json);
    case 'button':
      return CustomUI_Button.fromJson(json);
    case 'inlineSetting':
      return CustomUI_InlineSetting.fromJson(json);
    case 'slot':
      return CustomUI_Slot.fromJson(json);
    case 'column':
      return CustomUI_Column.fromJson(json);
    case 'row':
      return CustomUI_Row.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CustomUI',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CustomUI {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this CustomUI to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomUICopyWith<$Res> {
  factory $CustomUICopyWith(CustomUI value, $Res Function(CustomUI) then) =
      _$CustomUICopyWithImpl<$Res, CustomUI>;
}

/// @nodoc
class _$CustomUICopyWithImpl<$Res, $Val extends CustomUI>
    implements $CustomUICopyWith<$Res> {
  _$CustomUICopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CustomUI_TextImplCopyWith<$Res> {
  factory _$$CustomUI_TextImplCopyWith(
          _$CustomUI_TextImpl value, $Res Function(_$CustomUI_TextImpl) then) =
      __$$CustomUI_TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$CustomUI_TextImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_TextImpl>
    implements _$$CustomUI_TextImplCopyWith<$Res> {
  __$$CustomUI_TextImplCopyWithImpl(
      _$CustomUI_TextImpl _value, $Res Function(_$CustomUI_TextImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$CustomUI_TextImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_TextImpl extends CustomUI_Text {
  const _$CustomUI_TextImpl({required this.text, final String? $type})
      : $type = $type ?? 'text',
        super._();

  factory _$CustomUI_TextImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_TextImplFromJson(json);

  @override
  final String text;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.text(text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_TextImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_TextImplCopyWith<_$CustomUI_TextImpl> get copyWith =>
      __$$CustomUI_TextImplCopyWithImpl<_$CustomUI_TextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return text(this.text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return text?.call(this.text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this.text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_TextImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Text extends CustomUI {
  const factory CustomUI_Text({required final String text}) =
      _$CustomUI_TextImpl;
  const CustomUI_Text._() : super._();

  factory CustomUI_Text.fromJson(Map<String, dynamic> json) =
      _$CustomUI_TextImpl.fromJson;

  String get text;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_TextImplCopyWith<_$CustomUI_TextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_ImageImplCopyWith<$Res> {
  factory _$$CustomUI_ImageImplCopyWith(_$CustomUI_ImageImpl value,
          $Res Function(_$CustomUI_ImageImpl) then) =
      __$$CustomUI_ImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Link image, int? width, int? height});

  $LinkCopyWith<$Res> get image;
}

/// @nodoc
class __$$CustomUI_ImageImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_ImageImpl>
    implements _$$CustomUI_ImageImplCopyWith<$Res> {
  __$$CustomUI_ImageImplCopyWithImpl(
      _$CustomUI_ImageImpl _value, $Res Function(_$CustomUI_ImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$CustomUI_ImageImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Link,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get image {
    return $LinkCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_ImageImpl extends CustomUI_Image {
  const _$CustomUI_ImageImpl(
      {required this.image, this.width, this.height, final String? $type})
      : $type = $type ?? 'image',
        super._();

  factory _$CustomUI_ImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_ImageImplFromJson(json);

  @override
  final Link image;
  @override
  final int? width;
  @override
  final int? height;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.image(image: $image, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ImageImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, image, width, height);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_ImageImplCopyWith<_$CustomUI_ImageImpl> get copyWith =>
      __$$CustomUI_ImageImplCopyWithImpl<_$CustomUI_ImageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return image(this.image, width, height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return image?.call(this.image, width, height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this.image, width, height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_ImageImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Image extends CustomUI {
  const factory CustomUI_Image(
      {required final Link image,
      final int? width,
      final int? height}) = _$CustomUI_ImageImpl;
  const CustomUI_Image._() : super._();

  factory CustomUI_Image.fromJson(Map<String, dynamic> json) =
      _$CustomUI_ImageImpl.fromJson;

  Link get image;
  int? get width;
  int? get height;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_ImageImplCopyWith<_$CustomUI_ImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_LinkImplCopyWith<$Res> {
  factory _$$CustomUI_LinkImplCopyWith(
          _$CustomUI_LinkImpl value, $Res Function(_$CustomUI_LinkImpl) then) =
      __$$CustomUI_LinkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link, String? label});
}

/// @nodoc
class __$$CustomUI_LinkImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_LinkImpl>
    implements _$$CustomUI_LinkImplCopyWith<$Res> {
  __$$CustomUI_LinkImplCopyWithImpl(
      _$CustomUI_LinkImpl _value, $Res Function(_$CustomUI_LinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? label = freezed,
  }) {
    return _then(_$CustomUI_LinkImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_LinkImpl extends CustomUI_Link {
  const _$CustomUI_LinkImpl(
      {required this.link, this.label, final String? $type})
      : $type = $type ?? 'link',
        super._();

  factory _$CustomUI_LinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_LinkImplFromJson(json);

  @override
  final String link;
  @override
  final String? label;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.link(link: $link, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_LinkImpl &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, link, label);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_LinkImplCopyWith<_$CustomUI_LinkImpl> get copyWith =>
      __$$CustomUI_LinkImplCopyWithImpl<_$CustomUI_LinkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return link(this.link, label);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return link?.call(this.link, label);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (link != null) {
      return link(this.link, label);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return link(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return link?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (link != null) {
      return link(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_LinkImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Link extends CustomUI {
  const factory CustomUI_Link(
      {required final String link, final String? label}) = _$CustomUI_LinkImpl;
  const CustomUI_Link._() : super._();

  factory CustomUI_Link.fromJson(Map<String, dynamic> json) =
      _$CustomUI_LinkImpl.fromJson;

  String get link;
  String? get label;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_LinkImplCopyWith<_$CustomUI_LinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_TimeStampImplCopyWith<$Res> {
  factory _$$CustomUI_TimeStampImplCopyWith(_$CustomUI_TimeStampImpl value,
          $Res Function(_$CustomUI_TimeStampImpl) then) =
      __$$CustomUI_TimeStampImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String timestamp, TimestampType display});
}

/// @nodoc
class __$$CustomUI_TimeStampImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_TimeStampImpl>
    implements _$$CustomUI_TimeStampImplCopyWith<$Res> {
  __$$CustomUI_TimeStampImplCopyWithImpl(_$CustomUI_TimeStampImpl _value,
      $Res Function(_$CustomUI_TimeStampImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? display = null,
  }) {
    return _then(_$CustomUI_TimeStampImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as TimestampType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_TimeStampImpl extends CustomUI_TimeStamp {
  const _$CustomUI_TimeStampImpl(
      {required this.timestamp, required this.display, final String? $type})
      : $type = $type ?? 'timeStamp',
        super._();

  factory _$CustomUI_TimeStampImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_TimeStampImplFromJson(json);

  @override
  final String timestamp;
  @override
  final TimestampType display;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.timeStamp(timestamp: $timestamp, display: $display)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_TimeStampImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.display, display) || other.display == display));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, display);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_TimeStampImplCopyWith<_$CustomUI_TimeStampImpl> get copyWith =>
      __$$CustomUI_TimeStampImplCopyWithImpl<_$CustomUI_TimeStampImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return timeStamp(timestamp, display);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return timeStamp?.call(timestamp, display);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (timeStamp != null) {
      return timeStamp(timestamp, display);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return timeStamp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return timeStamp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (timeStamp != null) {
      return timeStamp(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_TimeStampImplToJson(
      this,
    );
  }
}

abstract class CustomUI_TimeStamp extends CustomUI {
  const factory CustomUI_TimeStamp(
      {required final String timestamp,
      required final TimestampType display}) = _$CustomUI_TimeStampImpl;
  const CustomUI_TimeStamp._() : super._();

  factory CustomUI_TimeStamp.fromJson(Map<String, dynamic> json) =
      _$CustomUI_TimeStampImpl.fromJson;

  String get timestamp;
  TimestampType get display;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_TimeStampImplCopyWith<_$CustomUI_TimeStampImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_EntryCardImplCopyWith<$Res> {
  factory _$$CustomUI_EntryCardImplCopyWith(_$CustomUI_EntryCardImpl value,
          $Res Function(_$CustomUI_EntryCardImpl) then) =
      __$$CustomUI_EntryCardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Entry entry});

  $EntryCopyWith<$Res> get entry;
}

/// @nodoc
class __$$CustomUI_EntryCardImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_EntryCardImpl>
    implements _$$CustomUI_EntryCardImplCopyWith<$Res> {
  __$$CustomUI_EntryCardImplCopyWithImpl(_$CustomUI_EntryCardImpl _value,
      $Res Function(_$CustomUI_EntryCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
  }) {
    return _then(_$CustomUI_EntryCardImpl(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as Entry,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EntryCopyWith<$Res> get entry {
    return $EntryCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_EntryCardImpl extends CustomUI_EntryCard {
  const _$CustomUI_EntryCardImpl({required this.entry, final String? $type})
      : $type = $type ?? 'entryCard',
        super._();

  factory _$CustomUI_EntryCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_EntryCardImplFromJson(json);

  @override
  final Entry entry;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.entryCard(entry: $entry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_EntryCardImpl &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, entry);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_EntryCardImplCopyWith<_$CustomUI_EntryCardImpl> get copyWith =>
      __$$CustomUI_EntryCardImplCopyWithImpl<_$CustomUI_EntryCardImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return entryCard(entry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return entryCard?.call(entry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (entryCard != null) {
      return entryCard(entry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return entryCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return entryCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (entryCard != null) {
      return entryCard(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_EntryCardImplToJson(
      this,
    );
  }
}

abstract class CustomUI_EntryCard extends CustomUI {
  const factory CustomUI_EntryCard({required final Entry entry}) =
      _$CustomUI_EntryCardImpl;
  const CustomUI_EntryCard._() : super._();

  factory CustomUI_EntryCard.fromJson(Map<String, dynamic> json) =
      _$CustomUI_EntryCardImpl.fromJson;

  Entry get entry;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_EntryCardImplCopyWith<_$CustomUI_EntryCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_ButtonImplCopyWith<$Res> {
  factory _$$CustomUI_ButtonImplCopyWith(_$CustomUI_ButtonImpl value,
          $Res Function(_$CustomUI_ButtonImpl) then) =
      __$$CustomUI_ButtonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String label, UIAction? onClick});

  $UIActionCopyWith<$Res>? get onClick;
}

/// @nodoc
class __$$CustomUI_ButtonImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_ButtonImpl>
    implements _$$CustomUI_ButtonImplCopyWith<$Res> {
  __$$CustomUI_ButtonImplCopyWithImpl(
      _$CustomUI_ButtonImpl _value, $Res Function(_$CustomUI_ButtonImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? onClick = freezed,
  }) {
    return _then(_$CustomUI_ButtonImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onClick: freezed == onClick
          ? _value.onClick
          : onClick // ignore: cast_nullable_to_non_nullable
              as UIAction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UIActionCopyWith<$Res>? get onClick {
    if (_value.onClick == null) {
      return null;
    }

    return $UIActionCopyWith<$Res>(_value.onClick!, (value) {
      return _then(_value.copyWith(onClick: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_ButtonImpl extends CustomUI_Button {
  const _$CustomUI_ButtonImpl(
      {required this.label, this.onClick, final String? $type})
      : $type = $type ?? 'button',
        super._();

  factory _$CustomUI_ButtonImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_ButtonImplFromJson(json);

  @override
  final String label;
  @override
  final UIAction? onClick;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.button(label: $label, onClick: $onClick)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ButtonImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onClick, onClick) || other.onClick == onClick));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, onClick);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_ButtonImplCopyWith<_$CustomUI_ButtonImpl> get copyWith =>
      __$$CustomUI_ButtonImplCopyWithImpl<_$CustomUI_ButtonImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return button(label, onClick);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return button?.call(label, onClick);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (button != null) {
      return button(label, onClick);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return button(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return button?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (button != null) {
      return button(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_ButtonImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Button extends CustomUI {
  const factory CustomUI_Button(
      {required final String label,
      final UIAction? onClick}) = _$CustomUI_ButtonImpl;
  const CustomUI_Button._() : super._();

  factory CustomUI_Button.fromJson(Map<String, dynamic> json) =
      _$CustomUI_ButtonImpl.fromJson;

  String get label;
  UIAction? get onClick;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_ButtonImplCopyWith<_$CustomUI_ButtonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_InlineSettingImplCopyWith<$Res> {
  factory _$$CustomUI_InlineSettingImplCopyWith(
          _$CustomUI_InlineSettingImpl value,
          $Res Function(_$CustomUI_InlineSettingImpl) then) =
      __$$CustomUI_InlineSettingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String settingId, UIAction? onCommit});

  $UIActionCopyWith<$Res>? get onCommit;
}

/// @nodoc
class __$$CustomUI_InlineSettingImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_InlineSettingImpl>
    implements _$$CustomUI_InlineSettingImplCopyWith<$Res> {
  __$$CustomUI_InlineSettingImplCopyWithImpl(
      _$CustomUI_InlineSettingImpl _value,
      $Res Function(_$CustomUI_InlineSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settingId = null,
    Object? onCommit = freezed,
  }) {
    return _then(_$CustomUI_InlineSettingImpl(
      settingId: null == settingId
          ? _value.settingId
          : settingId // ignore: cast_nullable_to_non_nullable
              as String,
      onCommit: freezed == onCommit
          ? _value.onCommit
          : onCommit // ignore: cast_nullable_to_non_nullable
              as UIAction?,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UIActionCopyWith<$Res>? get onCommit {
    if (_value.onCommit == null) {
      return null;
    }

    return $UIActionCopyWith<$Res>(_value.onCommit!, (value) {
      return _then(_value.copyWith(onCommit: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_InlineSettingImpl extends CustomUI_InlineSetting {
  const _$CustomUI_InlineSettingImpl(
      {required this.settingId, this.onCommit, final String? $type})
      : $type = $type ?? 'inlineSetting',
        super._();

  factory _$CustomUI_InlineSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_InlineSettingImplFromJson(json);

  @override
  final String settingId;
  @override
  final UIAction? onCommit;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.inlineSetting(settingId: $settingId, onCommit: $onCommit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_InlineSettingImpl &&
            (identical(other.settingId, settingId) ||
                other.settingId == settingId) &&
            (identical(other.onCommit, onCommit) ||
                other.onCommit == onCommit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settingId, onCommit);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_InlineSettingImplCopyWith<_$CustomUI_InlineSettingImpl>
      get copyWith => __$$CustomUI_InlineSettingImplCopyWithImpl<
          _$CustomUI_InlineSettingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return inlineSetting(settingId, onCommit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return inlineSetting?.call(settingId, onCommit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (inlineSetting != null) {
      return inlineSetting(settingId, onCommit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return inlineSetting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return inlineSetting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (inlineSetting != null) {
      return inlineSetting(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_InlineSettingImplToJson(
      this,
    );
  }
}

abstract class CustomUI_InlineSetting extends CustomUI {
  const factory CustomUI_InlineSetting(
      {required final String settingId,
      final UIAction? onCommit}) = _$CustomUI_InlineSettingImpl;
  const CustomUI_InlineSetting._() : super._();

  factory CustomUI_InlineSetting.fromJson(Map<String, dynamic> json) =
      _$CustomUI_InlineSettingImpl.fromJson;

  String get settingId;
  UIAction? get onCommit;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_InlineSettingImplCopyWith<_$CustomUI_InlineSettingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_SlotImplCopyWith<$Res> {
  factory _$$CustomUI_SlotImplCopyWith(
          _$CustomUI_SlotImpl value, $Res Function(_$CustomUI_SlotImpl) then) =
      __$$CustomUI_SlotImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, CustomUI child});

  $CustomUICopyWith<$Res> get child;
}

/// @nodoc
class __$$CustomUI_SlotImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_SlotImpl>
    implements _$$CustomUI_SlotImplCopyWith<$Res> {
  __$$CustomUI_SlotImplCopyWithImpl(
      _$CustomUI_SlotImpl _value, $Res Function(_$CustomUI_SlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? child = null,
  }) {
    return _then(_$CustomUI_SlotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      child: null == child
          ? _value.child
          : child // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get child {
    return $CustomUICopyWith<$Res>(_value.child, (value) {
      return _then(_value.copyWith(child: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_SlotImpl extends CustomUI_Slot {
  const _$CustomUI_SlotImpl(
      {required this.id, required this.child, final String? $type})
      : $type = $type ?? 'slot',
        super._();

  factory _$CustomUI_SlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_SlotImplFromJson(json);

  @override
  final String id;
  @override
  final CustomUI child;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.slot(id: $id, child: $child)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_SlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.child, child) || other.child == child));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, child);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_SlotImplCopyWith<_$CustomUI_SlotImpl> get copyWith =>
      __$$CustomUI_SlotImplCopyWithImpl<_$CustomUI_SlotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return slot(id, child);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return slot?.call(id, child);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (slot != null) {
      return slot(id, child);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return slot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return slot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (slot != null) {
      return slot(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_SlotImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Slot extends CustomUI {
  const factory CustomUI_Slot(
      {required final String id,
      required final CustomUI child}) = _$CustomUI_SlotImpl;
  const CustomUI_Slot._() : super._();

  factory CustomUI_Slot.fromJson(Map<String, dynamic> json) =
      _$CustomUI_SlotImpl.fromJson;

  String get id;
  CustomUI get child;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_SlotImplCopyWith<_$CustomUI_SlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_ColumnImplCopyWith<$Res> {
  factory _$$CustomUI_ColumnImplCopyWith(_$CustomUI_ColumnImpl value,
          $Res Function(_$CustomUI_ColumnImpl) then) =
      __$$CustomUI_ColumnImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomUI> children});
}

/// @nodoc
class __$$CustomUI_ColumnImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_ColumnImpl>
    implements _$$CustomUI_ColumnImplCopyWith<$Res> {
  __$$CustomUI_ColumnImplCopyWithImpl(
      _$CustomUI_ColumnImpl _value, $Res Function(_$CustomUI_ColumnImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? children = null,
  }) {
    return _then(_$CustomUI_ColumnImpl(
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_ColumnImpl extends CustomUI_Column {
  const _$CustomUI_ColumnImpl(
      {required final List<CustomUI> children, final String? $type})
      : _children = children,
        $type = $type ?? 'column',
        super._();

  factory _$CustomUI_ColumnImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_ColumnImplFromJson(json);

  final List<CustomUI> _children;
  @override
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.column(children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_ColumnImpl &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_ColumnImplCopyWith<_$CustomUI_ColumnImpl> get copyWith =>
      __$$CustomUI_ColumnImplCopyWithImpl<_$CustomUI_ColumnImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return column(children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return column?.call(children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (column != null) {
      return column(children);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return column(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return column?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (column != null) {
      return column(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_ColumnImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Column extends CustomUI {
  const factory CustomUI_Column({required final List<CustomUI> children}) =
      _$CustomUI_ColumnImpl;
  const CustomUI_Column._() : super._();

  factory CustomUI_Column.fromJson(Map<String, dynamic> json) =
      _$CustomUI_ColumnImpl.fromJson;

  List<CustomUI> get children;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_ColumnImplCopyWith<_$CustomUI_ColumnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomUI_RowImplCopyWith<$Res> {
  factory _$$CustomUI_RowImplCopyWith(
          _$CustomUI_RowImpl value, $Res Function(_$CustomUI_RowImpl) then) =
      __$$CustomUI_RowImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomUI> children});
}

/// @nodoc
class __$$CustomUI_RowImplCopyWithImpl<$Res>
    extends _$CustomUICopyWithImpl<$Res, _$CustomUI_RowImpl>
    implements _$$CustomUI_RowImplCopyWith<$Res> {
  __$$CustomUI_RowImplCopyWithImpl(
      _$CustomUI_RowImpl _value, $Res Function(_$CustomUI_RowImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? children = null,
  }) {
    return _then(_$CustomUI_RowImpl(
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUI_RowImpl extends CustomUI_Row {
  const _$CustomUI_RowImpl(
      {required final List<CustomUI> children, final String? $type})
      : _children = children,
        $type = $type ?? 'row',
        super._();

  factory _$CustomUI_RowImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUI_RowImplFromJson(json);

  final List<CustomUI> _children;
  @override
  List<CustomUI> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CustomUI.row(children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUI_RowImpl &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_children));

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUI_RowImplCopyWith<_$CustomUI_RowImpl> get copyWith =>
      __$$CustomUI_RowImplCopyWithImpl<_$CustomUI_RowImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text) text,
    required TResult Function(Link image, int? width, int? height) image,
    required TResult Function(String link, String? label) link,
    required TResult Function(String timestamp, TimestampType display)
        timeStamp,
    required TResult Function(Entry entry) entryCard,
    required TResult Function(String label, UIAction? onClick) button,
    required TResult Function(String settingId, UIAction? onCommit)
        inlineSetting,
    required TResult Function(String id, CustomUI child) slot,
    required TResult Function(List<CustomUI> children) column,
    required TResult Function(List<CustomUI> children) row,
  }) {
    return row(children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text)? text,
    TResult? Function(Link image, int? width, int? height)? image,
    TResult? Function(String link, String? label)? link,
    TResult? Function(String timestamp, TimestampType display)? timeStamp,
    TResult? Function(Entry entry)? entryCard,
    TResult? Function(String label, UIAction? onClick)? button,
    TResult? Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult? Function(String id, CustomUI child)? slot,
    TResult? Function(List<CustomUI> children)? column,
    TResult? Function(List<CustomUI> children)? row,
  }) {
    return row?.call(children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text)? text,
    TResult Function(Link image, int? width, int? height)? image,
    TResult Function(String link, String? label)? link,
    TResult Function(String timestamp, TimestampType display)? timeStamp,
    TResult Function(Entry entry)? entryCard,
    TResult Function(String label, UIAction? onClick)? button,
    TResult Function(String settingId, UIAction? onCommit)? inlineSetting,
    TResult Function(String id, CustomUI child)? slot,
    TResult Function(List<CustomUI> children)? column,
    TResult Function(List<CustomUI> children)? row,
    required TResult orElse(),
  }) {
    if (row != null) {
      return row(children);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomUI_Text value) text,
    required TResult Function(CustomUI_Image value) image,
    required TResult Function(CustomUI_Link value) link,
    required TResult Function(CustomUI_TimeStamp value) timeStamp,
    required TResult Function(CustomUI_EntryCard value) entryCard,
    required TResult Function(CustomUI_Button value) button,
    required TResult Function(CustomUI_InlineSetting value) inlineSetting,
    required TResult Function(CustomUI_Slot value) slot,
    required TResult Function(CustomUI_Column value) column,
    required TResult Function(CustomUI_Row value) row,
  }) {
    return row(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomUI_Text value)? text,
    TResult? Function(CustomUI_Image value)? image,
    TResult? Function(CustomUI_Link value)? link,
    TResult? Function(CustomUI_TimeStamp value)? timeStamp,
    TResult? Function(CustomUI_EntryCard value)? entryCard,
    TResult? Function(CustomUI_Button value)? button,
    TResult? Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult? Function(CustomUI_Slot value)? slot,
    TResult? Function(CustomUI_Column value)? column,
    TResult? Function(CustomUI_Row value)? row,
  }) {
    return row?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomUI_Text value)? text,
    TResult Function(CustomUI_Image value)? image,
    TResult Function(CustomUI_Link value)? link,
    TResult Function(CustomUI_TimeStamp value)? timeStamp,
    TResult Function(CustomUI_EntryCard value)? entryCard,
    TResult Function(CustomUI_Button value)? button,
    TResult Function(CustomUI_InlineSetting value)? inlineSetting,
    TResult Function(CustomUI_Slot value)? slot,
    TResult Function(CustomUI_Column value)? column,
    TResult Function(CustomUI_Row value)? row,
    required TResult orElse(),
  }) {
    if (row != null) {
      return row(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUI_RowImplToJson(
      this,
    );
  }
}

abstract class CustomUI_Row extends CustomUI {
  const factory CustomUI_Row({required final List<CustomUI> children}) =
      _$CustomUI_RowImpl;
  const CustomUI_Row._() : super._();

  factory CustomUI_Row.fromJson(Map<String, dynamic> json) =
      _$CustomUI_RowImpl.fromJson;

  List<CustomUI> get children;

  /// Create a copy of CustomUI
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUI_RowImplCopyWith<_$CustomUI_RowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

/// @nodoc
mixin _$Entry {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  Link? get cover => throw _privateConstructorUsedError;
  List<String>? get author => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  double? get views => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;

  /// Serializes this Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res, Entry>;
  @useResult
  $Res call(
      {String id,
      String url,
      String title,
      MediaType mediaType,
      Link? cover,
      List<String>? author,
      double? rating,
      double? views,
      int? length});

  $LinkCopyWith<$Res>? get cover;
}

/// @nodoc
class _$EntryCopyWithImpl<$Res, $Val extends Entry>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? mediaType = null,
    Object? cover = freezed,
    Object? author = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Link?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res>? get cover {
    if (_value.cover == null) {
      return null;
    }

    return $LinkCopyWith<$Res>(_value.cover!, (value) {
      return _then(_value.copyWith(cover: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryImplCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$$EntryImplCopyWith(
          _$EntryImpl value, $Res Function(_$EntryImpl) then) =
      __$$EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String title,
      MediaType mediaType,
      Link? cover,
      List<String>? author,
      double? rating,
      double? views,
      int? length});

  @override
  $LinkCopyWith<$Res>? get cover;
}

/// @nodoc
class __$$EntryImplCopyWithImpl<$Res>
    extends _$EntryCopyWithImpl<$Res, _$EntryImpl>
    implements _$$EntryImplCopyWith<$Res> {
  __$$EntryImplCopyWithImpl(
      _$EntryImpl _value, $Res Function(_$EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? mediaType = null,
    Object? cover = freezed,
    Object? author = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
  }) {
    return _then(_$EntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Link?,
      author: freezed == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryImpl extends _Entry {
  const _$EntryImpl(
      {required this.id,
      required this.url,
      required this.title,
      required this.mediaType,
      this.cover,
      final List<String>? author,
      this.rating,
      this.views,
      this.length})
      : _author = author,
        super._();

  factory _$EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String title;
  @override
  final MediaType mediaType;
  @override
  final Link? cover;
  final List<String>? _author;
  @override
  List<String>? get author {
    final value = _author;
    if (value == null) return null;
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? rating;
  @override
  final double? views;
  @override
  final int? length;

  @override
  String toString() {
    return 'Entry(id: $id, url: $url, title: $title, mediaType: $mediaType, cover: $cover, author: $author, rating: $rating, views: $views, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, title, mediaType, cover,
      const DeepCollectionEquality().hash(_author), rating, views, length);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      __$$EntryImplCopyWithImpl<_$EntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryImplToJson(
      this,
    );
  }
}

abstract class _Entry extends Entry {
  const factory _Entry(
      {required final String id,
      required final String url,
      required final String title,
      required final MediaType mediaType,
      final Link? cover,
      final List<String>? author,
      final double? rating,
      final double? views,
      final int? length}) = _$EntryImpl;
  const _Entry._() : super._();

  factory _Entry.fromJson(Map<String, dynamic> json) = _$EntryImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get title;
  @override
  MediaType get mediaType;
  @override
  Link? get cover;
  @override
  List<String>? get author;
  @override
  double? get rating;
  @override
  double? get views;
  @override
  int? get length;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntryActivity _$EntryActivityFromJson(Map<String, dynamic> json) {
  return EntryActivity_EpisodeActivity.fromJson(json);
}

/// @nodoc
mixin _$EntryActivity {
  int get progress => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int progress) episodeActivity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int progress)? episodeActivity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int progress)? episodeActivity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EntryActivity_EpisodeActivity value)
        episodeActivity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EntryActivity_EpisodeActivity value)? episodeActivity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EntryActivity_EpisodeActivity value)? episodeActivity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this EntryActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryActivityCopyWith<EntryActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryActivityCopyWith<$Res> {
  factory $EntryActivityCopyWith(
          EntryActivity value, $Res Function(EntryActivity) then) =
      _$EntryActivityCopyWithImpl<$Res, EntryActivity>;
  @useResult
  $Res call({int progress});
}

/// @nodoc
class _$EntryActivityCopyWithImpl<$Res, $Val extends EntryActivity>
    implements $EntryActivityCopyWith<$Res> {
  _$EntryActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntryActivity_EpisodeActivityImplCopyWith<$Res>
    implements $EntryActivityCopyWith<$Res> {
  factory _$$EntryActivity_EpisodeActivityImplCopyWith(
          _$EntryActivity_EpisodeActivityImpl value,
          $Res Function(_$EntryActivity_EpisodeActivityImpl) then) =
      __$$EntryActivity_EpisodeActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int progress});
}

/// @nodoc
class __$$EntryActivity_EpisodeActivityImplCopyWithImpl<$Res>
    extends _$EntryActivityCopyWithImpl<$Res,
        _$EntryActivity_EpisodeActivityImpl>
    implements _$$EntryActivity_EpisodeActivityImplCopyWith<$Res> {
  __$$EntryActivity_EpisodeActivityImplCopyWithImpl(
      _$EntryActivity_EpisodeActivityImpl _value,
      $Res Function(_$EntryActivity_EpisodeActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
  }) {
    return _then(_$EntryActivity_EpisodeActivityImpl(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryActivity_EpisodeActivityImpl
    extends EntryActivity_EpisodeActivity {
  const _$EntryActivity_EpisodeActivityImpl({required this.progress})
      : super._();

  factory _$EntryActivity_EpisodeActivityImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EntryActivity_EpisodeActivityImplFromJson(json);

  @override
  final int progress;

  @override
  String toString() {
    return 'EntryActivity.episodeActivity(progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryActivity_EpisodeActivityImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, progress);

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryActivity_EpisodeActivityImplCopyWith<
          _$EntryActivity_EpisodeActivityImpl>
      get copyWith => __$$EntryActivity_EpisodeActivityImplCopyWithImpl<
          _$EntryActivity_EpisodeActivityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int progress) episodeActivity,
  }) {
    return episodeActivity(progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int progress)? episodeActivity,
  }) {
    return episodeActivity?.call(progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int progress)? episodeActivity,
    required TResult orElse(),
  }) {
    if (episodeActivity != null) {
      return episodeActivity(progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EntryActivity_EpisodeActivity value)
        episodeActivity,
  }) {
    return episodeActivity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EntryActivity_EpisodeActivity value)? episodeActivity,
  }) {
    return episodeActivity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EntryActivity_EpisodeActivity value)? episodeActivity,
    required TResult orElse(),
  }) {
    if (episodeActivity != null) {
      return episodeActivity(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryActivity_EpisodeActivityImplToJson(
      this,
    );
  }
}

abstract class EntryActivity_EpisodeActivity extends EntryActivity {
  const factory EntryActivity_EpisodeActivity({required final int progress}) =
      _$EntryActivity_EpisodeActivityImpl;
  const EntryActivity_EpisodeActivity._() : super._();

  factory EntryActivity_EpisodeActivity.fromJson(Map<String, dynamic> json) =
      _$EntryActivity_EpisodeActivityImpl.fromJson;

  @override
  int get progress;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryActivity_EpisodeActivityImplCopyWith<
          _$EntryActivity_EpisodeActivityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EntryDetailed _$EntryDetailedFromJson(Map<String, dynamic> json) {
  return _EntryDetailed.fromJson(json);
}

/// @nodoc
mixin _$EntryDetailed {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<String> get titles => throw _privateConstructorUsedError;
  List<String>? get author => throw _privateConstructorUsedError;
  CustomUI? get ui => throw _privateConstructorUsedError;
  Map<String, String>? get meta => throw _privateConstructorUsedError;
  MediaType get mediaType => throw _privateConstructorUsedError;
  ReleaseStatus get status => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  Link? get cover => throw _privateConstructorUsedError;
  List<Episode> get episodes => throw _privateConstructorUsedError;
  List<String>? get genres => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  double? get views => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;

  /// Serializes this EntryDetailed to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryDetailedCopyWith<EntryDetailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryDetailedCopyWith<$Res> {
  factory $EntryDetailedCopyWith(
          EntryDetailed value, $Res Function(EntryDetailed) then) =
      _$EntryDetailedCopyWithImpl<$Res, EntryDetailed>;
  @useResult
  $Res call(
      {String id,
      String url,
      List<String> titles,
      List<String>? author,
      CustomUI? ui,
      Map<String, String>? meta,
      MediaType mediaType,
      ReleaseStatus status,
      String description,
      String language,
      Link? cover,
      List<Episode> episodes,
      List<String>? genres,
      double? rating,
      double? views,
      int? length});

  $CustomUICopyWith<$Res>? get ui;
  $LinkCopyWith<$Res>? get cover;
}

/// @nodoc
class _$EntryDetailedCopyWithImpl<$Res, $Val extends EntryDetailed>
    implements $EntryDetailedCopyWith<$Res> {
  _$EntryDetailedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? titles = null,
    Object? author = freezed,
    Object? ui = freezed,
    Object? meta = freezed,
    Object? mediaType = null,
    Object? status = null,
    Object? description = null,
    Object? language = null,
    Object? cover = freezed,
    Object? episodes = null,
    Object? genres = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReleaseStatus,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Link?,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get ui {
    if (_value.ui == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_value.ui!, (value) {
      return _then(_value.copyWith(ui: value) as $Val);
    });
  }

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res>? get cover {
    if (_value.cover == null) {
      return null;
    }

    return $LinkCopyWith<$Res>(_value.cover!, (value) {
      return _then(_value.copyWith(cover: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryDetailedImplCopyWith<$Res>
    implements $EntryDetailedCopyWith<$Res> {
  factory _$$EntryDetailedImplCopyWith(
          _$EntryDetailedImpl value, $Res Function(_$EntryDetailedImpl) then) =
      __$$EntryDetailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      List<String> titles,
      List<String>? author,
      CustomUI? ui,
      Map<String, String>? meta,
      MediaType mediaType,
      ReleaseStatus status,
      String description,
      String language,
      Link? cover,
      List<Episode> episodes,
      List<String>? genres,
      double? rating,
      double? views,
      int? length});

  @override
  $CustomUICopyWith<$Res>? get ui;
  @override
  $LinkCopyWith<$Res>? get cover;
}

/// @nodoc
class __$$EntryDetailedImplCopyWithImpl<$Res>
    extends _$EntryDetailedCopyWithImpl<$Res, _$EntryDetailedImpl>
    implements _$$EntryDetailedImplCopyWith<$Res> {
  __$$EntryDetailedImplCopyWithImpl(
      _$EntryDetailedImpl _value, $Res Function(_$EntryDetailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? titles = null,
    Object? author = freezed,
    Object? ui = freezed,
    Object? meta = freezed,
    Object? mediaType = null,
    Object? status = null,
    Object? description = null,
    Object? language = null,
    Object? cover = freezed,
    Object? episodes = null,
    Object? genres = freezed,
    Object? rating = freezed,
    Object? views = freezed,
    Object? length = freezed,
  }) {
    return _then(_$EntryDetailedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      titles: null == titles
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      author: freezed == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      ui: freezed == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
      meta: freezed == meta
          ? _value._meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as MediaType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReleaseStatus,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Link?,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryDetailedImpl extends _EntryDetailed {
  const _$EntryDetailedImpl(
      {required this.id,
      required this.url,
      required final List<String> titles,
      final List<String>? author,
      this.ui,
      final Map<String, String>? meta,
      required this.mediaType,
      required this.status,
      required this.description,
      required this.language,
      this.cover,
      required final List<Episode> episodes,
      final List<String>? genres,
      this.rating,
      this.views,
      this.length})
      : _titles = titles,
        _author = author,
        _meta = meta,
        _episodes = episodes,
        _genres = genres,
        super._();

  factory _$EntryDetailedImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryDetailedImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  final List<String> _titles;
  @override
  List<String> get titles {
    if (_titles is EqualUnmodifiableListView) return _titles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_titles);
  }

  final List<String>? _author;
  @override
  List<String>? get author {
    final value = _author;
    if (value == null) return null;
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CustomUI? ui;
  final Map<String, String>? _meta;
  @override
  Map<String, String>? get meta {
    final value = _meta;
    if (value == null) return null;
    if (_meta is EqualUnmodifiableMapView) return _meta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final MediaType mediaType;
  @override
  final ReleaseStatus status;
  @override
  final String description;
  @override
  final String language;
  @override
  final Link? cover;
  final List<Episode> _episodes;
  @override
  List<Episode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  final List<String>? _genres;
  @override
  List<String>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? rating;
  @override
  final double? views;
  @override
  final int? length;

  @override
  String toString() {
    return 'EntryDetailed(id: $id, url: $url, titles: $titles, author: $author, ui: $ui, meta: $meta, mediaType: $mediaType, status: $status, description: $description, language: $language, cover: $cover, episodes: $episodes, genres: $genres, rating: $rating, views: $views, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryDetailedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._titles, _titles) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            (identical(other.ui, ui) || other.ui == ui) &&
            const DeepCollectionEquality().equals(other._meta, _meta) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.length, length) || other.length == length));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      const DeepCollectionEquality().hash(_titles),
      const DeepCollectionEquality().hash(_author),
      ui,
      const DeepCollectionEquality().hash(_meta),
      mediaType,
      status,
      description,
      language,
      cover,
      const DeepCollectionEquality().hash(_episodes),
      const DeepCollectionEquality().hash(_genres),
      rating,
      views,
      length);

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryDetailedImplCopyWith<_$EntryDetailedImpl> get copyWith =>
      __$$EntryDetailedImplCopyWithImpl<_$EntryDetailedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryDetailedImplToJson(
      this,
    );
  }
}

abstract class _EntryDetailed extends EntryDetailed {
  const factory _EntryDetailed(
      {required final String id,
      required final String url,
      required final List<String> titles,
      final List<String>? author,
      final CustomUI? ui,
      final Map<String, String>? meta,
      required final MediaType mediaType,
      required final ReleaseStatus status,
      required final String description,
      required final String language,
      final Link? cover,
      required final List<Episode> episodes,
      final List<String>? genres,
      final double? rating,
      final double? views,
      final int? length}) = _$EntryDetailedImpl;
  const _EntryDetailed._() : super._();

  factory _EntryDetailed.fromJson(Map<String, dynamic> json) =
      _$EntryDetailedImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  List<String> get titles;
  @override
  List<String>? get author;
  @override
  CustomUI? get ui;
  @override
  Map<String, String>? get meta;
  @override
  MediaType get mediaType;
  @override
  ReleaseStatus get status;
  @override
  String get description;
  @override
  String get language;
  @override
  Link? get cover;
  @override
  List<Episode> get episodes;
  @override
  List<String>? get genres;
  @override
  double? get rating;
  @override
  double? get views;
  @override
  int? get length;

  /// Create a copy of EntryDetailed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryDetailedImplCopyWith<_$EntryDetailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntryDetailedResult _$EntryDetailedResultFromJson(Map<String, dynamic> json) {
  return _EntryDetailedResult.fromJson(json);
}

/// @nodoc
mixin _$EntryDetailedResult {
  EntryDetailed get entry => throw _privateConstructorUsedError;
  Map<String, Setting> get settings => throw _privateConstructorUsedError;

  /// Serializes this EntryDetailedResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryDetailedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryDetailedResultCopyWith<EntryDetailedResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryDetailedResultCopyWith<$Res> {
  factory $EntryDetailedResultCopyWith(
          EntryDetailedResult value, $Res Function(EntryDetailedResult) then) =
      _$EntryDetailedResultCopyWithImpl<$Res, EntryDetailedResult>;
  @useResult
  $Res call({EntryDetailed entry, Map<String, Setting> settings});

  $EntryDetailedCopyWith<$Res> get entry;
}

/// @nodoc
class _$EntryDetailedResultCopyWithImpl<$Res, $Val extends EntryDetailedResult>
    implements $EntryDetailedResultCopyWith<$Res> {
  _$EntryDetailedResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryDetailedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as EntryDetailed,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, Setting>,
    ) as $Val);
  }

  /// Create a copy of EntryDetailedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EntryDetailedCopyWith<$Res> get entry {
    return $EntryDetailedCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryDetailedResultImplCopyWith<$Res>
    implements $EntryDetailedResultCopyWith<$Res> {
  factory _$$EntryDetailedResultImplCopyWith(_$EntryDetailedResultImpl value,
          $Res Function(_$EntryDetailedResultImpl) then) =
      __$$EntryDetailedResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EntryDetailed entry, Map<String, Setting> settings});

  @override
  $EntryDetailedCopyWith<$Res> get entry;
}

/// @nodoc
class __$$EntryDetailedResultImplCopyWithImpl<$Res>
    extends _$EntryDetailedResultCopyWithImpl<$Res, _$EntryDetailedResultImpl>
    implements _$$EntryDetailedResultImplCopyWith<$Res> {
  __$$EntryDetailedResultImplCopyWithImpl(_$EntryDetailedResultImpl _value,
      $Res Function(_$EntryDetailedResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryDetailedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? settings = null,
  }) {
    return _then(_$EntryDetailedResultImpl(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as EntryDetailed,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, Setting>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryDetailedResultImpl extends _EntryDetailedResult {
  const _$EntryDetailedResultImpl(
      {required this.entry, required final Map<String, Setting> settings})
      : _settings = settings,
        super._();

  factory _$EntryDetailedResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryDetailedResultImplFromJson(json);

  @override
  final EntryDetailed entry;
  final Map<String, Setting> _settings;
  @override
  Map<String, Setting> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'EntryDetailedResult(entry: $entry, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryDetailedResultImpl &&
            (identical(other.entry, entry) || other.entry == entry) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, entry, const DeepCollectionEquality().hash(_settings));

  /// Create a copy of EntryDetailedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryDetailedResultImplCopyWith<_$EntryDetailedResultImpl> get copyWith =>
      __$$EntryDetailedResultImplCopyWithImpl<_$EntryDetailedResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryDetailedResultImplToJson(
      this,
    );
  }
}

abstract class _EntryDetailedResult extends EntryDetailedResult {
  const factory _EntryDetailedResult(
          {required final EntryDetailed entry,
          required final Map<String, Setting> settings}) =
      _$EntryDetailedResultImpl;
  const _EntryDetailedResult._() : super._();

  factory _EntryDetailedResult.fromJson(Map<String, dynamic> json) =
      _$EntryDetailedResultImpl.fromJson;

  @override
  EntryDetailed get entry;
  @override
  Map<String, Setting> get settings;

  /// Create a copy of EntryDetailedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryDetailedResultImplCopyWith<_$EntryDetailedResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntryList _$EntryListFromJson(Map<String, dynamic> json) {
  return _EntryList.fromJson(json);
}

/// @nodoc
mixin _$EntryList {
  bool? get hasnext => throw _privateConstructorUsedError;
  int? get length => throw _privateConstructorUsedError;
  List<Entry> get content => throw _privateConstructorUsedError;

  /// Serializes this EntryList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryListCopyWith<EntryList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryListCopyWith<$Res> {
  factory $EntryListCopyWith(EntryList value, $Res Function(EntryList) then) =
      _$EntryListCopyWithImpl<$Res, EntryList>;
  @useResult
  $Res call({bool? hasnext, int? length, List<Entry> content});
}

/// @nodoc
class _$EntryListCopyWithImpl<$Res, $Val extends EntryList>
    implements $EntryListCopyWith<$Res> {
  _$EntryListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasnext = freezed,
    Object? length = freezed,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      hasnext: freezed == hasnext
          ? _value.hasnext
          : hasnext // ignore: cast_nullable_to_non_nullable
              as bool?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntryListImplCopyWith<$Res>
    implements $EntryListCopyWith<$Res> {
  factory _$$EntryListImplCopyWith(
          _$EntryListImpl value, $Res Function(_$EntryListImpl) then) =
      __$$EntryListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? hasnext, int? length, List<Entry> content});
}

/// @nodoc
class __$$EntryListImplCopyWithImpl<$Res>
    extends _$EntryListCopyWithImpl<$Res, _$EntryListImpl>
    implements _$$EntryListImplCopyWith<$Res> {
  __$$EntryListImplCopyWithImpl(
      _$EntryListImpl _value, $Res Function(_$EntryListImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasnext = freezed,
    Object? length = freezed,
    Object? content = null,
  }) {
    return _then(_$EntryListImpl(
      hasnext: freezed == hasnext
          ? _value.hasnext
          : hasnext // ignore: cast_nullable_to_non_nullable
              as bool?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryListImpl extends _EntryList {
  const _$EntryListImpl(
      {this.hasnext, this.length, required final List<Entry> content})
      : _content = content,
        super._();

  factory _$EntryListImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryListImplFromJson(json);

  @override
  final bool? hasnext;
  @override
  final int? length;
  final List<Entry> _content;
  @override
  List<Entry> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  String toString() {
    return 'EntryList(hasnext: $hasnext, length: $length, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryListImpl &&
            (identical(other.hasnext, hasnext) || other.hasnext == hasnext) &&
            (identical(other.length, length) || other.length == length) &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hasnext, length,
      const DeepCollectionEquality().hash(_content));

  /// Create a copy of EntryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryListImplCopyWith<_$EntryListImpl> get copyWith =>
      __$$EntryListImplCopyWithImpl<_$EntryListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryListImplToJson(
      this,
    );
  }
}

abstract class _EntryList extends EntryList {
  const factory _EntryList(
      {final bool? hasnext,
      final int? length,
      required final List<Entry> content}) = _$EntryListImpl;
  const _EntryList._() : super._();

  factory _EntryList.fromJson(Map<String, dynamic> json) =
      _$EntryListImpl.fromJson;

  @override
  bool? get hasnext;
  @override
  int? get length;
  @override
  List<Entry> get content;

  /// Create a copy of EntryList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryListImplCopyWith<_$EntryListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return _Episode.fromJson(json);
}

/// @nodoc
mixin _$Episode {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  Link? get cover => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this Episode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodeCopyWith<Episode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) then) =
      _$EpisodeCopyWithImpl<$Res, Episode>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String url,
      Link? cover,
      String? timestamp});

  $LinkCopyWith<$Res>? get cover;
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res, $Val extends Episode>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? url = null,
    Object? cover = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Link?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res>? get cover {
    if (_value.cover == null) {
      return null;
    }

    return $LinkCopyWith<$Res>(_value.cover!, (value) {
      return _then(_value.copyWith(cover: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EpisodeImplCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$EpisodeImplCopyWith(
          _$EpisodeImpl value, $Res Function(_$EpisodeImpl) then) =
      __$$EpisodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String url,
      Link? cover,
      String? timestamp});

  @override
  $LinkCopyWith<$Res>? get cover;
}

/// @nodoc
class __$$EpisodeImplCopyWithImpl<$Res>
    extends _$EpisodeCopyWithImpl<$Res, _$EpisodeImpl>
    implements _$$EpisodeImplCopyWith<$Res> {
  __$$EpisodeImplCopyWithImpl(
      _$EpisodeImpl _value, $Res Function(_$EpisodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? url = null,
    Object? cover = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$EpisodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Link?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EpisodeImpl extends _Episode {
  const _$EpisodeImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.url,
      this.cover,
      this.timestamp})
      : super._();

  factory _$EpisodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpisodeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String url;
  @override
  final Link? cover;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'Episode(id: $id, name: $name, description: $description, url: $url, cover: $cover, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, url, cover, timestamp);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      __$$EpisodeImplCopyWithImpl<_$EpisodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpisodeImplToJson(
      this,
    );
  }
}

abstract class _Episode extends Episode {
  const factory _Episode(
      {required final String id,
      required final String name,
      final String? description,
      required final String url,
      final Link? cover,
      final String? timestamp}) = _$EpisodeImpl;
  const _Episode._() : super._();

  factory _Episode.fromJson(Map<String, dynamic> json) = _$EpisodeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get url;
  @override
  Link? get cover;
  @override
  String? get timestamp;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExtensionData _$ExtensionDataFromJson(Map<String, dynamic> json) {
  return _ExtensionData.fromJson(json);
}

/// @nodoc
mixin _$ExtensionData {
  String get id => throw _privateConstructorUsedError;
  String? get repo => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<MediaType>? get mediaType => throw _privateConstructorUsedError;
  List<ExtensionType>? get extensionType => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  List<String> get author => throw _privateConstructorUsedError;
  String? get license => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool? get nsfw => throw _privateConstructorUsedError;
  List<String> get lang => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this ExtensionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtensionDataCopyWith<ExtensionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtensionDataCopyWith<$Res> {
  factory $ExtensionDataCopyWith(
          ExtensionData value, $Res Function(ExtensionData) then) =
      _$ExtensionDataCopyWithImpl<$Res, ExtensionData>;
  @useResult
  $Res call(
      {String id,
      String? repo,
      String name,
      List<MediaType>? mediaType,
      List<ExtensionType>? extensionType,
      String? version,
      String? desc,
      List<String> author,
      String? license,
      List<String>? tags,
      bool? nsfw,
      List<String> lang,
      String? url,
      String? icon});
}

/// @nodoc
class _$ExtensionDataCopyWithImpl<$Res, $Val extends ExtensionData>
    implements $ExtensionDataCopyWith<$Res> {
  _$ExtensionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? repo = freezed,
    Object? name = null,
    Object? mediaType = freezed,
    Object? extensionType = freezed,
    Object? version = freezed,
    Object? desc = freezed,
    Object? author = null,
    Object? license = freezed,
    Object? tags = freezed,
    Object? nsfw = freezed,
    Object? lang = null,
    Object? url = freezed,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      repo: freezed == repo
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as List<MediaType>?,
      extensionType: freezed == extensionType
          ? _value.extensionType
          : extensionType // ignore: cast_nullable_to_non_nullable
              as List<ExtensionType>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>,
      license: freezed == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nsfw: freezed == nsfw
          ? _value.nsfw
          : nsfw // ignore: cast_nullable_to_non_nullable
              as bool?,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtensionDataImplCopyWith<$Res>
    implements $ExtensionDataCopyWith<$Res> {
  factory _$$ExtensionDataImplCopyWith(
          _$ExtensionDataImpl value, $Res Function(_$ExtensionDataImpl) then) =
      __$$ExtensionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? repo,
      String name,
      List<MediaType>? mediaType,
      List<ExtensionType>? extensionType,
      String? version,
      String? desc,
      List<String> author,
      String? license,
      List<String>? tags,
      bool? nsfw,
      List<String> lang,
      String? url,
      String? icon});
}

/// @nodoc
class __$$ExtensionDataImplCopyWithImpl<$Res>
    extends _$ExtensionDataCopyWithImpl<$Res, _$ExtensionDataImpl>
    implements _$$ExtensionDataImplCopyWith<$Res> {
  __$$ExtensionDataImplCopyWithImpl(
      _$ExtensionDataImpl _value, $Res Function(_$ExtensionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? repo = freezed,
    Object? name = null,
    Object? mediaType = freezed,
    Object? extensionType = freezed,
    Object? version = freezed,
    Object? desc = freezed,
    Object? author = null,
    Object? license = freezed,
    Object? tags = freezed,
    Object? nsfw = freezed,
    Object? lang = null,
    Object? url = freezed,
    Object? icon = freezed,
  }) {
    return _then(_$ExtensionDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      repo: freezed == repo
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mediaType: freezed == mediaType
          ? _value._mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as List<MediaType>?,
      extensionType: freezed == extensionType
          ? _value._extensionType
          : extensionType // ignore: cast_nullable_to_non_nullable
              as List<ExtensionType>?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      author: null == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as List<String>,
      license: freezed == license
          ? _value.license
          : license // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nsfw: freezed == nsfw
          ? _value.nsfw
          : nsfw // ignore: cast_nullable_to_non_nullable
              as bool?,
      lang: null == lang
          ? _value._lang
          : lang // ignore: cast_nullable_to_non_nullable
              as List<String>,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtensionDataImpl extends _ExtensionData {
  const _$ExtensionDataImpl(
      {required this.id,
      this.repo,
      required this.name,
      final List<MediaType>? mediaType,
      final List<ExtensionType>? extensionType,
      this.version,
      this.desc,
      required final List<String> author,
      this.license,
      final List<String>? tags,
      this.nsfw,
      required final List<String> lang,
      this.url,
      this.icon})
      : _mediaType = mediaType,
        _extensionType = extensionType,
        _author = author,
        _tags = tags,
        _lang = lang,
        super._();

  factory _$ExtensionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtensionDataImplFromJson(json);

  @override
  final String id;
  @override
  final String? repo;
  @override
  final String name;
  final List<MediaType>? _mediaType;
  @override
  List<MediaType>? get mediaType {
    final value = _mediaType;
    if (value == null) return null;
    if (_mediaType is EqualUnmodifiableListView) return _mediaType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ExtensionType>? _extensionType;
  @override
  List<ExtensionType>? get extensionType {
    final value = _extensionType;
    if (value == null) return null;
    if (_extensionType is EqualUnmodifiableListView) return _extensionType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? version;
  @override
  final String? desc;
  final List<String> _author;
  @override
  List<String> get author {
    if (_author is EqualUnmodifiableListView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_author);
  }

  @override
  final String? license;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? nsfw;
  final List<String> _lang;
  @override
  List<String> get lang {
    if (_lang is EqualUnmodifiableListView) return _lang;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lang);
  }

  @override
  final String? url;
  @override
  final String? icon;

  @override
  String toString() {
    return 'ExtensionData(id: $id, repo: $repo, name: $name, mediaType: $mediaType, extensionType: $extensionType, version: $version, desc: $desc, author: $author, license: $license, tags: $tags, nsfw: $nsfw, lang: $lang, url: $url, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.repo, repo) || other.repo == repo) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._mediaType, _mediaType) &&
            const DeepCollectionEquality()
                .equals(other._extensionType, _extensionType) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            (identical(other.license, license) || other.license == license) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.nsfw, nsfw) || other.nsfw == nsfw) &&
            const DeepCollectionEquality().equals(other._lang, _lang) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      repo,
      name,
      const DeepCollectionEquality().hash(_mediaType),
      const DeepCollectionEquality().hash(_extensionType),
      version,
      desc,
      const DeepCollectionEquality().hash(_author),
      license,
      const DeepCollectionEquality().hash(_tags),
      nsfw,
      const DeepCollectionEquality().hash(_lang),
      url,
      icon);

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionDataImplCopyWith<_$ExtensionDataImpl> get copyWith =>
      __$$ExtensionDataImplCopyWithImpl<_$ExtensionDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtensionDataImplToJson(
      this,
    );
  }
}

abstract class _ExtensionData extends ExtensionData {
  const factory _ExtensionData(
      {required final String id,
      final String? repo,
      required final String name,
      final List<MediaType>? mediaType,
      final List<ExtensionType>? extensionType,
      final String? version,
      final String? desc,
      required final List<String> author,
      final String? license,
      final List<String>? tags,
      final bool? nsfw,
      required final List<String> lang,
      final String? url,
      final String? icon}) = _$ExtensionDataImpl;
  const _ExtensionData._() : super._();

  factory _ExtensionData.fromJson(Map<String, dynamic> json) =
      _$ExtensionDataImpl.fromJson;

  @override
  String get id;
  @override
  String? get repo;
  @override
  String get name;
  @override
  List<MediaType>? get mediaType;
  @override
  List<ExtensionType>? get extensionType;
  @override
  String? get version;
  @override
  String? get desc;
  @override
  List<String> get author;
  @override
  String? get license;
  @override
  List<String>? get tags;
  @override
  bool? get nsfw;
  @override
  List<String> get lang;
  @override
  String? get url;
  @override
  String? get icon;

  /// Create a copy of ExtensionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionDataImplCopyWith<_$ExtensionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExtensionRepo _$ExtensionRepoFromJson(Map<String, dynamic> json) {
  return _ExtensionRepo.fromJson(json);
}

/// @nodoc
mixin _$ExtensionRepo {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<RemoteExtension> get extensions => throw _privateConstructorUsedError;

  /// Serializes this ExtensionRepo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExtensionRepo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtensionRepoCopyWith<ExtensionRepo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtensionRepoCopyWith<$Res> {
  factory $ExtensionRepoCopyWith(
          ExtensionRepo value, $Res Function(ExtensionRepo) then) =
      _$ExtensionRepoCopyWithImpl<$Res, ExtensionRepo>;
  @useResult
  $Res call(
      {String name,
      String description,
      String id,
      List<RemoteExtension> extensions});
}

/// @nodoc
class _$ExtensionRepoCopyWithImpl<$Res, $Val extends ExtensionRepo>
    implements $ExtensionRepoCopyWith<$Res> {
  _$ExtensionRepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtensionRepo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? id = null,
    Object? extensions = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      extensions: null == extensions
          ? _value.extensions
          : extensions // ignore: cast_nullable_to_non_nullable
              as List<RemoteExtension>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtensionRepoImplCopyWith<$Res>
    implements $ExtensionRepoCopyWith<$Res> {
  factory _$$ExtensionRepoImplCopyWith(
          _$ExtensionRepoImpl value, $Res Function(_$ExtensionRepoImpl) then) =
      __$$ExtensionRepoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String id,
      List<RemoteExtension> extensions});
}

/// @nodoc
class __$$ExtensionRepoImplCopyWithImpl<$Res>
    extends _$ExtensionRepoCopyWithImpl<$Res, _$ExtensionRepoImpl>
    implements _$$ExtensionRepoImplCopyWith<$Res> {
  __$$ExtensionRepoImplCopyWithImpl(
      _$ExtensionRepoImpl _value, $Res Function(_$ExtensionRepoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionRepo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? id = null,
    Object? extensions = null,
  }) {
    return _then(_$ExtensionRepoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      extensions: null == extensions
          ? _value._extensions
          : extensions // ignore: cast_nullable_to_non_nullable
              as List<RemoteExtension>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtensionRepoImpl extends _ExtensionRepo {
  const _$ExtensionRepoImpl(
      {required this.name,
      required this.description,
      required this.id,
      required final List<RemoteExtension> extensions})
      : _extensions = extensions,
        super._();

  factory _$ExtensionRepoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtensionRepoImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String id;
  final List<RemoteExtension> _extensions;
  @override
  List<RemoteExtension> get extensions {
    if (_extensions is EqualUnmodifiableListView) return _extensions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extensions);
  }

  @override
  String toString() {
    return 'ExtensionRepo(name: $name, description: $description, id: $id, extensions: $extensions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionRepoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._extensions, _extensions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, id,
      const DeepCollectionEquality().hash(_extensions));

  /// Create a copy of ExtensionRepo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionRepoImplCopyWith<_$ExtensionRepoImpl> get copyWith =>
      __$$ExtensionRepoImplCopyWithImpl<_$ExtensionRepoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtensionRepoImplToJson(
      this,
    );
  }
}

abstract class _ExtensionRepo extends ExtensionRepo {
  const factory _ExtensionRepo(
      {required final String name,
      required final String description,
      required final String id,
      required final List<RemoteExtension> extensions}) = _$ExtensionRepoImpl;
  const _ExtensionRepo._() : super._();

  factory _ExtensionRepo.fromJson(Map<String, dynamic> json) =
      _$ExtensionRepoImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get id;
  @override
  List<RemoteExtension> get extensions;

  /// Create a copy of ExtensionRepo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionRepoImplCopyWith<_$ExtensionRepoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImageListAudio _$ImageListAudioFromJson(Map<String, dynamic> json) {
  return _ImageListAudio.fromJson(json);
}

/// @nodoc
mixin _$ImageListAudio {
  Link get link => throw _privateConstructorUsedError;
  int get from => throw _privateConstructorUsedError;
  int get to => throw _privateConstructorUsedError;

  /// Serializes this ImageListAudio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImageListAudioCopyWith<ImageListAudio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageListAudioCopyWith<$Res> {
  factory $ImageListAudioCopyWith(
          ImageListAudio value, $Res Function(ImageListAudio) then) =
      _$ImageListAudioCopyWithImpl<$Res, ImageListAudio>;
  @useResult
  $Res call({Link link, int from, int to});

  $LinkCopyWith<$Res> get link;
}

/// @nodoc
class _$ImageListAudioCopyWithImpl<$Res, $Val extends ImageListAudio>
    implements $ImageListAudioCopyWith<$Res> {
  _$ImageListAudioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get link {
    return $LinkCopyWith<$Res>(_value.link, (value) {
      return _then(_value.copyWith(link: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageListAudioImplCopyWith<$Res>
    implements $ImageListAudioCopyWith<$Res> {
  factory _$$ImageListAudioImplCopyWith(_$ImageListAudioImpl value,
          $Res Function(_$ImageListAudioImpl) then) =
      __$$ImageListAudioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Link link, int from, int to});

  @override
  $LinkCopyWith<$Res> get link;
}

/// @nodoc
class __$$ImageListAudioImplCopyWithImpl<$Res>
    extends _$ImageListAudioCopyWithImpl<$Res, _$ImageListAudioImpl>
    implements _$$ImageListAudioImplCopyWith<$Res> {
  __$$ImageListAudioImplCopyWithImpl(
      _$ImageListAudioImpl _value, $Res Function(_$ImageListAudioImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_$ImageListAudioImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageListAudioImpl implements _ImageListAudio {
  const _$ImageListAudioImpl(
      {required this.link, required this.from, required this.to});

  factory _$ImageListAudioImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageListAudioImplFromJson(json);

  @override
  final Link link;
  @override
  final int from;
  @override
  final int to;

  @override
  String toString() {
    return 'ImageListAudio(link: $link, from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageListAudioImpl &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, link, from, to);

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageListAudioImplCopyWith<_$ImageListAudioImpl> get copyWith =>
      __$$ImageListAudioImplCopyWithImpl<_$ImageListAudioImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageListAudioImplToJson(
      this,
    );
  }
}

abstract class _ImageListAudio implements ImageListAudio {
  const factory _ImageListAudio(
      {required final Link link,
      required final int from,
      required final int to}) = _$ImageListAudioImpl;

  factory _ImageListAudio.fromJson(Map<String, dynamic> json) =
      _$ImageListAudioImpl.fromJson;

  @override
  Link get link;
  @override
  int get from;
  @override
  int get to;

  /// Create a copy of ImageListAudio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImageListAudioImplCopyWith<_$ImageListAudioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Link _$LinkFromJson(Map<String, dynamic> json) {
  return _Link.fromJson(json);
}

/// @nodoc
mixin _$Link {
  String get url => throw _privateConstructorUsedError;
  Map<String, String>? get header => throw _privateConstructorUsedError;

  /// Serializes this Link to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkCopyWith<Link> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkCopyWith<$Res> {
  factory $LinkCopyWith(Link value, $Res Function(Link) then) =
      _$LinkCopyWithImpl<$Res, Link>;
  @useResult
  $Res call({String url, Map<String, String>? header});
}

/// @nodoc
class _$LinkCopyWithImpl<$Res, $Val extends Link>
    implements $LinkCopyWith<$Res> {
  _$LinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? header = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      header: freezed == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkImplCopyWith<$Res> implements $LinkCopyWith<$Res> {
  factory _$$LinkImplCopyWith(
          _$LinkImpl value, $Res Function(_$LinkImpl) then) =
      __$$LinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, Map<String, String>? header});
}

/// @nodoc
class __$$LinkImplCopyWithImpl<$Res>
    extends _$LinkCopyWithImpl<$Res, _$LinkImpl>
    implements _$$LinkImplCopyWith<$Res> {
  __$$LinkImplCopyWithImpl(_$LinkImpl _value, $Res Function(_$LinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? header = freezed,
  }) {
    return _then(_$LinkImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      header: freezed == header
          ? _value._header
          : header // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkImpl extends _Link {
  const _$LinkImpl({required this.url, final Map<String, String>? header})
      : _header = header,
        super._();

  factory _$LinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkImplFromJson(json);

  @override
  final String url;
  final Map<String, String>? _header;
  @override
  Map<String, String>? get header {
    final value = _header;
    if (value == null) return null;
    if (_header is EqualUnmodifiableMapView) return _header;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Link(url: $url, header: $header)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkImpl &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._header, _header));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, const DeepCollectionEquality().hash(_header));

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkImplCopyWith<_$LinkImpl> get copyWith =>
      __$$LinkImplCopyWithImpl<_$LinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkImplToJson(
      this,
    );
  }
}

abstract class _Link extends Link {
  const factory _Link(
      {required final String url,
      final Map<String, String>? header}) = _$LinkImpl;
  const _Link._() : super._();

  factory _Link.fromJson(Map<String, dynamic> json) = _$LinkImpl.fromJson;

  @override
  String get url;
  @override
  Map<String, String>? get header;

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkImplCopyWith<_$LinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Mp3Chapter _$Mp3ChapterFromJson(Map<String, dynamic> json) {
  return _Mp3Chapter.fromJson(json);
}

/// @nodoc
mixin _$Mp3Chapter {
  String get title => throw _privateConstructorUsedError;
  Link get url => throw _privateConstructorUsedError;

  /// Serializes this Mp3Chapter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mp3Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Mp3ChapterCopyWith<Mp3Chapter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Mp3ChapterCopyWith<$Res> {
  factory $Mp3ChapterCopyWith(
          Mp3Chapter value, $Res Function(Mp3Chapter) then) =
      _$Mp3ChapterCopyWithImpl<$Res, Mp3Chapter>;
  @useResult
  $Res call({String title, Link url});

  $LinkCopyWith<$Res> get url;
}

/// @nodoc
class _$Mp3ChapterCopyWithImpl<$Res, $Val extends Mp3Chapter>
    implements $Mp3ChapterCopyWith<$Res> {
  _$Mp3ChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mp3Chapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Link,
    ) as $Val);
  }

  /// Create a copy of Mp3Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get url {
    return $LinkCopyWith<$Res>(_value.url, (value) {
      return _then(_value.copyWith(url: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$Mp3ChapterImplCopyWith<$Res>
    implements $Mp3ChapterCopyWith<$Res> {
  factory _$$Mp3ChapterImplCopyWith(
          _$Mp3ChapterImpl value, $Res Function(_$Mp3ChapterImpl) then) =
      __$$Mp3ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, Link url});

  @override
  $LinkCopyWith<$Res> get url;
}

/// @nodoc
class __$$Mp3ChapterImplCopyWithImpl<$Res>
    extends _$Mp3ChapterCopyWithImpl<$Res, _$Mp3ChapterImpl>
    implements _$$Mp3ChapterImplCopyWith<$Res> {
  __$$Mp3ChapterImplCopyWithImpl(
      _$Mp3ChapterImpl _value, $Res Function(_$Mp3ChapterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mp3Chapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_$Mp3ChapterImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Link,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Mp3ChapterImpl implements _Mp3Chapter {
  const _$Mp3ChapterImpl({required this.title, required this.url});

  factory _$Mp3ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$Mp3ChapterImplFromJson(json);

  @override
  final String title;
  @override
  final Link url;

  @override
  String toString() {
    return 'Mp3Chapter(title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Mp3ChapterImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, url);

  /// Create a copy of Mp3Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Mp3ChapterImplCopyWith<_$Mp3ChapterImpl> get copyWith =>
      __$$Mp3ChapterImplCopyWithImpl<_$Mp3ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Mp3ChapterImplToJson(
      this,
    );
  }
}

abstract class _Mp3Chapter implements Mp3Chapter {
  const factory _Mp3Chapter(
      {required final String title,
      required final Link url}) = _$Mp3ChapterImpl;

  factory _Mp3Chapter.fromJson(Map<String, dynamic> json) =
      _$Mp3ChapterImpl.fromJson;

  @override
  String get title;
  @override
  Link get url;

  /// Create a copy of Mp3Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Mp3ChapterImplCopyWith<_$Mp3ChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Paragraph _$ParagraphFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'text':
      return Paragraph_Text.fromJson(json);
    case 'customUi':
      return Paragraph_CustomUI.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Paragraph',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Paragraph {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(CustomUI ui) customUi,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(CustomUI ui)? customUi,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(CustomUI ui)? customUi,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Paragraph_Text value) text,
    required TResult Function(Paragraph_CustomUI value) customUi,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Paragraph_Text value)? text,
    TResult? Function(Paragraph_CustomUI value)? customUi,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Paragraph_Text value)? text,
    TResult Function(Paragraph_CustomUI value)? customUi,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Paragraph to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphCopyWith<$Res> {
  factory $ParagraphCopyWith(Paragraph value, $Res Function(Paragraph) then) =
      _$ParagraphCopyWithImpl<$Res, Paragraph>;
}

/// @nodoc
class _$ParagraphCopyWithImpl<$Res, $Val extends Paragraph>
    implements $ParagraphCopyWith<$Res> {
  _$ParagraphCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Paragraph_TextImplCopyWith<$Res> {
  factory _$$Paragraph_TextImplCopyWith(_$Paragraph_TextImpl value,
          $Res Function(_$Paragraph_TextImpl) then) =
      __$$Paragraph_TextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$Paragraph_TextImplCopyWithImpl<$Res>
    extends _$ParagraphCopyWithImpl<$Res, _$Paragraph_TextImpl>
    implements _$$Paragraph_TextImplCopyWith<$Res> {
  __$$Paragraph_TextImplCopyWithImpl(
      _$Paragraph_TextImpl _value, $Res Function(_$Paragraph_TextImpl) _then)
      : super(_value, _then);

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$Paragraph_TextImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Paragraph_TextImpl extends Paragraph_Text {
  const _$Paragraph_TextImpl({required this.content, final String? $type})
      : $type = $type ?? 'text',
        super._();

  factory _$Paragraph_TextImpl.fromJson(Map<String, dynamic> json) =>
      _$$Paragraph_TextImplFromJson(json);

  @override
  final String content;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Paragraph.text(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Paragraph_TextImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Paragraph_TextImplCopyWith<_$Paragraph_TextImpl> get copyWith =>
      __$$Paragraph_TextImplCopyWithImpl<_$Paragraph_TextImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(CustomUI ui) customUi,
  }) {
    return text(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(CustomUI ui)? customUi,
  }) {
    return text?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(CustomUI ui)? customUi,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Paragraph_Text value) text,
    required TResult Function(Paragraph_CustomUI value) customUi,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Paragraph_Text value)? text,
    TResult? Function(Paragraph_CustomUI value)? customUi,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Paragraph_Text value)? text,
    TResult Function(Paragraph_CustomUI value)? customUi,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Paragraph_TextImplToJson(
      this,
    );
  }
}

abstract class Paragraph_Text extends Paragraph {
  const factory Paragraph_Text({required final String content}) =
      _$Paragraph_TextImpl;
  const Paragraph_Text._() : super._();

  factory Paragraph_Text.fromJson(Map<String, dynamic> json) =
      _$Paragraph_TextImpl.fromJson;

  String get content;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Paragraph_TextImplCopyWith<_$Paragraph_TextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Paragraph_CustomUIImplCopyWith<$Res> {
  factory _$$Paragraph_CustomUIImplCopyWith(_$Paragraph_CustomUIImpl value,
          $Res Function(_$Paragraph_CustomUIImpl) then) =
      __$$Paragraph_CustomUIImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CustomUI ui});

  $CustomUICopyWith<$Res> get ui;
}

/// @nodoc
class __$$Paragraph_CustomUIImplCopyWithImpl<$Res>
    extends _$ParagraphCopyWithImpl<$Res, _$Paragraph_CustomUIImpl>
    implements _$$Paragraph_CustomUIImplCopyWith<$Res> {
  __$$Paragraph_CustomUIImplCopyWithImpl(_$Paragraph_CustomUIImpl _value,
      $Res Function(_$Paragraph_CustomUIImpl) _then)
      : super(_value, _then);

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ui = null,
  }) {
    return _then(_$Paragraph_CustomUIImpl(
      ui: null == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get ui {
    return $CustomUICopyWith<$Res>(_value.ui, (value) {
      return _then(_value.copyWith(ui: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Paragraph_CustomUIImpl extends Paragraph_CustomUI {
  const _$Paragraph_CustomUIImpl({required this.ui, final String? $type})
      : $type = $type ?? 'customUi',
        super._();

  factory _$Paragraph_CustomUIImpl.fromJson(Map<String, dynamic> json) =>
      _$$Paragraph_CustomUIImplFromJson(json);

  @override
  final CustomUI ui;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Paragraph.customUi(ui: $ui)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Paragraph_CustomUIImpl &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ui);

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Paragraph_CustomUIImplCopyWith<_$Paragraph_CustomUIImpl> get copyWith =>
      __$$Paragraph_CustomUIImplCopyWithImpl<_$Paragraph_CustomUIImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String content) text,
    required TResult Function(CustomUI ui) customUi,
  }) {
    return customUi(ui);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String content)? text,
    TResult? Function(CustomUI ui)? customUi,
  }) {
    return customUi?.call(ui);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String content)? text,
    TResult Function(CustomUI ui)? customUi,
    required TResult orElse(),
  }) {
    if (customUi != null) {
      return customUi(ui);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Paragraph_Text value) text,
    required TResult Function(Paragraph_CustomUI value) customUi,
  }) {
    return customUi(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Paragraph_Text value)? text,
    TResult? Function(Paragraph_CustomUI value)? customUi,
  }) {
    return customUi?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Paragraph_Text value)? text,
    TResult Function(Paragraph_CustomUI value)? customUi,
    required TResult orElse(),
  }) {
    if (customUi != null) {
      return customUi(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Paragraph_CustomUIImplToJson(
      this,
    );
  }
}

abstract class Paragraph_CustomUI extends Paragraph {
  const factory Paragraph_CustomUI({required final CustomUI ui}) =
      _$Paragraph_CustomUIImpl;
  const Paragraph_CustomUI._() : super._();

  factory Paragraph_CustomUI.fromJson(Map<String, dynamic> json) =
      _$Paragraph_CustomUIImpl.fromJson;

  CustomUI get ui;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Paragraph_CustomUIImplCopyWith<_$Paragraph_CustomUIImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PopupAction _$PopupActionFromJson(Map<String, dynamic> json) {
  return _PopupAction.fromJson(json);
}

/// @nodoc
mixin _$PopupAction {
  String get label => throw _privateConstructorUsedError;
  Action get onclick => throw _privateConstructorUsedError;

  /// Serializes this PopupAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PopupAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopupActionCopyWith<PopupAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopupActionCopyWith<$Res> {
  factory $PopupActionCopyWith(
          PopupAction value, $Res Function(PopupAction) then) =
      _$PopupActionCopyWithImpl<$Res, PopupAction>;
  @useResult
  $Res call({String label, Action onclick});

  $ActionCopyWith<$Res> get onclick;
}

/// @nodoc
class _$PopupActionCopyWithImpl<$Res, $Val extends PopupAction>
    implements $PopupActionCopyWith<$Res> {
  _$PopupActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopupAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? onclick = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onclick: null == onclick
          ? _value.onclick
          : onclick // ignore: cast_nullable_to_non_nullable
              as Action,
    ) as $Val);
  }

  /// Create a copy of PopupAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionCopyWith<$Res> get onclick {
    return $ActionCopyWith<$Res>(_value.onclick, (value) {
      return _then(_value.copyWith(onclick: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PopupActionImplCopyWith<$Res>
    implements $PopupActionCopyWith<$Res> {
  factory _$$PopupActionImplCopyWith(
          _$PopupActionImpl value, $Res Function(_$PopupActionImpl) then) =
      __$$PopupActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, Action onclick});

  @override
  $ActionCopyWith<$Res> get onclick;
}

/// @nodoc
class __$$PopupActionImplCopyWithImpl<$Res>
    extends _$PopupActionCopyWithImpl<$Res, _$PopupActionImpl>
    implements _$$PopupActionImplCopyWith<$Res> {
  __$$PopupActionImplCopyWithImpl(
      _$PopupActionImpl _value, $Res Function(_$PopupActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PopupAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? onclick = null,
  }) {
    return _then(_$PopupActionImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      onclick: null == onclick
          ? _value.onclick
          : onclick // ignore: cast_nullable_to_non_nullable
              as Action,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PopupActionImpl implements _PopupAction {
  const _$PopupActionImpl({required this.label, required this.onclick});

  factory _$PopupActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PopupActionImplFromJson(json);

  @override
  final String label;
  @override
  final Action onclick;

  @override
  String toString() {
    return 'PopupAction(label: $label, onclick: $onclick)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopupActionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onclick, onclick) || other.onclick == onclick));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, onclick);

  /// Create a copy of PopupAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopupActionImplCopyWith<_$PopupActionImpl> get copyWith =>
      __$$PopupActionImplCopyWithImpl<_$PopupActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PopupActionImplToJson(
      this,
    );
  }
}

abstract class _PopupAction implements PopupAction {
  const factory _PopupAction(
      {required final String label,
      required final Action onclick}) = _$PopupActionImpl;

  factory _PopupAction.fromJson(Map<String, dynamic> json) =
      _$PopupActionImpl.fromJson;

  @override
  String get label;
  @override
  Action get onclick;

  /// Create a copy of PopupAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopupActionImplCopyWith<_$PopupActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RemoteExtension _$RemoteExtensionFromJson(Map<String, dynamic> json) {
  return _RemoteExtension.fromJson(json);
}

/// @nodoc
mixin _$RemoteExtension {
  String get extensionUrl => throw _privateConstructorUsedError;
  bool get compatible => throw _privateConstructorUsedError;
  ExtensionData get data => throw _privateConstructorUsedError;

  /// Serializes this RemoteExtension to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoteExtension
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemoteExtensionCopyWith<RemoteExtension> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteExtensionCopyWith<$Res> {
  factory $RemoteExtensionCopyWith(
          RemoteExtension value, $Res Function(RemoteExtension) then) =
      _$RemoteExtensionCopyWithImpl<$Res, RemoteExtension>;
  @useResult
  $Res call({String extensionUrl, bool compatible, ExtensionData data});

  $ExtensionDataCopyWith<$Res> get data;
}

/// @nodoc
class _$RemoteExtensionCopyWithImpl<$Res, $Val extends RemoteExtension>
    implements $RemoteExtensionCopyWith<$Res> {
  _$RemoteExtensionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoteExtension
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extensionUrl = null,
    Object? compatible = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      extensionUrl: null == extensionUrl
          ? _value.extensionUrl
          : extensionUrl // ignore: cast_nullable_to_non_nullable
              as String,
      compatible: null == compatible
          ? _value.compatible
          : compatible // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ExtensionData,
    ) as $Val);
  }

  /// Create a copy of RemoteExtension
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtensionDataCopyWith<$Res> get data {
    return $ExtensionDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RemoteExtensionImplCopyWith<$Res>
    implements $RemoteExtensionCopyWith<$Res> {
  factory _$$RemoteExtensionImplCopyWith(_$RemoteExtensionImpl value,
          $Res Function(_$RemoteExtensionImpl) then) =
      __$$RemoteExtensionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String extensionUrl, bool compatible, ExtensionData data});

  @override
  $ExtensionDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$RemoteExtensionImplCopyWithImpl<$Res>
    extends _$RemoteExtensionCopyWithImpl<$Res, _$RemoteExtensionImpl>
    implements _$$RemoteExtensionImplCopyWith<$Res> {
  __$$RemoteExtensionImplCopyWithImpl(
      _$RemoteExtensionImpl _value, $Res Function(_$RemoteExtensionImpl) _then)
      : super(_value, _then);

  /// Create a copy of RemoteExtension
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extensionUrl = null,
    Object? compatible = null,
    Object? data = null,
  }) {
    return _then(_$RemoteExtensionImpl(
      extensionUrl: null == extensionUrl
          ? _value.extensionUrl
          : extensionUrl // ignore: cast_nullable_to_non_nullable
              as String,
      compatible: null == compatible
          ? _value.compatible
          : compatible // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ExtensionData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoteExtensionImpl extends _RemoteExtension {
  const _$RemoteExtensionImpl(
      {required this.extensionUrl,
      required this.compatible,
      required this.data})
      : super._();

  factory _$RemoteExtensionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoteExtensionImplFromJson(json);

  @override
  final String extensionUrl;
  @override
  final bool compatible;
  @override
  final ExtensionData data;

  @override
  String toString() {
    return 'RemoteExtension(extensionUrl: $extensionUrl, compatible: $compatible, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteExtensionImpl &&
            (identical(other.extensionUrl, extensionUrl) ||
                other.extensionUrl == extensionUrl) &&
            (identical(other.compatible, compatible) ||
                other.compatible == compatible) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, extensionUrl, compatible, data);

  /// Create a copy of RemoteExtension
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteExtensionImplCopyWith<_$RemoteExtensionImpl> get copyWith =>
      __$$RemoteExtensionImplCopyWithImpl<_$RemoteExtensionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoteExtensionImplToJson(
      this,
    );
  }
}

abstract class _RemoteExtension extends RemoteExtension {
  const factory _RemoteExtension(
      {required final String extensionUrl,
      required final bool compatible,
      required final ExtensionData data}) = _$RemoteExtensionImpl;
  const _RemoteExtension._() : super._();

  factory _RemoteExtension.fromJson(Map<String, dynamic> json) =
      _$RemoteExtensionImpl.fromJson;

  @override
  String get extensionUrl;
  @override
  bool get compatible;
  @override
  ExtensionData get data;

  /// Create a copy of RemoteExtension
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoteExtensionImplCopyWith<_$RemoteExtensionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Source _$SourceFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'epub':
      return Source_Epub.fromJson(json);
    case 'pdf':
      return Source_Pdf.fromJson(json);
    case 'imagelist':
      return Source_Imagelist.fromJson(json);
    case 'm3U8':
      return Source_M3u8.fromJson(json);
    case 'mp3':
      return Source_Mp3.fromJson(json);
    case 'paragraphlist':
      return Source_Paragraphlist.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Source',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Source {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Source to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceCopyWith<$Res> {
  factory $SourceCopyWith(Source value, $Res Function(Source) then) =
      _$SourceCopyWithImpl<$Res, Source>;
}

/// @nodoc
class _$SourceCopyWithImpl<$Res, $Val extends Source>
    implements $SourceCopyWith<$Res> {
  _$SourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Source_EpubImplCopyWith<$Res> {
  factory _$$Source_EpubImplCopyWith(
          _$Source_EpubImpl value, $Res Function(_$Source_EpubImpl) then) =
      __$$Source_EpubImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Link link});

  $LinkCopyWith<$Res> get link;
}

/// @nodoc
class __$$Source_EpubImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_EpubImpl>
    implements _$$Source_EpubImplCopyWith<$Res> {
  __$$Source_EpubImplCopyWithImpl(
      _$Source_EpubImpl _value, $Res Function(_$Source_EpubImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$Source_EpubImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get link {
    return $LinkCopyWith<$Res>(_value.link, (value) {
      return _then(_value.copyWith(link: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Source_EpubImpl extends Source_Epub {
  const _$Source_EpubImpl({required this.link, final String? $type})
      : $type = $type ?? 'epub',
        super._();

  factory _$Source_EpubImpl.fromJson(Map<String, dynamic> json) =>
      _$$Source_EpubImplFromJson(json);

  @override
  final Link link;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Source.epub(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_EpubImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, link);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_EpubImplCopyWith<_$Source_EpubImpl> get copyWith =>
      __$$Source_EpubImplCopyWithImpl<_$Source_EpubImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) {
    return epub(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) {
    return epub?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (epub != null) {
      return epub(link);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    return epub(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    return epub?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (epub != null) {
      return epub(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_EpubImplToJson(
      this,
    );
  }
}

abstract class Source_Epub extends Source {
  const factory Source_Epub({required final Link link}) = _$Source_EpubImpl;
  const Source_Epub._() : super._();

  factory Source_Epub.fromJson(Map<String, dynamic> json) =
      _$Source_EpubImpl.fromJson;

  Link get link;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_EpubImplCopyWith<_$Source_EpubImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_PdfImplCopyWith<$Res> {
  factory _$$Source_PdfImplCopyWith(
          _$Source_PdfImpl value, $Res Function(_$Source_PdfImpl) then) =
      __$$Source_PdfImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Link link});

  $LinkCopyWith<$Res> get link;
}

/// @nodoc
class __$$Source_PdfImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_PdfImpl>
    implements _$$Source_PdfImplCopyWith<$Res> {
  __$$Source_PdfImplCopyWithImpl(
      _$Source_PdfImpl _value, $Res Function(_$Source_PdfImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$Source_PdfImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get link {
    return $LinkCopyWith<$Res>(_value.link, (value) {
      return _then(_value.copyWith(link: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Source_PdfImpl extends Source_Pdf {
  const _$Source_PdfImpl({required this.link, final String? $type})
      : $type = $type ?? 'pdf',
        super._();

  factory _$Source_PdfImpl.fromJson(Map<String, dynamic> json) =>
      _$$Source_PdfImplFromJson(json);

  @override
  final Link link;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Source.pdf(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_PdfImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, link);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_PdfImplCopyWith<_$Source_PdfImpl> get copyWith =>
      __$$Source_PdfImplCopyWithImpl<_$Source_PdfImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) {
    return pdf(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) {
    return pdf?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (pdf != null) {
      return pdf(link);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    return pdf(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    return pdf?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (pdf != null) {
      return pdf(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_PdfImplToJson(
      this,
    );
  }
}

abstract class Source_Pdf extends Source {
  const factory Source_Pdf({required final Link link}) = _$Source_PdfImpl;
  const Source_Pdf._() : super._();

  factory Source_Pdf.fromJson(Map<String, dynamic> json) =
      _$Source_PdfImpl.fromJson;

  Link get link;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_PdfImplCopyWith<_$Source_PdfImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_ImagelistImplCopyWith<$Res> {
  factory _$$Source_ImagelistImplCopyWith(_$Source_ImagelistImpl value,
          $Res Function(_$Source_ImagelistImpl) then) =
      __$$Source_ImagelistImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Link> links, List<ImageListAudio>? audio});
}

/// @nodoc
class __$$Source_ImagelistImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_ImagelistImpl>
    implements _$$Source_ImagelistImplCopyWith<$Res> {
  __$$Source_ImagelistImplCopyWithImpl(_$Source_ImagelistImpl _value,
      $Res Function(_$Source_ImagelistImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = null,
    Object? audio = freezed,
  }) {
    return _then(_$Source_ImagelistImpl(
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Link>,
      audio: freezed == audio
          ? _value._audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<ImageListAudio>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Source_ImagelistImpl extends Source_Imagelist {
  const _$Source_ImagelistImpl(
      {required final List<Link> links,
      final List<ImageListAudio>? audio,
      final String? $type})
      : _links = links,
        _audio = audio,
        $type = $type ?? 'imagelist',
        super._();

  factory _$Source_ImagelistImpl.fromJson(Map<String, dynamic> json) =>
      _$$Source_ImagelistImplFromJson(json);

  final List<Link> _links;
  @override
  List<Link> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final List<ImageListAudio>? _audio;
  @override
  List<ImageListAudio>? get audio {
    final value = _audio;
    if (value == null) return null;
    if (_audio is EqualUnmodifiableListView) return _audio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Source.imagelist(links: $links, audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_ImagelistImpl &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._audio, _audio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_audio));

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_ImagelistImplCopyWith<_$Source_ImagelistImpl> get copyWith =>
      __$$Source_ImagelistImplCopyWithImpl<_$Source_ImagelistImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) {
    return imagelist(links, audio);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) {
    return imagelist?.call(links, audio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (imagelist != null) {
      return imagelist(links, audio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    return imagelist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    return imagelist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (imagelist != null) {
      return imagelist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_ImagelistImplToJson(
      this,
    );
  }
}

abstract class Source_Imagelist extends Source {
  const factory Source_Imagelist(
      {required final List<Link> links,
      final List<ImageListAudio>? audio}) = _$Source_ImagelistImpl;
  const Source_Imagelist._() : super._();

  factory Source_Imagelist.fromJson(Map<String, dynamic> json) =
      _$Source_ImagelistImpl.fromJson;

  List<Link> get links;
  List<ImageListAudio>? get audio;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_ImagelistImplCopyWith<_$Source_ImagelistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_M3u8ImplCopyWith<$Res> {
  factory _$$Source_M3u8ImplCopyWith(
          _$Source_M3u8Impl value, $Res Function(_$Source_M3u8Impl) then) =
      __$$Source_M3u8ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Link link, List<Subtitles> sub});

  $LinkCopyWith<$Res> get link;
}

/// @nodoc
class __$$Source_M3u8ImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_M3u8Impl>
    implements _$$Source_M3u8ImplCopyWith<$Res> {
  __$$Source_M3u8ImplCopyWithImpl(
      _$Source_M3u8Impl _value, $Res Function(_$Source_M3u8Impl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? sub = null,
  }) {
    return _then(_$Source_M3u8Impl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
      sub: null == sub
          ? _value._sub
          : sub // ignore: cast_nullable_to_non_nullable
              as List<Subtitles>,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get link {
    return $LinkCopyWith<$Res>(_value.link, (value) {
      return _then(_value.copyWith(link: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Source_M3u8Impl extends Source_M3u8 {
  const _$Source_M3u8Impl(
      {required this.link,
      required final List<Subtitles> sub,
      final String? $type})
      : _sub = sub,
        $type = $type ?? 'm3U8',
        super._();

  factory _$Source_M3u8Impl.fromJson(Map<String, dynamic> json) =>
      _$$Source_M3u8ImplFromJson(json);

  @override
  final Link link;
  final List<Subtitles> _sub;
  @override
  List<Subtitles> get sub {
    if (_sub is EqualUnmodifiableListView) return _sub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sub);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Source.m3U8(link: $link, sub: $sub)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_M3u8Impl &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality().equals(other._sub, _sub));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, link, const DeepCollectionEquality().hash(_sub));

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_M3u8ImplCopyWith<_$Source_M3u8Impl> get copyWith =>
      __$$Source_M3u8ImplCopyWithImpl<_$Source_M3u8Impl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) {
    return m3U8(link, sub);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) {
    return m3U8?.call(link, sub);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (m3U8 != null) {
      return m3U8(link, sub);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    return m3U8(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    return m3U8?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (m3U8 != null) {
      return m3U8(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_M3u8ImplToJson(
      this,
    );
  }
}

abstract class Source_M3u8 extends Source {
  const factory Source_M3u8(
      {required final Link link,
      required final List<Subtitles> sub}) = _$Source_M3u8Impl;
  const Source_M3u8._() : super._();

  factory Source_M3u8.fromJson(Map<String, dynamic> json) =
      _$Source_M3u8Impl.fromJson;

  Link get link;
  List<Subtitles> get sub;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_M3u8ImplCopyWith<_$Source_M3u8Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_Mp3ImplCopyWith<$Res> {
  factory _$$Source_Mp3ImplCopyWith(
          _$Source_Mp3Impl value, $Res Function(_$Source_Mp3Impl) then) =
      __$$Source_Mp3ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Mp3Chapter> chapters});
}

/// @nodoc
class __$$Source_Mp3ImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_Mp3Impl>
    implements _$$Source_Mp3ImplCopyWith<$Res> {
  __$$Source_Mp3ImplCopyWithImpl(
      _$Source_Mp3Impl _value, $Res Function(_$Source_Mp3Impl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapters = null,
  }) {
    return _then(_$Source_Mp3Impl(
      chapters: null == chapters
          ? _value._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Mp3Chapter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Source_Mp3Impl extends Source_Mp3 {
  const _$Source_Mp3Impl(
      {required final List<Mp3Chapter> chapters, final String? $type})
      : _chapters = chapters,
        $type = $type ?? 'mp3',
        super._();

  factory _$Source_Mp3Impl.fromJson(Map<String, dynamic> json) =>
      _$$Source_Mp3ImplFromJson(json);

  final List<Mp3Chapter> _chapters;
  @override
  List<Mp3Chapter> get chapters {
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chapters);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Source.mp3(chapters: $chapters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_Mp3Impl &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_chapters));

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_Mp3ImplCopyWith<_$Source_Mp3Impl> get copyWith =>
      __$$Source_Mp3ImplCopyWithImpl<_$Source_Mp3Impl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) {
    return mp3(chapters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) {
    return mp3?.call(chapters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (mp3 != null) {
      return mp3(chapters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    return mp3(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    return mp3?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (mp3 != null) {
      return mp3(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_Mp3ImplToJson(
      this,
    );
  }
}

abstract class Source_Mp3 extends Source {
  const factory Source_Mp3({required final List<Mp3Chapter> chapters}) =
      _$Source_Mp3Impl;
  const Source_Mp3._() : super._();

  factory Source_Mp3.fromJson(Map<String, dynamic> json) =
      _$Source_Mp3Impl.fromJson;

  List<Mp3Chapter> get chapters;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_Mp3ImplCopyWith<_$Source_Mp3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_ParagraphlistImplCopyWith<$Res> {
  factory _$$Source_ParagraphlistImplCopyWith(_$Source_ParagraphlistImpl value,
          $Res Function(_$Source_ParagraphlistImpl) then) =
      __$$Source_ParagraphlistImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Paragraph> paragraphs});
}

/// @nodoc
class __$$Source_ParagraphlistImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_ParagraphlistImpl>
    implements _$$Source_ParagraphlistImplCopyWith<$Res> {
  __$$Source_ParagraphlistImplCopyWithImpl(_$Source_ParagraphlistImpl _value,
      $Res Function(_$Source_ParagraphlistImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paragraphs = null,
  }) {
    return _then(_$Source_ParagraphlistImpl(
      paragraphs: null == paragraphs
          ? _value._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<Paragraph>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Source_ParagraphlistImpl extends Source_Paragraphlist {
  const _$Source_ParagraphlistImpl(
      {required final List<Paragraph> paragraphs, final String? $type})
      : _paragraphs = paragraphs,
        $type = $type ?? 'paragraphlist',
        super._();

  factory _$Source_ParagraphlistImpl.fromJson(Map<String, dynamic> json) =>
      _$$Source_ParagraphlistImplFromJson(json);

  final List<Paragraph> _paragraphs;
  @override
  List<Paragraph> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Source.paragraphlist(paragraphs: $paragraphs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_ParagraphlistImpl &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_paragraphs));

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_ParagraphlistImplCopyWith<_$Source_ParagraphlistImpl>
      get copyWith =>
          __$$Source_ParagraphlistImplCopyWithImpl<_$Source_ParagraphlistImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(Link link, List<Subtitles> sub) m3U8,
    required TResult Function(List<Mp3Chapter> chapters) mp3,
    required TResult Function(List<Paragraph> paragraphs) paragraphlist,
  }) {
    return paragraphlist(paragraphs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(Link link, List<Subtitles> sub)? m3U8,
    TResult? Function(List<Mp3Chapter> chapters)? mp3,
    TResult? Function(List<Paragraph> paragraphs)? paragraphlist,
  }) {
    return paragraphlist?.call(paragraphs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(Link link, List<Subtitles> sub)? m3U8,
    TResult Function(List<Mp3Chapter> chapters)? mp3,
    TResult Function(List<Paragraph> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) {
    if (paragraphlist != null) {
      return paragraphlist(paragraphs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_M3u8 value) m3U8,
    required TResult Function(Source_Mp3 value) mp3,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    return paragraphlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_M3u8 value)? m3U8,
    TResult? Function(Source_Mp3 value)? mp3,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    return paragraphlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_M3u8 value)? m3U8,
    TResult Function(Source_Mp3 value)? mp3,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (paragraphlist != null) {
      return paragraphlist(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$Source_ParagraphlistImplToJson(
      this,
    );
  }
}

abstract class Source_Paragraphlist extends Source {
  const factory Source_Paragraphlist(
      {required final List<Paragraph> paragraphs}) = _$Source_ParagraphlistImpl;
  const Source_Paragraphlist._() : super._();

  factory Source_Paragraphlist.fromJson(Map<String, dynamic> json) =
      _$Source_ParagraphlistImpl.fromJson;

  List<Paragraph> get paragraphs;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_ParagraphlistImplCopyWith<_$Source_ParagraphlistImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SourceResult _$SourceResultFromJson(Map<String, dynamic> json) {
  return _SourceResult.fromJson(json);
}

/// @nodoc
mixin _$SourceResult {
  Source get source => throw _privateConstructorUsedError;
  Map<String, Setting> get settings => throw _privateConstructorUsedError;

  /// Serializes this SourceResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SourceResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SourceResultCopyWith<SourceResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SourceResultCopyWith<$Res> {
  factory $SourceResultCopyWith(
          SourceResult value, $Res Function(SourceResult) then) =
      _$SourceResultCopyWithImpl<$Res, SourceResult>;
  @useResult
  $Res call({Source source, Map<String, Setting> settings});

  $SourceCopyWith<$Res> get source;
}

/// @nodoc
class _$SourceResultCopyWithImpl<$Res, $Val extends SourceResult>
    implements $SourceResultCopyWith<$Res> {
  _$SourceResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SourceResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Source,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, Setting>,
    ) as $Val);
  }

  /// Create a copy of SourceResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SourceCopyWith<$Res> get source {
    return $SourceCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SourceResultImplCopyWith<$Res>
    implements $SourceResultCopyWith<$Res> {
  factory _$$SourceResultImplCopyWith(
          _$SourceResultImpl value, $Res Function(_$SourceResultImpl) then) =
      __$$SourceResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Source source, Map<String, Setting> settings});

  @override
  $SourceCopyWith<$Res> get source;
}

/// @nodoc
class __$$SourceResultImplCopyWithImpl<$Res>
    extends _$SourceResultCopyWithImpl<$Res, _$SourceResultImpl>
    implements _$$SourceResultImplCopyWith<$Res> {
  __$$SourceResultImplCopyWithImpl(
      _$SourceResultImpl _value, $Res Function(_$SourceResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SourceResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? settings = null,
  }) {
    return _then(_$SourceResultImpl(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as Source,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, Setting>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceResultImpl implements _SourceResult {
  const _$SourceResultImpl(
      {required this.source, required final Map<String, Setting> settings})
      : _settings = settings;

  factory _$SourceResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceResultImplFromJson(json);

  @override
  final Source source;
  final Map<String, Setting> _settings;
  @override
  Map<String, Setting> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  String toString() {
    return 'SourceResult(source: $source, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceResultImpl &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, source, const DeepCollectionEquality().hash(_settings));

  /// Create a copy of SourceResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceResultImplCopyWith<_$SourceResultImpl> get copyWith =>
      __$$SourceResultImplCopyWithImpl<_$SourceResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceResultImplToJson(
      this,
    );
  }
}

abstract class _SourceResult implements SourceResult {
  const factory _SourceResult(
      {required final Source source,
      required final Map<String, Setting> settings}) = _$SourceResultImpl;

  factory _SourceResult.fromJson(Map<String, dynamic> json) =
      _$SourceResultImpl.fromJson;

  @override
  Source get source;
  @override
  Map<String, Setting> get settings;

  /// Create a copy of SourceResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SourceResultImplCopyWith<_$SourceResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Subtitles _$SubtitlesFromJson(Map<String, dynamic> json) {
  return _Subtitles.fromJson(json);
}

/// @nodoc
mixin _$Subtitles {
  String get title => throw _privateConstructorUsedError;
  Link get url => throw _privateConstructorUsedError;

  /// Serializes this Subtitles to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtitlesCopyWith<Subtitles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitlesCopyWith<$Res> {
  factory $SubtitlesCopyWith(Subtitles value, $Res Function(Subtitles) then) =
      _$SubtitlesCopyWithImpl<$Res, Subtitles>;
  @useResult
  $Res call({String title, Link url});

  $LinkCopyWith<$Res> get url;
}

/// @nodoc
class _$SubtitlesCopyWithImpl<$Res, $Val extends Subtitles>
    implements $SubtitlesCopyWith<$Res> {
  _$SubtitlesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Link,
    ) as $Val);
  }

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkCopyWith<$Res> get url {
    return $LinkCopyWith<$Res>(_value.url, (value) {
      return _then(_value.copyWith(url: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SubtitlesImplCopyWith<$Res>
    implements $SubtitlesCopyWith<$Res> {
  factory _$$SubtitlesImplCopyWith(
          _$SubtitlesImpl value, $Res Function(_$SubtitlesImpl) then) =
      __$$SubtitlesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, Link url});

  @override
  $LinkCopyWith<$Res> get url;
}

/// @nodoc
class __$$SubtitlesImplCopyWithImpl<$Res>
    extends _$SubtitlesCopyWithImpl<$Res, _$SubtitlesImpl>
    implements _$$SubtitlesImplCopyWith<$Res> {
  __$$SubtitlesImplCopyWithImpl(
      _$SubtitlesImpl _value, $Res Function(_$SubtitlesImpl) _then)
      : super(_value, _then);

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
  }) {
    return _then(_$SubtitlesImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Link,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtitlesImpl implements _Subtitles {
  const _$SubtitlesImpl({required this.title, required this.url});

  factory _$SubtitlesImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtitlesImplFromJson(json);

  @override
  final String title;
  @override
  final Link url;

  @override
  String toString() {
    return 'Subtitles(title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtitlesImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, url);

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtitlesImplCopyWith<_$SubtitlesImpl> get copyWith =>
      __$$SubtitlesImplCopyWithImpl<_$SubtitlesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtitlesImplToJson(
      this,
    );
  }
}

abstract class _Subtitles implements Subtitles {
  const factory _Subtitles(
      {required final String title, required final Link url}) = _$SubtitlesImpl;

  factory _Subtitles.fromJson(Map<String, dynamic> json) =
      _$SubtitlesImpl.fromJson;

  @override
  String get title;
  @override
  Link get url;

  /// Create a copy of Subtitles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtitlesImplCopyWith<_$SubtitlesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UIAction _$UIActionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'action':
      return UIAction_Action.fromJson(json);
    case 'swapContent':
      return UIAction_SwapContent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UIAction',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UIAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Action action) action,
    required TResult Function(
            String? targetid, String event, CustomUI? placeholder)
        swapContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Action action)? action,
    TResult? Function(String? targetid, String event, CustomUI? placeholder)?
        swapContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Action action)? action,
    TResult Function(String? targetid, String event, CustomUI? placeholder)?
        swapContent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIAction_Action value) action,
    required TResult Function(UIAction_SwapContent value) swapContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIAction_Action value)? action,
    TResult? Function(UIAction_SwapContent value)? swapContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIAction_Action value)? action,
    TResult Function(UIAction_SwapContent value)? swapContent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this UIAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIActionCopyWith<$Res> {
  factory $UIActionCopyWith(UIAction value, $Res Function(UIAction) then) =
      _$UIActionCopyWithImpl<$Res, UIAction>;
}

/// @nodoc
class _$UIActionCopyWithImpl<$Res, $Val extends UIAction>
    implements $UIActionCopyWith<$Res> {
  _$UIActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UIAction_ActionImplCopyWith<$Res> {
  factory _$$UIAction_ActionImplCopyWith(_$UIAction_ActionImpl value,
          $Res Function(_$UIAction_ActionImpl) then) =
      __$$UIAction_ActionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Action action});

  $ActionCopyWith<$Res> get action;
}

/// @nodoc
class __$$UIAction_ActionImplCopyWithImpl<$Res>
    extends _$UIActionCopyWithImpl<$Res, _$UIAction_ActionImpl>
    implements _$$UIAction_ActionImplCopyWith<$Res> {
  __$$UIAction_ActionImplCopyWithImpl(
      _$UIAction_ActionImpl _value, $Res Function(_$UIAction_ActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
  }) {
    return _then(_$UIAction_ActionImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as Action,
    ));
  }

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActionCopyWith<$Res> get action {
    return $ActionCopyWith<$Res>(_value.action, (value) {
      return _then(_value.copyWith(action: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$UIAction_ActionImpl extends UIAction_Action {
  const _$UIAction_ActionImpl({required this.action, final String? $type})
      : $type = $type ?? 'action',
        super._();

  factory _$UIAction_ActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UIAction_ActionImplFromJson(json);

  @override
  final Action action;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UIAction.action(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIAction_ActionImpl &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, action);

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UIAction_ActionImplCopyWith<_$UIAction_ActionImpl> get copyWith =>
      __$$UIAction_ActionImplCopyWithImpl<_$UIAction_ActionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Action action) action,
    required TResult Function(
            String? targetid, String event, CustomUI? placeholder)
        swapContent,
  }) {
    return action(this.action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Action action)? action,
    TResult? Function(String? targetid, String event, CustomUI? placeholder)?
        swapContent,
  }) {
    return action?.call(this.action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Action action)? action,
    TResult Function(String? targetid, String event, CustomUI? placeholder)?
        swapContent,
    required TResult orElse(),
  }) {
    if (action != null) {
      return action(this.action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIAction_Action value) action,
    required TResult Function(UIAction_SwapContent value) swapContent,
  }) {
    return action(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIAction_Action value)? action,
    TResult? Function(UIAction_SwapContent value)? swapContent,
  }) {
    return action?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIAction_Action value)? action,
    TResult Function(UIAction_SwapContent value)? swapContent,
    required TResult orElse(),
  }) {
    if (action != null) {
      return action(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UIAction_ActionImplToJson(
      this,
    );
  }
}

abstract class UIAction_Action extends UIAction {
  const factory UIAction_Action({required final Action action}) =
      _$UIAction_ActionImpl;
  const UIAction_Action._() : super._();

  factory UIAction_Action.fromJson(Map<String, dynamic> json) =
      _$UIAction_ActionImpl.fromJson;

  Action get action;

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UIAction_ActionImplCopyWith<_$UIAction_ActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UIAction_SwapContentImplCopyWith<$Res> {
  factory _$$UIAction_SwapContentImplCopyWith(_$UIAction_SwapContentImpl value,
          $Res Function(_$UIAction_SwapContentImpl) then) =
      __$$UIAction_SwapContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? targetid, String event, CustomUI? placeholder});

  $CustomUICopyWith<$Res>? get placeholder;
}

/// @nodoc
class __$$UIAction_SwapContentImplCopyWithImpl<$Res>
    extends _$UIActionCopyWithImpl<$Res, _$UIAction_SwapContentImpl>
    implements _$$UIAction_SwapContentImplCopyWith<$Res> {
  __$$UIAction_SwapContentImplCopyWithImpl(_$UIAction_SwapContentImpl _value,
      $Res Function(_$UIAction_SwapContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetid = freezed,
    Object? event = null,
    Object? placeholder = freezed,
  }) {
    return _then(_$UIAction_SwapContentImpl(
      targetid: freezed == targetid
          ? _value.targetid
          : targetid // ignore: cast_nullable_to_non_nullable
              as String?,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      placeholder: freezed == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as CustomUI?,
    ));
  }

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res>? get placeholder {
    if (_value.placeholder == null) {
      return null;
    }

    return $CustomUICopyWith<$Res>(_value.placeholder!, (value) {
      return _then(_value.copyWith(placeholder: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$UIAction_SwapContentImpl extends UIAction_SwapContent {
  const _$UIAction_SwapContentImpl(
      {this.targetid,
      required this.event,
      this.placeholder,
      final String? $type})
      : $type = $type ?? 'swapContent',
        super._();

  factory _$UIAction_SwapContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UIAction_SwapContentImplFromJson(json);

  @override
  final String? targetid;
  @override
  final String event;
  @override
  final CustomUI? placeholder;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UIAction.swapContent(targetid: $targetid, event: $event, placeholder: $placeholder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIAction_SwapContentImpl &&
            (identical(other.targetid, targetid) ||
                other.targetid == targetid) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, targetid, event, placeholder);

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UIAction_SwapContentImplCopyWith<_$UIAction_SwapContentImpl>
      get copyWith =>
          __$$UIAction_SwapContentImplCopyWithImpl<_$UIAction_SwapContentImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Action action) action,
    required TResult Function(
            String? targetid, String event, CustomUI? placeholder)
        swapContent,
  }) {
    return swapContent(targetid, event, placeholder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Action action)? action,
    TResult? Function(String? targetid, String event, CustomUI? placeholder)?
        swapContent,
  }) {
    return swapContent?.call(targetid, event, placeholder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Action action)? action,
    TResult Function(String? targetid, String event, CustomUI? placeholder)?
        swapContent,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(targetid, event, placeholder);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UIAction_Action value) action,
    required TResult Function(UIAction_SwapContent value) swapContent,
  }) {
    return swapContent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UIAction_Action value)? action,
    TResult? Function(UIAction_SwapContent value)? swapContent,
  }) {
    return swapContent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UIAction_Action value)? action,
    TResult Function(UIAction_SwapContent value)? swapContent,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UIAction_SwapContentImplToJson(
      this,
    );
  }
}

abstract class UIAction_SwapContent extends UIAction {
  const factory UIAction_SwapContent(
      {final String? targetid,
      required final String event,
      final CustomUI? placeholder}) = _$UIAction_SwapContentImpl;
  const UIAction_SwapContent._() : super._();

  factory UIAction_SwapContent.fromJson(Map<String, dynamic> json) =
      _$UIAction_SwapContentImpl.fromJson;

  String? get targetid;
  String get event;
  CustomUI? get placeholder;

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UIAction_SwapContentImplCopyWith<_$UIAction_SwapContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}
