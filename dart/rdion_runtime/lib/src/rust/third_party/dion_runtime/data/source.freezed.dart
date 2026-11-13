// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MixedContent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MixedContent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MixedContent()';
  }
}

/// @nodoc
class $MixedContentCopyWith<$Res> {
  $MixedContentCopyWith(MixedContent _, $Res Function(MixedContent) __);
}

/// Adds pattern-matching-related methods to [MixedContent].
extension MixedContentPatterns on MixedContent {
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
    TResult Function(MixedContent_Text value)? text,
    TResult Function(MixedContent_CustomUI value)? customUi,
    TResult Function(MixedContent_Table value)? table,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MixedContent_Text() when text != null:
        return text(_that);
      case MixedContent_CustomUI() when customUi != null:
        return customUi(_that);
      case MixedContent_Table() when table != null:
        return table(_that);
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
    required TResult Function(MixedContent_Text value) text,
    required TResult Function(MixedContent_CustomUI value) customUi,
    required TResult Function(MixedContent_Table value) table,
  }) {
    final _that = this;
    switch (_that) {
      case MixedContent_Text():
        return text(_that);
      case MixedContent_CustomUI():
        return customUi(_that);
      case MixedContent_Table():
        return table(_that);
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
    TResult? Function(MixedContent_Text value)? text,
    TResult? Function(MixedContent_CustomUI value)? customUi,
    TResult? Function(MixedContent_Table value)? table,
  }) {
    final _that = this;
    switch (_that) {
      case MixedContent_Text() when text != null:
        return text(_that);
      case MixedContent_CustomUI() when customUi != null:
        return customUi(_that);
      case MixedContent_Table() when table != null:
        return table(_that);
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
    TResult Function(String content, TextStyle? style)? text,
    TResult Function(CustomUI ui)? customUi,
    TResult Function(List<Row> columns)? table,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case MixedContent_Text() when text != null:
        return text(_that.content, _that.style);
      case MixedContent_CustomUI() when customUi != null:
        return customUi(_that.ui);
      case MixedContent_Table() when table != null:
        return table(_that.columns);
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
    required TResult Function(String content, TextStyle? style) text,
    required TResult Function(CustomUI ui) customUi,
    required TResult Function(List<Row> columns) table,
  }) {
    final _that = this;
    switch (_that) {
      case MixedContent_Text():
        return text(_that.content, _that.style);
      case MixedContent_CustomUI():
        return customUi(_that.ui);
      case MixedContent_Table():
        return table(_that.columns);
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
    TResult? Function(String content, TextStyle? style)? text,
    TResult? Function(CustomUI ui)? customUi,
    TResult? Function(List<Row> columns)? table,
  }) {
    final _that = this;
    switch (_that) {
      case MixedContent_Text() when text != null:
        return text(_that.content, _that.style);
      case MixedContent_CustomUI() when customUi != null:
        return customUi(_that.ui);
      case MixedContent_Table() when table != null:
        return table(_that.columns);
      case _:
        return null;
    }
  }
}

/// @nodoc

class MixedContent_Text extends MixedContent {
  const MixedContent_Text({required this.content, this.style}) : super._();

  final String content;
  final TextStyle? style;

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MixedContent_TextCopyWith<MixedContent_Text> get copyWith =>
      _$MixedContent_TextCopyWithImpl<MixedContent_Text>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MixedContent_Text &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.style, style) || other.style == style));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, style);

  @override
  String toString() {
    return 'MixedContent.text(content: $content, style: $style)';
  }
}

/// @nodoc
abstract mixin class $MixedContent_TextCopyWith<$Res>
    implements $MixedContentCopyWith<$Res> {
  factory $MixedContent_TextCopyWith(
          MixedContent_Text value, $Res Function(MixedContent_Text) _then) =
      _$MixedContent_TextCopyWithImpl;
  @useResult
  $Res call({String content, TextStyle? style});
}

/// @nodoc
class _$MixedContent_TextCopyWithImpl<$Res>
    implements $MixedContent_TextCopyWith<$Res> {
  _$MixedContent_TextCopyWithImpl(this._self, this._then);

  final MixedContent_Text _self;
  final $Res Function(MixedContent_Text) _then;

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
    Object? style = freezed,
  }) {
    return _then(MixedContent_Text(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyle?,
    ));
  }
}

/// @nodoc

class MixedContent_CustomUI extends MixedContent {
  const MixedContent_CustomUI({required this.ui}) : super._();

  final CustomUI ui;

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MixedContent_CustomUICopyWith<MixedContent_CustomUI> get copyWith =>
      _$MixedContent_CustomUICopyWithImpl<MixedContent_CustomUI>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MixedContent_CustomUI &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ui);

  @override
  String toString() {
    return 'MixedContent.customUi(ui: $ui)';
  }
}

/// @nodoc
abstract mixin class $MixedContent_CustomUICopyWith<$Res>
    implements $MixedContentCopyWith<$Res> {
  factory $MixedContent_CustomUICopyWith(MixedContent_CustomUI value,
          $Res Function(MixedContent_CustomUI) _then) =
      _$MixedContent_CustomUICopyWithImpl;
  @useResult
  $Res call({CustomUI ui});

  $CustomUICopyWith<$Res> get ui;
}

/// @nodoc
class _$MixedContent_CustomUICopyWithImpl<$Res>
    implements $MixedContent_CustomUICopyWith<$Res> {
  _$MixedContent_CustomUICopyWithImpl(this._self, this._then);

  final MixedContent_CustomUI _self;
  final $Res Function(MixedContent_CustomUI) _then;

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ui = null,
  }) {
    return _then(MixedContent_CustomUI(
      ui: null == ui
          ? _self.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get ui {
    return $CustomUICopyWith<$Res>(_self.ui, (value) {
      return _then(_self.copyWith(ui: value));
    });
  }
}

/// @nodoc

class MixedContent_Table extends MixedContent {
  const MixedContent_Table({required final List<Row> columns})
      : _columns = columns,
        super._();

  final List<Row> _columns;
  List<Row> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MixedContent_TableCopyWith<MixedContent_Table> get copyWith =>
      _$MixedContent_TableCopyWithImpl<MixedContent_Table>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MixedContent_Table &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_columns));

  @override
  String toString() {
    return 'MixedContent.table(columns: $columns)';
  }
}

/// @nodoc
abstract mixin class $MixedContent_TableCopyWith<$Res>
    implements $MixedContentCopyWith<$Res> {
  factory $MixedContent_TableCopyWith(
          MixedContent_Table value, $Res Function(MixedContent_Table) _then) =
      _$MixedContent_TableCopyWithImpl;
  @useResult
  $Res call({List<Row> columns});
}

/// @nodoc
class _$MixedContent_TableCopyWithImpl<$Res>
    implements $MixedContent_TableCopyWith<$Res> {
  _$MixedContent_TableCopyWithImpl(this._self, this._then);

  final MixedContent_Table _self;
  final $Res Function(MixedContent_Table) _then;

  /// Create a copy of MixedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? columns = null,
  }) {
    return _then(MixedContent_Table(
      columns: null == columns
          ? _self._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<Row>,
    ));
  }
}

/// @nodoc
mixin _$Paragraph {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Paragraph);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Paragraph()';
  }
}

/// @nodoc
class $ParagraphCopyWith<$Res> {
  $ParagraphCopyWith(Paragraph _, $Res Function(Paragraph) __);
}

/// Adds pattern-matching-related methods to [Paragraph].
extension ParagraphPatterns on Paragraph {
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
    TResult Function(Paragraph_Text value)? text,
    TResult Function(Paragraph_Mixed value)? mixed,
    TResult Function(Paragraph_CustomUI value)? customUi,
    TResult Function(Paragraph_Table value)? table,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Paragraph_Text() when text != null:
        return text(_that);
      case Paragraph_Mixed() when mixed != null:
        return mixed(_that);
      case Paragraph_CustomUI() when customUi != null:
        return customUi(_that);
      case Paragraph_Table() when table != null:
        return table(_that);
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
    required TResult Function(Paragraph_Text value) text,
    required TResult Function(Paragraph_Mixed value) mixed,
    required TResult Function(Paragraph_CustomUI value) customUi,
    required TResult Function(Paragraph_Table value) table,
  }) {
    final _that = this;
    switch (_that) {
      case Paragraph_Text():
        return text(_that);
      case Paragraph_Mixed():
        return mixed(_that);
      case Paragraph_CustomUI():
        return customUi(_that);
      case Paragraph_Table():
        return table(_that);
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
    TResult? Function(Paragraph_Text value)? text,
    TResult? Function(Paragraph_Mixed value)? mixed,
    TResult? Function(Paragraph_CustomUI value)? customUi,
    TResult? Function(Paragraph_Table value)? table,
  }) {
    final _that = this;
    switch (_that) {
      case Paragraph_Text() when text != null:
        return text(_that);
      case Paragraph_Mixed() when mixed != null:
        return mixed(_that);
      case Paragraph_CustomUI() when customUi != null:
        return customUi(_that);
      case Paragraph_Table() when table != null:
        return table(_that);
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
    TResult Function(String content, TextStyle? style)? text,
    TResult Function(List<MixedContent> content)? mixed,
    TResult Function(CustomUI ui)? customUi,
    TResult Function(List<Row> columns)? table,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Paragraph_Text() when text != null:
        return text(_that.content, _that.style);
      case Paragraph_Mixed() when mixed != null:
        return mixed(_that.content);
      case Paragraph_CustomUI() when customUi != null:
        return customUi(_that.ui);
      case Paragraph_Table() when table != null:
        return table(_that.columns);
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
    required TResult Function(String content, TextStyle? style) text,
    required TResult Function(List<MixedContent> content) mixed,
    required TResult Function(CustomUI ui) customUi,
    required TResult Function(List<Row> columns) table,
  }) {
    final _that = this;
    switch (_that) {
      case Paragraph_Text():
        return text(_that.content, _that.style);
      case Paragraph_Mixed():
        return mixed(_that.content);
      case Paragraph_CustomUI():
        return customUi(_that.ui);
      case Paragraph_Table():
        return table(_that.columns);
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
    TResult? Function(String content, TextStyle? style)? text,
    TResult? Function(List<MixedContent> content)? mixed,
    TResult? Function(CustomUI ui)? customUi,
    TResult? Function(List<Row> columns)? table,
  }) {
    final _that = this;
    switch (_that) {
      case Paragraph_Text() when text != null:
        return text(_that.content, _that.style);
      case Paragraph_Mixed() when mixed != null:
        return mixed(_that.content);
      case Paragraph_CustomUI() when customUi != null:
        return customUi(_that.ui);
      case Paragraph_Table() when table != null:
        return table(_that.columns);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Paragraph_Text extends Paragraph {
  const Paragraph_Text({required this.content, this.style}) : super._();

  final String content;
  final TextStyle? style;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Paragraph_TextCopyWith<Paragraph_Text> get copyWith =>
      _$Paragraph_TextCopyWithImpl<Paragraph_Text>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Paragraph_Text &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.style, style) || other.style == style));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, style);

  @override
  String toString() {
    return 'Paragraph.text(content: $content, style: $style)';
  }
}

/// @nodoc
abstract mixin class $Paragraph_TextCopyWith<$Res>
    implements $ParagraphCopyWith<$Res> {
  factory $Paragraph_TextCopyWith(
          Paragraph_Text value, $Res Function(Paragraph_Text) _then) =
      _$Paragraph_TextCopyWithImpl;
  @useResult
  $Res call({String content, TextStyle? style});
}

/// @nodoc
class _$Paragraph_TextCopyWithImpl<$Res>
    implements $Paragraph_TextCopyWith<$Res> {
  _$Paragraph_TextCopyWithImpl(this._self, this._then);

  final Paragraph_Text _self;
  final $Res Function(Paragraph_Text) _then;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
    Object? style = freezed,
  }) {
    return _then(Paragraph_Text(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyle?,
    ));
  }
}

/// @nodoc

class Paragraph_Mixed extends Paragraph {
  const Paragraph_Mixed({required final List<MixedContent> content})
      : _content = content,
        super._();

  final List<MixedContent> _content;
  List<MixedContent> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Paragraph_MixedCopyWith<Paragraph_Mixed> get copyWith =>
      _$Paragraph_MixedCopyWithImpl<Paragraph_Mixed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Paragraph_Mixed &&
            const DeepCollectionEquality().equals(other._content, _content));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_content));

  @override
  String toString() {
    return 'Paragraph.mixed(content: $content)';
  }
}

/// @nodoc
abstract mixin class $Paragraph_MixedCopyWith<$Res>
    implements $ParagraphCopyWith<$Res> {
  factory $Paragraph_MixedCopyWith(
          Paragraph_Mixed value, $Res Function(Paragraph_Mixed) _then) =
      _$Paragraph_MixedCopyWithImpl;
  @useResult
  $Res call({List<MixedContent> content});
}

/// @nodoc
class _$Paragraph_MixedCopyWithImpl<$Res>
    implements $Paragraph_MixedCopyWith<$Res> {
  _$Paragraph_MixedCopyWithImpl(this._self, this._then);

  final Paragraph_Mixed _self;
  final $Res Function(Paragraph_Mixed) _then;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
  }) {
    return _then(Paragraph_Mixed(
      content: null == content
          ? _self._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<MixedContent>,
    ));
  }
}

/// @nodoc

class Paragraph_CustomUI extends Paragraph {
  const Paragraph_CustomUI({required this.ui}) : super._();

  final CustomUI ui;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Paragraph_CustomUICopyWith<Paragraph_CustomUI> get copyWith =>
      _$Paragraph_CustomUICopyWithImpl<Paragraph_CustomUI>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Paragraph_CustomUI &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ui);

  @override
  String toString() {
    return 'Paragraph.customUi(ui: $ui)';
  }
}

/// @nodoc
abstract mixin class $Paragraph_CustomUICopyWith<$Res>
    implements $ParagraphCopyWith<$Res> {
  factory $Paragraph_CustomUICopyWith(
          Paragraph_CustomUI value, $Res Function(Paragraph_CustomUI) _then) =
      _$Paragraph_CustomUICopyWithImpl;
  @useResult
  $Res call({CustomUI ui});

  $CustomUICopyWith<$Res> get ui;
}

/// @nodoc
class _$Paragraph_CustomUICopyWithImpl<$Res>
    implements $Paragraph_CustomUICopyWith<$Res> {
  _$Paragraph_CustomUICopyWithImpl(this._self, this._then);

  final Paragraph_CustomUI _self;
  final $Res Function(Paragraph_CustomUI) _then;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ui = null,
  }) {
    return _then(Paragraph_CustomUI(
      ui: null == ui
          ? _self.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as CustomUI,
    ));
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomUICopyWith<$Res> get ui {
    return $CustomUICopyWith<$Res>(_self.ui, (value) {
      return _then(_self.copyWith(ui: value));
    });
  }
}

/// @nodoc

class Paragraph_Table extends Paragraph {
  const Paragraph_Table({required final List<Row> columns})
      : _columns = columns,
        super._();

  final List<Row> _columns;
  List<Row> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Paragraph_TableCopyWith<Paragraph_Table> get copyWith =>
      _$Paragraph_TableCopyWithImpl<Paragraph_Table>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Paragraph_Table &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_columns));

  @override
  String toString() {
    return 'Paragraph.table(columns: $columns)';
  }
}

/// @nodoc
abstract mixin class $Paragraph_TableCopyWith<$Res>
    implements $ParagraphCopyWith<$Res> {
  factory $Paragraph_TableCopyWith(
          Paragraph_Table value, $Res Function(Paragraph_Table) _then) =
      _$Paragraph_TableCopyWithImpl;
  @useResult
  $Res call({List<Row> columns});
}

/// @nodoc
class _$Paragraph_TableCopyWithImpl<$Res>
    implements $Paragraph_TableCopyWith<$Res> {
  _$Paragraph_TableCopyWithImpl(this._self, this._then);

  final Paragraph_Table _self;
  final $Res Function(Paragraph_Table) _then;

  /// Create a copy of Paragraph
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? columns = null,
  }) {
    return _then(Paragraph_Table(
      columns: null == columns
          ? _self._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<Row>,
    ));
  }
}

/// @nodoc
mixin _$Source {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Source);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Source()';
  }
}

/// @nodoc
class $SourceCopyWith<$Res> {
  $SourceCopyWith(Source _, $Res Function(Source) __);
}

/// Adds pattern-matching-related methods to [Source].
extension SourcePatterns on Source {
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
    TResult Function(Source_Epub value)? epub,
    TResult Function(Source_Pdf value)? pdf,
    TResult Function(Source_Imagelist value)? imagelist,
    TResult Function(Source_Video value)? video,
    TResult Function(Source_Audio value)? audio,
    TResult Function(Source_Paragraphlist value)? paragraphlist,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Source_Epub() when epub != null:
        return epub(_that);
      case Source_Pdf() when pdf != null:
        return pdf(_that);
      case Source_Imagelist() when imagelist != null:
        return imagelist(_that);
      case Source_Video() when video != null:
        return video(_that);
      case Source_Audio() when audio != null:
        return audio(_that);
      case Source_Paragraphlist() when paragraphlist != null:
        return paragraphlist(_that);
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
    required TResult Function(Source_Epub value) epub,
    required TResult Function(Source_Pdf value) pdf,
    required TResult Function(Source_Imagelist value) imagelist,
    required TResult Function(Source_Video value) video,
    required TResult Function(Source_Audio value) audio,
    required TResult Function(Source_Paragraphlist value) paragraphlist,
  }) {
    final _that = this;
    switch (_that) {
      case Source_Epub():
        return epub(_that);
      case Source_Pdf():
        return pdf(_that);
      case Source_Imagelist():
        return imagelist(_that);
      case Source_Video():
        return video(_that);
      case Source_Audio():
        return audio(_that);
      case Source_Paragraphlist():
        return paragraphlist(_that);
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
    TResult? Function(Source_Epub value)? epub,
    TResult? Function(Source_Pdf value)? pdf,
    TResult? Function(Source_Imagelist value)? imagelist,
    TResult? Function(Source_Video value)? video,
    TResult? Function(Source_Audio value)? audio,
    TResult? Function(Source_Paragraphlist value)? paragraphlist,
  }) {
    final _that = this;
    switch (_that) {
      case Source_Epub() when epub != null:
        return epub(_that);
      case Source_Pdf() when pdf != null:
        return pdf(_that);
      case Source_Imagelist() when imagelist != null:
        return imagelist(_that);
      case Source_Video() when video != null:
        return video(_that);
      case Source_Audio() when audio != null:
        return audio(_that);
      case Source_Paragraphlist() when paragraphlist != null:
        return paragraphlist(_that);
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
    TResult Function(Link link)? epub,
    TResult Function(Link link)? pdf,
    TResult Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult Function(List<StreamSource> sources, List<Subtitles> sub,
            List<Chapter>? chapters)?
        video,
    TResult Function(List<StreamSource> sources, List<Chapter>? chapters)?
        audio,
    TResult Function(List<Paragraph> paragraphs, List<ImageListAudio>? audio)?
        paragraphlist,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Source_Epub() when epub != null:
        return epub(_that.link);
      case Source_Pdf() when pdf != null:
        return pdf(_that.link);
      case Source_Imagelist() when imagelist != null:
        return imagelist(_that.links, _that.audio);
      case Source_Video() when video != null:
        return video(_that.sources, _that.sub, _that.chapters);
      case Source_Audio() when audio != null:
        return audio(_that.sources, _that.chapters);
      case Source_Paragraphlist() when paragraphlist != null:
        return paragraphlist(_that.paragraphs, _that.audio);
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
    required TResult Function(Link link) epub,
    required TResult Function(Link link) pdf,
    required TResult Function(List<Link> links, List<ImageListAudio>? audio)
        imagelist,
    required TResult Function(List<StreamSource> sources, List<Subtitles> sub,
            List<Chapter>? chapters)
        video,
    required TResult Function(
            List<StreamSource> sources, List<Chapter>? chapters)
        audio,
    required TResult Function(
            List<Paragraph> paragraphs, List<ImageListAudio>? audio)
        paragraphlist,
  }) {
    final _that = this;
    switch (_that) {
      case Source_Epub():
        return epub(_that.link);
      case Source_Pdf():
        return pdf(_that.link);
      case Source_Imagelist():
        return imagelist(_that.links, _that.audio);
      case Source_Video():
        return video(_that.sources, _that.sub, _that.chapters);
      case Source_Audio():
        return audio(_that.sources, _that.chapters);
      case Source_Paragraphlist():
        return paragraphlist(_that.paragraphs, _that.audio);
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
    TResult? Function(Link link)? epub,
    TResult? Function(Link link)? pdf,
    TResult? Function(List<Link> links, List<ImageListAudio>? audio)? imagelist,
    TResult? Function(List<StreamSource> sources, List<Subtitles> sub,
            List<Chapter>? chapters)?
        video,
    TResult? Function(List<StreamSource> sources, List<Chapter>? chapters)?
        audio,
    TResult? Function(List<Paragraph> paragraphs, List<ImageListAudio>? audio)?
        paragraphlist,
  }) {
    final _that = this;
    switch (_that) {
      case Source_Epub() when epub != null:
        return epub(_that.link);
      case Source_Pdf() when pdf != null:
        return pdf(_that.link);
      case Source_Imagelist() when imagelist != null:
        return imagelist(_that.links, _that.audio);
      case Source_Video() when video != null:
        return video(_that.sources, _that.sub, _that.chapters);
      case Source_Audio() when audio != null:
        return audio(_that.sources, _that.chapters);
      case Source_Paragraphlist() when paragraphlist != null:
        return paragraphlist(_that.paragraphs, _that.audio);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Source_Epub extends Source {
  const Source_Epub({required this.link}) : super._();

  final Link link;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Source_EpubCopyWith<Source_Epub> get copyWith =>
      _$Source_EpubCopyWithImpl<Source_Epub>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source_Epub &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  @override
  String toString() {
    return 'Source.epub(link: $link)';
  }
}

/// @nodoc
abstract mixin class $Source_EpubCopyWith<$Res>
    implements $SourceCopyWith<$Res> {
  factory $Source_EpubCopyWith(
          Source_Epub value, $Res Function(Source_Epub) _then) =
      _$Source_EpubCopyWithImpl;
  @useResult
  $Res call({Link link});
}

/// @nodoc
class _$Source_EpubCopyWithImpl<$Res> implements $Source_EpubCopyWith<$Res> {
  _$Source_EpubCopyWithImpl(this._self, this._then);

  final Source_Epub _self;
  final $Res Function(Source_Epub) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? link = null,
  }) {
    return _then(Source_Epub(
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
    ));
  }
}

/// @nodoc

class Source_Pdf extends Source {
  const Source_Pdf({required this.link}) : super._();

  final Link link;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Source_PdfCopyWith<Source_Pdf> get copyWith =>
      _$Source_PdfCopyWithImpl<Source_Pdf>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source_Pdf &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode => Object.hash(runtimeType, link);

  @override
  String toString() {
    return 'Source.pdf(link: $link)';
  }
}

/// @nodoc
abstract mixin class $Source_PdfCopyWith<$Res>
    implements $SourceCopyWith<$Res> {
  factory $Source_PdfCopyWith(
          Source_Pdf value, $Res Function(Source_Pdf) _then) =
      _$Source_PdfCopyWithImpl;
  @useResult
  $Res call({Link link});
}

/// @nodoc
class _$Source_PdfCopyWithImpl<$Res> implements $Source_PdfCopyWith<$Res> {
  _$Source_PdfCopyWithImpl(this._self, this._then);

  final Source_Pdf _self;
  final $Res Function(Source_Pdf) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? link = null,
  }) {
    return _then(Source_Pdf(
      link: null == link
          ? _self.link
          : link // ignore: cast_nullable_to_non_nullable
              as Link,
    ));
  }
}

/// @nodoc

class Source_Imagelist extends Source {
  const Source_Imagelist(
      {required final List<Link> links, final List<ImageListAudio>? audio})
      : _links = links,
        _audio = audio,
        super._();

  final List<Link> _links;
  List<Link> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final List<ImageListAudio>? _audio;
  List<ImageListAudio>? get audio {
    final value = _audio;
    if (value == null) return null;
    if (_audio is EqualUnmodifiableListView) return _audio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Source_ImagelistCopyWith<Source_Imagelist> get copyWith =>
      _$Source_ImagelistCopyWithImpl<Source_Imagelist>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source_Imagelist &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(other._audio, _audio));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_links),
      const DeepCollectionEquality().hash(_audio));

  @override
  String toString() {
    return 'Source.imagelist(links: $links, audio: $audio)';
  }
}

/// @nodoc
abstract mixin class $Source_ImagelistCopyWith<$Res>
    implements $SourceCopyWith<$Res> {
  factory $Source_ImagelistCopyWith(
          Source_Imagelist value, $Res Function(Source_Imagelist) _then) =
      _$Source_ImagelistCopyWithImpl;
  @useResult
  $Res call({List<Link> links, List<ImageListAudio>? audio});
}

/// @nodoc
class _$Source_ImagelistCopyWithImpl<$Res>
    implements $Source_ImagelistCopyWith<$Res> {
  _$Source_ImagelistCopyWithImpl(this._self, this._then);

  final Source_Imagelist _self;
  final $Res Function(Source_Imagelist) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? links = null,
    Object? audio = freezed,
  }) {
    return _then(Source_Imagelist(
      links: null == links
          ? _self._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Link>,
      audio: freezed == audio
          ? _self._audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<ImageListAudio>?,
    ));
  }
}

/// @nodoc

class Source_Video extends Source {
  const Source_Video(
      {required final List<StreamSource> sources,
      required final List<Subtitles> sub,
      final List<Chapter>? chapters})
      : _sources = sources,
        _sub = sub,
        _chapters = chapters,
        super._();

  final List<StreamSource> _sources;
  List<StreamSource> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  final List<Subtitles> _sub;
  List<Subtitles> get sub {
    if (_sub is EqualUnmodifiableListView) return _sub;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sub);
  }

  final List<Chapter>? _chapters;
  List<Chapter>? get chapters {
    final value = _chapters;
    if (value == null) return null;
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Source_VideoCopyWith<Source_Video> get copyWith =>
      _$Source_VideoCopyWithImpl<Source_Video>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source_Video &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            const DeepCollectionEquality().equals(other._sub, _sub) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sources),
      const DeepCollectionEquality().hash(_sub),
      const DeepCollectionEquality().hash(_chapters));

  @override
  String toString() {
    return 'Source.video(sources: $sources, sub: $sub, chapters: $chapters)';
  }
}

/// @nodoc
abstract mixin class $Source_VideoCopyWith<$Res>
    implements $SourceCopyWith<$Res> {
  factory $Source_VideoCopyWith(
          Source_Video value, $Res Function(Source_Video) _then) =
      _$Source_VideoCopyWithImpl;
  @useResult
  $Res call(
      {List<StreamSource> sources,
      List<Subtitles> sub,
      List<Chapter>? chapters});
}

/// @nodoc
class _$Source_VideoCopyWithImpl<$Res> implements $Source_VideoCopyWith<$Res> {
  _$Source_VideoCopyWithImpl(this._self, this._then);

  final Source_Video _self;
  final $Res Function(Source_Video) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sources = null,
    Object? sub = null,
    Object? chapters = freezed,
  }) {
    return _then(Source_Video(
      sources: null == sources
          ? _self._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<StreamSource>,
      sub: null == sub
          ? _self._sub
          : sub // ignore: cast_nullable_to_non_nullable
              as List<Subtitles>,
      chapters: freezed == chapters
          ? _self._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>?,
    ));
  }
}

/// @nodoc

class Source_Audio extends Source {
  const Source_Audio(
      {required final List<StreamSource> sources,
      final List<Chapter>? chapters})
      : _sources = sources,
        _chapters = chapters,
        super._();

  final List<StreamSource> _sources;
  List<StreamSource> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  final List<Chapter>? _chapters;
  List<Chapter>? get chapters {
    final value = _chapters;
    if (value == null) return null;
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Source_AudioCopyWith<Source_Audio> get copyWith =>
      _$Source_AudioCopyWithImpl<Source_Audio>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source_Audio &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sources),
      const DeepCollectionEquality().hash(_chapters));

  @override
  String toString() {
    return 'Source.audio(sources: $sources, chapters: $chapters)';
  }
}

/// @nodoc
abstract mixin class $Source_AudioCopyWith<$Res>
    implements $SourceCopyWith<$Res> {
  factory $Source_AudioCopyWith(
          Source_Audio value, $Res Function(Source_Audio) _then) =
      _$Source_AudioCopyWithImpl;
  @useResult
  $Res call({List<StreamSource> sources, List<Chapter>? chapters});
}

/// @nodoc
class _$Source_AudioCopyWithImpl<$Res> implements $Source_AudioCopyWith<$Res> {
  _$Source_AudioCopyWithImpl(this._self, this._then);

  final Source_Audio _self;
  final $Res Function(Source_Audio) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sources = null,
    Object? chapters = freezed,
  }) {
    return _then(Source_Audio(
      sources: null == sources
          ? _self._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<StreamSource>,
      chapters: freezed == chapters
          ? _self._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>?,
    ));
  }
}

/// @nodoc

class Source_Paragraphlist extends Source {
  const Source_Paragraphlist(
      {required final List<Paragraph> paragraphs,
      final List<ImageListAudio>? audio})
      : _paragraphs = paragraphs,
        _audio = audio,
        super._();

  final List<Paragraph> _paragraphs;
  List<Paragraph> get paragraphs {
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paragraphs);
  }

  final List<ImageListAudio>? _audio;
  List<ImageListAudio>? get audio {
    final value = _audio;
    if (value == null) return null;
    if (_audio is EqualUnmodifiableListView) return _audio;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Source_ParagraphlistCopyWith<Source_Paragraphlist> get copyWith =>
      _$Source_ParagraphlistCopyWithImpl<Source_Paragraphlist>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Source_Paragraphlist &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs) &&
            const DeepCollectionEquality().equals(other._audio, _audio));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_paragraphs),
      const DeepCollectionEquality().hash(_audio));

  @override
  String toString() {
    return 'Source.paragraphlist(paragraphs: $paragraphs, audio: $audio)';
  }
}

/// @nodoc
abstract mixin class $Source_ParagraphlistCopyWith<$Res>
    implements $SourceCopyWith<$Res> {
  factory $Source_ParagraphlistCopyWith(Source_Paragraphlist value,
          $Res Function(Source_Paragraphlist) _then) =
      _$Source_ParagraphlistCopyWithImpl;
  @useResult
  $Res call({List<Paragraph> paragraphs, List<ImageListAudio>? audio});
}

/// @nodoc
class _$Source_ParagraphlistCopyWithImpl<$Res>
    implements $Source_ParagraphlistCopyWith<$Res> {
  _$Source_ParagraphlistCopyWithImpl(this._self, this._then);

  final Source_Paragraphlist _self;
  final $Res Function(Source_Paragraphlist) _then;

  /// Create a copy of Source
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? paragraphs = null,
    Object? audio = freezed,
  }) {
    return _then(Source_Paragraphlist(
      paragraphs: null == paragraphs
          ? _self._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<Paragraph>,
      audio: freezed == audio
          ? _self._audio
          : audio // ignore: cast_nullable_to_non_nullable
              as List<ImageListAudio>?,
    ));
  }
}

// dart format on
