// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_controller_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaybackInfo {

 int get currentFrame;
/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackInfoCopyWith<PlaybackInfo> get copyWith => _$PlaybackInfoCopyWithImpl<PlaybackInfo>(this as PlaybackInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackInfo&&(identical(other.currentFrame, currentFrame) || other.currentFrame == currentFrame));
}


@override
int get hashCode => Object.hash(runtimeType,currentFrame);

@override
String toString() {
  return 'PlaybackInfo(currentFrame: $currentFrame)';
}


}

/// @nodoc
abstract mixin class $PlaybackInfoCopyWith<$Res>  {
  factory $PlaybackInfoCopyWith(PlaybackInfo value, $Res Function(PlaybackInfo) _then) = _$PlaybackInfoCopyWithImpl;
@useResult
$Res call({
 int currentFrame
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
@pragma('vm:prefer-inline') @override $Res call({Object? currentFrame = null,}) {
  return _then(_self.copyWith(
currentFrame: null == currentFrame ? _self.currentFrame : currentFrame // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlaybackStopped value)?  stopped,TResult Function( PlaybackPlaying value)?  playing,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlaybackStopped() when stopped != null:
return stopped(_that);case PlaybackPlaying() when playing != null:
return playing(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlaybackStopped value)  stopped,required TResult Function( PlaybackPlaying value)  playing,}){
final _that = this;
switch (_that) {
case PlaybackStopped():
return stopped(_that);case PlaybackPlaying():
return playing(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlaybackStopped value)?  stopped,TResult? Function( PlaybackPlaying value)?  playing,}){
final _that = this;
switch (_that) {
case PlaybackStopped() when stopped != null:
return stopped(_that);case PlaybackPlaying() when playing != null:
return playing(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int currentFrame)?  stopped,TResult Function( int currentFrame,  int playStartFrame,  Duration playStartElapsed)?  playing,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlaybackStopped() when stopped != null:
return stopped(_that.currentFrame);case PlaybackPlaying() when playing != null:
return playing(_that.currentFrame,_that.playStartFrame,_that.playStartElapsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int currentFrame)  stopped,required TResult Function( int currentFrame,  int playStartFrame,  Duration playStartElapsed)  playing,}) {final _that = this;
switch (_that) {
case PlaybackStopped():
return stopped(_that.currentFrame);case PlaybackPlaying():
return playing(_that.currentFrame,_that.playStartFrame,_that.playStartElapsed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int currentFrame)?  stopped,TResult? Function( int currentFrame,  int playStartFrame,  Duration playStartElapsed)?  playing,}) {final _that = this;
switch (_that) {
case PlaybackStopped() when stopped != null:
return stopped(_that.currentFrame);case PlaybackPlaying() when playing != null:
return playing(_that.currentFrame,_that.playStartFrame,_that.playStartElapsed);case _:
  return null;

}
}

}

/// @nodoc


class PlaybackStopped implements PlaybackInfo {
  const PlaybackStopped({required this.currentFrame});
  

@override final  int currentFrame;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackStoppedCopyWith<PlaybackStopped> get copyWith => _$PlaybackStoppedCopyWithImpl<PlaybackStopped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackStopped&&(identical(other.currentFrame, currentFrame) || other.currentFrame == currentFrame));
}


@override
int get hashCode => Object.hash(runtimeType,currentFrame);

@override
String toString() {
  return 'PlaybackInfo.stopped(currentFrame: $currentFrame)';
}


}

/// @nodoc
abstract mixin class $PlaybackStoppedCopyWith<$Res> implements $PlaybackInfoCopyWith<$Res> {
  factory $PlaybackStoppedCopyWith(PlaybackStopped value, $Res Function(PlaybackStopped) _then) = _$PlaybackStoppedCopyWithImpl;
@override @useResult
$Res call({
 int currentFrame
});




}
/// @nodoc
class _$PlaybackStoppedCopyWithImpl<$Res>
    implements $PlaybackStoppedCopyWith<$Res> {
  _$PlaybackStoppedCopyWithImpl(this._self, this._then);

  final PlaybackStopped _self;
  final $Res Function(PlaybackStopped) _then;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentFrame = null,}) {
  return _then(PlaybackStopped(
currentFrame: null == currentFrame ? _self.currentFrame : currentFrame // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PlaybackPlaying implements PlaybackInfo {
  const PlaybackPlaying({required this.currentFrame, required this.playStartFrame, required this.playStartElapsed});
  

@override final  int currentFrame;
 final  int playStartFrame;
 final  Duration playStartElapsed;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackPlayingCopyWith<PlaybackPlaying> get copyWith => _$PlaybackPlayingCopyWithImpl<PlaybackPlaying>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackPlaying&&(identical(other.currentFrame, currentFrame) || other.currentFrame == currentFrame)&&(identical(other.playStartFrame, playStartFrame) || other.playStartFrame == playStartFrame)&&(identical(other.playStartElapsed, playStartElapsed) || other.playStartElapsed == playStartElapsed));
}


@override
int get hashCode => Object.hash(runtimeType,currentFrame,playStartFrame,playStartElapsed);

@override
String toString() {
  return 'PlaybackInfo.playing(currentFrame: $currentFrame, playStartFrame: $playStartFrame, playStartElapsed: $playStartElapsed)';
}


}

/// @nodoc
abstract mixin class $PlaybackPlayingCopyWith<$Res> implements $PlaybackInfoCopyWith<$Res> {
  factory $PlaybackPlayingCopyWith(PlaybackPlaying value, $Res Function(PlaybackPlaying) _then) = _$PlaybackPlayingCopyWithImpl;
@override @useResult
$Res call({
 int currentFrame, int playStartFrame, Duration playStartElapsed
});




}
/// @nodoc
class _$PlaybackPlayingCopyWithImpl<$Res>
    implements $PlaybackPlayingCopyWith<$Res> {
  _$PlaybackPlayingCopyWithImpl(this._self, this._then);

  final PlaybackPlaying _self;
  final $Res Function(PlaybackPlaying) _then;

/// Create a copy of PlaybackInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentFrame = null,Object? playStartFrame = null,Object? playStartElapsed = null,}) {
  return _then(PlaybackPlaying(
currentFrame: null == currentFrame ? _self.currentFrame : currentFrame // ignore: cast_nullable_to_non_nullable
as int,playStartFrame: null == playStartFrame ? _self.playStartFrame : playStartFrame // ignore: cast_nullable_to_non_nullable
as int,playStartElapsed: null == playStartElapsed ? _self.playStartElapsed : playStartElapsed // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
