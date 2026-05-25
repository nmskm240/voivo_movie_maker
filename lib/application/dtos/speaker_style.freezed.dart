// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speaker_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpeakerStyle {

 String get speakerName; String get styleName; int get id;
/// Create a copy of SpeakerStyle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeakerStyleCopyWith<SpeakerStyle> get copyWith => _$SpeakerStyleCopyWithImpl<SpeakerStyle>(this as SpeakerStyle, _$identity);

  /// Serializes this SpeakerStyle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeakerStyle&&(identical(other.speakerName, speakerName) || other.speakerName == speakerName)&&(identical(other.styleName, styleName) || other.styleName == styleName)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speakerName,styleName,id);

@override
String toString() {
  return 'SpeakerStyle(speakerName: $speakerName, styleName: $styleName, id: $id)';
}


}

/// @nodoc
abstract mixin class $SpeakerStyleCopyWith<$Res>  {
  factory $SpeakerStyleCopyWith(SpeakerStyle value, $Res Function(SpeakerStyle) _then) = _$SpeakerStyleCopyWithImpl;
@useResult
$Res call({
 String speakerName, String styleName, int id
});




}
/// @nodoc
class _$SpeakerStyleCopyWithImpl<$Res>
    implements $SpeakerStyleCopyWith<$Res> {
  _$SpeakerStyleCopyWithImpl(this._self, this._then);

  final SpeakerStyle _self;
  final $Res Function(SpeakerStyle) _then;

/// Create a copy of SpeakerStyle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speakerName = null,Object? styleName = null,Object? id = null,}) {
  return _then(_self.copyWith(
speakerName: null == speakerName ? _self.speakerName : speakerName // ignore: cast_nullable_to_non_nullable
as String,styleName: null == styleName ? _self.styleName : styleName // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeakerStyle].
extension SpeakerStylePatterns on SpeakerStyle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeakerStyle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeakerStyle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeakerStyle value)  $default,){
final _that = this;
switch (_that) {
case _SpeakerStyle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeakerStyle value)?  $default,){
final _that = this;
switch (_that) {
case _SpeakerStyle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String speakerName,  String styleName,  int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeakerStyle() when $default != null:
return $default(_that.speakerName,_that.styleName,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String speakerName,  String styleName,  int id)  $default,) {final _that = this;
switch (_that) {
case _SpeakerStyle():
return $default(_that.speakerName,_that.styleName,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String speakerName,  String styleName,  int id)?  $default,) {final _that = this;
switch (_that) {
case _SpeakerStyle() when $default != null:
return $default(_that.speakerName,_that.styleName,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeakerStyle extends SpeakerStyle {
  const _SpeakerStyle({required this.speakerName, required this.styleName, required this.id}): super._();
  factory _SpeakerStyle.fromJson(Map<String, dynamic> json) => _$SpeakerStyleFromJson(json);

@override final  String speakerName;
@override final  String styleName;
@override final  int id;

/// Create a copy of SpeakerStyle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeakerStyleCopyWith<_SpeakerStyle> get copyWith => __$SpeakerStyleCopyWithImpl<_SpeakerStyle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeakerStyleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeakerStyle&&(identical(other.speakerName, speakerName) || other.speakerName == speakerName)&&(identical(other.styleName, styleName) || other.styleName == styleName)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speakerName,styleName,id);

@override
String toString() {
  return 'SpeakerStyle(speakerName: $speakerName, styleName: $styleName, id: $id)';
}


}

/// @nodoc
abstract mixin class _$SpeakerStyleCopyWith<$Res> implements $SpeakerStyleCopyWith<$Res> {
  factory _$SpeakerStyleCopyWith(_SpeakerStyle value, $Res Function(_SpeakerStyle) _then) = __$SpeakerStyleCopyWithImpl;
@override @useResult
$Res call({
 String speakerName, String styleName, int id
});




}
/// @nodoc
class __$SpeakerStyleCopyWithImpl<$Res>
    implements _$SpeakerStyleCopyWith<$Res> {
  __$SpeakerStyleCopyWithImpl(this._self, this._then);

  final _SpeakerStyle _self;
  final $Res Function(_SpeakerStyle) _then;

/// Create a copy of SpeakerStyle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speakerName = null,Object? styleName = null,Object? id = null,}) {
  return _then(_SpeakerStyle(
speakerName: null == speakerName ? _self.speakerName : speakerName // ignore: cast_nullable_to_non_nullable
as String,styleName: null == styleName ? _self.styleName : styleName // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
