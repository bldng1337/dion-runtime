// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extension.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtensionType {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExtensionType);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExtensionType()';
  }
}

/// @nodoc
class $ExtensionTypeCopyWith<$Res> {
  $ExtensionTypeCopyWith(ExtensionType _, $Res Function(ExtensionType) __);
}

/// Adds pattern-matching-related methods to [ExtensionType].
extension ExtensionTypePatterns on ExtensionType {
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
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ExtensionType_EntryProvider() when entryProvider != null:
        return entryProvider(_that);
      case ExtensionType_SourceProcessor() when sourceProcessor != null:
        return sourceProcessor(_that);
      case ExtensionType_EntryProcessor() when entryProcessor != null:
        return entryProcessor(_that);
      case ExtensionType_URLHandler() when urlHandler != null:
        return urlHandler(_that);
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
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    final _that = this;
    switch (_that) {
      case ExtensionType_EntryProvider():
        return entryProvider(_that);
      case ExtensionType_SourceProcessor():
        return sourceProcessor(_that);
      case ExtensionType_EntryProcessor():
        return entryProcessor(_that);
      case ExtensionType_URLHandler():
        return urlHandler(_that);
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
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    final _that = this;
    switch (_that) {
      case ExtensionType_EntryProvider() when entryProvider != null:
        return entryProvider(_that);
      case ExtensionType_SourceProcessor() when sourceProcessor != null:
        return sourceProcessor(_that);
      case ExtensionType_EntryProcessor() when entryProcessor != null:
        return entryProcessor(_that);
      case ExtensionType_URLHandler() when urlHandler != null:
        return urlHandler(_that);
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
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ExtensionType_EntryProvider() when entryProvider != null:
        return entryProvider(_that.hasSearch);
      case ExtensionType_SourceProcessor() when sourceProcessor != null:
        return sourceProcessor(_that.sourcetypes, _that.opentype);
      case ExtensionType_EntryProcessor() when entryProcessor != null:
        return entryProcessor(
            _that.triggerMapEntry, _that.triggerOnEntryActivity);
      case ExtensionType_URLHandler() when urlHandler != null:
        return urlHandler(_that.urlPatterns);
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
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    final _that = this;
    switch (_that) {
      case ExtensionType_EntryProvider():
        return entryProvider(_that.hasSearch);
      case ExtensionType_SourceProcessor():
        return sourceProcessor(_that.sourcetypes, _that.opentype);
      case ExtensionType_EntryProcessor():
        return entryProcessor(
            _that.triggerMapEntry, _that.triggerOnEntryActivity);
      case ExtensionType_URLHandler():
        return urlHandler(_that.urlPatterns);
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
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    final _that = this;
    switch (_that) {
      case ExtensionType_EntryProvider() when entryProvider != null:
        return entryProvider(_that.hasSearch);
      case ExtensionType_SourceProcessor() when sourceProcessor != null:
        return sourceProcessor(_that.sourcetypes, _that.opentype);
      case ExtensionType_EntryProcessor() when entryProcessor != null:
        return entryProcessor(
            _that.triggerMapEntry, _that.triggerOnEntryActivity);
      case ExtensionType_URLHandler() when urlHandler != null:
        return urlHandler(_that.urlPatterns);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ExtensionType_EntryProvider extends ExtensionType {
  const ExtensionType_EntryProvider({required this.hasSearch}) : super._();

  final bool hasSearch;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtensionType_EntryProviderCopyWith<ExtensionType_EntryProvider>
      get copyWith => _$ExtensionType_EntryProviderCopyWithImpl<
          ExtensionType_EntryProvider>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtensionType_EntryProvider &&
            (identical(other.hasSearch, hasSearch) ||
                other.hasSearch == hasSearch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasSearch);

  @override
  String toString() {
    return 'ExtensionType.entryProvider(hasSearch: $hasSearch)';
  }
}

/// @nodoc
abstract mixin class $ExtensionType_EntryProviderCopyWith<$Res>
    implements $ExtensionTypeCopyWith<$Res> {
  factory $ExtensionType_EntryProviderCopyWith(
          ExtensionType_EntryProvider value,
          $Res Function(ExtensionType_EntryProvider) _then) =
      _$ExtensionType_EntryProviderCopyWithImpl;
  @useResult
  $Res call({bool hasSearch});
}

/// @nodoc
class _$ExtensionType_EntryProviderCopyWithImpl<$Res>
    implements $ExtensionType_EntryProviderCopyWith<$Res> {
  _$ExtensionType_EntryProviderCopyWithImpl(this._self, this._then);

  final ExtensionType_EntryProvider _self;
  final $Res Function(ExtensionType_EntryProvider) _then;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hasSearch = null,
  }) {
    return _then(ExtensionType_EntryProvider(
      hasSearch: null == hasSearch
          ? _self.hasSearch
          : hasSearch // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ExtensionType_SourceProcessor extends ExtensionType {
  const ExtensionType_SourceProcessor(
      {required final Set<SourceType> sourcetypes,
      required final Set<SourceOpenType> opentype})
      : _sourcetypes = sourcetypes,
        _opentype = opentype,
        super._();

  final Set<SourceType> _sourcetypes;
  Set<SourceType> get sourcetypes {
    if (_sourcetypes is EqualUnmodifiableSetView) return _sourcetypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sourcetypes);
  }

  final Set<SourceOpenType> _opentype;
  Set<SourceOpenType> get opentype {
    if (_opentype is EqualUnmodifiableSetView) return _opentype;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_opentype);
  }

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtensionType_SourceProcessorCopyWith<ExtensionType_SourceProcessor>
      get copyWith => _$ExtensionType_SourceProcessorCopyWithImpl<
          ExtensionType_SourceProcessor>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtensionType_SourceProcessor &&
            const DeepCollectionEquality()
                .equals(other._sourcetypes, _sourcetypes) &&
            const DeepCollectionEquality().equals(other._opentype, _opentype));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sourcetypes),
      const DeepCollectionEquality().hash(_opentype));

  @override
  String toString() {
    return 'ExtensionType.sourceProcessor(sourcetypes: $sourcetypes, opentype: $opentype)';
  }
}

/// @nodoc
abstract mixin class $ExtensionType_SourceProcessorCopyWith<$Res>
    implements $ExtensionTypeCopyWith<$Res> {
  factory $ExtensionType_SourceProcessorCopyWith(
          ExtensionType_SourceProcessor value,
          $Res Function(ExtensionType_SourceProcessor) _then) =
      _$ExtensionType_SourceProcessorCopyWithImpl;
  @useResult
  $Res call({Set<SourceType> sourcetypes, Set<SourceOpenType> opentype});
}

/// @nodoc
class _$ExtensionType_SourceProcessorCopyWithImpl<$Res>
    implements $ExtensionType_SourceProcessorCopyWith<$Res> {
  _$ExtensionType_SourceProcessorCopyWithImpl(this._self, this._then);

  final ExtensionType_SourceProcessor _self;
  final $Res Function(ExtensionType_SourceProcessor) _then;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sourcetypes = null,
    Object? opentype = null,
  }) {
    return _then(ExtensionType_SourceProcessor(
      sourcetypes: null == sourcetypes
          ? _self._sourcetypes
          : sourcetypes // ignore: cast_nullable_to_non_nullable
              as Set<SourceType>,
      opentype: null == opentype
          ? _self._opentype
          : opentype // ignore: cast_nullable_to_non_nullable
              as Set<SourceOpenType>,
    ));
  }
}

/// @nodoc

class ExtensionType_EntryProcessor extends ExtensionType {
  const ExtensionType_EntryProcessor(
      {required this.triggerMapEntry, required this.triggerOnEntryActivity})
      : super._();

  final bool triggerMapEntry;
  final bool triggerOnEntryActivity;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtensionType_EntryProcessorCopyWith<ExtensionType_EntryProcessor>
      get copyWith => _$ExtensionType_EntryProcessorCopyWithImpl<
          ExtensionType_EntryProcessor>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtensionType_EntryProcessor &&
            (identical(other.triggerMapEntry, triggerMapEntry) ||
                other.triggerMapEntry == triggerMapEntry) &&
            (identical(other.triggerOnEntryActivity, triggerOnEntryActivity) ||
                other.triggerOnEntryActivity == triggerOnEntryActivity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, triggerMapEntry, triggerOnEntryActivity);

  @override
  String toString() {
    return 'ExtensionType.entryProcessor(triggerMapEntry: $triggerMapEntry, triggerOnEntryActivity: $triggerOnEntryActivity)';
  }
}

/// @nodoc
abstract mixin class $ExtensionType_EntryProcessorCopyWith<$Res>
    implements $ExtensionTypeCopyWith<$Res> {
  factory $ExtensionType_EntryProcessorCopyWith(
          ExtensionType_EntryProcessor value,
          $Res Function(ExtensionType_EntryProcessor) _then) =
      _$ExtensionType_EntryProcessorCopyWithImpl;
  @useResult
  $Res call({bool triggerMapEntry, bool triggerOnEntryActivity});
}

/// @nodoc
class _$ExtensionType_EntryProcessorCopyWithImpl<$Res>
    implements $ExtensionType_EntryProcessorCopyWith<$Res> {
  _$ExtensionType_EntryProcessorCopyWithImpl(this._self, this._then);

  final ExtensionType_EntryProcessor _self;
  final $Res Function(ExtensionType_EntryProcessor) _then;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? triggerMapEntry = null,
    Object? triggerOnEntryActivity = null,
  }) {
    return _then(ExtensionType_EntryProcessor(
      triggerMapEntry: null == triggerMapEntry
          ? _self.triggerMapEntry
          : triggerMapEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      triggerOnEntryActivity: null == triggerOnEntryActivity
          ? _self.triggerOnEntryActivity
          : triggerOnEntryActivity // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class ExtensionType_URLHandler extends ExtensionType {
  const ExtensionType_URLHandler({required final List<String> urlPatterns})
      : _urlPatterns = urlPatterns,
        super._();

  final List<String> _urlPatterns;
  List<String> get urlPatterns {
    if (_urlPatterns is EqualUnmodifiableListView) return _urlPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urlPatterns);
  }

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExtensionType_URLHandlerCopyWith<ExtensionType_URLHandler> get copyWith =>
      _$ExtensionType_URLHandlerCopyWithImpl<ExtensionType_URLHandler>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExtensionType_URLHandler &&
            const DeepCollectionEquality()
                .equals(other._urlPatterns, _urlPatterns));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_urlPatterns));

  @override
  String toString() {
    return 'ExtensionType.urlHandler(urlPatterns: $urlPatterns)';
  }
}

/// @nodoc
abstract mixin class $ExtensionType_URLHandlerCopyWith<$Res>
    implements $ExtensionTypeCopyWith<$Res> {
  factory $ExtensionType_URLHandlerCopyWith(ExtensionType_URLHandler value,
          $Res Function(ExtensionType_URLHandler) _then) =
      _$ExtensionType_URLHandlerCopyWithImpl;
  @useResult
  $Res call({List<String> urlPatterns});
}

/// @nodoc
class _$ExtensionType_URLHandlerCopyWithImpl<$Res>
    implements $ExtensionType_URLHandlerCopyWith<$Res> {
  _$ExtensionType_URLHandlerCopyWithImpl(this._self, this._then);

  final ExtensionType_URLHandler _self;
  final $Res Function(ExtensionType_URLHandler) _then;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? urlPatterns = null,
  }) {
    return _then(ExtensionType_URLHandler(
      urlPatterns: null == urlPatterns
          ? _self._urlPatterns
          : urlPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
