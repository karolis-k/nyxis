// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'world_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorldObject _$WorldObjectFromJson(Map<String, dynamic> json) {
  return _WorldObject.fromJson(json);
}

/// @nodoc
mixin _$WorldObject {
  /// Unique instance ID for this world object.
  String get id => throw _privateConstructorUsedError;

  /// Type of this world object.
  WorldObjectType get type => throw _privateConstructorUsedError;

  /// Position on the map.
  Position get position => throw _privateConstructorUsedError;

  /// Reference to specific config (e.g., portal definition ID).
  String get configId => throw _privateConstructorUsedError;

  /// Whether the player can interact with this object.
  bool get isInteractable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorldObjectCopyWith<WorldObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorldObjectCopyWith<$Res> {
  factory $WorldObjectCopyWith(
          WorldObject value, $Res Function(WorldObject) then) =
      _$WorldObjectCopyWithImpl<$Res, WorldObject>;
  @useResult
  $Res call(
      {String id,
      WorldObjectType type,
      Position position,
      String configId,
      bool isInteractable});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$WorldObjectCopyWithImpl<$Res, $Val extends WorldObject>
    implements $WorldObjectCopyWith<$Res> {
  _$WorldObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? position = null,
    Object? configId = null,
    Object? isInteractable = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorldObjectType,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      configId: null == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String,
      isInteractable: null == isInteractable
          ? _value.isInteractable
          : isInteractable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PositionCopyWith<$Res> get position {
    return $PositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorldObjectImplCopyWith<$Res>
    implements $WorldObjectCopyWith<$Res> {
  factory _$$WorldObjectImplCopyWith(
          _$WorldObjectImpl value, $Res Function(_$WorldObjectImpl) then) =
      __$$WorldObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      WorldObjectType type,
      Position position,
      String configId,
      bool isInteractable});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$WorldObjectImplCopyWithImpl<$Res>
    extends _$WorldObjectCopyWithImpl<$Res, _$WorldObjectImpl>
    implements _$$WorldObjectImplCopyWith<$Res> {
  __$$WorldObjectImplCopyWithImpl(
      _$WorldObjectImpl _value, $Res Function(_$WorldObjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? position = null,
    Object? configId = null,
    Object? isInteractable = null,
  }) {
    return _then(_$WorldObjectImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorldObjectType,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      configId: null == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String,
      isInteractable: null == isInteractable
          ? _value.isInteractable
          : isInteractable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorldObjectImpl extends _WorldObject {
  const _$WorldObjectImpl(
      {required this.id,
      required this.type,
      required this.position,
      required this.configId,
      this.isInteractable = true})
      : super._();

  factory _$WorldObjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorldObjectImplFromJson(json);

  /// Unique instance ID for this world object.
  @override
  final String id;

  /// Type of this world object.
  @override
  final WorldObjectType type;

  /// Position on the map.
  @override
  final Position position;

  /// Reference to specific config (e.g., portal definition ID).
  @override
  final String configId;

  /// Whether the player can interact with this object.
  @override
  @JsonKey()
  final bool isInteractable;

  @override
  String toString() {
    return 'WorldObject(id: $id, type: $type, position: $position, configId: $configId, isInteractable: $isInteractable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorldObjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.configId, configId) ||
                other.configId == configId) &&
            (identical(other.isInteractable, isInteractable) ||
                other.isInteractable == isInteractable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, position, configId, isInteractable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorldObjectImplCopyWith<_$WorldObjectImpl> get copyWith =>
      __$$WorldObjectImplCopyWithImpl<_$WorldObjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorldObjectImplToJson(
      this,
    );
  }
}

abstract class _WorldObject extends WorldObject {
  const factory _WorldObject(
      {required final String id,
      required final WorldObjectType type,
      required final Position position,
      required final String configId,
      final bool isInteractable}) = _$WorldObjectImpl;
  const _WorldObject._() : super._();

  factory _WorldObject.fromJson(Map<String, dynamic> json) =
      _$WorldObjectImpl.fromJson;

  @override

  /// Unique instance ID for this world object.
  String get id;
  @override

  /// Type of this world object.
  WorldObjectType get type;
  @override

  /// Position on the map.
  Position get position;
  @override

  /// Reference to specific config (e.g., portal definition ID).
  String get configId;
  @override

  /// Whether the player can interact with this object.
  bool get isInteractable;
  @override
  @JsonKey(ignore: true)
  _$$WorldObjectImplCopyWith<_$WorldObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
