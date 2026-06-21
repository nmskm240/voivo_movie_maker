// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_clip_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimelineClipInfo {

 TimelineClipId get id; int get startFrame; int get durationFrames; bool get hasAudio; AssetId? get audioAssetId;
/// Create a copy of TimelineClipInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineClipInfoCopyWith<TimelineClipInfo> get copyWith => _$TimelineClipInfoCopyWithImpl<TimelineClipInfo>(this as TimelineClipInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineClipInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.startFrame, startFrame) || other.startFrame == startFrame)&&(identical(other.durationFrames, durationFrames) || other.durationFrames == durationFrames)&&(identical(other.hasAudio, hasAudio) || other.hasAudio == hasAudio)&&(identical(other.audioAssetId, audioAssetId) || other.audioAssetId == audioAssetId));
}


@override
int get hashCode => Object.hash(runtimeType,id,startFrame,durationFrames,hasAudio,audioAssetId);

@override
String toString() {
  return 'TimelineClipInfo(id: $id, startFrame: $startFrame, durationFrames: $durationFrames, hasAudio: $hasAudio, audioAssetId: $audioAssetId)';
}


}

/// @nodoc
abstract mixin class $TimelineClipInfoCopyWith<$Res>  {
  factory $TimelineClipInfoCopyWith(TimelineClipInfo value, $Res Function(TimelineClipInfo) _then) = _$TimelineClipInfoCopyWithImpl;
@useResult
$Res call({
 TimelineClipId id, int startFrame, int durationFrames, bool hasAudio, AssetId? audioAssetId
});




}
/// @nodoc
class _$TimelineClipInfoCopyWithImpl<$Res>
    implements $TimelineClipInfoCopyWith<$Res> {
  _$TimelineClipInfoCopyWithImpl(this._self, this._then);

  final TimelineClipInfo _self;
  final $Res Function(TimelineClipInfo) _then;

/// Create a copy of TimelineClipInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startFrame = null,Object? durationFrames = null,Object? hasAudio = null,Object? audioAssetId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as TimelineClipId,startFrame: null == startFrame ? _self.startFrame : startFrame // ignore: cast_nullable_to_non_nullable
as int,durationFrames: null == durationFrames ? _self.durationFrames : durationFrames // ignore: cast_nullable_to_non_nullable
as int,hasAudio: null == hasAudio ? _self.hasAudio : hasAudio // ignore: cast_nullable_to_non_nullable
as bool,audioAssetId: freezed == audioAssetId ? _self.audioAssetId : audioAssetId // ignore: cast_nullable_to_non_nullable
as AssetId?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineClipInfo].
extension TimelineClipInfoPatterns on TimelineClipInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineClipInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineClipInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineClipInfo value)  $default,){
final _that = this;
switch (_that) {
case _TimelineClipInfo():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineClipInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineClipInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimelineClipId id,  int startFrame,  int durationFrames,  bool hasAudio,  AssetId? audioAssetId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineClipInfo() when $default != null:
return $default(_that.id,_that.startFrame,_that.durationFrames,_that.hasAudio,_that.audioAssetId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimelineClipId id,  int startFrame,  int durationFrames,  bool hasAudio,  AssetId? audioAssetId)  $default,) {final _that = this;
switch (_that) {
case _TimelineClipInfo():
return $default(_that.id,_that.startFrame,_that.durationFrames,_that.hasAudio,_that.audioAssetId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimelineClipId id,  int startFrame,  int durationFrames,  bool hasAudio,  AssetId? audioAssetId)?  $default,) {final _that = this;
switch (_that) {
case _TimelineClipInfo() when $default != null:
return $default(_that.id,_that.startFrame,_that.durationFrames,_that.hasAudio,_that.audioAssetId);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineClipInfo implements TimelineClipInfo {
  const _TimelineClipInfo({required this.id, required this.startFrame, required this.durationFrames, this.hasAudio = false, this.audioAssetId});
  

@override final  TimelineClipId id;
@override final  int startFrame;
@override final  int durationFrames;
@override@JsonKey() final  bool hasAudio;
@override final  AssetId? audioAssetId;

/// Create a copy of TimelineClipInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineClipInfoCopyWith<_TimelineClipInfo> get copyWith => __$TimelineClipInfoCopyWithImpl<_TimelineClipInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineClipInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.startFrame, startFrame) || other.startFrame == startFrame)&&(identical(other.durationFrames, durationFrames) || other.durationFrames == durationFrames)&&(identical(other.hasAudio, hasAudio) || other.hasAudio == hasAudio)&&(identical(other.audioAssetId, audioAssetId) || other.audioAssetId == audioAssetId));
}


@override
int get hashCode => Object.hash(runtimeType,id,startFrame,durationFrames,hasAudio,audioAssetId);

@override
String toString() {
  return 'TimelineClipInfo(id: $id, startFrame: $startFrame, durationFrames: $durationFrames, hasAudio: $hasAudio, audioAssetId: $audioAssetId)';
}


}

/// @nodoc
abstract mixin class _$TimelineClipInfoCopyWith<$Res> implements $TimelineClipInfoCopyWith<$Res> {
  factory _$TimelineClipInfoCopyWith(_TimelineClipInfo value, $Res Function(_TimelineClipInfo) _then) = __$TimelineClipInfoCopyWithImpl;
@override @useResult
$Res call({
 TimelineClipId id, int startFrame, int durationFrames, bool hasAudio, AssetId? audioAssetId
});




}
/// @nodoc
class __$TimelineClipInfoCopyWithImpl<$Res>
    implements _$TimelineClipInfoCopyWith<$Res> {
  __$TimelineClipInfoCopyWithImpl(this._self, this._then);

  final _TimelineClipInfo _self;
  final $Res Function(_TimelineClipInfo) _then;

/// Create a copy of TimelineClipInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startFrame = null,Object? durationFrames = null,Object? hasAudio = null,Object? audioAssetId = freezed,}) {
  return _then(_TimelineClipInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as TimelineClipId,startFrame: null == startFrame ? _self.startFrame : startFrame // ignore: cast_nullable_to_non_nullable
as int,durationFrames: null == durationFrames ? _self.durationFrames : durationFrames // ignore: cast_nullable_to_non_nullable
as int,hasAudio: null == hasAudio ? _self.hasAudio : hasAudio // ignore: cast_nullable_to_non_nullable
as bool,audioAssetId: freezed == audioAssetId ? _self.audioAssetId : audioAssetId // ignore: cast_nullable_to_non_nullable
as AssetId?,
  ));
}


}

// dart format on
