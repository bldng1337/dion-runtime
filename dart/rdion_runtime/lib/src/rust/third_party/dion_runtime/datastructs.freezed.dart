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

/// @nodoc
mixin _$DataSource {
  List<String> get paragraphs => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> paragraphs) paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> paragraphs)? paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> paragraphs)? paragraphlist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataSource_Paragraphlist value) paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataSource_Paragraphlist value)? paragraphlist,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSource_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataSourceCopyWith<DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceCopyWith<$Res> {
  factory $DataSourceCopyWith(
          DataSource value, $Res Function(DataSource) then) =
      _$DataSourceCopyWithImpl<$Res, DataSource>;
  @useResult
  $Res call({List<String> paragraphs});
}

/// @nodoc
class _$DataSourceCopyWithImpl<$Res, $Val extends DataSource>
    implements $DataSourceCopyWith<$Res> {
  _$DataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paragraphs = null,
  }) {
    return _then(_value.copyWith(
      paragraphs: null == paragraphs
          ? _value.paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataSource_ParagraphlistImplCopyWith<$Res>
    implements $DataSourceCopyWith<$Res> {
  factory _$$DataSource_ParagraphlistImplCopyWith(
          _$DataSource_ParagraphlistImpl value,
          $Res Function(_$DataSource_ParagraphlistImpl) then) =
      __$$DataSource_ParagraphlistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> paragraphs});
}

/// @nodoc
class __$$DataSource_ParagraphlistImplCopyWithImpl<$Res>
    extends _$DataSourceCopyWithImpl<$Res, _$DataSource_ParagraphlistImpl>
    implements _$$DataSource_ParagraphlistImplCopyWith<$Res> {
  __$$DataSource_ParagraphlistImplCopyWithImpl(
      _$DataSource_ParagraphlistImpl _value,
      $Res Function(_$DataSource_ParagraphlistImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paragraphs = null,
  }) {
    return _then(_$DataSource_ParagraphlistImpl(
      paragraphs: null == paragraphs
          ? _value._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$DataSource_ParagraphlistImpl extends DataSource_Paragraphlist {
  const _$DataSource_ParagraphlistImpl({required final List<String> paragraphs})
      : _paragraphs = paragraphs,
        super._();

  final List<String> _paragraphs;
  @override
  List<String> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

  @override
  String toString() {
    return 'DataSource.paragraphlist(paragraphs: $paragraphs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSource_ParagraphlistImpl &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_paragraphs));

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSource_ParagraphlistImplCopyWith<_$DataSource_ParagraphlistImpl>
      get copyWith => __$$DataSource_ParagraphlistImplCopyWithImpl<
          _$DataSource_ParagraphlistImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> paragraphs) paragraphlist,
  }) {
    return paragraphlist(paragraphs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> paragraphs)? paragraphlist,
  }) {
    return paragraphlist?.call(paragraphs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> paragraphs)? paragraphlist,
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
    required TResult Function(DataSource_Paragraphlist value) paragraphlist,
  }) {
    return paragraphlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataSource_Paragraphlist value)? paragraphlist,
  }) {
    return paragraphlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataSource_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    if (paragraphlist != null) {
      return paragraphlist(this);
    }
    return orElse();
  }
}

abstract class DataSource_Paragraphlist extends DataSource {
  const factory DataSource_Paragraphlist(
          {required final List<String> paragraphs}) =
      _$DataSource_ParagraphlistImpl;
  const DataSource_Paragraphlist._() : super._();

  @override
  List<String> get paragraphs;

  /// Create a copy of DataSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataSource_ParagraphlistImplCopyWith<_$DataSource_ParagraphlistImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LinkSource {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkSourceCopyWith<$Res> {
  factory $LinkSourceCopyWith(
          LinkSource value, $Res Function(LinkSource) then) =
      _$LinkSourceCopyWithImpl<$Res, LinkSource>;
}

/// @nodoc
class _$LinkSourceCopyWithImpl<$Res, $Val extends LinkSource>
    implements $LinkSourceCopyWith<$Res> {
  _$LinkSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LinkSource_EpubImplCopyWith<$Res> {
  factory _$$LinkSource_EpubImplCopyWith(_$LinkSource_EpubImpl value,
          $Res Function(_$LinkSource_EpubImpl) then) =
      __$$LinkSource_EpubImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link});
}

/// @nodoc
class __$$LinkSource_EpubImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_EpubImpl>
    implements _$$LinkSource_EpubImplCopyWith<$Res> {
  __$$LinkSource_EpubImplCopyWithImpl(
      _$LinkSource_EpubImpl _value, $Res Function(_$LinkSource_EpubImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$LinkSource_EpubImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LinkSource_EpubImpl extends LinkSource_Epub {
  const _$LinkSource_EpubImpl({required this.link}) : super._();

  @override
  final String link;

  @override
  String toString() {
    return 'LinkSource.epub(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_EpubImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_EpubImplCopyWith<_$LinkSource_EpubImpl> get copyWith =>
      __$$LinkSource_EpubImplCopyWithImpl<_$LinkSource_EpubImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
  }) {
    return epub(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
  }) {
    return epub?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
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
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
  }) {
    return epub(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
  }) {
    return epub?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    required TResult orElse(),
  }) {
    if (epub != null) {
      return epub(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Epub extends LinkSource {
  const factory LinkSource_Epub({required final String link}) =
      _$LinkSource_EpubImpl;
  const LinkSource_Epub._() : super._();

  String get link;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_EpubImplCopyWith<_$LinkSource_EpubImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_PdfImplCopyWith<$Res> {
  factory _$$LinkSource_PdfImplCopyWith(_$LinkSource_PdfImpl value,
          $Res Function(_$LinkSource_PdfImpl) then) =
      __$$LinkSource_PdfImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link});
}

/// @nodoc
class __$$LinkSource_PdfImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_PdfImpl>
    implements _$$LinkSource_PdfImplCopyWith<$Res> {
  __$$LinkSource_PdfImplCopyWithImpl(
      _$LinkSource_PdfImpl _value, $Res Function(_$LinkSource_PdfImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
  }) {
    return _then(_$LinkSource_PdfImpl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LinkSource_PdfImpl extends LinkSource_Pdf {
  const _$LinkSource_PdfImpl({required this.link}) : super._();

  @override
  final String link;

  @override
  String toString() {
    return 'LinkSource.pdf(link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_PdfImpl &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_PdfImplCopyWith<_$LinkSource_PdfImpl> get copyWith =>
      __$$LinkSource_PdfImplCopyWithImpl<_$LinkSource_PdfImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
  }) {
    return pdf(link);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
  }) {
    return pdf?.call(link);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
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
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
  }) {
    return pdf(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
  }) {
    return pdf?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    required TResult orElse(),
  }) {
    if (pdf != null) {
      return pdf(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Pdf extends LinkSource {
  const factory LinkSource_Pdf({required final String link}) =
      _$LinkSource_PdfImpl;
  const LinkSource_Pdf._() : super._();

  String get link;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_PdfImplCopyWith<_$LinkSource_PdfImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_ImagelistImplCopyWith<$Res> {
  factory _$$LinkSource_ImagelistImplCopyWith(_$LinkSource_ImagelistImpl value,
          $Res Function(_$LinkSource_ImagelistImpl) then) =
      __$$LinkSource_ImagelistImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<String> links,
      Map<String, String>? header,
      List<ImageListAudio>? audio});
}

/// @nodoc
class __$$LinkSource_ImagelistImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_ImagelistImpl>
    implements _$$LinkSource_ImagelistImplCopyWith<$Res> {
  __$$LinkSource_ImagelistImplCopyWithImpl(_$LinkSource_ImagelistImpl _value,
      $Res Function(_$LinkSource_ImagelistImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? links = null,
    Object? header = freezed,
    Object? audio = freezed,
  }) {
    return _then(_$LinkSource_ImagelistImpl(
      links: null == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<String>,
      header: freezed == header
          ? _value._header
          : header // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      audio: freezed == audio
          ? _value._audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<ImageListAudio>?,
    ));
  }
}

/// @nodoc

class _$LinkSource_ImagelistImpl extends LinkSource_Imagelist {
  const _$LinkSource_ImagelistImpl(
      {required final List<String> links,
      final Map<String, String>? header,
      final List<ImageListAudio>? audio})
      : _links = links,
        _header = header,
        _audio = audio,
        super._();

  final List<String> _links;
  @override
  List<String> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final Map<String, String>? _header;
  @override
  Map<String, String>? get header {
    final value = _header;
    if (value == null) return null;
    if (_header is EqualUnmodifiableMapView) return _header;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
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

  @override
  String toString() {
    return 'LinkSource.imagelist(links: $links, header: $header, audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_ImagelistImpl &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._header, _header) &&
            const DeepCollectionEquality().equals(other._audio, _audio));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_header),
      const DeepCollectionEquality().hash(_audio));

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_ImagelistImplCopyWith<_$LinkSource_ImagelistImpl>
      get copyWith =>
          __$$LinkSource_ImagelistImplCopyWithImpl<_$LinkSource_ImagelistImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
  }) {
    return imagelist(links, header, audio);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
  }) {
    return imagelist?.call(links, header, audio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
    required TResult orElse(),
  }) {
    if (imagelist != null) {
      return imagelist(links, header, audio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
  }) {
    return imagelist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
  }) {
    return imagelist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    required TResult orElse(),
  }) {
    if (imagelist != null) {
      return imagelist(this);
    }
    return orElse();
  }
}

abstract class LinkSource_Imagelist extends LinkSource {
  const factory LinkSource_Imagelist(
      {required final List<String> links,
      final Map<String, String>? header,
      final List<ImageListAudio>? audio}) = _$LinkSource_ImagelistImpl;
  const LinkSource_Imagelist._() : super._();

  List<String> get links;
  Map<String, String>? get header;
  List<ImageListAudio>? get audio;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_ImagelistImplCopyWith<_$LinkSource_ImagelistImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LinkSource_M3u8ImplCopyWith<$Res> {
  factory _$$LinkSource_M3u8ImplCopyWith(_$LinkSource_M3u8Impl value,
          $Res Function(_$LinkSource_M3u8Impl) then) =
      __$$LinkSource_M3u8ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String link, List<Subtitles> sub});
}

/// @nodoc
class __$$LinkSource_M3u8ImplCopyWithImpl<$Res>
    extends _$LinkSourceCopyWithImpl<$Res, _$LinkSource_M3u8Impl>
    implements _$$LinkSource_M3u8ImplCopyWith<$Res> {
  __$$LinkSource_M3u8ImplCopyWithImpl(
      _$LinkSource_M3u8Impl _value, $Res Function(_$LinkSource_M3u8Impl) _then)
      : super(_value, _then);

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? link = null,
    Object? sub = null,
  }) {
    return _then(_$LinkSource_M3u8Impl(
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      sub: null == sub
          ? _value._sub
          : sub // ignore: cast_nullable_to_non_nullable
              as List<Subtitles>,
    ));
  }
}

/// @nodoc

class _$LinkSource_M3u8Impl extends LinkSource_M3u8 {
  const _$LinkSource_M3u8Impl(
      {required this.link, required final List<Subtitles> sub})
      : _sub = sub,
        super._();

  @override
  final String link;
  final List<Subtitles> _sub;
  @override
  List<Subtitles> get sub {
    if (_sub is EqualUnmodifiableListView) return _sub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sub);
  }

  @override
  String toString() {
    return 'LinkSource.m3U8(link: $link, sub: $sub)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkSource_M3u8Impl &&
            (identical(other.link, link) || other.link == link) &&
            const DeepCollectionEquality().equals(other._sub, _sub));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, link, const DeepCollectionEquality().hash(_sub));

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkSource_M3u8ImplCopyWith<_$LinkSource_M3u8Impl> get copyWith =>
      __$$LinkSource_M3u8ImplCopyWithImpl<_$LinkSource_M3u8Impl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String link) epub,
    required TResult Function(String link) pdf,
    required TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(String link, List<Subtitles> sub) m3U8,
  }) {
    return m3U8(link, sub);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String link)? epub,
    TResult? Function(String link)? pdf,
    TResult? Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult? Function(String link, List<Subtitles> sub)? m3U8,
  }) {
    return m3U8?.call(link, sub);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String link)? epub,
    TResult Function(String link)? pdf,
    TResult Function(List<String> links, Map<String, String>? header,
            List<ImageListAudio>? audio)?
        imagelist,
    TResult Function(String link, List<Subtitles> sub)? m3U8,
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
    required TResult Function(LinkSource_Epub value) epub,
    required TResult Function(LinkSource_Pdf value) pdf,
    required TResult Function(LinkSource_Imagelist value) imagelist,
    required TResult Function(LinkSource_M3u8 value) m3U8,
  }) {
    return m3U8(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LinkSource_Epub value)? epub,
    TResult? Function(LinkSource_Pdf value)? pdf,
    TResult? Function(LinkSource_Imagelist value)? imagelist,
    TResult? Function(LinkSource_M3u8 value)? m3U8,
  }) {
    return m3U8?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LinkSource_Epub value)? epub,
    TResult Function(LinkSource_Pdf value)? pdf,
    TResult Function(LinkSource_Imagelist value)? imagelist,
    TResult Function(LinkSource_M3u8 value)? m3U8,
    required TResult orElse(),
  }) {
    if (m3U8 != null) {
      return m3U8(this);
    }
    return orElse();
  }
}

abstract class LinkSource_M3u8 extends LinkSource {
  const factory LinkSource_M3u8(
      {required final String link,
      required final List<Subtitles> sub}) = _$LinkSource_M3u8Impl;
  const LinkSource_M3u8._() : super._();

  String get link;
  List<Subtitles> get sub;

  /// Create a copy of LinkSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkSource_M3u8ImplCopyWith<_$LinkSource_M3u8Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Source {
  Object get sourcedata => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataSource sourcedata) data,
    required TResult Function(LinkSource sourcedata) directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataSource sourcedata)? data,
    TResult? Function(LinkSource sourcedata)? directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataSource sourcedata)? data,
    TResult Function(LinkSource sourcedata)? directlink,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Data value) data,
    required TResult Function(Source_Directlink value) directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Data value)? data,
    TResult? Function(Source_Directlink value)? directlink,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Data value)? data,
    TResult Function(Source_Directlink value)? directlink,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
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
abstract class _$$Source_DataImplCopyWith<$Res> {
  factory _$$Source_DataImplCopyWith(
          _$Source_DataImpl value, $Res Function(_$Source_DataImpl) then) =
      __$$Source_DataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DataSource sourcedata});

  $DataSourceCopyWith<$Res> get sourcedata;
}

/// @nodoc
class __$$Source_DataImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_DataImpl>
    implements _$$Source_DataImplCopyWith<$Res> {
  __$$Source_DataImplCopyWithImpl(
      _$Source_DataImpl _value, $Res Function(_$Source_DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourcedata = null,
  }) {
    return _then(_$Source_DataImpl(
      sourcedata: null == sourcedata
          ? _value.sourcedata
          : sourcedata // ignore: cast_nullable_to_non_nullable
              as DataSource,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataSourceCopyWith<$Res> get sourcedata {
    return $DataSourceCopyWith<$Res>(_value.sourcedata, (value) {
      return _then(_value.copyWith(sourcedata: value));
    });
  }
}

/// @nodoc

class _$Source_DataImpl extends Source_Data {
  const _$Source_DataImpl({required this.sourcedata}) : super._();

  @override
  final DataSource sourcedata;

  @override
  String toString() {
    return 'Source.data(sourcedata: $sourcedata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_DataImpl &&
            (identical(other.sourcedata, sourcedata) ||
                other.sourcedata == sourcedata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourcedata);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_DataImplCopyWith<_$Source_DataImpl> get copyWith =>
      __$$Source_DataImplCopyWithImpl<_$Source_DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataSource sourcedata) data,
    required TResult Function(LinkSource sourcedata) directlink,
  }) {
    return data(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataSource sourcedata)? data,
    TResult? Function(LinkSource sourcedata)? directlink,
  }) {
    return data?.call(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataSource sourcedata)? data,
    TResult Function(LinkSource sourcedata)? directlink,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(sourcedata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Data value) data,
    required TResult Function(Source_Directlink value) directlink,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Data value)? data,
    TResult? Function(Source_Directlink value)? directlink,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Data value)? data,
    TResult Function(Source_Directlink value)? directlink,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class Source_Data extends Source {
  const factory Source_Data({required final DataSource sourcedata}) =
      _$Source_DataImpl;
  const Source_Data._() : super._();

  @override
  DataSource get sourcedata;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_DataImplCopyWith<_$Source_DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Source_DirectlinkImplCopyWith<$Res> {
  factory _$$Source_DirectlinkImplCopyWith(_$Source_DirectlinkImpl value,
          $Res Function(_$Source_DirectlinkImpl) then) =
      __$$Source_DirectlinkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LinkSource sourcedata});

  $LinkSourceCopyWith<$Res> get sourcedata;
}

/// @nodoc
class __$$Source_DirectlinkImplCopyWithImpl<$Res>
    extends _$SourceCopyWithImpl<$Res, _$Source_DirectlinkImpl>
    implements _$$Source_DirectlinkImplCopyWith<$Res> {
  __$$Source_DirectlinkImplCopyWithImpl(_$Source_DirectlinkImpl _value,
      $Res Function(_$Source_DirectlinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourcedata = null,
  }) {
    return _then(_$Source_DirectlinkImpl(
      sourcedata: null == sourcedata
          ? _value.sourcedata
          : sourcedata // ignore: cast_nullable_to_non_nullable
              as LinkSource,
    ));
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LinkSourceCopyWith<$Res> get sourcedata {
    return $LinkSourceCopyWith<$Res>(_value.sourcedata, (value) {
      return _then(_value.copyWith(sourcedata: value));
    });
  }
}

/// @nodoc

class _$Source_DirectlinkImpl extends Source_Directlink {
  const _$Source_DirectlinkImpl({required this.sourcedata}) : super._();

  @override
  final LinkSource sourcedata;

  @override
  String toString() {
    return 'Source.directlink(sourcedata: $sourcedata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Source_DirectlinkImpl &&
            (identical(other.sourcedata, sourcedata) ||
                other.sourcedata == sourcedata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourcedata);

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Source_DirectlinkImplCopyWith<_$Source_DirectlinkImpl> get copyWith =>
      __$$Source_DirectlinkImplCopyWithImpl<_$Source_DirectlinkImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataSource sourcedata) data,
    required TResult Function(LinkSource sourcedata) directlink,
  }) {
    return directlink(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataSource sourcedata)? data,
    TResult? Function(LinkSource sourcedata)? directlink,
  }) {
    return directlink?.call(sourcedata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataSource sourcedata)? data,
    TResult Function(LinkSource sourcedata)? directlink,
    required TResult orElse(),
  }) {
    if (directlink != null) {
      return directlink(sourcedata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Source_Data value) data,
    required TResult Function(Source_Directlink value) directlink,
  }) {
    return directlink(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Source_Data value)? data,
    TResult? Function(Source_Directlink value)? directlink,
  }) {
    return directlink?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Source_Data value)? data,
    TResult Function(Source_Directlink value)? directlink,
    required TResult orElse(),
  }) {
    if (directlink != null) {
      return directlink(this);
    }
    return orElse();
  }
}

abstract class Source_Directlink extends Source {
  const factory Source_Directlink({required final LinkSource sourcedata}) =
      _$Source_DirectlinkImpl;
  const Source_Directlink._() : super._();

  @override
  LinkSource get sourcedata;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_DirectlinkImplCopyWith<_$Source_DirectlinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
