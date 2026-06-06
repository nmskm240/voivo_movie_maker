// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_select_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimelineSelection {

 int? get trackIndex; TimelineClipId? get clipId;
/// Create a copy of TimelineSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineSelectionCopyWith<TimelineSelection> get copyWith => _$TimelineSelectionCopyWithImpl<TimelineSelection>(this as TimelineSelection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineSelection&&(identical(other.trackIndex, trackIndex) || other.trackIndex == trackIndex)&&(identical(other.clipId, clipId) || other.clipId == clipId));
}


@override
int get hashCode => Object.hash(runtimeType,trackIndex,clipId);

@override
String toString() {
  return 'TimelineSelection(trackIndex: $trackIndex, clipId: $clipId)';
}


}

/// @nodoc
abstract mixin class $TimelineSelectionCopyWith<$Res>  {
  factory $TimelineSelectionCopyWith(TimelineSelection value, $Res Function(TimelineSelection) _then) = _$TimelineSelectionCopyWithImpl;
@useResult
$Res call({
 int? trackIndex, TimelineClipId? clipId
});




}
/// @nodoc
class _$TimelineSelectionCopyWithImpl<$Res>
    implements $TimelineSelectionCopyWith<$Res> {
  _$TimelineSelectionCopyWithImpl(this._self, this._then);

  final TimelineSelection _self;
  final $Res Function(TimelineSelection) _then;

/// Create a copy of TimelineSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trackIndex = freezed,Object? clipId = freezed,}) {
  return _then(_self.copyWith(
trackIndex: freezed == trackIndex ? _self.trackIndex : trackIndex // ignore: cast_nullable_to_non_nullable
as int?,clipId: freezed == clipId ? _self.clipId : clipId // ignore: cast_nullable_to_non_nullable
as TimelineClipId?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineSelection].
extension TimelineSelectionPatterns on TimelineSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineSelection value)  $default,){
final _that = this;
switch (_that) {
case _TimelineSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineSelection value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? trackIndex,  TimelineClipId? clipId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineSelection() when $default != null:
return $default(_that.trackIndex,_that.clipId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? trackIndex,  TimelineClipId? clipId)  $default,) {final _that = this;
switch (_that) {
case _TimelineSelection():
return $default(_that.trackIndex,_that.clipId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? trackIndex,  TimelineClipId? clipId)?  $default,) {final _that = this;
switch (_that) {
case _TimelineSelection() when $default != null:
return $default(_that.trackIndex,_that.clipId);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineSelection implements TimelineSelection {
  const _TimelineSelection({this.trackIndex, this.clipId});
  

@override final  int? trackIndex;
@override final  TimelineClipId? clipId;

/// Create a copy of TimelineSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineSelectionCopyWith<_TimelineSelection> get copyWith => __$TimelineSelectionCopyWithImpl<_TimelineSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineSelection&&(identical(other.trackIndex, trackIndex) || other.trackIndex == trackIndex)&&(identical(other.clipId, clipId) || other.clipId == clipId));
}


@override
int get hashCode => Object.hash(runtimeType,trackIndex,clipId);

@override
String toString() {
  return 'TimelineSelection(trackIndex: $trackIndex, clipId: $clipId)';
}


}

/// @nodoc
abstract mixin class _$TimelineSelectionCopyWith<$Res> implements $TimelineSelectionCopyWith<$Res> {
  factory _$TimelineSelectionCopyWith(_TimelineSelection value, $Res Function(_TimelineSelection) _then) = __$TimelineSelectionCopyWithImpl;
@override @useResult
$Res call({
 int? trackIndex, TimelineClipId? clipId
});




}
/// @nodoc
class __$TimelineSelectionCopyWithImpl<$Res>
    implements _$TimelineSelectionCopyWith<$Res> {
  __$TimelineSelectionCopyWithImpl(this._self, this._then);

  final _TimelineSelection _self;
  final $Res Function(_TimelineSelection) _then;

/// Create a copy of TimelineSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trackIndex = freezed,Object? clipId = freezed,}) {
  return _then(_TimelineSelection(
trackIndex: freezed == trackIndex ? _self.trackIndex : trackIndex // ignore: cast_nullable_to_non_nullable
as int?,clipId: freezed == clipId ? _self.clipId : clipId // ignore: cast_nullable_to_non_nullable
as TimelineClipId?,
  ));
}


}

// dart format on
