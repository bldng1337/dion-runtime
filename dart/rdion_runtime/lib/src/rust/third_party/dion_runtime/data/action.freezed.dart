// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Action {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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

class _$Action_OpenBrowserImpl extends Action_OpenBrowser {
  const _$Action_OpenBrowserImpl({required this.url}) : super._();

  @override
  final String url;

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
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
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
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
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
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
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
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) {
    return openBrowser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) {
    return openBrowser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) {
    if (openBrowser != null) {
      return openBrowser(this);
    }
    return orElse();
  }
}

abstract class Action_OpenBrowser extends Action {
  const factory Action_OpenBrowser({required final String url}) =
      _$Action_OpenBrowserImpl;
  const Action_OpenBrowser._() : super._();

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

class _$Action_PopupImpl extends Action_Popup {
  const _$Action_PopupImpl(
      {required this.title,
      required this.content,
      required final List<PopupAction> actions})
      : _actions = actions,
        super._();

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
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
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
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
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
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
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
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) {
    return popup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) {
    return popup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) {
    if (popup != null) {
      return popup(this);
    }
    return orElse();
  }
}

abstract class Action_Popup extends Action {
  const factory Action_Popup(
      {required final String title,
      required final CustomUI content,
      required final List<PopupAction> actions}) = _$Action_PopupImpl;
  const Action_Popup._() : super._();

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

class _$Action_NavImpl extends Action_Nav {
  const _$Action_NavImpl({required this.title, required this.content})
      : super._();

  @override
  final String title;
  @override
  final CustomUI content;

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
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
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
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
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
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
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
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) {
    return nav(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) {
    return nav?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) {
    if (nav != null) {
      return nav(this);
    }
    return orElse();
  }
}

abstract class Action_Nav extends Action {
  const factory Action_Nav(
      {required final String title,
      required final CustomUI content}) = _$Action_NavImpl;
  const Action_Nav._() : super._();

  String get title;
  CustomUI get content;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_NavImplCopyWith<_$Action_NavImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Action_PopViewImplCopyWith<$Res> {
  factory _$$Action_PopViewImplCopyWith(_$Action_PopViewImpl value,
          $Res Function(_$Action_PopViewImpl) then) =
      __$$Action_PopViewImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$Action_PopViewImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_PopViewImpl>
    implements _$$Action_PopViewImplCopyWith<$Res> {
  __$$Action_PopViewImplCopyWithImpl(
      _$Action_PopViewImpl _value, $Res Function(_$Action_PopViewImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$Action_PopViewImpl extends Action_PopView {
  const _$Action_PopViewImpl() : super._();

  @override
  String toString() {
    return 'Action.popView()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Action_PopViewImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
  }) {
    return popView();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
  }) {
    return popView?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
    required TResult orElse(),
  }) {
    if (popView != null) {
      return popView();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) {
    return popView(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) {
    return popView?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) {
    if (popView != null) {
      return popView(this);
    }
    return orElse();
  }
}

abstract class Action_PopView extends Action {
  const factory Action_PopView() = _$Action_PopViewImpl;
  const Action_PopView._() : super._();
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

class _$Action_TriggerEventImpl extends Action_TriggerEvent {
  const _$Action_TriggerEventImpl({required this.event, required this.data})
      : super._();

  @override
  final String event;
  @override
  final String data;

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
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
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
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
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
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
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
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) {
    return triggerEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) {
    return triggerEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) {
    if (triggerEvent != null) {
      return triggerEvent(this);
    }
    return orElse();
  }
}

abstract class Action_TriggerEvent extends Action {
  const factory Action_TriggerEvent(
      {required final String event,
      required final String data}) = _$Action_TriggerEventImpl;
  const Action_TriggerEvent._() : super._();

  String get event;
  String get data;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_TriggerEventImplCopyWith<_$Action_TriggerEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Action_NavEntryImplCopyWith<$Res> {
  factory _$$Action_NavEntryImplCopyWith(_$Action_NavEntryImpl value,
          $Res Function(_$Action_NavEntryImpl) then) =
      __$$Action_NavEntryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EntryDetailed entry});
}

/// @nodoc
class __$$Action_NavEntryImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_NavEntryImpl>
    implements _$$Action_NavEntryImplCopyWith<$Res> {
  __$$Action_NavEntryImplCopyWithImpl(
      _$Action_NavEntryImpl _value, $Res Function(_$Action_NavEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
  }) {
    return _then(_$Action_NavEntryImpl(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as EntryDetailed,
    ));
  }
}

/// @nodoc

class _$Action_NavEntryImpl extends Action_NavEntry {
  const _$Action_NavEntryImpl({required this.entry}) : super._();

  @override
  final EntryDetailed entry;

  @override
  String toString() {
    return 'Action.navEntry(entry: $entry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Action_NavEntryImpl &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Action_NavEntryImplCopyWith<_$Action_NavEntryImpl> get copyWith =>
      __$$Action_NavEntryImplCopyWithImpl<_$Action_NavEntryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function() popView,
    required TResult Function(String event, String data) triggerEvent,
    required TResult Function(EntryDetailed entry) navEntry,
  }) {
    return navEntry(entry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function()? popView,
    TResult? Function(String event, String data)? triggerEvent,
    TResult? Function(EntryDetailed entry)? navEntry,
  }) {
    return navEntry?.call(entry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function()? popView,
    TResult Function(String event, String data)? triggerEvent,
    TResult Function(EntryDetailed entry)? navEntry,
    required TResult orElse(),
  }) {
    if (navEntry != null) {
      return navEntry(entry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_TriggerEvent value) triggerEvent,
    required TResult Function(Action_NavEntry value) navEntry,
  }) {
    return navEntry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_TriggerEvent value)? triggerEvent,
    TResult? Function(Action_NavEntry value)? navEntry,
  }) {
    return navEntry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_TriggerEvent value)? triggerEvent,
    TResult Function(Action_NavEntry value)? navEntry,
    required TResult orElse(),
  }) {
    if (navEntry != null) {
      return navEntry(this);
    }
    return orElse();
  }
}

abstract class Action_NavEntry extends Action {
  const factory Action_NavEntry({required final EntryDetailed entry}) =
      _$Action_NavEntryImpl;
  const Action_NavEntry._() : super._();

  EntryDetailed get entry;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_NavEntryImplCopyWith<_$Action_NavEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventData {
  String get event => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, String targetid, String data)
        swapContent,
    required TResult Function(String event, String data, int page) feedUpdate,
    required TResult Function(String event, String data) trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, String targetid, String data)? swapContent,
    TResult? Function(String event, String data, int page)? feedUpdate,
    TResult? Function(String event, String data)? trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, String targetid, String data)? swapContent,
    TResult Function(String event, String data, int page)? feedUpdate,
    TResult Function(String event, String data)? trigger,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_SwapContent value) swapContent,
    required TResult Function(EventData_FeedUpdate value) feedUpdate,
    required TResult Function(EventData_Trigger value) trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_SwapContent value)? swapContent,
    TResult? Function(EventData_FeedUpdate value)? feedUpdate,
    TResult? Function(EventData_Trigger value)? trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_SwapContent value)? swapContent,
    TResult Function(EventData_FeedUpdate value)? feedUpdate,
    TResult Function(EventData_Trigger value)? trigger,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventDataCopyWith<EventData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDataCopyWith<$Res> {
  factory $EventDataCopyWith(EventData value, $Res Function(EventData) then) =
      _$EventDataCopyWithImpl<$Res, EventData>;
  @useResult
  $Res call({String event, String data});
}

/// @nodoc
class _$EventDataCopyWithImpl<$Res, $Val extends EventData>
    implements $EventDataCopyWith<$Res> {
  _$EventDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventData_SwapContentImplCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory _$$EventData_SwapContentImplCopyWith(
          _$EventData_SwapContentImpl value,
          $Res Function(_$EventData_SwapContentImpl) then) =
      __$$EventData_SwapContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String event, String targetid, String data});
}

/// @nodoc
class __$$EventData_SwapContentImplCopyWithImpl<$Res>
    extends _$EventDataCopyWithImpl<$Res, _$EventData_SwapContentImpl>
    implements _$$EventData_SwapContentImplCopyWith<$Res> {
  __$$EventData_SwapContentImplCopyWithImpl(_$EventData_SwapContentImpl _value,
      $Res Function(_$EventData_SwapContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? targetid = null,
    Object? data = null,
  }) {
    return _then(_$EventData_SwapContentImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      targetid: null == targetid
          ? _value.targetid
          : targetid // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EventData_SwapContentImpl extends EventData_SwapContent {
  const _$EventData_SwapContentImpl(
      {required this.event, required this.targetid, required this.data})
      : super._();

  @override
  final String event;
  @override
  final String targetid;
  @override
  final String data;

  @override
  String toString() {
    return 'EventData.swapContent(event: $event, targetid: $targetid, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventData_SwapContentImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.targetid, targetid) ||
                other.targetid == targetid) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event, targetid, data);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventData_SwapContentImplCopyWith<_$EventData_SwapContentImpl>
      get copyWith => __$$EventData_SwapContentImplCopyWithImpl<
          _$EventData_SwapContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, String targetid, String data)
        swapContent,
    required TResult Function(String event, String data, int page) feedUpdate,
    required TResult Function(String event, String data) trigger,
  }) {
    return swapContent(event, targetid, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, String targetid, String data)? swapContent,
    TResult? Function(String event, String data, int page)? feedUpdate,
    TResult? Function(String event, String data)? trigger,
  }) {
    return swapContent?.call(event, targetid, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, String targetid, String data)? swapContent,
    TResult Function(String event, String data, int page)? feedUpdate,
    TResult Function(String event, String data)? trigger,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(event, targetid, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_SwapContent value) swapContent,
    required TResult Function(EventData_FeedUpdate value) feedUpdate,
    required TResult Function(EventData_Trigger value) trigger,
  }) {
    return swapContent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_SwapContent value)? swapContent,
    TResult? Function(EventData_FeedUpdate value)? feedUpdate,
    TResult? Function(EventData_Trigger value)? trigger,
  }) {
    return swapContent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_SwapContent value)? swapContent,
    TResult Function(EventData_FeedUpdate value)? feedUpdate,
    TResult Function(EventData_Trigger value)? trigger,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(this);
    }
    return orElse();
  }
}

abstract class EventData_SwapContent extends EventData {
  const factory EventData_SwapContent(
      {required final String event,
      required final String targetid,
      required final String data}) = _$EventData_SwapContentImpl;
  const EventData_SwapContent._() : super._();

  @override
  String get event;
  String get targetid;
  @override
  String get data;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventData_SwapContentImplCopyWith<_$EventData_SwapContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventData_FeedUpdateImplCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory _$$EventData_FeedUpdateImplCopyWith(_$EventData_FeedUpdateImpl value,
          $Res Function(_$EventData_FeedUpdateImpl) then) =
      __$$EventData_FeedUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String event, String data, int page});
}

/// @nodoc
class __$$EventData_FeedUpdateImplCopyWithImpl<$Res>
    extends _$EventDataCopyWithImpl<$Res, _$EventData_FeedUpdateImpl>
    implements _$$EventData_FeedUpdateImplCopyWith<$Res> {
  __$$EventData_FeedUpdateImplCopyWithImpl(_$EventData_FeedUpdateImpl _value,
      $Res Function(_$EventData_FeedUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
    Object? page = null,
  }) {
    return _then(_$EventData_FeedUpdateImpl(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$EventData_FeedUpdateImpl extends EventData_FeedUpdate {
  const _$EventData_FeedUpdateImpl(
      {required this.event, required this.data, required this.page})
      : super._();

  @override
  final String event;
  @override
  final String data;
  @override
  final int page;

  @override
  String toString() {
    return 'EventData.feedUpdate(event: $event, data: $data, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventData_FeedUpdateImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event, data, page);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventData_FeedUpdateImplCopyWith<_$EventData_FeedUpdateImpl>
      get copyWith =>
          __$$EventData_FeedUpdateImplCopyWithImpl<_$EventData_FeedUpdateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, String targetid, String data)
        swapContent,
    required TResult Function(String event, String data, int page) feedUpdate,
    required TResult Function(String event, String data) trigger,
  }) {
    return feedUpdate(event, data, page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, String targetid, String data)? swapContent,
    TResult? Function(String event, String data, int page)? feedUpdate,
    TResult? Function(String event, String data)? trigger,
  }) {
    return feedUpdate?.call(event, data, page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, String targetid, String data)? swapContent,
    TResult Function(String event, String data, int page)? feedUpdate,
    TResult Function(String event, String data)? trigger,
    required TResult orElse(),
  }) {
    if (feedUpdate != null) {
      return feedUpdate(event, data, page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_SwapContent value) swapContent,
    required TResult Function(EventData_FeedUpdate value) feedUpdate,
    required TResult Function(EventData_Trigger value) trigger,
  }) {
    return feedUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_SwapContent value)? swapContent,
    TResult? Function(EventData_FeedUpdate value)? feedUpdate,
    TResult? Function(EventData_Trigger value)? trigger,
  }) {
    return feedUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_SwapContent value)? swapContent,
    TResult Function(EventData_FeedUpdate value)? feedUpdate,
    TResult Function(EventData_Trigger value)? trigger,
    required TResult orElse(),
  }) {
    if (feedUpdate != null) {
      return feedUpdate(this);
    }
    return orElse();
  }
}

abstract class EventData_FeedUpdate extends EventData {
  const factory EventData_FeedUpdate(
      {required final String event,
      required final String data,
      required final int page}) = _$EventData_FeedUpdateImpl;
  const EventData_FeedUpdate._() : super._();

  @override
  String get event;
  @override
  String get data;
  int get page;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventData_FeedUpdateImplCopyWith<_$EventData_FeedUpdateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventData_TriggerImplCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory _$$EventData_TriggerImplCopyWith(_$EventData_TriggerImpl value,
          $Res Function(_$EventData_TriggerImpl) then) =
      __$$EventData_TriggerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String event, String data});
}

/// @nodoc
class __$$EventData_TriggerImplCopyWithImpl<$Res>
    extends _$EventDataCopyWithImpl<$Res, _$EventData_TriggerImpl>
    implements _$$EventData_TriggerImplCopyWith<$Res> {
  __$$EventData_TriggerImplCopyWithImpl(_$EventData_TriggerImpl _value,
      $Res Function(_$EventData_TriggerImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? data = null,
  }) {
    return _then(_$EventData_TriggerImpl(
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

class _$EventData_TriggerImpl extends EventData_Trigger {
  const _$EventData_TriggerImpl({required this.event, required this.data})
      : super._();

  @override
  final String event;
  @override
  final String data;

  @override
  String toString() {
    return 'EventData.trigger(event: $event, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventData_TriggerImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event, data);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventData_TriggerImplCopyWith<_$EventData_TriggerImpl> get copyWith =>
      __$$EventData_TriggerImplCopyWithImpl<_$EventData_TriggerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, String targetid, String data)
        swapContent,
    required TResult Function(String event, String data, int page) feedUpdate,
    required TResult Function(String event, String data) trigger,
  }) {
    return trigger(event, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, String targetid, String data)? swapContent,
    TResult? Function(String event, String data, int page)? feedUpdate,
    TResult? Function(String event, String data)? trigger,
  }) {
    return trigger?.call(event, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, String targetid, String data)? swapContent,
    TResult Function(String event, String data, int page)? feedUpdate,
    TResult Function(String event, String data)? trigger,
    required TResult orElse(),
  }) {
    if (trigger != null) {
      return trigger(event, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_SwapContent value) swapContent,
    required TResult Function(EventData_FeedUpdate value) feedUpdate,
    required TResult Function(EventData_Trigger value) trigger,
  }) {
    return trigger(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_SwapContent value)? swapContent,
    TResult? Function(EventData_FeedUpdate value)? feedUpdate,
    TResult? Function(EventData_Trigger value)? trigger,
  }) {
    return trigger?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_SwapContent value)? swapContent,
    TResult Function(EventData_FeedUpdate value)? feedUpdate,
    TResult Function(EventData_Trigger value)? trigger,
    required TResult orElse(),
  }) {
    if (trigger != null) {
      return trigger(this);
    }
    return orElse();
  }
}

abstract class EventData_Trigger extends EventData {
  const factory EventData_Trigger(
      {required final String event,
      required final String data}) = _$EventData_TriggerImpl;
  const EventData_Trigger._() : super._();

  @override
  String get event;
  @override
  String get data;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventData_TriggerImplCopyWith<_$EventData_TriggerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) swapContent,
    required TResult Function(
            List<CustomUI> customui, bool? hasnext, int? length)
        feedUpdate,
    required TResult Function(Action action) doAction,
    required TResult Function() return_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? swapContent,
    TResult? Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult? Function(Action action)? doAction,
    TResult? Function()? return_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? swapContent,
    TResult Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult Function(Action action)? doAction,
    TResult Function()? return_,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SwapContent value) swapContent,
    required TResult Function(EventResult_FeedUpdate value) feedUpdate,
    required TResult Function(EventResult_DoAction value) doAction,
    required TResult Function(EventResult_Return value) return_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SwapContent value)? swapContent,
    TResult? Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult? Function(EventResult_DoAction value)? doAction,
    TResult? Function(EventResult_Return value)? return_,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SwapContent value)? swapContent,
    TResult Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult Function(EventResult_DoAction value)? doAction,
    TResult Function(EventResult_Return value)? return_,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventResultCopyWith<$Res> {
  factory $EventResultCopyWith(
          EventResult value, $Res Function(EventResult) then) =
      _$EventResultCopyWithImpl<$Res, EventResult>;
}

/// @nodoc
class _$EventResultCopyWithImpl<$Res, $Val extends EventResult>
    implements $EventResultCopyWith<$Res> {
  _$EventResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EventResult_SwapContentImplCopyWith<$Res> {
  factory _$$EventResult_SwapContentImplCopyWith(
          _$EventResult_SwapContentImpl value,
          $Res Function(_$EventResult_SwapContentImpl) then) =
      __$$EventResult_SwapContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CustomUI customui});

  $CustomUICopyWith<$Res> get customui;
}

/// @nodoc
class __$$EventResult_SwapContentImplCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$EventResult_SwapContentImpl>
    implements _$$EventResult_SwapContentImplCopyWith<$Res> {
  __$$EventResult_SwapContentImplCopyWithImpl(
      _$EventResult_SwapContentImpl _value,
      $Res Function(_$EventResult_SwapContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customui = null,
  }) {
    return _then(_$EventResult_SwapContentImpl(
      customui: null == customui
          ? _value.customui
          : customui // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get customui {
    return $CustomUICopyWith<$Res>(_value.customui, (value) {
      return _then(_value.copyWith(customui: value));
    });
  }
}

/// @nodoc

class _$EventResult_SwapContentImpl extends EventResult_SwapContent {
  const _$EventResult_SwapContentImpl({required this.customui}) : super._();

  @override
  final CustomUI customui;

  @override
  String toString() {
    return 'EventResult.swapContent(customui: $customui)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventResult_SwapContentImpl &&
            (identical(other.customui, customui) ||
                other.customui == customui));
  }

  @override
  int get hashCode => Object.hash(runtimeType, customui);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventResult_SwapContentImplCopyWith<_$EventResult_SwapContentImpl>
      get copyWith => __$$EventResult_SwapContentImplCopyWithImpl<
          _$EventResult_SwapContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) swapContent,
    required TResult Function(
            List<CustomUI> customui, bool? hasnext, int? length)
        feedUpdate,
    required TResult Function(Action action) doAction,
    required TResult Function() return_,
  }) {
    return swapContent(customui);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? swapContent,
    TResult? Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult? Function(Action action)? doAction,
    TResult? Function()? return_,
  }) {
    return swapContent?.call(customui);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? swapContent,
    TResult Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult Function(Action action)? doAction,
    TResult Function()? return_,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(customui);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SwapContent value) swapContent,
    required TResult Function(EventResult_FeedUpdate value) feedUpdate,
    required TResult Function(EventResult_DoAction value) doAction,
    required TResult Function(EventResult_Return value) return_,
  }) {
    return swapContent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SwapContent value)? swapContent,
    TResult? Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult? Function(EventResult_DoAction value)? doAction,
    TResult? Function(EventResult_Return value)? return_,
  }) {
    return swapContent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SwapContent value)? swapContent,
    TResult Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult Function(EventResult_DoAction value)? doAction,
    TResult Function(EventResult_Return value)? return_,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(this);
    }
    return orElse();
  }
}

abstract class EventResult_SwapContent extends EventResult {
  const factory EventResult_SwapContent({required final CustomUI customui}) =
      _$EventResult_SwapContentImpl;
  const EventResult_SwapContent._() : super._();

  CustomUI get customui;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventResult_SwapContentImplCopyWith<_$EventResult_SwapContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventResult_FeedUpdateImplCopyWith<$Res> {
  factory _$$EventResult_FeedUpdateImplCopyWith(
          _$EventResult_FeedUpdateImpl value,
          $Res Function(_$EventResult_FeedUpdateImpl) then) =
      __$$EventResult_FeedUpdateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomUI> customui, bool? hasnext, int? length});
}

/// @nodoc
class __$$EventResult_FeedUpdateImplCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$EventResult_FeedUpdateImpl>
    implements _$$EventResult_FeedUpdateImplCopyWith<$Res> {
  __$$EventResult_FeedUpdateImplCopyWithImpl(
      _$EventResult_FeedUpdateImpl _value,
      $Res Function(_$EventResult_FeedUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customui = null,
    Object? hasnext = freezed,
    Object? length = freezed,
  }) {
    return _then(_$EventResult_FeedUpdateImpl(
      customui: null == customui
          ? _value._customui
          : customui // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      hasnext: freezed == hasnext
          ? _value.hasnext
          : hasnext // ignore: cast_nullable_to_non_nullable
              as bool?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$EventResult_FeedUpdateImpl extends EventResult_FeedUpdate {
  const _$EventResult_FeedUpdateImpl(
      {required final List<CustomUI> customui, this.hasnext, this.length})
      : _customui = customui,
        super._();

  final List<CustomUI> _customui;
  @override
  List<CustomUI> get customui {
    if (_customui is EqualUnmodifiableListView) return _customui;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customui);
  }

  @override
  final bool? hasnext;
  @override
  final int? length;

  @override
  String toString() {
    return 'EventResult.feedUpdate(customui: $customui, hasnext: $hasnext, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventResult_FeedUpdateImpl &&
            const DeepCollectionEquality().equals(other._customui, _customui) &&
            (identical(other.hasnext, hasnext) || other.hasnext == hasnext) &&
            (identical(other.length, length) || other.length == length));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_customui), hasnext, length);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventResult_FeedUpdateImplCopyWith<_$EventResult_FeedUpdateImpl>
      get copyWith => __$$EventResult_FeedUpdateImplCopyWithImpl<
          _$EventResult_FeedUpdateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) swapContent,
    required TResult Function(
            List<CustomUI> customui, bool? hasnext, int? length)
        feedUpdate,
    required TResult Function(Action action) doAction,
    required TResult Function() return_,
  }) {
    return feedUpdate(customui, hasnext, length);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? swapContent,
    TResult? Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult? Function(Action action)? doAction,
    TResult? Function()? return_,
  }) {
    return feedUpdate?.call(customui, hasnext, length);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? swapContent,
    TResult Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult Function(Action action)? doAction,
    TResult Function()? return_,
    required TResult orElse(),
  }) {
    if (feedUpdate != null) {
      return feedUpdate(customui, hasnext, length);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SwapContent value) swapContent,
    required TResult Function(EventResult_FeedUpdate value) feedUpdate,
    required TResult Function(EventResult_DoAction value) doAction,
    required TResult Function(EventResult_Return value) return_,
  }) {
    return feedUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SwapContent value)? swapContent,
    TResult? Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult? Function(EventResult_DoAction value)? doAction,
    TResult? Function(EventResult_Return value)? return_,
  }) {
    return feedUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SwapContent value)? swapContent,
    TResult Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult Function(EventResult_DoAction value)? doAction,
    TResult Function(EventResult_Return value)? return_,
    required TResult orElse(),
  }) {
    if (feedUpdate != null) {
      return feedUpdate(this);
    }
    return orElse();
  }
}

abstract class EventResult_FeedUpdate extends EventResult {
  const factory EventResult_FeedUpdate(
      {required final List<CustomUI> customui,
      final bool? hasnext,
      final int? length}) = _$EventResult_FeedUpdateImpl;
  const EventResult_FeedUpdate._() : super._();

  List<CustomUI> get customui;
  bool? get hasnext;
  int? get length;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventResult_FeedUpdateImplCopyWith<_$EventResult_FeedUpdateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventResult_DoActionImplCopyWith<$Res> {
  factory _$$EventResult_DoActionImplCopyWith(_$EventResult_DoActionImpl value,
          $Res Function(_$EventResult_DoActionImpl) then) =
      __$$EventResult_DoActionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Action action});

  $ActionCopyWith<$Res> get action;
}

/// @nodoc
class __$$EventResult_DoActionImplCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$EventResult_DoActionImpl>
    implements _$$EventResult_DoActionImplCopyWith<$Res> {
  __$$EventResult_DoActionImplCopyWithImpl(_$EventResult_DoActionImpl _value,
      $Res Function(_$EventResult_DoActionImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
  }) {
    return _then(_$EventResult_DoActionImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as Action,
    ));
  }

  /// Create a copy of EventResult
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

class _$EventResult_DoActionImpl extends EventResult_DoAction {
  const _$EventResult_DoActionImpl({required this.action}) : super._();

  @override
  final Action action;

  @override
  String toString() {
    return 'EventResult.doAction(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventResult_DoActionImpl &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, action);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventResult_DoActionImplCopyWith<_$EventResult_DoActionImpl>
      get copyWith =>
          __$$EventResult_DoActionImplCopyWithImpl<_$EventResult_DoActionImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) swapContent,
    required TResult Function(
            List<CustomUI> customui, bool? hasnext, int? length)
        feedUpdate,
    required TResult Function(Action action) doAction,
    required TResult Function() return_,
  }) {
    return doAction(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? swapContent,
    TResult? Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult? Function(Action action)? doAction,
    TResult? Function()? return_,
  }) {
    return doAction?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? swapContent,
    TResult Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult Function(Action action)? doAction,
    TResult Function()? return_,
    required TResult orElse(),
  }) {
    if (doAction != null) {
      return doAction(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SwapContent value) swapContent,
    required TResult Function(EventResult_FeedUpdate value) feedUpdate,
    required TResult Function(EventResult_DoAction value) doAction,
    required TResult Function(EventResult_Return value) return_,
  }) {
    return doAction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SwapContent value)? swapContent,
    TResult? Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult? Function(EventResult_DoAction value)? doAction,
    TResult? Function(EventResult_Return value)? return_,
  }) {
    return doAction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SwapContent value)? swapContent,
    TResult Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult Function(EventResult_DoAction value)? doAction,
    TResult Function(EventResult_Return value)? return_,
    required TResult orElse(),
  }) {
    if (doAction != null) {
      return doAction(this);
    }
    return orElse();
  }
}

abstract class EventResult_DoAction extends EventResult {
  const factory EventResult_DoAction({required final Action action}) =
      _$EventResult_DoActionImpl;
  const EventResult_DoAction._() : super._();

  Action get action;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventResult_DoActionImplCopyWith<_$EventResult_DoActionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventResult_ReturnImplCopyWith<$Res> {
  factory _$$EventResult_ReturnImplCopyWith(_$EventResult_ReturnImpl value,
          $Res Function(_$EventResult_ReturnImpl) then) =
      __$$EventResult_ReturnImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EventResult_ReturnImplCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$EventResult_ReturnImpl>
    implements _$$EventResult_ReturnImplCopyWith<$Res> {
  __$$EventResult_ReturnImplCopyWithImpl(_$EventResult_ReturnImpl _value,
      $Res Function(_$EventResult_ReturnImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EventResult_ReturnImpl extends EventResult_Return {
  const _$EventResult_ReturnImpl() : super._();

  @override
  String toString() {
    return 'EventResult.return_()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EventResult_ReturnImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) swapContent,
    required TResult Function(
            List<CustomUI> customui, bool? hasnext, int? length)
        feedUpdate,
    required TResult Function(Action action) doAction,
    required TResult Function() return_,
  }) {
    return return_();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? swapContent,
    TResult? Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult? Function(Action action)? doAction,
    TResult? Function()? return_,
  }) {
    return return_?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? swapContent,
    TResult Function(List<CustomUI> customui, bool? hasnext, int? length)?
        feedUpdate,
    TResult Function(Action action)? doAction,
    TResult Function()? return_,
    required TResult orElse(),
  }) {
    if (return_ != null) {
      return return_();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SwapContent value) swapContent,
    required TResult Function(EventResult_FeedUpdate value) feedUpdate,
    required TResult Function(EventResult_DoAction value) doAction,
    required TResult Function(EventResult_Return value) return_,
  }) {
    return return_(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SwapContent value)? swapContent,
    TResult? Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult? Function(EventResult_DoAction value)? doAction,
    TResult? Function(EventResult_Return value)? return_,
  }) {
    return return_?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SwapContent value)? swapContent,
    TResult Function(EventResult_FeedUpdate value)? feedUpdate,
    TResult Function(EventResult_DoAction value)? doAction,
    TResult Function(EventResult_Return value)? return_,
    required TResult orElse(),
  }) {
    if (return_ != null) {
      return return_(this);
    }
    return orElse();
  }
}

abstract class EventResult_Return extends EventResult {
  const factory EventResult_Return() = _$EventResult_ReturnImpl;
  const EventResult_Return._() : super._();
}

/// @nodoc
mixin _$UIAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Action action) action,
    required TResult Function(
            String targetid, String event, String data, CustomUI? placeholder)
        swapContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Action action)? action,
    TResult? Function(
            String targetid, String event, String data, CustomUI? placeholder)?
        swapContent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Action action)? action,
    TResult Function(
            String targetid, String event, String data, CustomUI? placeholder)?
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

class _$UIAction_ActionImpl extends UIAction_Action {
  const _$UIAction_ActionImpl({required this.action}) : super._();

  @override
  final Action action;

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
            String targetid, String event, String data, CustomUI? placeholder)
        swapContent,
  }) {
    return action(this.action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Action action)? action,
    TResult? Function(
            String targetid, String event, String data, CustomUI? placeholder)?
        swapContent,
  }) {
    return action?.call(this.action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Action action)? action,
    TResult Function(
            String targetid, String event, String data, CustomUI? placeholder)?
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
}

abstract class UIAction_Action extends UIAction {
  const factory UIAction_Action({required final Action action}) =
      _$UIAction_ActionImpl;
  const UIAction_Action._() : super._();

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
  $Res call(
      {String targetid, String event, String data, CustomUI? placeholder});

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
    Object? targetid = null,
    Object? event = null,
    Object? data = null,
    Object? placeholder = freezed,
  }) {
    return _then(_$UIAction_SwapContentImpl(
      targetid: null == targetid
          ? _value.targetid
          : targetid // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
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

class _$UIAction_SwapContentImpl extends UIAction_SwapContent {
  const _$UIAction_SwapContentImpl(
      {required this.targetid,
      required this.event,
      required this.data,
      this.placeholder})
      : super._();

  @override
  final String targetid;
  @override
  final String event;
  @override
  final String data;
  @override
  final CustomUI? placeholder;

  @override
  String toString() {
    return 'UIAction.swapContent(targetid: $targetid, event: $event, data: $data, placeholder: $placeholder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIAction_SwapContentImpl &&
            (identical(other.targetid, targetid) ||
                other.targetid == targetid) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, targetid, event, data, placeholder);

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
            String targetid, String event, String data, CustomUI? placeholder)
        swapContent,
  }) {
    return swapContent(targetid, event, data, placeholder);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Action action)? action,
    TResult? Function(
            String targetid, String event, String data, CustomUI? placeholder)?
        swapContent,
  }) {
    return swapContent?.call(targetid, event, data, placeholder);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Action action)? action,
    TResult Function(
            String targetid, String event, String data, CustomUI? placeholder)?
        swapContent,
    required TResult orElse(),
  }) {
    if (swapContent != null) {
      return swapContent(targetid, event, data, placeholder);
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
}

abstract class UIAction_SwapContent extends UIAction {
  const factory UIAction_SwapContent(
      {required final String targetid,
      required final String event,
      required final String data,
      final CustomUI? placeholder}) = _$UIAction_SwapContentImpl;
  const UIAction_SwapContent._() : super._();

  String get targetid;
  String get event;
  String get data;
  CustomUI? get placeholder;

  /// Create a copy of UIAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UIAction_SwapContentImplCopyWith<_$UIAction_SwapContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}
