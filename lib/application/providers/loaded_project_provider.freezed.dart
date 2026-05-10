// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loaded_project_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProjectSnapshot {

 Project get project; int get revision;
/// Create a copy of ProjectSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectSnapshotCopyWith<ProjectSnapshot> get copyWith => _$ProjectSnapshotCopyWithImpl<ProjectSnapshot>(this as ProjectSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectSnapshot&&(identical(other.project, project) || other.project == project)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,project,revision);

@override
String toString() {
  return 'ProjectSnapshot(project: $project, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $ProjectSnapshotCopyWith<$Res>  {
  factory $ProjectSnapshotCopyWith(ProjectSnapshot value, $Res Function(ProjectSnapshot) _then) = _$ProjectSnapshotCopyWithImpl;
@useResult
$Res call({
 Project project, int revision
});




}
/// @nodoc
class _$ProjectSnapshotCopyWithImpl<$Res>
    implements $ProjectSnapshotCopyWith<$Res> {
  _$ProjectSnapshotCopyWithImpl(this._self, this._then);

  final ProjectSnapshot _self;
  final $Res Function(ProjectSnapshot) _then;

/// Create a copy of ProjectSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? project = null,Object? revision = null,}) {
  return _then(_self.copyWith(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectSnapshot].
extension ProjectSnapshotPatterns on ProjectSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _ProjectSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Project project,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectSnapshot() when $default != null:
return $default(_that.project,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Project project,  int revision)  $default,) {final _that = this;
switch (_that) {
case _ProjectSnapshot():
return $default(_that.project,_that.revision);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Project project,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _ProjectSnapshot() when $default != null:
return $default(_that.project,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _ProjectSnapshot implements ProjectSnapshot {
  const _ProjectSnapshot({required this.project, this.revision = 0});
  

@override final  Project project;
@override@JsonKey() final  int revision;

/// Create a copy of ProjectSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectSnapshotCopyWith<_ProjectSnapshot> get copyWith => __$ProjectSnapshotCopyWithImpl<_ProjectSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectSnapshot&&(identical(other.project, project) || other.project == project)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,project,revision);

@override
String toString() {
  return 'ProjectSnapshot(project: $project, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$ProjectSnapshotCopyWith<$Res> implements $ProjectSnapshotCopyWith<$Res> {
  factory _$ProjectSnapshotCopyWith(_ProjectSnapshot value, $Res Function(_ProjectSnapshot) _then) = __$ProjectSnapshotCopyWithImpl;
@override @useResult
$Res call({
 Project project, int revision
});




}
/// @nodoc
class __$ProjectSnapshotCopyWithImpl<$Res>
    implements _$ProjectSnapshotCopyWith<$Res> {
  __$ProjectSnapshotCopyWithImpl(this._self, this._then);

  final _ProjectSnapshot _self;
  final $Res Function(_ProjectSnapshot) _then;

/// Create a copy of ProjectSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? project = null,Object? revision = null,}) {
  return _then(_ProjectSnapshot(
project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
