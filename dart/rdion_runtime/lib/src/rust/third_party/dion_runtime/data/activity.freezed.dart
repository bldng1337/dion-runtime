// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntryActivity {
  int get progress;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EntryActivityCopyWith<EntryActivity> get copyWith =>
      _$EntryActivityCopyWithImpl<EntryActivity>(
          this as EntryActivity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EntryActivity &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  @override
  String toString() {
    return 'EntryActivity(progress: $progress)';
  }
}

/// @nodoc
abstract mixin class $EntryActivityCopyWith<$Res> {
  factory $EntryActivityCopyWith(
          EntryActivity value, $Res Function(EntryActivity) _then) =
      _$EntryActivityCopyWithImpl;
  @useResult
  $Res call({int progress});
}

/// @nodoc
class _$EntryActivityCopyWithImpl<$Res>
    implements $EntryActivityCopyWith<$Res> {
  _$EntryActivityCopyWithImpl(this._self, this._then);

  final EntryActivity _self;
  final $Res Function(EntryActivity) _then;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
  }) {
    return _then(_self.copyWith(
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [EntryActivity].
extension EntryActivityPatterns on EntryActivity {
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
    TResult Function(EntryActivity_EpisodeActivity value)? episodeActivity,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EntryActivity_EpisodeActivity() when episodeActivity != null:
        return episodeActivity(_that);
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
    required TResult Function(EntryActivity_EpisodeActivity value)
        episodeActivity,
  }) {
    final _that = this;
    switch (_that) {
      case EntryActivity_EpisodeActivity():
        return episodeActivity(_that);
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
    TResult? Function(EntryActivity_EpisodeActivity value)? episodeActivity,
  }) {
    final _that = this;
    switch (_that) {
      case EntryActivity_EpisodeActivity() when episodeActivity != null:
        return episodeActivity(_that);
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
    TResult Function(int progress)? episodeActivity,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case EntryActivity_EpisodeActivity() when episodeActivity != null:
        return episodeActivity(_that.progress);
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
    required TResult Function(int progress) episodeActivity,
  }) {
    final _that = this;
    switch (_that) {
      case EntryActivity_EpisodeActivity():
        return episodeActivity(_that.progress);
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
    TResult? Function(int progress)? episodeActivity,
  }) {
    final _that = this;
    switch (_that) {
      case EntryActivity_EpisodeActivity() when episodeActivity != null:
        return episodeActivity(_that.progress);
      case _:
        return null;
    }
  }
}

/// @nodoc

class EntryActivity_EpisodeActivity extends EntryActivity {
  const EntryActivity_EpisodeActivity({required this.progress}) : super._();

  @override
  final int progress;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EntryActivity_EpisodeActivityCopyWith<EntryActivity_EpisodeActivity>
      get copyWith => _$EntryActivity_EpisodeActivityCopyWithImpl<
          EntryActivity_EpisodeActivity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EntryActivity_EpisodeActivity &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress);

  @override
  String toString() {
    return 'EntryActivity.episodeActivity(progress: $progress)';
  }
}

/// @nodoc
abstract mixin class $EntryActivity_EpisodeActivityCopyWith<$Res>
    implements $EntryActivityCopyWith<$Res> {
  factory $EntryActivity_EpisodeActivityCopyWith(
          EntryActivity_EpisodeActivity value,
          $Res Function(EntryActivity_EpisodeActivity) _then) =
      _$EntryActivity_EpisodeActivityCopyWithImpl;
  @override
  @useResult
  $Res call({int progress});
}

/// @nodoc
class _$EntryActivity_EpisodeActivityCopyWithImpl<$Res>
    implements $EntryActivity_EpisodeActivityCopyWith<$Res> {
  _$EntryActivity_EpisodeActivityCopyWithImpl(this._self, this._then);

  final EntryActivity_EpisodeActivity _self;
  final $Res Function(EntryActivity_EpisodeActivity) _then;

  /// Create a copy of EntryActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? progress = null,
  }) {
    return _then(EntryActivity_EpisodeActivity(
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
