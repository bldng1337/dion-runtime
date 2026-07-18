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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function()? popView,
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
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
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
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
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
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
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
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
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
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
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
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
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
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
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
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
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
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
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
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
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
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
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
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
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
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
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
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
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
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
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
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
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
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
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
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
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
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
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
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
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
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
abstract class _$$Action_ShowToastImplCopyWith<$Res> {
  factory _$$Action_ShowToastImplCopyWith(_$Action_ShowToastImpl value,
          $Res Function(_$Action_ShowToastImpl) then) =
      __$$Action_ShowToastImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, ToastKind kind});
}

/// @nodoc
class __$$Action_ShowToastImplCopyWithImpl<$Res>
    extends _$ActionCopyWithImpl<$Res, _$Action_ShowToastImpl>
    implements _$$Action_ShowToastImplCopyWith<$Res> {
  __$$Action_ShowToastImplCopyWithImpl(_$Action_ShowToastImpl _value,
      $Res Function(_$Action_ShowToastImpl) _then)
      : super(_value, _then);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? kind = null,
  }) {
    return _then(_$Action_ShowToastImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as ToastKind,
    ));
  }
}

/// @nodoc

class _$Action_ShowToastImpl extends Action_ShowToast {
  const _$Action_ShowToastImpl({required this.message, required this.kind})
      : super._();

  @override
  final String message;
  @override
  final ToastKind kind;

  @override
  String toString() {
    return 'Action.showToast(message: $message, kind: $kind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Action_ShowToastImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, kind);

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Action_ShowToastImplCopyWith<_$Action_ShowToastImpl> get copyWith =>
      __$$Action_ShowToastImplCopyWithImpl<_$Action_ShowToastImpl>(
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
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
  }) {
    return showToast(message, kind);
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
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
  }) {
    return showToast?.call(message, kind);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function()? popView,
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
    required TResult orElse(),
  }) {
    if (showToast != null) {
      return showToast(message, kind);
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
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
  }) {
    return showToast(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
  }) {
    return showToast?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
    required TResult orElse(),
  }) {
    if (showToast != null) {
      return showToast(this);
    }
    return orElse();
  }
}

abstract class Action_ShowToast extends Action {
  const factory Action_ShowToast(
      {required final String message,
      required final ToastKind kind}) = _$Action_ShowToastImpl;
  const Action_ShowToast._() : super._();

  String get message;
  ToastKind get kind;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Action_ShowToastImplCopyWith<_$Action_ShowToastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventData {
  String get handler => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String handler, String staticData, Map<String, String?> values)
        loadSlot,
    required TResult Function(String handler, String data, int page) loadPage,
    required TResult Function(String handler, String payload) invoke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult? Function(String handler, String data, int page)? loadPage,
    TResult? Function(String handler, String payload)? invoke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult Function(String handler, String data, int page)? loadPage,
    TResult Function(String handler, String payload)? invoke,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_LoadSlot value) loadSlot,
    required TResult Function(EventData_LoadPage value) loadPage,
    required TResult Function(EventData_Invoke value) invoke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_LoadSlot value)? loadSlot,
    TResult? Function(EventData_LoadPage value)? loadPage,
    TResult? Function(EventData_Invoke value)? invoke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_LoadSlot value)? loadSlot,
    TResult Function(EventData_LoadPage value)? loadPage,
    TResult Function(EventData_Invoke value)? invoke,
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
  $Res call({String handler});
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
    Object? handler = null,
  }) {
    return _then(_value.copyWith(
      handler: null == handler
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventData_LoadSlotImplCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory _$$EventData_LoadSlotImplCopyWith(_$EventData_LoadSlotImpl value,
          $Res Function(_$EventData_LoadSlotImpl) then) =
      __$$EventData_LoadSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String handler, String staticData, Map<String, String?> values});
}

/// @nodoc
class __$$EventData_LoadSlotImplCopyWithImpl<$Res>
    extends _$EventDataCopyWithImpl<$Res, _$EventData_LoadSlotImpl>
    implements _$$EventData_LoadSlotImplCopyWith<$Res> {
  __$$EventData_LoadSlotImplCopyWithImpl(_$EventData_LoadSlotImpl _value,
      $Res Function(_$EventData_LoadSlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handler = null,
    Object? staticData = null,
    Object? values = null,
  }) {
    return _then(_$EventData_LoadSlotImpl(
      handler: null == handler
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      staticData: null == staticData
          ? _value.staticData
          : staticData // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc

class _$EventData_LoadSlotImpl extends EventData_LoadSlot {
  const _$EventData_LoadSlotImpl(
      {required this.handler,
      required this.staticData,
      required final Map<String, String?> values})
      : _values = values,
        super._();

  @override
  final String handler;
  @override
  final String staticData;
  final Map<String, String?> _values;
  @override
  Map<String, String?> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  @override
  String toString() {
    return 'EventData.loadSlot(handler: $handler, staticData: $staticData, values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventData_LoadSlotImpl &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.staticData, staticData) ||
                other.staticData == staticData) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, staticData,
      const DeepCollectionEquality().hash(_values));

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventData_LoadSlotImplCopyWith<_$EventData_LoadSlotImpl> get copyWith =>
      __$$EventData_LoadSlotImplCopyWithImpl<_$EventData_LoadSlotImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String handler, String staticData, Map<String, String?> values)
        loadSlot,
    required TResult Function(String handler, String data, int page) loadPage,
    required TResult Function(String handler, String payload) invoke,
  }) {
    return loadSlot(handler, staticData, values);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult? Function(String handler, String data, int page)? loadPage,
    TResult? Function(String handler, String payload)? invoke,
  }) {
    return loadSlot?.call(handler, staticData, values);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult Function(String handler, String data, int page)? loadPage,
    TResult Function(String handler, String payload)? invoke,
    required TResult orElse(),
  }) {
    if (loadSlot != null) {
      return loadSlot(handler, staticData, values);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_LoadSlot value) loadSlot,
    required TResult Function(EventData_LoadPage value) loadPage,
    required TResult Function(EventData_Invoke value) invoke,
  }) {
    return loadSlot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_LoadSlot value)? loadSlot,
    TResult? Function(EventData_LoadPage value)? loadPage,
    TResult? Function(EventData_Invoke value)? invoke,
  }) {
    return loadSlot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_LoadSlot value)? loadSlot,
    TResult Function(EventData_LoadPage value)? loadPage,
    TResult Function(EventData_Invoke value)? invoke,
    required TResult orElse(),
  }) {
    if (loadSlot != null) {
      return loadSlot(this);
    }
    return orElse();
  }
}

abstract class EventData_LoadSlot extends EventData {
  const factory EventData_LoadSlot(
      {required final String handler,
      required final String staticData,
      required final Map<String, String?> values}) = _$EventData_LoadSlotImpl;
  const EventData_LoadSlot._() : super._();

  @override
  String get handler;
  String get staticData;
  Map<String, String?> get values;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventData_LoadSlotImplCopyWith<_$EventData_LoadSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventData_LoadPageImplCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory _$$EventData_LoadPageImplCopyWith(_$EventData_LoadPageImpl value,
          $Res Function(_$EventData_LoadPageImpl) then) =
      __$$EventData_LoadPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String handler, String data, int page});
}

/// @nodoc
class __$$EventData_LoadPageImplCopyWithImpl<$Res>
    extends _$EventDataCopyWithImpl<$Res, _$EventData_LoadPageImpl>
    implements _$$EventData_LoadPageImplCopyWith<$Res> {
  __$$EventData_LoadPageImplCopyWithImpl(_$EventData_LoadPageImpl _value,
      $Res Function(_$EventData_LoadPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handler = null,
    Object? data = null,
    Object? page = null,
  }) {
    return _then(_$EventData_LoadPageImpl(
      handler: null == handler
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
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

class _$EventData_LoadPageImpl extends EventData_LoadPage {
  const _$EventData_LoadPageImpl(
      {required this.handler, required this.data, required this.page})
      : super._();

  @override
  final String handler;
  @override
  final String data;
  @override
  final int page;

  @override
  String toString() {
    return 'EventData.loadPage(handler: $handler, data: $data, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventData_LoadPageImpl &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, data, page);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventData_LoadPageImplCopyWith<_$EventData_LoadPageImpl> get copyWith =>
      __$$EventData_LoadPageImplCopyWithImpl<_$EventData_LoadPageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String handler, String staticData, Map<String, String?> values)
        loadSlot,
    required TResult Function(String handler, String data, int page) loadPage,
    required TResult Function(String handler, String payload) invoke,
  }) {
    return loadPage(handler, data, page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult? Function(String handler, String data, int page)? loadPage,
    TResult? Function(String handler, String payload)? invoke,
  }) {
    return loadPage?.call(handler, data, page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult Function(String handler, String data, int page)? loadPage,
    TResult Function(String handler, String payload)? invoke,
    required TResult orElse(),
  }) {
    if (loadPage != null) {
      return loadPage(handler, data, page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_LoadSlot value) loadSlot,
    required TResult Function(EventData_LoadPage value) loadPage,
    required TResult Function(EventData_Invoke value) invoke,
  }) {
    return loadPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_LoadSlot value)? loadSlot,
    TResult? Function(EventData_LoadPage value)? loadPage,
    TResult? Function(EventData_Invoke value)? invoke,
  }) {
    return loadPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_LoadSlot value)? loadSlot,
    TResult Function(EventData_LoadPage value)? loadPage,
    TResult Function(EventData_Invoke value)? invoke,
    required TResult orElse(),
  }) {
    if (loadPage != null) {
      return loadPage(this);
    }
    return orElse();
  }
}

abstract class EventData_LoadPage extends EventData {
  const factory EventData_LoadPage(
      {required final String handler,
      required final String data,
      required final int page}) = _$EventData_LoadPageImpl;
  const EventData_LoadPage._() : super._();

  @override
  String get handler;
  String get data;
  int get page;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventData_LoadPageImplCopyWith<_$EventData_LoadPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventData_InvokeImplCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory _$$EventData_InvokeImplCopyWith(_$EventData_InvokeImpl value,
          $Res Function(_$EventData_InvokeImpl) then) =
      __$$EventData_InvokeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String handler, String payload});
}

/// @nodoc
class __$$EventData_InvokeImplCopyWithImpl<$Res>
    extends _$EventDataCopyWithImpl<$Res, _$EventData_InvokeImpl>
    implements _$$EventData_InvokeImplCopyWith<$Res> {
  __$$EventData_InvokeImplCopyWithImpl(_$EventData_InvokeImpl _value,
      $Res Function(_$EventData_InvokeImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handler = null,
    Object? payload = null,
  }) {
    return _then(_$EventData_InvokeImpl(
      handler: null == handler
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EventData_InvokeImpl extends EventData_Invoke {
  const _$EventData_InvokeImpl({required this.handler, required this.payload})
      : super._();

  @override
  final String handler;
  @override
  final String payload;

  @override
  String toString() {
    return 'EventData.invoke(handler: $handler, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventData_InvokeImpl &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, payload);

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventData_InvokeImplCopyWith<_$EventData_InvokeImpl> get copyWith =>
      __$$EventData_InvokeImplCopyWithImpl<_$EventData_InvokeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String handler, String staticData, Map<String, String?> values)
        loadSlot,
    required TResult Function(String handler, String data, int page) loadPage,
    required TResult Function(String handler, String payload) invoke,
  }) {
    return invoke(handler, payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult? Function(String handler, String data, int page)? loadPage,
    TResult? Function(String handler, String payload)? invoke,
  }) {
    return invoke?.call(handler, payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String handler, String staticData, Map<String, String?> values)?
        loadSlot,
    TResult Function(String handler, String data, int page)? loadPage,
    TResult Function(String handler, String payload)? invoke,
    required TResult orElse(),
  }) {
    if (invoke != null) {
      return invoke(handler, payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventData_LoadSlot value) loadSlot,
    required TResult Function(EventData_LoadPage value) loadPage,
    required TResult Function(EventData_Invoke value) invoke,
  }) {
    return invoke(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventData_LoadSlot value)? loadSlot,
    TResult? Function(EventData_LoadPage value)? loadPage,
    TResult? Function(EventData_Invoke value)? invoke,
  }) {
    return invoke?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventData_LoadSlot value)? loadSlot,
    TResult Function(EventData_LoadPage value)? loadPage,
    TResult Function(EventData_Invoke value)? invoke,
    required TResult orElse(),
  }) {
    if (invoke != null) {
      return invoke(this);
    }
    return orElse();
  }
}

abstract class EventData_Invoke extends EventData {
  const factory EventData_Invoke(
      {required final String handler,
      required final String payload}) = _$EventData_InvokeImpl;
  const EventData_Invoke._() : super._();

  @override
  String get handler;
  String get payload;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventData_InvokeImplCopyWith<_$EventData_InvokeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) slotContent,
    required TResult Function(List<CustomUI> items, bool hasMore) feedPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? slotContent,
    TResult? Function(List<CustomUI> items, bool hasMore)? feedPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? slotContent,
    TResult Function(List<CustomUI> items, bool hasMore)? feedPage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SlotContent value) slotContent,
    required TResult Function(EventResult_FeedPage value) feedPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SlotContent value)? slotContent,
    TResult? Function(EventResult_FeedPage value)? feedPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SlotContent value)? slotContent,
    TResult Function(EventResult_FeedPage value)? feedPage,
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
abstract class _$$EventResult_SlotContentImplCopyWith<$Res> {
  factory _$$EventResult_SlotContentImplCopyWith(
          _$EventResult_SlotContentImpl value,
          $Res Function(_$EventResult_SlotContentImpl) then) =
      __$$EventResult_SlotContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CustomUI customui});

  $CustomUICopyWith<$Res> get customui;
}

/// @nodoc
class __$$EventResult_SlotContentImplCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$EventResult_SlotContentImpl>
    implements _$$EventResult_SlotContentImplCopyWith<$Res> {
  __$$EventResult_SlotContentImplCopyWithImpl(
      _$EventResult_SlotContentImpl _value,
      $Res Function(_$EventResult_SlotContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customui = null,
  }) {
    return _then(_$EventResult_SlotContentImpl(
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

class _$EventResult_SlotContentImpl extends EventResult_SlotContent {
  const _$EventResult_SlotContentImpl({required this.customui}) : super._();

  @override
  final CustomUI customui;

  @override
  String toString() {
    return 'EventResult.slotContent(customui: $customui)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventResult_SlotContentImpl &&
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
  _$$EventResult_SlotContentImplCopyWith<_$EventResult_SlotContentImpl>
      get copyWith => __$$EventResult_SlotContentImplCopyWithImpl<
          _$EventResult_SlotContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) slotContent,
    required TResult Function(List<CustomUI> items, bool hasMore) feedPage,
  }) {
    return slotContent(customui);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? slotContent,
    TResult? Function(List<CustomUI> items, bool hasMore)? feedPage,
  }) {
    return slotContent?.call(customui);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? slotContent,
    TResult Function(List<CustomUI> items, bool hasMore)? feedPage,
    required TResult orElse(),
  }) {
    if (slotContent != null) {
      return slotContent(customui);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SlotContent value) slotContent,
    required TResult Function(EventResult_FeedPage value) feedPage,
  }) {
    return slotContent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SlotContent value)? slotContent,
    TResult? Function(EventResult_FeedPage value)? feedPage,
  }) {
    return slotContent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SlotContent value)? slotContent,
    TResult Function(EventResult_FeedPage value)? feedPage,
    required TResult orElse(),
  }) {
    if (slotContent != null) {
      return slotContent(this);
    }
    return orElse();
  }
}

abstract class EventResult_SlotContent extends EventResult {
  const factory EventResult_SlotContent({required final CustomUI customui}) =
      _$EventResult_SlotContentImpl;
  const EventResult_SlotContent._() : super._();

  CustomUI get customui;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventResult_SlotContentImplCopyWith<_$EventResult_SlotContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EventResult_FeedPageImplCopyWith<$Res> {
  factory _$$EventResult_FeedPageImplCopyWith(_$EventResult_FeedPageImpl value,
          $Res Function(_$EventResult_FeedPageImpl) then) =
      __$$EventResult_FeedPageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomUI> items, bool hasMore});
}

/// @nodoc
class __$$EventResult_FeedPageImplCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$EventResult_FeedPageImpl>
    implements _$$EventResult_FeedPageImplCopyWith<$Res> {
  __$$EventResult_FeedPageImplCopyWithImpl(_$EventResult_FeedPageImpl _value,
      $Res Function(_$EventResult_FeedPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasMore = null,
  }) {
    return _then(_$EventResult_FeedPageImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EventResult_FeedPageImpl extends EventResult_FeedPage {
  const _$EventResult_FeedPageImpl(
      {required final List<CustomUI> items, required this.hasMore})
      : _items = items,
        super._();

  final List<CustomUI> _items;
  @override
  List<CustomUI> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool hasMore;

  @override
  String toString() {
    return 'EventResult.feedPage(items: $items, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventResult_FeedPageImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), hasMore);

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventResult_FeedPageImplCopyWith<_$EventResult_FeedPageImpl>
      get copyWith =>
          __$$EventResult_FeedPageImplCopyWithImpl<_$EventResult_FeedPageImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CustomUI customui) slotContent,
    required TResult Function(List<CustomUI> items, bool hasMore) feedPage,
  }) {
    return feedPage(items, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CustomUI customui)? slotContent,
    TResult? Function(List<CustomUI> items, bool hasMore)? feedPage,
  }) {
    return feedPage?.call(items, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CustomUI customui)? slotContent,
    TResult Function(List<CustomUI> items, bool hasMore)? feedPage,
    required TResult orElse(),
  }) {
    if (feedPage != null) {
      return feedPage(items, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EventResult_SlotContent value) slotContent,
    required TResult Function(EventResult_FeedPage value) feedPage,
  }) {
    return feedPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EventResult_SlotContent value)? slotContent,
    TResult? Function(EventResult_FeedPage value)? feedPage,
  }) {
    return feedPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EventResult_SlotContent value)? slotContent,
    TResult Function(EventResult_FeedPage value)? feedPage,
    required TResult orElse(),
  }) {
    if (feedPage != null) {
      return feedPage(this);
    }
    return orElse();
  }
}

abstract class EventResult_FeedPage extends EventResult {
  const factory EventResult_FeedPage(
      {required final List<CustomUI> items,
      required final bool hasMore}) = _$EventResult_FeedPageImpl;
  const EventResult_FeedPage._() : super._();

  List<CustomUI> get items;
  bool get hasMore;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventResult_FeedPageImplCopyWith<_$EventResult_FeedPageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Interaction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String handler, String payload) invoke,
    required TResult Function(String key, String value) writeKey,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String handler, String payload)? invoke,
    TResult? Function(String key, String value)? writeKey,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String handler, String payload)? invoke,
    TResult Function(String key, String value)? writeKey,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Interaction_Invoke value) invoke,
    required TResult Function(Interaction_WriteKey value) writeKey,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Interaction_Invoke value)? invoke,
    TResult? Function(Interaction_WriteKey value)? writeKey,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Interaction_Invoke value)? invoke,
    TResult Function(Interaction_WriteKey value)? writeKey,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionCopyWith<$Res> {
  factory $InteractionCopyWith(
          Interaction value, $Res Function(Interaction) then) =
      _$InteractionCopyWithImpl<$Res, Interaction>;
}

/// @nodoc
class _$InteractionCopyWithImpl<$Res, $Val extends Interaction>
    implements $InteractionCopyWith<$Res> {
  _$InteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$Interaction_InvokeImplCopyWith<$Res> {
  factory _$$Interaction_InvokeImplCopyWith(_$Interaction_InvokeImpl value,
          $Res Function(_$Interaction_InvokeImpl) then) =
      __$$Interaction_InvokeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String handler, String payload});
}

/// @nodoc
class __$$Interaction_InvokeImplCopyWithImpl<$Res>
    extends _$InteractionCopyWithImpl<$Res, _$Interaction_InvokeImpl>
    implements _$$Interaction_InvokeImplCopyWith<$Res> {
  __$$Interaction_InvokeImplCopyWithImpl(_$Interaction_InvokeImpl _value,
      $Res Function(_$Interaction_InvokeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handler = null,
    Object? payload = null,
  }) {
    return _then(_$Interaction_InvokeImpl(
      handler: null == handler
          ? _value.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Interaction_InvokeImpl extends Interaction_Invoke {
  const _$Interaction_InvokeImpl({required this.handler, required this.payload})
      : super._();

  @override
  final String handler;
  @override
  final String payload;

  @override
  String toString() {
    return 'Interaction.invoke(handler: $handler, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Interaction_InvokeImpl &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, payload);

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Interaction_InvokeImplCopyWith<_$Interaction_InvokeImpl> get copyWith =>
      __$$Interaction_InvokeImplCopyWithImpl<_$Interaction_InvokeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String handler, String payload) invoke,
    required TResult Function(String key, String value) writeKey,
  }) {
    return invoke(handler, payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String handler, String payload)? invoke,
    TResult? Function(String key, String value)? writeKey,
  }) {
    return invoke?.call(handler, payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String handler, String payload)? invoke,
    TResult Function(String key, String value)? writeKey,
    required TResult orElse(),
  }) {
    if (invoke != null) {
      return invoke(handler, payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Interaction_Invoke value) invoke,
    required TResult Function(Interaction_WriteKey value) writeKey,
  }) {
    return invoke(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Interaction_Invoke value)? invoke,
    TResult? Function(Interaction_WriteKey value)? writeKey,
  }) {
    return invoke?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Interaction_Invoke value)? invoke,
    TResult Function(Interaction_WriteKey value)? writeKey,
    required TResult orElse(),
  }) {
    if (invoke != null) {
      return invoke(this);
    }
    return orElse();
  }
}

abstract class Interaction_Invoke extends Interaction {
  const factory Interaction_Invoke(
      {required final String handler,
      required final String payload}) = _$Interaction_InvokeImpl;
  const Interaction_Invoke._() : super._();

  String get handler;
  String get payload;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Interaction_InvokeImplCopyWith<_$Interaction_InvokeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Interaction_WriteKeyImplCopyWith<$Res> {
  factory _$$Interaction_WriteKeyImplCopyWith(_$Interaction_WriteKeyImpl value,
          $Res Function(_$Interaction_WriteKeyImpl) then) =
      __$$Interaction_WriteKeyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class __$$Interaction_WriteKeyImplCopyWithImpl<$Res>
    extends _$InteractionCopyWithImpl<$Res, _$Interaction_WriteKeyImpl>
    implements _$$Interaction_WriteKeyImplCopyWith<$Res> {
  __$$Interaction_WriteKeyImplCopyWithImpl(_$Interaction_WriteKeyImpl _value,
      $Res Function(_$Interaction_WriteKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(_$Interaction_WriteKeyImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Interaction_WriteKeyImpl extends Interaction_WriteKey {
  const _$Interaction_WriteKeyImpl({required this.key, required this.value})
      : super._();

  @override
  final String key;
  @override
  final String value;

  @override
  String toString() {
    return 'Interaction.writeKey(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Interaction_WriteKeyImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Interaction_WriteKeyImplCopyWith<_$Interaction_WriteKeyImpl>
      get copyWith =>
          __$$Interaction_WriteKeyImplCopyWithImpl<_$Interaction_WriteKeyImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String handler, String payload) invoke,
    required TResult Function(String key, String value) writeKey,
  }) {
    return writeKey(key, value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String handler, String payload)? invoke,
    TResult? Function(String key, String value)? writeKey,
  }) {
    return writeKey?.call(key, value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String handler, String payload)? invoke,
    TResult Function(String key, String value)? writeKey,
    required TResult orElse(),
  }) {
    if (writeKey != null) {
      return writeKey(key, value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Interaction_Invoke value) invoke,
    required TResult Function(Interaction_WriteKey value) writeKey,
  }) {
    return writeKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Interaction_Invoke value)? invoke,
    TResult? Function(Interaction_WriteKey value)? writeKey,
  }) {
    return writeKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Interaction_Invoke value)? invoke,
    TResult Function(Interaction_WriteKey value)? writeKey,
    required TResult orElse(),
  }) {
    if (writeKey != null) {
      return writeKey(this);
    }
    return orElse();
  }
}

abstract class Interaction_WriteKey extends Interaction {
  const factory Interaction_WriteKey(
      {required final String key,
      required final String value}) = _$Interaction_WriteKeyImpl;
  const Interaction_WriteKey._() : super._();

  String get key;
  String get value;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Interaction_WriteKeyImplCopyWith<_$Interaction_WriteKeyImpl>
      get copyWith => throw _privateConstructorUsedError;
}
