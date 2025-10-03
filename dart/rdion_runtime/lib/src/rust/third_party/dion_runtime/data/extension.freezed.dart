// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extension.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExtensionType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtensionTypeCopyWith<$Res> {
  factory $ExtensionTypeCopyWith(
          ExtensionType value, $Res Function(ExtensionType) then) =
      _$ExtensionTypeCopyWithImpl<$Res, ExtensionType>;
}

/// @nodoc
class _$ExtensionTypeCopyWithImpl<$Res, $Val extends ExtensionType>
    implements $ExtensionTypeCopyWith<$Res> {
  _$ExtensionTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ExtensionType_EntryProviderImplCopyWith<$Res> {
  factory _$$ExtensionType_EntryProviderImplCopyWith(
          _$ExtensionType_EntryProviderImpl value,
          $Res Function(_$ExtensionType_EntryProviderImpl) then) =
      __$$ExtensionType_EntryProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool hasSearch});
}

/// @nodoc
class __$$ExtensionType_EntryProviderImplCopyWithImpl<$Res>
    extends _$ExtensionTypeCopyWithImpl<$Res, _$ExtensionType_EntryProviderImpl>
    implements _$$ExtensionType_EntryProviderImplCopyWith<$Res> {
  __$$ExtensionType_EntryProviderImplCopyWithImpl(
      _$ExtensionType_EntryProviderImpl _value,
      $Res Function(_$ExtensionType_EntryProviderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasSearch = null,
  }) {
    return _then(_$ExtensionType_EntryProviderImpl(
      hasSearch: null == hasSearch
          ? _value.hasSearch
          : hasSearch // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ExtensionType_EntryProviderImpl extends ExtensionType_EntryProvider {
  const _$ExtensionType_EntryProviderImpl({required this.hasSearch})
      : super._();

  @override
  final bool hasSearch;

  @override
  String toString() {
    return 'ExtensionType.entryProvider(hasSearch: $hasSearch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionType_EntryProviderImpl &&
            (identical(other.hasSearch, hasSearch) ||
                other.hasSearch == hasSearch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasSearch);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionType_EntryProviderImplCopyWith<_$ExtensionType_EntryProviderImpl>
      get copyWith => __$$ExtensionType_EntryProviderImplCopyWithImpl<
          _$ExtensionType_EntryProviderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    return entryProvider(hasSearch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    return entryProvider?.call(hasSearch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    if (entryProvider != null) {
      return entryProvider(hasSearch);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    return entryProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    return entryProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    if (entryProvider != null) {
      return entryProvider(this);
    }
    return orElse();
  }
}

abstract class ExtensionType_EntryProvider extends ExtensionType {
  const factory ExtensionType_EntryProvider({required final bool hasSearch}) =
      _$ExtensionType_EntryProviderImpl;
  const ExtensionType_EntryProvider._() : super._();

  bool get hasSearch;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionType_EntryProviderImplCopyWith<_$ExtensionType_EntryProviderImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExtensionType_EntryDetailedProviderImplCopyWith<$Res> {
  factory _$$ExtensionType_EntryDetailedProviderImplCopyWith(
          _$ExtensionType_EntryDetailedProviderImpl value,
          $Res Function(_$ExtensionType_EntryDetailedProviderImpl) then) =
      __$$ExtensionType_EntryDetailedProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> idTypes});
}

/// @nodoc
class __$$ExtensionType_EntryDetailedProviderImplCopyWithImpl<$Res>
    extends _$ExtensionTypeCopyWithImpl<$Res,
        _$ExtensionType_EntryDetailedProviderImpl>
    implements _$$ExtensionType_EntryDetailedProviderImplCopyWith<$Res> {
  __$$ExtensionType_EntryDetailedProviderImplCopyWithImpl(
      _$ExtensionType_EntryDetailedProviderImpl _value,
      $Res Function(_$ExtensionType_EntryDetailedProviderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idTypes = null,
  }) {
    return _then(_$ExtensionType_EntryDetailedProviderImpl(
      idTypes: null == idTypes
          ? _value._idTypes
          : idTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ExtensionType_EntryDetailedProviderImpl
    extends ExtensionType_EntryDetailedProvider {
  const _$ExtensionType_EntryDetailedProviderImpl(
      {required final List<String> idTypes})
      : _idTypes = idTypes,
        super._();

  final List<String> _idTypes;
  @override
  List<String> get idTypes {
    if (_idTypes is EqualUnmodifiableListView) return _idTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_idTypes);
  }

  @override
  String toString() {
    return 'ExtensionType.entryDetailedProvider(idTypes: $idTypes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionType_EntryDetailedProviderImpl &&
            const DeepCollectionEquality().equals(other._idTypes, _idTypes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_idTypes));

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionType_EntryDetailedProviderImplCopyWith<
          _$ExtensionType_EntryDetailedProviderImpl>
      get copyWith => __$$ExtensionType_EntryDetailedProviderImplCopyWithImpl<
          _$ExtensionType_EntryDetailedProviderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    return entryDetailedProvider(idTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    return entryDetailedProvider?.call(idTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    if (entryDetailedProvider != null) {
      return entryDetailedProvider(idTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    return entryDetailedProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    return entryDetailedProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    if (entryDetailedProvider != null) {
      return entryDetailedProvider(this);
    }
    return orElse();
  }
}

abstract class ExtensionType_EntryDetailedProvider extends ExtensionType {
  const factory ExtensionType_EntryDetailedProvider(
          {required final List<String> idTypes}) =
      _$ExtensionType_EntryDetailedProviderImpl;
  const ExtensionType_EntryDetailedProvider._() : super._();

  List<String> get idTypes;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionType_EntryDetailedProviderImplCopyWith<
          _$ExtensionType_EntryDetailedProviderImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExtensionType_SourceProviderImplCopyWith<$Res> {
  factory _$$ExtensionType_SourceProviderImplCopyWith(
          _$ExtensionType_SourceProviderImpl value,
          $Res Function(_$ExtensionType_SourceProviderImpl) then) =
      __$$ExtensionType_SourceProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> idTypes});
}

/// @nodoc
class __$$ExtensionType_SourceProviderImplCopyWithImpl<$Res>
    extends _$ExtensionTypeCopyWithImpl<$Res,
        _$ExtensionType_SourceProviderImpl>
    implements _$$ExtensionType_SourceProviderImplCopyWith<$Res> {
  __$$ExtensionType_SourceProviderImplCopyWithImpl(
      _$ExtensionType_SourceProviderImpl _value,
      $Res Function(_$ExtensionType_SourceProviderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idTypes = null,
  }) {
    return _then(_$ExtensionType_SourceProviderImpl(
      idTypes: null == idTypes
          ? _value._idTypes
          : idTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ExtensionType_SourceProviderImpl extends ExtensionType_SourceProvider {
  const _$ExtensionType_SourceProviderImpl(
      {required final List<String> idTypes})
      : _idTypes = idTypes,
        super._();

  final List<String> _idTypes;
  @override
  List<String> get idTypes {
    if (_idTypes is EqualUnmodifiableListView) return _idTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_idTypes);
  }

  @override
  String toString() {
    return 'ExtensionType.sourceProvider(idTypes: $idTypes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionType_SourceProviderImpl &&
            const DeepCollectionEquality().equals(other._idTypes, _idTypes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_idTypes));

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionType_SourceProviderImplCopyWith<
          _$ExtensionType_SourceProviderImpl>
      get copyWith => __$$ExtensionType_SourceProviderImplCopyWithImpl<
          _$ExtensionType_SourceProviderImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    return sourceProvider(idTypes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    return sourceProvider?.call(idTypes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    if (sourceProvider != null) {
      return sourceProvider(idTypes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    return sourceProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    return sourceProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    if (sourceProvider != null) {
      return sourceProvider(this);
    }
    return orElse();
  }
}

abstract class ExtensionType_SourceProvider extends ExtensionType {
  const factory ExtensionType_SourceProvider(
          {required final List<String> idTypes}) =
      _$ExtensionType_SourceProviderImpl;
  const ExtensionType_SourceProvider._() : super._();

  List<String> get idTypes;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionType_SourceProviderImplCopyWith<
          _$ExtensionType_SourceProviderImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExtensionType_SourceProcessorImplCopyWith<$Res> {
  factory _$$ExtensionType_SourceProcessorImplCopyWith(
          _$ExtensionType_SourceProcessorImpl value,
          $Res Function(_$ExtensionType_SourceProcessorImpl) then) =
      __$$ExtensionType_SourceProcessorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Set<SourceType> sourcetypes, Set<SourceOpenType> opentype});
}

/// @nodoc
class __$$ExtensionType_SourceProcessorImplCopyWithImpl<$Res>
    extends _$ExtensionTypeCopyWithImpl<$Res,
        _$ExtensionType_SourceProcessorImpl>
    implements _$$ExtensionType_SourceProcessorImplCopyWith<$Res> {
  __$$ExtensionType_SourceProcessorImplCopyWithImpl(
      _$ExtensionType_SourceProcessorImpl _value,
      $Res Function(_$ExtensionType_SourceProcessorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourcetypes = null,
    Object? opentype = null,
  }) {
    return _then(_$ExtensionType_SourceProcessorImpl(
      sourcetypes: null == sourcetypes
          ? _value._sourcetypes
          : sourcetypes // ignore: cast_nullable_to_non_nullable
              as Set<SourceType>,
      opentype: null == opentype
          ? _value._opentype
          : opentype // ignore: cast_nullable_to_non_nullable
              as Set<SourceOpenType>,
    ));
  }
}

/// @nodoc

class _$ExtensionType_SourceProcessorImpl
    extends ExtensionType_SourceProcessor {
  const _$ExtensionType_SourceProcessorImpl(
      {required final Set<SourceType> sourcetypes,
      required final Set<SourceOpenType> opentype})
      : _sourcetypes = sourcetypes,
        _opentype = opentype,
        super._();

  final Set<SourceType> _sourcetypes;
  @override
  Set<SourceType> get sourcetypes {
    if (_sourcetypes is EqualUnmodifiableSetView) return _sourcetypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sourcetypes);
  }

  final Set<SourceOpenType> _opentype;
  @override
  Set<SourceOpenType> get opentype {
    if (_opentype is EqualUnmodifiableSetView) return _opentype;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_opentype);
  }

  @override
  String toString() {
    return 'ExtensionType.sourceProcessor(sourcetypes: $sourcetypes, opentype: $opentype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionType_SourceProcessorImpl &&
            const DeepCollectionEquality()
                .equals(other._sourcetypes, _sourcetypes) &&
            const DeepCollectionEquality().equals(other._opentype, _opentype));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sourcetypes),
      const DeepCollectionEquality().hash(_opentype));

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionType_SourceProcessorImplCopyWith<
          _$ExtensionType_SourceProcessorImpl>
      get copyWith => __$$ExtensionType_SourceProcessorImplCopyWithImpl<
          _$ExtensionType_SourceProcessorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    return sourceProcessor(sourcetypes, opentype);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    return sourceProcessor?.call(sourcetypes, opentype);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    if (sourceProcessor != null) {
      return sourceProcessor(sourcetypes, opentype);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    return sourceProcessor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    return sourceProcessor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    if (sourceProcessor != null) {
      return sourceProcessor(this);
    }
    return orElse();
  }
}

abstract class ExtensionType_SourceProcessor extends ExtensionType {
  const factory ExtensionType_SourceProcessor(
          {required final Set<SourceType> sourcetypes,
          required final Set<SourceOpenType> opentype}) =
      _$ExtensionType_SourceProcessorImpl;
  const ExtensionType_SourceProcessor._() : super._();

  Set<SourceType> get sourcetypes;
  Set<SourceOpenType> get opentype;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionType_SourceProcessorImplCopyWith<
          _$ExtensionType_SourceProcessorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExtensionType_EntryProcessorImplCopyWith<$Res> {
  factory _$$ExtensionType_EntryProcessorImplCopyWith(
          _$ExtensionType_EntryProcessorImpl value,
          $Res Function(_$ExtensionType_EntryProcessorImpl) then) =
      __$$ExtensionType_EntryProcessorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool triggerMapEntry, bool triggerOnEntryActivity});
}

/// @nodoc
class __$$ExtensionType_EntryProcessorImplCopyWithImpl<$Res>
    extends _$ExtensionTypeCopyWithImpl<$Res,
        _$ExtensionType_EntryProcessorImpl>
    implements _$$ExtensionType_EntryProcessorImplCopyWith<$Res> {
  __$$ExtensionType_EntryProcessorImplCopyWithImpl(
      _$ExtensionType_EntryProcessorImpl _value,
      $Res Function(_$ExtensionType_EntryProcessorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? triggerMapEntry = null,
    Object? triggerOnEntryActivity = null,
  }) {
    return _then(_$ExtensionType_EntryProcessorImpl(
      triggerMapEntry: null == triggerMapEntry
          ? _value.triggerMapEntry
          : triggerMapEntry // ignore: cast_nullable_to_non_nullable
              as bool,
      triggerOnEntryActivity: null == triggerOnEntryActivity
          ? _value.triggerOnEntryActivity
          : triggerOnEntryActivity // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ExtensionType_EntryProcessorImpl extends ExtensionType_EntryProcessor {
  const _$ExtensionType_EntryProcessorImpl(
      {required this.triggerMapEntry, required this.triggerOnEntryActivity})
      : super._();

  @override
  final bool triggerMapEntry;
  @override
  final bool triggerOnEntryActivity;

  @override
  String toString() {
    return 'ExtensionType.entryProcessor(triggerMapEntry: $triggerMapEntry, triggerOnEntryActivity: $triggerOnEntryActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionType_EntryProcessorImpl &&
            (identical(other.triggerMapEntry, triggerMapEntry) ||
                other.triggerMapEntry == triggerMapEntry) &&
            (identical(other.triggerOnEntryActivity, triggerOnEntryActivity) ||
                other.triggerOnEntryActivity == triggerOnEntryActivity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, triggerMapEntry, triggerOnEntryActivity);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionType_EntryProcessorImplCopyWith<
          _$ExtensionType_EntryProcessorImpl>
      get copyWith => __$$ExtensionType_EntryProcessorImplCopyWithImpl<
          _$ExtensionType_EntryProcessorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    return entryProcessor(triggerMapEntry, triggerOnEntryActivity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    return entryProcessor?.call(triggerMapEntry, triggerOnEntryActivity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    if (entryProcessor != null) {
      return entryProcessor(triggerMapEntry, triggerOnEntryActivity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    return entryProcessor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    return entryProcessor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    if (entryProcessor != null) {
      return entryProcessor(this);
    }
    return orElse();
  }
}

abstract class ExtensionType_EntryProcessor extends ExtensionType {
  const factory ExtensionType_EntryProcessor(
          {required final bool triggerMapEntry,
          required final bool triggerOnEntryActivity}) =
      _$ExtensionType_EntryProcessorImpl;
  const ExtensionType_EntryProcessor._() : super._();

  bool get triggerMapEntry;
  bool get triggerOnEntryActivity;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionType_EntryProcessorImplCopyWith<
          _$ExtensionType_EntryProcessorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExtensionType_URLHandlerImplCopyWith<$Res> {
  factory _$$ExtensionType_URLHandlerImplCopyWith(
          _$ExtensionType_URLHandlerImpl value,
          $Res Function(_$ExtensionType_URLHandlerImpl) then) =
      __$$ExtensionType_URLHandlerImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> urlPatterns});
}

/// @nodoc
class __$$ExtensionType_URLHandlerImplCopyWithImpl<$Res>
    extends _$ExtensionTypeCopyWithImpl<$Res, _$ExtensionType_URLHandlerImpl>
    implements _$$ExtensionType_URLHandlerImplCopyWith<$Res> {
  __$$ExtensionType_URLHandlerImplCopyWithImpl(
      _$ExtensionType_URLHandlerImpl _value,
      $Res Function(_$ExtensionType_URLHandlerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlPatterns = null,
  }) {
    return _then(_$ExtensionType_URLHandlerImpl(
      urlPatterns: null == urlPatterns
          ? _value._urlPatterns
          : urlPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ExtensionType_URLHandlerImpl extends ExtensionType_URLHandler {
  const _$ExtensionType_URLHandlerImpl(
      {required final List<String> urlPatterns})
      : _urlPatterns = urlPatterns,
        super._();

  final List<String> _urlPatterns;
  @override
  List<String> get urlPatterns {
    if (_urlPatterns is EqualUnmodifiableListView) return _urlPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urlPatterns);
  }

  @override
  String toString() {
    return 'ExtensionType.urlHandler(urlPatterns: $urlPatterns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtensionType_URLHandlerImpl &&
            const DeepCollectionEquality()
                .equals(other._urlPatterns, _urlPatterns));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_urlPatterns));

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtensionType_URLHandlerImplCopyWith<_$ExtensionType_URLHandlerImpl>
      get copyWith => __$$ExtensionType_URLHandlerImplCopyWithImpl<
          _$ExtensionType_URLHandlerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasSearch) entryProvider,
    required TResult Function(List<String> idTypes) entryDetailedProvider,
    required TResult Function(List<String> idTypes) sourceProvider,
    required TResult Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)
        sourceProcessor,
    required TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)
        entryProcessor,
    required TResult Function(List<String> urlPatterns) urlHandler,
  }) {
    return urlHandler(urlPatterns);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasSearch)? entryProvider,
    TResult? Function(List<String> idTypes)? entryDetailedProvider,
    TResult? Function(List<String> idTypes)? sourceProvider,
    TResult? Function(
            Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult? Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult? Function(List<String> urlPatterns)? urlHandler,
  }) {
    return urlHandler?.call(urlPatterns);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasSearch)? entryProvider,
    TResult Function(List<String> idTypes)? entryDetailedProvider,
    TResult Function(List<String> idTypes)? sourceProvider,
    TResult Function(Set<SourceType> sourcetypes, Set<SourceOpenType> opentype)?
        sourceProcessor,
    TResult Function(bool triggerMapEntry, bool triggerOnEntryActivity)?
        entryProcessor,
    TResult Function(List<String> urlPatterns)? urlHandler,
    required TResult orElse(),
  }) {
    if (urlHandler != null) {
      return urlHandler(urlPatterns);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExtensionType_EntryProvider value) entryProvider,
    required TResult Function(ExtensionType_EntryDetailedProvider value)
        entryDetailedProvider,
    required TResult Function(ExtensionType_SourceProvider value)
        sourceProvider,
    required TResult Function(ExtensionType_SourceProcessor value)
        sourceProcessor,
    required TResult Function(ExtensionType_EntryProcessor value)
        entryProcessor,
    required TResult Function(ExtensionType_URLHandler value) urlHandler,
  }) {
    return urlHandler(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult? Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult? Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult? Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult? Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult? Function(ExtensionType_URLHandler value)? urlHandler,
  }) {
    return urlHandler?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExtensionType_EntryProvider value)? entryProvider,
    TResult Function(ExtensionType_EntryDetailedProvider value)?
        entryDetailedProvider,
    TResult Function(ExtensionType_SourceProvider value)? sourceProvider,
    TResult Function(ExtensionType_SourceProcessor value)? sourceProcessor,
    TResult Function(ExtensionType_EntryProcessor value)? entryProcessor,
    TResult Function(ExtensionType_URLHandler value)? urlHandler,
    required TResult orElse(),
  }) {
    if (urlHandler != null) {
      return urlHandler(this);
    }
    return orElse();
  }
}

abstract class ExtensionType_URLHandler extends ExtensionType {
  const factory ExtensionType_URLHandler(
          {required final List<String> urlPatterns}) =
      _$ExtensionType_URLHandlerImpl;
  const ExtensionType_URLHandler._() : super._();

  List<String> get urlPatterns;

  /// Create a copy of ExtensionType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtensionType_URLHandlerImplCopyWith<_$ExtensionType_URLHandlerImpl>
      get copyWith => throw _privateConstructorUsedError;
}
