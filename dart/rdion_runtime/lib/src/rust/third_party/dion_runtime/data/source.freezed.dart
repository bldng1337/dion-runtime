// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

class _$Paragraph_TextImpl extends Paragraph_Text {
  const _$Paragraph_TextImpl({required this.content}) : super._();

  @override
  final String content;

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
}

abstract class Paragraph_Text extends Paragraph {
  const factory Paragraph_Text({required final String content}) =
      _$Paragraph_TextImpl;
  const Paragraph_Text._() : super._();

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

class _$Paragraph_CustomUIImpl extends Paragraph_CustomUI {
  const _$Paragraph_CustomUIImpl({required this.ui}) : super._();

  @override
  final CustomUI ui;

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
}

abstract class Paragraph_CustomUI extends Paragraph {
  const factory Paragraph_CustomUI({required final CustomUI ui}) =
      _$Paragraph_CustomUIImpl;
  const Paragraph_CustomUI._() : super._();

  CustomUI get ui;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Paragraph_CustomUIImplCopyWith<_$Paragraph_CustomUIImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
}

/// @nodoc

class _$Source_EpubImpl extends Source_Epub {
  const _$Source_EpubImpl({required this.link}) : super._();

  @override
  final Link link;

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
}

abstract class Source_Epub extends Source {
  const factory Source_Epub({required final Link link}) = _$Source_EpubImpl;
  const Source_Epub._() : super._();

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
}

/// @nodoc

class _$Source_PdfImpl extends Source_Pdf {
  const _$Source_PdfImpl({required this.link}) : super._();

  @override
  final Link link;

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
}

abstract class Source_Pdf extends Source {
  const factory Source_Pdf({required final Link link}) = _$Source_PdfImpl;
  const Source_Pdf._() : super._();

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

class _$Source_ImagelistImpl extends Source_Imagelist {
  const _$Source_ImagelistImpl(
      {required final List<Link> links, final List<ImageListAudio>? audio})
      : _links = links,
        _audio = audio,
        super._();

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
}

abstract class Source_Imagelist extends Source {
  const factory Source_Imagelist(
      {required final List<Link> links,
      final List<ImageListAudio>? audio}) = _$Source_ImagelistImpl;
  const Source_Imagelist._() : super._();

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
}

/// @nodoc

class _$Source_M3u8Impl extends Source_M3u8 {
  const _$Source_M3u8Impl(
      {required this.link, required final List<Subtitles> sub})
      : _sub = sub,
        super._();

  @override
  final Link link;
  final List<Subtitles> _sub;
  @override
  List<Subtitles> get sub {
    if (_sub is EqualUnmodifiableListView) return _sub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sub);
  }

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
}

abstract class Source_M3u8 extends Source {
  const factory Source_M3u8(
      {required final Link link,
      required final List<Subtitles> sub}) = _$Source_M3u8Impl;
  const Source_M3u8._() : super._();

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

class _$Source_Mp3Impl extends Source_Mp3 {
  const _$Source_Mp3Impl({required final List<Mp3Chapter> chapters})
      : _chapters = chapters,
        super._();

  final List<Mp3Chapter> _chapters;
  @override
  List<Mp3Chapter> get chapters {
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chapters);
  }

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
}

abstract class Source_Mp3 extends Source {
  const factory Source_Mp3({required final List<Mp3Chapter> chapters}) =
      _$Source_Mp3Impl;
  const Source_Mp3._() : super._();

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

class _$Source_ParagraphlistImpl extends Source_Paragraphlist {
  const _$Source_ParagraphlistImpl({required final List<Paragraph> paragraphs})
      : _paragraphs = paragraphs,
        super._();

  final List<Paragraph> _paragraphs;
  @override
  List<Paragraph> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

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
}

abstract class Source_Paragraphlist extends Source {
  const factory Source_Paragraphlist(
      {required final List<Paragraph> paragraphs}) = _$Source_ParagraphlistImpl;
  const Source_Paragraphlist._() : super._();

  List<Paragraph> get paragraphs;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Source_ParagraphlistImplCopyWith<_$Source_ParagraphlistImpl>
      get copyWith => throw _privateConstructorUsedError;
}
