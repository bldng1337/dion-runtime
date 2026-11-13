// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Action {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Action);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Action()';
  }
}

/// @nodoc
class $ActionCopyWith<$Res> {
  $ActionCopyWith(Action _, $Res Function(Action) __);
}

/// Adds pattern-matching-related methods to [Action].
extension ActionPatterns on Action {
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
    TResult Function(Action_OpenBrowser value)? openBrowser,
    TResult Function(Action_Popup value)? popup,
    TResult Function(Action_Nav value)? nav,
    TResult Function(Action_PopView value)? popView,
    TResult Function(Action_NavEntry value)? navEntry,
    TResult Function(Action_ShowToast value)? showToast,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Action_OpenBrowser() when openBrowser != null:
        return openBrowser(_that);
      case Action_Popup() when popup != null:
        return popup(_that);
      case Action_Nav() when nav != null:
        return nav(_that);
      case Action_PopView() when popView != null:
        return popView(_that);
      case Action_NavEntry() when navEntry != null:
        return navEntry(_that);
      case Action_ShowToast() when showToast != null:
        return showToast(_that);
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
    required TResult Function(Action_OpenBrowser value) openBrowser,
    required TResult Function(Action_Popup value) popup,
    required TResult Function(Action_Nav value) nav,
    required TResult Function(Action_PopView value) popView,
    required TResult Function(Action_NavEntry value) navEntry,
    required TResult Function(Action_ShowToast value) showToast,
  }) {
    final _that = this;
    switch (_that) {
      case Action_OpenBrowser():
        return openBrowser(_that);
      case Action_Popup():
        return popup(_that);
      case Action_Nav():
        return nav(_that);
      case Action_PopView():
        return popView(_that);
      case Action_NavEntry():
        return navEntry(_that);
      case Action_ShowToast():
        return showToast(_that);
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
    TResult? Function(Action_OpenBrowser value)? openBrowser,
    TResult? Function(Action_Popup value)? popup,
    TResult? Function(Action_Nav value)? nav,
    TResult? Function(Action_PopView value)? popView,
    TResult? Function(Action_NavEntry value)? navEntry,
    TResult? Function(Action_ShowToast value)? showToast,
  }) {
    final _that = this;
    switch (_that) {
      case Action_OpenBrowser() when openBrowser != null:
        return openBrowser(_that);
      case Action_Popup() when popup != null:
        return popup(_that);
      case Action_Nav() when nav != null:
        return nav(_that);
      case Action_PopView() when popView != null:
        return popView(_that);
      case Action_NavEntry() when navEntry != null:
        return navEntry(_that);
      case Action_ShowToast() when showToast != null:
        return showToast(_that);
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
    TResult Function(String url)? openBrowser,
    TResult Function(String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult Function(String title, CustomUI content)? nav,
    TResult Function()? popView,
    TResult Function(EntryDetailed entry)? navEntry,
    TResult Function(String message, ToastKind kind)? showToast,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Action_OpenBrowser() when openBrowser != null:
        return openBrowser(_that.url);
      case Action_Popup() when popup != null:
        return popup(_that.title, _that.content, _that.actions);
      case Action_Nav() when nav != null:
        return nav(_that.title, _that.content);
      case Action_PopView() when popView != null:
        return popView();
      case Action_NavEntry() when navEntry != null:
        return navEntry(_that.entry);
      case Action_ShowToast() when showToast != null:
        return showToast(_that.message, _that.kind);
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
    required TResult Function(String url) openBrowser,
    required TResult Function(
            String title, CustomUI content, List<PopupAction> actions)
        popup,
    required TResult Function(String title, CustomUI content) nav,
    required TResult Function() popView,
    required TResult Function(EntryDetailed entry) navEntry,
    required TResult Function(String message, ToastKind kind) showToast,
  }) {
    final _that = this;
    switch (_that) {
      case Action_OpenBrowser():
        return openBrowser(_that.url);
      case Action_Popup():
        return popup(_that.title, _that.content, _that.actions);
      case Action_Nav():
        return nav(_that.title, _that.content);
      case Action_PopView():
        return popView();
      case Action_NavEntry():
        return navEntry(_that.entry);
      case Action_ShowToast():
        return showToast(_that.message, _that.kind);
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
    TResult? Function(String url)? openBrowser,
    TResult? Function(
            String title, CustomUI content, List<PopupAction> actions)?
        popup,
    TResult? Function(String title, CustomUI content)? nav,
    TResult? Function()? popView,
    TResult? Function(EntryDetailed entry)? navEntry,
    TResult? Function(String message, ToastKind kind)? showToast,
  }) {
    final _that = this;
    switch (_that) {
      case Action_OpenBrowser() when openBrowser != null:
        return openBrowser(_that.url);
      case Action_Popup() when popup != null:
        return popup(_that.title, _that.content, _that.actions);
      case Action_Nav() when nav != null:
        return nav(_that.title, _that.content);
      case Action_PopView() when popView != null:
        return popView();
      case Action_NavEntry() when navEntry != null:
        return navEntry(_that.entry);
      case Action_ShowToast() when showToast != null:
        return showToast(_that.message, _that.kind);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Action_OpenBrowser extends Action {
  const Action_OpenBrowser({required this.url}) : super._();

  final String url;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Action_OpenBrowserCopyWith<Action_OpenBrowser> get copyWith =>
      _$Action_OpenBrowserCopyWithImpl<Action_OpenBrowser>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Action_OpenBrowser &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @override
  String toString() {
    return 'Action.openBrowser(url: $url)';
  }
}

/// @nodoc
abstract mixin class $Action_OpenBrowserCopyWith<$Res>
    implements $ActionCopyWith<$Res> {
  factory $Action_OpenBrowserCopyWith(
          Action_OpenBrowser value, $Res Function(Action_OpenBrowser) _then) =
      _$Action_OpenBrowserCopyWithImpl;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$Action_OpenBrowserCopyWithImpl<$Res>
    implements $Action_OpenBrowserCopyWith<$Res> {
  _$Action_OpenBrowserCopyWithImpl(this._self, this._then);

  final Action_OpenBrowser _self;
  final $Res Function(Action_OpenBrowser) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
  }) {
    return _then(Action_OpenBrowser(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Action_Popup extends Action {
  const Action_Popup(
      {required this.title,
      required this.content,
      required final List<PopupAction> actions})
      : _actions = actions,
        super._();

  final String title;
  final CustomUI content;
  final List<PopupAction> _actions;
  List<PopupAction> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Action_PopupCopyWith<Action_Popup> get copyWith =>
      _$Action_PopupCopyWithImpl<Action_Popup>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Action_Popup &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content,
      const DeepCollectionEquality().hash(_actions));

  @override
  String toString() {
    return 'Action.popup(title: $title, content: $content, actions: $actions)';
  }
}

/// @nodoc
abstract mixin class $Action_PopupCopyWith<$Res>
    implements $ActionCopyWith<$Res> {
  factory $Action_PopupCopyWith(
          Action_Popup value, $Res Function(Action_Popup) _then) =
      _$Action_PopupCopyWithImpl;
  @useResult
  $Res call({String title, CustomUI content, List<PopupAction> actions});

  $CustomUICopyWith<$Res> get content;
}

/// @nodoc
class _$Action_PopupCopyWithImpl<$Res> implements $Action_PopupCopyWith<$Res> {
  _$Action_PopupCopyWithImpl(this._self, this._then);

  final Action_Popup _self;
  final $Res Function(Action_Popup) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? actions = null,
  }) {
    return _then(Action_Popup(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as CustomUI,
      actions: null == actions
          ? _self._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<PopupAction>,
    ));
  }

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get content {
    return $CustomUICopyWith<$Res>(_self.content, (value) {
      return _then(_self.copyWith(content: value));
    });
  }
}

/// @nodoc

class Action_Nav extends Action {
  const Action_Nav({required this.title, required this.content}) : super._();

  final String title;
  final CustomUI content;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Action_NavCopyWith<Action_Nav> get copyWith =>
      _$Action_NavCopyWithImpl<Action_Nav>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Action_Nav &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content);

  @override
  String toString() {
    return 'Action.nav(title: $title, content: $content)';
  }
}

/// @nodoc
abstract mixin class $Action_NavCopyWith<$Res>
    implements $ActionCopyWith<$Res> {
  factory $Action_NavCopyWith(
          Action_Nav value, $Res Function(Action_Nav) _then) =
      _$Action_NavCopyWithImpl;
  @useResult
  $Res call({String title, CustomUI content});

  $CustomUICopyWith<$Res> get content;
}

/// @nodoc
class _$Action_NavCopyWithImpl<$Res> implements $Action_NavCopyWith<$Res> {
  _$Action_NavCopyWithImpl(this._self, this._then);

  final Action_Nav _self;
  final $Res Function(Action_Nav) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? content = null,
  }) {
    return _then(Action_Nav(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get content {
    return $CustomUICopyWith<$Res>(_self.content, (value) {
      return _then(_self.copyWith(content: value));
    });
  }
}

/// @nodoc

class Action_PopView extends Action {
  const Action_PopView() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Action_PopView);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Action.popView()';
  }
}

/// @nodoc

class Action_NavEntry extends Action {
  const Action_NavEntry({required this.entry}) : super._();

  final EntryDetailed entry;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Action_NavEntryCopyWith<Action_NavEntry> get copyWith =>
      _$Action_NavEntryCopyWithImpl<Action_NavEntry>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Action_NavEntry &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry);

  @override
  String toString() {
    return 'Action.navEntry(entry: $entry)';
  }
}

/// @nodoc
abstract mixin class $Action_NavEntryCopyWith<$Res>
    implements $ActionCopyWith<$Res> {
  factory $Action_NavEntryCopyWith(
          Action_NavEntry value, $Res Function(Action_NavEntry) _then) =
      _$Action_NavEntryCopyWithImpl;
  @useResult
  $Res call({EntryDetailed entry});
}

/// @nodoc
class _$Action_NavEntryCopyWithImpl<$Res>
    implements $Action_NavEntryCopyWith<$Res> {
  _$Action_NavEntryCopyWithImpl(this._self, this._then);

  final Action_NavEntry _self;
  final $Res Function(Action_NavEntry) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? entry = null,
  }) {
    return _then(Action_NavEntry(
      entry: null == entry
          ? _self.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as EntryDetailed,
    ));
  }
}

/// @nodoc

class Action_ShowToast extends Action {
  const Action_ShowToast({required this.message, required this.kind})
      : super._();

  final String message;
  final ToastKind kind;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Action_ShowToastCopyWith<Action_ShowToast> get copyWith =>
      _$Action_ShowToastCopyWithImpl<Action_ShowToast>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Action_ShowToast &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.kind, kind) || other.kind == kind));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, kind);

  @override
  String toString() {
    return 'Action.showToast(message: $message, kind: $kind)';
  }
}

/// @nodoc
abstract mixin class $Action_ShowToastCopyWith<$Res>
    implements $ActionCopyWith<$Res> {
  factory $Action_ShowToastCopyWith(
          Action_ShowToast value, $Res Function(Action_ShowToast) _then) =
      _$Action_ShowToastCopyWithImpl;
  @useResult
  $Res call({String message, ToastKind kind});
}

/// @nodoc
class _$Action_ShowToastCopyWithImpl<$Res>
    implements $Action_ShowToastCopyWith<$Res> {
  _$Action_ShowToastCopyWithImpl(this._self, this._then);

  final Action_ShowToast _self;
  final $Res Function(Action_ShowToast) _then;

  /// Create a copy of Action
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? kind = null,
  }) {
    return _then(Action_ShowToast(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as ToastKind,
    ));
  }
}

/// @nodoc
mixin _$EventData {
  String get handler;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventDataCopyWith<EventData> get copyWith =>
      _$EventDataCopyWithImpl<EventData>(this as EventData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EventData &&
            (identical(other.handler, handler) || other.handler == handler));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler);

  @override
  String toString() {
    return 'EventData(handler: $handler)';
  }
}

/// @nodoc
abstract mixin class $EventDataCopyWith<$Res> {
  factory $EventDataCopyWith(EventData value, $Res Function(EventData) _then) =
      _$EventDataCopyWithImpl;
  @useResult
  $Res call({String handler});
}

/// @nodoc
class _$EventDataCopyWithImpl<$Res> implements $EventDataCopyWith<$Res> {
  _$EventDataCopyWithImpl(this._self, this._then);

  final EventData _self;
  final $Res Function(EventData) _then;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? handler = null,
  }) {
    return _then(_self.copyWith(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [EventData].
extension EventDataPatterns on EventData {
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
    TResult Function(EventData_LoadSlot value)? loadSlot,
    TResult Function(EventData_LoadPage value)? loadPage,
    TResult Function(EventData_Invoke value)? invoke,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EventData_LoadSlot() when loadSlot != null:
        return loadSlot(_that);
      case EventData_LoadPage() when loadPage != null:
        return loadPage(_that);
      case EventData_Invoke() when invoke != null:
        return invoke(_that);
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
    required TResult Function(EventData_LoadSlot value) loadSlot,
    required TResult Function(EventData_LoadPage value) loadPage,
    required TResult Function(EventData_Invoke value) invoke,
  }) {
    final _that = this;
    switch (_that) {
      case EventData_LoadSlot():
        return loadSlot(_that);
      case EventData_LoadPage():
        return loadPage(_that);
      case EventData_Invoke():
        return invoke(_that);
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
    TResult? Function(EventData_LoadSlot value)? loadSlot,
    TResult? Function(EventData_LoadPage value)? loadPage,
    TResult? Function(EventData_Invoke value)? invoke,
  }) {
    final _that = this;
    switch (_that) {
      case EventData_LoadSlot() when loadSlot != null:
        return loadSlot(_that);
      case EventData_LoadPage() when loadPage != null:
        return loadPage(_that);
      case EventData_Invoke() when invoke != null:
        return invoke(_that);
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
    TResult Function(
            String handler, String staticData, Map<String, SlotValue> values)?
        loadSlot,
    TResult Function(String handler, String data, int page)? loadPage,
    TResult Function(String handler, String payload)? invoke,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EventData_LoadSlot() when loadSlot != null:
        return loadSlot(_that.handler, _that.staticData, _that.values);
      case EventData_LoadPage() when loadPage != null:
        return loadPage(_that.handler, _that.data, _that.page);
      case EventData_Invoke() when invoke != null:
        return invoke(_that.handler, _that.payload);
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
    required TResult Function(
            String handler, String staticData, Map<String, SlotValue> values)
        loadSlot,
    required TResult Function(String handler, String data, int page) loadPage,
    required TResult Function(String handler, String payload) invoke,
  }) {
    final _that = this;
    switch (_that) {
      case EventData_LoadSlot():
        return loadSlot(_that.handler, _that.staticData, _that.values);
      case EventData_LoadPage():
        return loadPage(_that.handler, _that.data, _that.page);
      case EventData_Invoke():
        return invoke(_that.handler, _that.payload);
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
    TResult? Function(
            String handler, String staticData, Map<String, SlotValue> values)?
        loadSlot,
    TResult? Function(String handler, String data, int page)? loadPage,
    TResult? Function(String handler, String payload)? invoke,
  }) {
    final _that = this;
    switch (_that) {
      case EventData_LoadSlot() when loadSlot != null:
        return loadSlot(_that.handler, _that.staticData, _that.values);
      case EventData_LoadPage() when loadPage != null:
        return loadPage(_that.handler, _that.data, _that.page);
      case EventData_Invoke() when invoke != null:
        return invoke(_that.handler, _that.payload);
      case _:
        return null;
    }
  }
}

/// @nodoc

class EventData_LoadSlot extends EventData {
  const EventData_LoadSlot(
      {required this.handler,
      required this.staticData,
      required final Map<String, SlotValue> values})
      : _values = values,
        super._();

  @override
  final String handler;
  final String staticData;
  final Map<String, SlotValue> _values;
  Map<String, SlotValue> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventData_LoadSlotCopyWith<EventData_LoadSlot> get copyWith =>
      _$EventData_LoadSlotCopyWithImpl<EventData_LoadSlot>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EventData_LoadSlot &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.staticData, staticData) ||
                other.staticData == staticData) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, staticData,
      const DeepCollectionEquality().hash(_values));

  @override
  String toString() {
    return 'EventData.loadSlot(handler: $handler, staticData: $staticData, values: $values)';
  }
}

/// @nodoc
abstract mixin class $EventData_LoadSlotCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory $EventData_LoadSlotCopyWith(
          EventData_LoadSlot value, $Res Function(EventData_LoadSlot) _then) =
      _$EventData_LoadSlotCopyWithImpl;
  @override
  @useResult
  $Res call({String handler, String staticData, Map<String, SlotValue> values});
}

/// @nodoc
class _$EventData_LoadSlotCopyWithImpl<$Res>
    implements $EventData_LoadSlotCopyWith<$Res> {
  _$EventData_LoadSlotCopyWithImpl(this._self, this._then);

  final EventData_LoadSlot _self;
  final $Res Function(EventData_LoadSlot) _then;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? handler = null,
    Object? staticData = null,
    Object? values = null,
  }) {
    return _then(EventData_LoadSlot(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      staticData: null == staticData
          ? _self.staticData
          : staticData // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _self._values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<String, SlotValue>,
    ));
  }
}

/// @nodoc

class EventData_LoadPage extends EventData {
  const EventData_LoadPage(
      {required this.handler, required this.data, required this.page})
      : super._();

  @override
  final String handler;
  final String data;
  final int page;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventData_LoadPageCopyWith<EventData_LoadPage> get copyWith =>
      _$EventData_LoadPageCopyWithImpl<EventData_LoadPage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EventData_LoadPage &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, data, page);

  @override
  String toString() {
    return 'EventData.loadPage(handler: $handler, data: $data, page: $page)';
  }
}

/// @nodoc
abstract mixin class $EventData_LoadPageCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory $EventData_LoadPageCopyWith(
          EventData_LoadPage value, $Res Function(EventData_LoadPage) _then) =
      _$EventData_LoadPageCopyWithImpl;
  @override
  @useResult
  $Res call({String handler, String data, int page});
}

/// @nodoc
class _$EventData_LoadPageCopyWithImpl<$Res>
    implements $EventData_LoadPageCopyWith<$Res> {
  _$EventData_LoadPageCopyWithImpl(this._self, this._then);

  final EventData_LoadPage _self;
  final $Res Function(EventData_LoadPage) _then;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? handler = null,
    Object? data = null,
    Object? page = null,
  }) {
    return _then(EventData_LoadPage(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class EventData_Invoke extends EventData {
  const EventData_Invoke({required this.handler, required this.payload})
      : super._();

  @override
  final String handler;
  final String payload;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventData_InvokeCopyWith<EventData_Invoke> get copyWith =>
      _$EventData_InvokeCopyWithImpl<EventData_Invoke>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EventData_Invoke &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, payload);

  @override
  String toString() {
    return 'EventData.invoke(handler: $handler, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $EventData_InvokeCopyWith<$Res>
    implements $EventDataCopyWith<$Res> {
  factory $EventData_InvokeCopyWith(
          EventData_Invoke value, $Res Function(EventData_Invoke) _then) =
      _$EventData_InvokeCopyWithImpl;
  @override
  @useResult
  $Res call({String handler, String payload});
}

/// @nodoc
class _$EventData_InvokeCopyWithImpl<$Res>
    implements $EventData_InvokeCopyWith<$Res> {
  _$EventData_InvokeCopyWithImpl(this._self, this._then);

  final EventData_Invoke _self;
  final $Res Function(EventData_Invoke) _then;

  /// Create a copy of EventData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? handler = null,
    Object? payload = null,
  }) {
    return _then(EventData_Invoke(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$EventResult {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EventResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EventResult()';
  }
}

/// @nodoc
class $EventResultCopyWith<$Res> {
  $EventResultCopyWith(EventResult _, $Res Function(EventResult) __);
}

/// Adds pattern-matching-related methods to [EventResult].
extension EventResultPatterns on EventResult {
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
    TResult Function(EventResult_SlotContent value)? slotContent,
    TResult Function(EventResult_FeedPage value)? feedPage,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EventResult_SlotContent() when slotContent != null:
        return slotContent(_that);
      case EventResult_FeedPage() when feedPage != null:
        return feedPage(_that);
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
    required TResult Function(EventResult_SlotContent value) slotContent,
    required TResult Function(EventResult_FeedPage value) feedPage,
  }) {
    final _that = this;
    switch (_that) {
      case EventResult_SlotContent():
        return slotContent(_that);
      case EventResult_FeedPage():
        return feedPage(_that);
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
    TResult? Function(EventResult_SlotContent value)? slotContent,
    TResult? Function(EventResult_FeedPage value)? feedPage,
  }) {
    final _that = this;
    switch (_that) {
      case EventResult_SlotContent() when slotContent != null:
        return slotContent(_that);
      case EventResult_FeedPage() when feedPage != null:
        return feedPage(_that);
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
    TResult Function(CustomUI customui)? slotContent,
    TResult Function(List<CustomUI> items, bool hasMore)? feedPage,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EventResult_SlotContent() when slotContent != null:
        return slotContent(_that.customui);
      case EventResult_FeedPage() when feedPage != null:
        return feedPage(_that.items, _that.hasMore);
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
    required TResult Function(CustomUI customui) slotContent,
    required TResult Function(List<CustomUI> items, bool hasMore) feedPage,
  }) {
    final _that = this;
    switch (_that) {
      case EventResult_SlotContent():
        return slotContent(_that.customui);
      case EventResult_FeedPage():
        return feedPage(_that.items, _that.hasMore);
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
    TResult? Function(CustomUI customui)? slotContent,
    TResult? Function(List<CustomUI> items, bool hasMore)? feedPage,
  }) {
    final _that = this;
    switch (_that) {
      case EventResult_SlotContent() when slotContent != null:
        return slotContent(_that.customui);
      case EventResult_FeedPage() when feedPage != null:
        return feedPage(_that.items, _that.hasMore);
      case _:
        return null;
    }
  }
}

/// @nodoc

class EventResult_SlotContent extends EventResult {
  const EventResult_SlotContent({required this.customui}) : super._();

  final CustomUI customui;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventResult_SlotContentCopyWith<EventResult_SlotContent> get copyWith =>
      _$EventResult_SlotContentCopyWithImpl<EventResult_SlotContent>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EventResult_SlotContent &&
            (identical(other.customui, customui) ||
                other.customui == customui));
  }

  @override
  int get hashCode => Object.hash(runtimeType, customui);

  @override
  String toString() {
    return 'EventResult.slotContent(customui: $customui)';
  }
}

/// @nodoc
abstract mixin class $EventResult_SlotContentCopyWith<$Res>
    implements $EventResultCopyWith<$Res> {
  factory $EventResult_SlotContentCopyWith(EventResult_SlotContent value,
          $Res Function(EventResult_SlotContent) _then) =
      _$EventResult_SlotContentCopyWithImpl;
  @useResult
  $Res call({CustomUI customui});

  $CustomUICopyWith<$Res> get customui;
}

/// @nodoc
class _$EventResult_SlotContentCopyWithImpl<$Res>
    implements $EventResult_SlotContentCopyWith<$Res> {
  _$EventResult_SlotContentCopyWithImpl(this._self, this._then);

  final EventResult_SlotContent _self;
  final $Res Function(EventResult_SlotContent) _then;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? customui = null,
  }) {
    return _then(EventResult_SlotContent(
      customui: null == customui
          ? _self.customui
          : customui // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get customui {
    return $CustomUICopyWith<$Res>(_self.customui, (value) {
      return _then(_self.copyWith(customui: value));
    });
  }
}

/// @nodoc

class EventResult_FeedPage extends EventResult {
  const EventResult_FeedPage(
      {required final List<CustomUI> items, required this.hasMore})
      : _items = items,
        super._();

  final List<CustomUI> _items;
  List<CustomUI> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final bool hasMore;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventResult_FeedPageCopyWith<EventResult_FeedPage> get copyWith =>
      _$EventResult_FeedPageCopyWithImpl<EventResult_FeedPage>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EventResult_FeedPage &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), hasMore);

  @override
  String toString() {
    return 'EventResult.feedPage(items: $items, hasMore: $hasMore)';
  }
}

/// @nodoc
abstract mixin class $EventResult_FeedPageCopyWith<$Res>
    implements $EventResultCopyWith<$Res> {
  factory $EventResult_FeedPageCopyWith(EventResult_FeedPage value,
          $Res Function(EventResult_FeedPage) _then) =
      _$EventResult_FeedPageCopyWithImpl;
  @useResult
  $Res call({List<CustomUI> items, bool hasMore});
}

/// @nodoc
class _$EventResult_FeedPageCopyWithImpl<$Res>
    implements $EventResult_FeedPageCopyWith<$Res> {
  _$EventResult_FeedPageCopyWithImpl(this._self, this._then);

  final EventResult_FeedPage _self;
  final $Res Function(EventResult_FeedPage) _then;

  /// Create a copy of EventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? hasMore = null,
  }) {
    return _then(EventResult_FeedPage(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CustomUI>,
      hasMore: null == hasMore
          ? _self.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$Interaction {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Interaction);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Interaction()';
  }
}

/// @nodoc
class $InteractionCopyWith<$Res> {
  $InteractionCopyWith(Interaction _, $Res Function(Interaction) __);
}

/// Adds pattern-matching-related methods to [Interaction].
extension InteractionPatterns on Interaction {
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
    TResult Function(Interaction_Invoke value)? invoke,
    TResult Function(Interaction_WriteKey value)? writeKey,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Interaction_Invoke() when invoke != null:
        return invoke(_that);
      case Interaction_WriteKey() when writeKey != null:
        return writeKey(_that);
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
    required TResult Function(Interaction_Invoke value) invoke,
    required TResult Function(Interaction_WriteKey value) writeKey,
  }) {
    final _that = this;
    switch (_that) {
      case Interaction_Invoke():
        return invoke(_that);
      case Interaction_WriteKey():
        return writeKey(_that);
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
    TResult? Function(Interaction_Invoke value)? invoke,
    TResult? Function(Interaction_WriteKey value)? writeKey,
  }) {
    final _that = this;
    switch (_that) {
      case Interaction_Invoke() when invoke != null:
        return invoke(_that);
      case Interaction_WriteKey() when writeKey != null:
        return writeKey(_that);
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
    TResult Function(String handler, String payload)? invoke,
    TResult Function(String key, String value)? writeKey,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Interaction_Invoke() when invoke != null:
        return invoke(_that.handler, _that.payload);
      case Interaction_WriteKey() when writeKey != null:
        return writeKey(_that.key, _that.value);
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
    required TResult Function(String handler, String payload) invoke,
    required TResult Function(String key, String value) writeKey,
  }) {
    final _that = this;
    switch (_that) {
      case Interaction_Invoke():
        return invoke(_that.handler, _that.payload);
      case Interaction_WriteKey():
        return writeKey(_that.key, _that.value);
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
    TResult? Function(String handler, String payload)? invoke,
    TResult? Function(String key, String value)? writeKey,
  }) {
    final _that = this;
    switch (_that) {
      case Interaction_Invoke() when invoke != null:
        return invoke(_that.handler, _that.payload);
      case Interaction_WriteKey() when writeKey != null:
        return writeKey(_that.key, _that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Interaction_Invoke extends Interaction {
  const Interaction_Invoke({required this.handler, required this.payload})
      : super._();

  final String handler;
  final String payload;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Interaction_InvokeCopyWith<Interaction_Invoke> get copyWith =>
      _$Interaction_InvokeCopyWithImpl<Interaction_Invoke>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Interaction_Invoke &&
            (identical(other.handler, handler) || other.handler == handler) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, handler, payload);

  @override
  String toString() {
    return 'Interaction.invoke(handler: $handler, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $Interaction_InvokeCopyWith<$Res>
    implements $InteractionCopyWith<$Res> {
  factory $Interaction_InvokeCopyWith(
          Interaction_Invoke value, $Res Function(Interaction_Invoke) _then) =
      _$Interaction_InvokeCopyWithImpl;
  @useResult
  $Res call({String handler, String payload});
}

/// @nodoc
class _$Interaction_InvokeCopyWithImpl<$Res>
    implements $Interaction_InvokeCopyWith<$Res> {
  _$Interaction_InvokeCopyWithImpl(this._self, this._then);

  final Interaction_Invoke _self;
  final $Res Function(Interaction_Invoke) _then;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? handler = null,
    Object? payload = null,
  }) {
    return _then(Interaction_Invoke(
      handler: null == handler
          ? _self.handler
          : handler // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Interaction_WriteKey extends Interaction {
  const Interaction_WriteKey({required this.key, required this.value})
      : super._();

  final String key;
  final String value;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Interaction_WriteKeyCopyWith<Interaction_WriteKey> get copyWith =>
      _$Interaction_WriteKeyCopyWithImpl<Interaction_WriteKey>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Interaction_WriteKey &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @override
  String toString() {
    return 'Interaction.writeKey(key: $key, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Interaction_WriteKeyCopyWith<$Res>
    implements $InteractionCopyWith<$Res> {
  factory $Interaction_WriteKeyCopyWith(Interaction_WriteKey value,
          $Res Function(Interaction_WriteKey) _then) =
      _$Interaction_WriteKeyCopyWithImpl;
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class _$Interaction_WriteKeyCopyWithImpl<$Res>
    implements $Interaction_WriteKeyCopyWith<$Res> {
  _$Interaction_WriteKeyCopyWithImpl(this._self, this._then);

  final Interaction_WriteKey _self;
  final $Res Function(Interaction_WriteKey) _then;

  /// Create a copy of Interaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(Interaction_WriteKey(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SlotValue {
  Object get value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SlotValue &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'SlotValue(value: $value)';
  }
}

/// @nodoc
class $SlotValueCopyWith<$Res> {
  $SlotValueCopyWith(SlotValue _, $Res Function(SlotValue) __);
}

/// Adds pattern-matching-related methods to [SlotValue].
extension SlotValuePatterns on SlotValue {
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
    TResult Function(SlotValue_Setting value)? setting,
    TResult Function(SlotValue_Store value)? store,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SlotValue_Setting() when setting != null:
        return setting(_that);
      case SlotValue_Store() when store != null:
        return store(_that);
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
    required TResult Function(SlotValue_Setting value) setting,
    required TResult Function(SlotValue_Store value) store,
  }) {
    final _that = this;
    switch (_that) {
      case SlotValue_Setting():
        return setting(_that);
      case SlotValue_Store():
        return store(_that);
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
    TResult? Function(SlotValue_Setting value)? setting,
    TResult? Function(SlotValue_Store value)? store,
  }) {
    final _that = this;
    switch (_that) {
      case SlotValue_Setting() when setting != null:
        return setting(_that);
      case SlotValue_Store() when store != null:
        return store(_that);
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
    TResult Function(SettingValue value)? setting,
    TResult Function(String key, String value)? store,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SlotValue_Setting() when setting != null:
        return setting(_that.value);
      case SlotValue_Store() when store != null:
        return store(_that.key, _that.value);
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
    required TResult Function(SettingValue value) setting,
    required TResult Function(String key, String value) store,
  }) {
    final _that = this;
    switch (_that) {
      case SlotValue_Setting():
        return setting(_that.value);
      case SlotValue_Store():
        return store(_that.key, _that.value);
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
    TResult? Function(SettingValue value)? setting,
    TResult? Function(String key, String value)? store,
  }) {
    final _that = this;
    switch (_that) {
      case SlotValue_Setting() when setting != null:
        return setting(_that.value);
      case SlotValue_Store() when store != null:
        return store(_that.key, _that.value);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SlotValue_Setting extends SlotValue {
  const SlotValue_Setting({required this.value}) : super._();

  @override
  final SettingValue value;

  /// Create a copy of SlotValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SlotValue_SettingCopyWith<SlotValue_Setting> get copyWith =>
      _$SlotValue_SettingCopyWithImpl<SlotValue_Setting>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SlotValue_Setting &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'SlotValue.setting(value: $value)';
  }
}

/// @nodoc
abstract mixin class $SlotValue_SettingCopyWith<$Res>
    implements $SlotValueCopyWith<$Res> {
  factory $SlotValue_SettingCopyWith(
          SlotValue_Setting value, $Res Function(SlotValue_Setting) _then) =
      _$SlotValue_SettingCopyWithImpl;
  @useResult
  $Res call({SettingValue value});

  $SettingValueCopyWith<$Res> get value;
}

/// @nodoc
class _$SlotValue_SettingCopyWithImpl<$Res>
    implements $SlotValue_SettingCopyWith<$Res> {
  _$SlotValue_SettingCopyWithImpl(this._self, this._then);

  final SlotValue_Setting _self;
  final $Res Function(SlotValue_Setting) _then;

  /// Create a copy of SlotValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(SlotValue_Setting(
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as SettingValue,
    ));
  }

  /// Create a copy of SlotValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettingValueCopyWith<$Res> get value {
    return $SettingValueCopyWith<$Res>(_self.value, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// @nodoc

class SlotValue_Store extends SlotValue {
  const SlotValue_Store({required this.key, required this.value}) : super._();

  final String key;
  @override
  final String value;

  /// Create a copy of SlotValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SlotValue_StoreCopyWith<SlotValue_Store> get copyWith =>
      _$SlotValue_StoreCopyWithImpl<SlotValue_Store>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SlotValue_Store &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, value);

  @override
  String toString() {
    return 'SlotValue.store(key: $key, value: $value)';
  }
}

/// @nodoc
abstract mixin class $SlotValue_StoreCopyWith<$Res>
    implements $SlotValueCopyWith<$Res> {
  factory $SlotValue_StoreCopyWith(
          SlotValue_Store value, $Res Function(SlotValue_Store) _then) =
      _$SlotValue_StoreCopyWithImpl;
  @useResult
  $Res call({String key, String value});
}

/// @nodoc
class _$SlotValue_StoreCopyWithImpl<$Res>
    implements $SlotValue_StoreCopyWith<$Res> {
  _$SlotValue_StoreCopyWithImpl(this._self, this._then);

  final SlotValue_Store _self;
  final $Res Function(SlotValue_Store) _then;

  /// Create a copy of SlotValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
    Object? value = null,
  }) {
    return _then(SlotValue_Store(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
