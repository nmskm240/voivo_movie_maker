// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectInfo {

 double get width; double get height; int get fps; int get sampleRate; TimelineInfo get timeline;
/// Create a copy of ProjectInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectInfoCopyWith<ProjectInfo> get copyWith => _$ProjectInfoCopyWithImpl<ProjectInfo>(this as ProjectInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectInfo&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fps, fps) || other.fps == fps)&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.timeline, timeline) || other.timeline == timeline));
}


@override
int get hashCode => Object.hash(runtimeType,width,height,fps,sampleRate,timeline);

@override
String toString() {
  return 'ProjectInfo(width: $width, height: $height, fps: $fps, sampleRate: $sampleRate, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class $ProjectInfoCopyWith<$Res>  {
  factory $ProjectInfoCopyWith(ProjectInfo value, $Res Function(ProjectInfo) _then) = _$ProjectInfoCopyWithImpl;
@useResult
$Res call({
 double width, double height, int fps, int sampleRate, TimelineInfo timeline
});


$TimelineInfoCopyWith<$Res> get timeline;

}
/// @nodoc
class _$ProjectInfoCopyWithImpl<$Res>
    implements $ProjectInfoCopyWith<$Res> {
  _$ProjectInfoCopyWithImpl(this._self, this._then);

  final ProjectInfo _self;
  final $Res Function(ProjectInfo) _then;

/// Create a copy of ProjectInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,Object? fps = null,Object? sampleRate = null,Object? timeline = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,sampleRate: null == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as TimelineInfo,
  ));
}
/// Create a copy of ProjectInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimelineInfoCopyWith<$Res> get timeline {
  
  return $TimelineInfoCopyWith<$Res>(_self.timeline, (value) {
    return _then(_self.copyWith(timeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectInfo].
extension ProjectInfoPatterns on ProjectInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectInfo value)  $default,){
final _that = this;
switch (_that) {
case _ProjectInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double width,  double height,  int fps,  int sampleRate,  TimelineInfo timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectInfo() when $default != null:
return $default(_that.width,_that.height,_that.fps,_that.sampleRate,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double width,  double height,  int fps,  int sampleRate,  TimelineInfo timeline)  $default,) {final _that = this;
switch (_that) {
case _ProjectInfo():
return $default(_that.width,_that.height,_that.fps,_that.sampleRate,_that.timeline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double width,  double height,  int fps,  int sampleRate,  TimelineInfo timeline)?  $default,) {final _that = this;
switch (_that) {
case _ProjectInfo() when $default != null:
return $default(_that.width,_that.height,_that.fps,_that.sampleRate,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectInfo implements ProjectInfo {
  const _ProjectInfo({required this.width, required this.height, required this.fps, required this.sampleRate, required this.timeline});
  

@override final  double width;
@override final  double height;
@override final  int fps;
@override final  int sampleRate;
@override final  TimelineInfo timeline;

/// Create a copy of ProjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectInfoCopyWith<_ProjectInfo> get copyWith => __$ProjectInfoCopyWithImpl<_ProjectInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectInfo&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fps, fps) || other.fps == fps)&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.timeline, timeline) || other.timeline == timeline));
}


@override
int get hashCode => Object.hash(runtimeType,width,height,fps,sampleRate,timeline);

@override
String toString() {
  return 'ProjectInfo(width: $width, height: $height, fps: $fps, sampleRate: $sampleRate, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$ProjectInfoCopyWith<$Res> implements $ProjectInfoCopyWith<$Res> {
  factory _$ProjectInfoCopyWith(_ProjectInfo value, $Res Function(_ProjectInfo) _then) = __$ProjectInfoCopyWithImpl;
@override @useResult
$Res call({
 double width, double height, int fps, int sampleRate, TimelineInfo timeline
});


@override $TimelineInfoCopyWith<$Res> get timeline;

}
/// @nodoc
class __$ProjectInfoCopyWithImpl<$Res>
    implements _$ProjectInfoCopyWith<$Res> {
  __$ProjectInfoCopyWithImpl(this._self, this._then);

  final _ProjectInfo _self;
  final $Res Function(_ProjectInfo) _then;

/// Create a copy of ProjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? fps = null,Object? sampleRate = null,Object? timeline = null,}) {
  return _then(_ProjectInfo(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,fps: null == fps ? _self.fps : fps // ignore: cast_nullable_to_non_nullable
as int,sampleRate: null == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as TimelineInfo,
  ));
}

/// Create a copy of ProjectInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimelineInfoCopyWith<$Res> get timeline {
  
  return $TimelineInfoCopyWith<$Res>(_self.timeline, (value) {
    return _then(_self.copyWith(timeline: value));
  });
}
}

// dart format on
