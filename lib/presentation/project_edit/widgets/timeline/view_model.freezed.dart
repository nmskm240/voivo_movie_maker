// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimelineViewState {

 TimelineInfo get timeline; double get pixelsPerFrame; double get horizontalScrollOffset; int get revision;
/// Create a copy of TimelineViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineViewStateCopyWith<TimelineViewState> get copyWith => _$TimelineViewStateCopyWithImpl<TimelineViewState>(this as TimelineViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineViewState&&(identical(other.timeline, timeline) || other.timeline == timeline)&&(identical(other.pixelsPerFrame, pixelsPerFrame) || other.pixelsPerFrame == pixelsPerFrame)&&(identical(other.horizontalScrollOffset, horizontalScrollOffset) || other.horizontalScrollOffset == horizontalScrollOffset)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,timeline,pixelsPerFrame,horizontalScrollOffset,revision);

@override
String toString() {
  return 'TimelineViewState(timeline: $timeline, pixelsPerFrame: $pixelsPerFrame, horizontalScrollOffset: $horizontalScrollOffset, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $TimelineViewStateCopyWith<$Res>  {
  factory $TimelineViewStateCopyWith(TimelineViewState value, $Res Function(TimelineViewState) _then) = _$TimelineViewStateCopyWithImpl;
@useResult
$Res call({
 TimelineInfo timeline, double pixelsPerFrame, double horizontalScrollOffset, int revision
});


$TimelineInfoCopyWith<$Res> get timeline;

}
/// @nodoc
class _$TimelineViewStateCopyWithImpl<$Res>
    implements $TimelineViewStateCopyWith<$Res> {
  _$TimelineViewStateCopyWithImpl(this._self, this._then);

  final TimelineViewState _self;
  final $Res Function(TimelineViewState) _then;

/// Create a copy of TimelineViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeline = null,Object? pixelsPerFrame = null,Object? horizontalScrollOffset = null,Object? revision = null,}) {
  return _then(_self.copyWith(
timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as TimelineInfo,pixelsPerFrame: null == pixelsPerFrame ? _self.pixelsPerFrame : pixelsPerFrame // ignore: cast_nullable_to_non_nullable
as double,horizontalScrollOffset: null == horizontalScrollOffset ? _self.horizontalScrollOffset : horizontalScrollOffset // ignore: cast_nullable_to_non_nullable
as double,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TimelineViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimelineInfoCopyWith<$Res> get timeline {
  
  return $TimelineInfoCopyWith<$Res>(_self.timeline, (value) {
    return _then(_self.copyWith(timeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [TimelineViewState].
extension TimelineViewStatePatterns on TimelineViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineViewState value)  $default,){
final _that = this;
switch (_that) {
case _TimelineViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineViewState value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TimelineInfo timeline,  double pixelsPerFrame,  double horizontalScrollOffset,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineViewState() when $default != null:
return $default(_that.timeline,_that.pixelsPerFrame,_that.horizontalScrollOffset,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TimelineInfo timeline,  double pixelsPerFrame,  double horizontalScrollOffset,  int revision)  $default,) {final _that = this;
switch (_that) {
case _TimelineViewState():
return $default(_that.timeline,_that.pixelsPerFrame,_that.horizontalScrollOffset,_that.revision);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TimelineInfo timeline,  double pixelsPerFrame,  double horizontalScrollOffset,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _TimelineViewState() when $default != null:
return $default(_that.timeline,_that.pixelsPerFrame,_that.horizontalScrollOffset,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineViewState implements TimelineViewState {
  const _TimelineViewState({required this.timeline, this.pixelsPerFrame = 1.0, this.horizontalScrollOffset = 0.0, this.revision = 0});
  

@override final  TimelineInfo timeline;
@override@JsonKey() final  double pixelsPerFrame;
@override@JsonKey() final  double horizontalScrollOffset;
@override@JsonKey() final  int revision;

/// Create a copy of TimelineViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineViewStateCopyWith<_TimelineViewState> get copyWith => __$TimelineViewStateCopyWithImpl<_TimelineViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineViewState&&(identical(other.timeline, timeline) || other.timeline == timeline)&&(identical(other.pixelsPerFrame, pixelsPerFrame) || other.pixelsPerFrame == pixelsPerFrame)&&(identical(other.horizontalScrollOffset, horizontalScrollOffset) || other.horizontalScrollOffset == horizontalScrollOffset)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,timeline,pixelsPerFrame,horizontalScrollOffset,revision);

@override
String toString() {
  return 'TimelineViewState(timeline: $timeline, pixelsPerFrame: $pixelsPerFrame, horizontalScrollOffset: $horizontalScrollOffset, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$TimelineViewStateCopyWith<$Res> implements $TimelineViewStateCopyWith<$Res> {
  factory _$TimelineViewStateCopyWith(_TimelineViewState value, $Res Function(_TimelineViewState) _then) = __$TimelineViewStateCopyWithImpl;
@override @useResult
$Res call({
 TimelineInfo timeline, double pixelsPerFrame, double horizontalScrollOffset, int revision
});


@override $TimelineInfoCopyWith<$Res> get timeline;

}
/// @nodoc
class __$TimelineViewStateCopyWithImpl<$Res>
    implements _$TimelineViewStateCopyWith<$Res> {
  __$TimelineViewStateCopyWithImpl(this._self, this._then);

  final _TimelineViewState _self;
  final $Res Function(_TimelineViewState) _then;

/// Create a copy of TimelineViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timeline = null,Object? pixelsPerFrame = null,Object? horizontalScrollOffset = null,Object? revision = null,}) {
  return _then(_TimelineViewState(
timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as TimelineInfo,pixelsPerFrame: null == pixelsPerFrame ? _self.pixelsPerFrame : pixelsPerFrame // ignore: cast_nullable_to_non_nullable
as double,horizontalScrollOffset: null == horizontalScrollOffset ? _self.horizontalScrollOffset : horizontalScrollOffset // ignore: cast_nullable_to_non_nullable
as double,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TimelineViewState
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
