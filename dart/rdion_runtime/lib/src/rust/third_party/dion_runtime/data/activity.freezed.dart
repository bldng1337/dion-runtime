// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

class _$EntryActivity_EpisodeActivityImpl
    extends EntryActivity_EpisodeActivity {
  const _$EntryActivity_EpisodeActivityImpl({required this.progress})
      : super._();

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
}

abstract class EntryActivity_EpisodeActivity extends EntryActivity {
  const factory EntryActivity_EpisodeActivity({required final int progress}) =
      _$EntryActivity_EpisodeActivityImpl;
  const EntryActivity_EpisodeActivity._() : super._();

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
