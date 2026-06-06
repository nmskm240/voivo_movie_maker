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
mixin _$ProjectEditState {

 ProjectInfo get project;
/// Create a copy of ProjectEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectEditStateCopyWith<ProjectEditState> get copyWith => _$ProjectEditStateCopyWithImpl<ProjectEditState>(this as ProjectEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectEditState&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,project);

@override
String toString() {
  return 'ProjectEditState(project: $project)';
}


}

/// @nodoc
abstract mixin class $ProjectEditStateCopyWith<$Res>  {
  factory $ProjectEditStateCopyWith(ProjectEditState value, $Res Function(ProjectEditState) _then) = _$ProjectEditStateCopyWithImpl;
@useResult
$Res call({
 ProjectInfo project
});


$ProjectInfoCopyWith<$Res> get project;

}
/// @nodoc
class _$ProjectEditStateCopyWithImpl<$Res>
    implements $ProjectEditStateCopyWith<$Res> {
  _$ProjectEditStateCopyWithImpl(this._self, this._then);

  final ProjectEditState _self;
  final $Res Function(ProjectEditState) _then;

/// Create a copy of ProjectEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? project = null,}) {
  return _then(_self.copyWith(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as ProjectInfo,
  ));
}
/// Create a copy of ProjectEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectInfoCopyWith<$Res> get project {
  
  return $ProjectInfoCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProjectEditState].
extension ProjectEditStatePatterns on ProjectEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectEditState value)  $default,){
final _that = this;
switch (_that) {
case _ProjectEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectEditState value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectInfo project)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectEditState() when $default != null:
return $default(_that.project);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectInfo project)  $default,) {final _that = this;
switch (_that) {
case _ProjectEditState():
return $default(_that.project);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectInfo project)?  $default,) {final _that = this;
switch (_that) {
case _ProjectEditState() when $default != null:
return $default(_that.project);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectEditState implements ProjectEditState {
  const _ProjectEditState({required this.project});
  

@override final  ProjectInfo project;

/// Create a copy of ProjectEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectEditStateCopyWith<_ProjectEditState> get copyWith => __$ProjectEditStateCopyWithImpl<_ProjectEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectEditState&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,project);

@override
String toString() {
  return 'ProjectEditState(project: $project)';
}


}

/// @nodoc
abstract mixin class _$ProjectEditStateCopyWith<$Res> implements $ProjectEditStateCopyWith<$Res> {
  factory _$ProjectEditStateCopyWith(_ProjectEditState value, $Res Function(_ProjectEditState) _then) = __$ProjectEditStateCopyWithImpl;
@override @useResult
$Res call({
 ProjectInfo project
});


@override $ProjectInfoCopyWith<$Res> get project;

}
/// @nodoc
class __$ProjectEditStateCopyWithImpl<$Res>
    implements _$ProjectEditStateCopyWith<$Res> {
  __$ProjectEditStateCopyWithImpl(this._self, this._then);

  final _ProjectEditState _self;
  final $Res Function(_ProjectEditState) _then;

/// Create a copy of ProjectEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? project = null,}) {
  return _then(_ProjectEditState(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as ProjectInfo,
  ));
}

/// Create a copy of ProjectEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectInfoCopyWith<$Res> get project {
  
  return $ProjectInfoCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

// dart format on
