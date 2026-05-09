// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_track_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimelineTrackInfo {

 String get id; List<TimelineClipInfo> get clips;
/// Create a copy of TimelineTrackInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineTrackInfoCopyWith<TimelineTrackInfo> get copyWith => _$TimelineTrackInfoCopyWithImpl<TimelineTrackInfo>(this as TimelineTrackInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineTrackInfo&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.clips, clips));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(clips));

@override
String toString() {
  return 'TimelineTrackInfo(id: $id, clips: $clips)';
}


}

/// @nodoc
abstract mixin class $TimelineTrackInfoCopyWith<$Res>  {
  factory $TimelineTrackInfoCopyWith(TimelineTrackInfo value, $Res Function(TimelineTrackInfo) _then) = _$TimelineTrackInfoCopyWithImpl;
@useResult
$Res call({
 String id, List<TimelineClipInfo> clips
});




}
/// @nodoc
class _$TimelineTrackInfoCopyWithImpl<$Res>
    implements $TimelineTrackInfoCopyWith<$Res> {
  _$TimelineTrackInfoCopyWithImpl(this._self, this._then);

  final TimelineTrackInfo _self;
  final $Res Function(TimelineTrackInfo) _then;

/// Create a copy of TimelineTrackInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clips = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clips: null == clips ? _self.clips : clips // ignore: cast_nullable_to_non_nullable
as List<TimelineClipInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineTrackInfo].
extension TimelineTrackInfoPatterns on TimelineTrackInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineTrackInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineTrackInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineTrackInfo value)  $default,){
final _that = this;
switch (_that) {
case _TimelineTrackInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineTrackInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineTrackInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  List<TimelineClipInfo> clips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineTrackInfo() when $default != null:
return $default(_that.id,_that.clips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  List<TimelineClipInfo> clips)  $default,) {final _that = this;
switch (_that) {
case _TimelineTrackInfo():
return $default(_that.id,_that.clips);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  List<TimelineClipInfo> clips)?  $default,) {final _that = this;
switch (_that) {
case _TimelineTrackInfo() when $default != null:
return $default(_that.id,_that.clips);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineTrackInfo implements TimelineTrackInfo {
  const _TimelineTrackInfo({required this.id, required final  List<TimelineClipInfo> clips}): _clips = clips;
  

@override final  String id;
 final  List<TimelineClipInfo> _clips;
@override List<TimelineClipInfo> get clips {
  if (_clips is EqualUnmodifiableListView) return _clips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clips);
}


/// Create a copy of TimelineTrackInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineTrackInfoCopyWith<_TimelineTrackInfo> get copyWith => __$TimelineTrackInfoCopyWithImpl<_TimelineTrackInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineTrackInfo&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._clips, _clips));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_clips));

@override
String toString() {
  return 'TimelineTrackInfo(id: $id, clips: $clips)';
}


}

/// @nodoc
abstract mixin class _$TimelineTrackInfoCopyWith<$Res> implements $TimelineTrackInfoCopyWith<$Res> {
  factory _$TimelineTrackInfoCopyWith(_TimelineTrackInfo value, $Res Function(_TimelineTrackInfo) _then) = __$TimelineTrackInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, List<TimelineClipInfo> clips
});




}
/// @nodoc
class __$TimelineTrackInfoCopyWithImpl<$Res>
    implements _$TimelineTrackInfoCopyWith<$Res> {
  __$TimelineTrackInfoCopyWithImpl(this._self, this._then);

  final _TimelineTrackInfo _self;
  final $Res Function(_TimelineTrackInfo) _then;

/// Create a copy of TimelineTrackInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clips = null,}) {
  return _then(_TimelineTrackInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,clips: null == clips ? _self._clips : clips // ignore: cast_nullable_to_non_nullable
as List<TimelineClipInfo>,
  ));
}


}

// dart format on
