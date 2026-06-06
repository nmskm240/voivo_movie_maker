// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaybackInfo {

 int get fps; int get currentFrame; int get playStartFrame; Duration get playStartElapsed; bool get isPlaying;
/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackInfoCopyWith<PlaybackInfo> get copyWith => _$PlaybackInfoCopyWithImpl<PlaybackInfo>(this as PlaybackInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackInfo&&(identical(other.fps, fps) || other.fps == fps)&&(identical(other.currentFrame, currentFrame) || other.currentFrame == currentFrame)&&(identical(other.playStartFrame, playStartFrame) || other.playStartFrame == playStartFrame)&&(identical(other.playStartElapsed, playStartElapsed) || other.playStartElapsed == playStartElapsed)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying));
}


@override
int get hashCode => Object.hash(runtimeType,fps,currentFrame,playStartFrame,playStartElapsed,isPlaying);

@override
String toString() {
  return 'PlaybackInfo(fps: $fps, currentFrame: $currentFrame, playStartFrame: $playStartFrame, playStartElapsed: $playStartElapsed, isPlaying: $isPlaying)';
}


}

/// @nodoc
abstract mixin class $PlaybackInfoCopyWith<$Res>  {
  factory $PlaybackInfoCopyWith(PlaybackInfo value, $Res Function(PlaybackInfo) _then) = _$PlaybackInfoCopyWithImpl;
@useResult
$Res call({
 int fps, int currentFrame, int playStartFrame, Duration playStartElapsed, bool isPlaying
});




}
/// @nodoc
class _$PlaybackInfoCopyWithImpl<$Res>
    implements $PlaybackInfoCopyWith<$Res> {
  _$PlaybackInfoCopyWithImpl(this._self, this._then);

  final PlaybackInfo _self;
  final $Res Function(PlaybackInfo) _then;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fps = null,Object? currentFrame = null,Object? playStartFrame = null,Object? playStartElapsed = null,Object? isPlaying = null,}) {
  return _then(_self.copyWith(
fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,currentFrame: null == currentFrame ? _self.currentFrame : currentFrame // ignore: cast_nullable_to_non_nullable
as int,playStartFrame: null == playStartFrame ? _self.playStartFrame : playStartFrame // ignore: cast_nullable_to_non_nullable
as int,playStartElapsed: null == playStartElapsed ? _self.playStartElapsed : playStartElapsed // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackInfo].
extension PlaybackInfoPatterns on PlaybackInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackInfo() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackInfo value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackInfo() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fps,  int currentFrame,  int playStartFrame,  Duration playStartElapsed,  bool isPlaying)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackInfo() when $default != null:
return $default(_that.fps,_that.currentFrame,_that.playStartFrame,_that.playStartElapsed,_that.isPlaying);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fps,  int currentFrame,  int playStartFrame,  Duration playStartElapsed,  bool isPlaying)  $default,) {final _that = this;
switch (_that) {
case _PlaybackInfo():
return $default(_that.fps,_that.currentFrame,_that.playStartFrame,_that.playStartElapsed,_that.isPlaying);case _:
  throw StateError('Unexpected subclass');

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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fps,  int currentFrame,  int playStartFrame,  Duration playStartElapsed,  bool isPlaying)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackInfo() when $default != null:
return $default(_that.fps,_that.currentFrame,_that.playStartFrame,_that.playStartElapsed,_that.isPlaying);case _:
  return null;

}
}

}

/// @nodoc


class _PlaybackInfo extends PlaybackInfo {
  const _PlaybackInfo({required this.fps, this.currentFrame = 0, this.playStartFrame = 0, this.playStartElapsed = Duration.zero, this.isPlaying = false}): super._();
  

@override final  int fps;
@override@JsonKey() final  int currentFrame;
@override@JsonKey() final  int playStartFrame;
@override@JsonKey() final  Duration playStartElapsed;
@override@JsonKey() final  bool isPlaying;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackInfoCopyWith<_PlaybackInfo> get copyWith => __$PlaybackInfoCopyWithImpl<_PlaybackInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackInfo&&(identical(other.fps, fps) || other.fps == fps)&&(identical(other.currentFrame, currentFrame) || other.currentFrame == currentFrame)&&(identical(other.playStartFrame, playStartFrame) || other.playStartFrame == playStartFrame)&&(identical(other.playStartElapsed, playStartElapsed) || other.playStartElapsed == playStartElapsed)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying));
}


@override
int get hashCode => Object.hash(runtimeType,fps,currentFrame,playStartFrame,playStartElapsed,isPlaying);

@override
String toString() {
  return 'PlaybackInfo(fps: $fps, currentFrame: $currentFrame, playStartFrame: $playStartFrame, playStartElapsed: $playStartElapsed, isPlaying: $isPlaying)';
}


}

/// @nodoc
abstract mixin class _$PlaybackInfoCopyWith<$Res> implements $PlaybackInfoCopyWith<$Res> {
  factory _$PlaybackInfoCopyWith(_PlaybackInfo value, $Res Function(_PlaybackInfo) _then) = __$PlaybackInfoCopyWithImpl;
@override @useResult
$Res call({
 int fps, int currentFrame, int playStartFrame, Duration playStartElapsed, bool isPlaying
});




}
/// @nodoc
class __$PlaybackInfoCopyWithImpl<$Res>
    implements _$PlaybackInfoCopyWith<$Res> {
  __$PlaybackInfoCopyWithImpl(this._self, this._then);

  final _PlaybackInfo _self;
  final $Res Function(_PlaybackInfo) _then;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fps = null,Object? currentFrame = null,Object? playStartFrame = null,Object? playStartElapsed = null,Object? isPlaying = null,}) {
  return _then(_PlaybackInfo(
fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,currentFrame: null == currentFrame ? _self.currentFrame : currentFrame // ignore: cast_nullable_to_non_nullable
as int,playStartFrame: null == playStartFrame ? _self.playStartFrame : playStartFrame // ignore: cast_nullable_to_non_nullable
as int,playStartElapsed: null == playStartElapsed ? _self.playStartElapsed : playStartElapsed // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
