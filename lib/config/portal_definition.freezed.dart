// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portal_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PortalDefinition _$PortalDefinitionFromJson(Map<String, dynamic> json) {
  return _PortalDefinition.fromJson(json);
}

/// @nodoc
mixin _$PortalDefinition {
  /// Unique portal ID (e.g., 'dark_dungeon_to_surface')
  String get id => throw _privateConstructorUsedError;

  /// First location config ID
  String get location1 => throw _privateConstructorUsedError;

  /// Second location config ID
  String get location2 => throw _privateConstructorUsedError;

  /// Display name when viewing from location1
  String get displayName1 => throw _privateConstructorUsedError;

  /// Display name when viewing from location2
  String get displayName2 => throw _privateConstructorUsedError;

  /// Floor in location1 where portal appears
  int get floor1 => throw _privateConstructorUsedError;

  /// Floor in location2 where portal appears
  int get floor2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PortalDefinitionCopyWith<PortalDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortalDefinitionCopyWith<$Res> {
  factory $PortalDefinitionCopyWith(
          PortalDefinition value, $Res Function(PortalDefinition) then) =
      _$PortalDefinitionCopyWithImpl<$Res, PortalDefinition>;
  @useResult
  $Res call(
      {String id,
      String location1,
      String location2,
      String displayName1,
      String displayName2,
      int floor1,
      int floor2});
}

/// @nodoc
class _$PortalDefinitionCopyWithImpl<$Res, $Val extends PortalDefinition>
    implements $PortalDefinitionCopyWith<$Res> {
  _$PortalDefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? location1 = null,
    Object? location2 = null,
    Object? displayName1 = null,
    Object? displayName2 = null,
    Object? floor1 = null,
    Object? floor2 = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      location1: null == location1
          ? _value.location1
          : location1 // ignore: cast_nullable_to_non_nullable
              as String,
      location2: null == location2
          ? _value.location2
          : location2 // ignore: cast_nullable_to_non_nullable
              as String,
      displayName1: null == displayName1
          ? _value.displayName1
          : displayName1 // ignore: cast_nullable_to_non_nullable
              as String,
      displayName2: null == displayName2
          ? _value.displayName2
          : displayName2 // ignore: cast_nullable_to_non_nullable
              as String,
      floor1: null == floor1
          ? _value.floor1
          : floor1 // ignore: cast_nullable_to_non_nullable
              as int,
      floor2: null == floor2
          ? _value.floor2
          : floor2 // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortalDefinitionImplCopyWith<$Res>
    implements $PortalDefinitionCopyWith<$Res> {
  factory _$$PortalDefinitionImplCopyWith(_$PortalDefinitionImpl value,
          $Res Function(_$PortalDefinitionImpl) then) =
      __$$PortalDefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String location1,
      String location2,
      String displayName1,
      String displayName2,
      int floor1,
      int floor2});
}

/// @nodoc
class __$$PortalDefinitionImplCopyWithImpl<$Res>
    extends _$PortalDefinitionCopyWithImpl<$Res, _$PortalDefinitionImpl>
    implements _$$PortalDefinitionImplCopyWith<$Res> {
  __$$PortalDefinitionImplCopyWithImpl(_$PortalDefinitionImpl _value,
      $Res Function(_$PortalDefinitionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? location1 = null,
    Object? location2 = null,
    Object? displayName1 = null,
    Object? displayName2 = null,
    Object? floor1 = null,
    Object? floor2 = null,
  }) {
    return _then(_$PortalDefinitionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      location1: null == location1
          ? _value.location1
          : location1 // ignore: cast_nullable_to_non_nullable
              as String,
      location2: null == location2
          ? _value.location2
          : location2 // ignore: cast_nullable_to_non_nullable
              as String,
      displayName1: null == displayName1
          ? _value.displayName1
          : displayName1 // ignore: cast_nullable_to_non_nullable
              as String,
      displayName2: null == displayName2
          ? _value.displayName2
          : displayName2 // ignore: cast_nullable_to_non_nullable
              as String,
      floor1: null == floor1
          ? _value.floor1
          : floor1 // ignore: cast_nullable_to_non_nullable
              as int,
      floor2: null == floor2
          ? _value.floor2
          : floor2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PortalDefinitionImpl extends _PortalDefinition {
  const _$PortalDefinitionImpl(
      {required this.id,
      required this.location1,
      required this.location2,
      required this.displayName1,
      required this.displayName2,
      required this.floor1,
      required this.floor2})
      : super._();

  factory _$PortalDefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortalDefinitionImplFromJson(json);

  /// Unique portal ID (e.g., 'dark_dungeon_to_surface')
  @override
  final String id;

  /// First location config ID
  @override
  final String location1;

  /// Second location config ID
  @override
  final String location2;

  /// Display name when viewing from location1
  @override
  final String displayName1;

  /// Display name when viewing from location2
  @override
  final String displayName2;

  /// Floor in location1 where portal appears
  @override
  final int floor1;

  /// Floor in location2 where portal appears
  @override
  final int floor2;

  @override
  String toString() {
    return 'PortalDefinition(id: $id, location1: $location1, location2: $location2, displayName1: $displayName1, displayName2: $displayName2, floor1: $floor1, floor2: $floor2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortalDefinitionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.location1, location1) ||
                other.location1 == location1) &&
            (identical(other.location2, location2) ||
                other.location2 == location2) &&
            (identical(other.displayName1, displayName1) ||
                other.displayName1 == displayName1) &&
            (identical(other.displayName2, displayName2) ||
                other.displayName2 == displayName2) &&
            (identical(other.floor1, floor1) || other.floor1 == floor1) &&
            (identical(other.floor2, floor2) || other.floor2 == floor2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, location1, location2,
      displayName1, displayName2, floor1, floor2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PortalDefinitionImplCopyWith<_$PortalDefinitionImpl> get copyWith =>
      __$$PortalDefinitionImplCopyWithImpl<_$PortalDefinitionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortalDefinitionImplToJson(
      this,
    );
  }
}

abstract class _PortalDefinition extends PortalDefinition {
  const factory _PortalDefinition(
      {required final String id,
      required final String location1,
      required final String location2,
      required final String displayName1,
      required final String displayName2,
      required final int floor1,
      required final int floor2}) = _$PortalDefinitionImpl;
  const _PortalDefinition._() : super._();

  factory _PortalDefinition.fromJson(Map<String, dynamic> json) =
      _$PortalDefinitionImpl.fromJson;

  @override

  /// Unique portal ID (e.g., 'dark_dungeon_to_surface')
  String get id;
  @override

  /// First location config ID
  String get location1;
  @override

  /// Second location config ID
  String get location2;
  @override

  /// Display name when viewing from location1
  String get displayName1;
  @override

  /// Display name when viewing from location2
  String get displayName2;
  @override

  /// Floor in location1 where portal appears
  int get floor1;
  @override

  /// Floor in location2 where portal appears
  int get floor2;
  @override
  @JsonKey(ignore: true)
  _$$PortalDefinitionImplCopyWith<_$PortalDefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
