// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monster.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Monster _$MonsterFromJson(Map<String, dynamic> json) {
  return _Monster.fromJson(json);
}

/// @nodoc
mixin _$Monster {
  /// Unique identifier for this monster instance.
  String get id => throw _privateConstructorUsedError;

  /// Reference to the monster type in MonsterRegistry.
  String get configId => throw _privateConstructorUsedError;

  /// Current position on the game map.
  Position get position => throw _privateConstructorUsedError;

  /// Current health points.
  int get health => throw _privateConstructorUsedError;

  /// Maximum health points.
  int get maxHealth => throw _privateConstructorUsedError;

  /// Current AI behavior state.
  AIState get aiState => throw _privateConstructorUsedError;

  /// Current energy for the energy-based turn system.
  int get energy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonsterCopyWith<Monster> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonsterCopyWith<$Res> {
  factory $MonsterCopyWith(Monster value, $Res Function(Monster) then) =
      _$MonsterCopyWithImpl<$Res, Monster>;
  @useResult
  $Res call(
      {String id,
      String configId,
      Position position,
      int health,
      int maxHealth,
      AIState aiState,
      int energy});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$MonsterCopyWithImpl<$Res, $Val extends Monster>
    implements $MonsterCopyWith<$Res> {
  _$MonsterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? configId = null,
    Object? position = null,
    Object? health = null,
    Object? maxHealth = null,
    Object? aiState = null,
    Object? energy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      configId: null == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      health: null == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as int,
      maxHealth: null == maxHealth
          ? _value.maxHealth
          : maxHealth // ignore: cast_nullable_to_non_nullable
              as int,
      aiState: null == aiState
          ? _value.aiState
          : aiState // ignore: cast_nullable_to_non_nullable
              as AIState,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$MonsterImplCopyWith<$Res> implements $MonsterCopyWith<$Res> {
  factory _$$MonsterImplCopyWith(
          _$MonsterImpl value, $Res Function(_$MonsterImpl) then) =
      __$$MonsterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String configId,
      Position position,
      int health,
      int maxHealth,
      AIState aiState,
      int energy});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$MonsterImplCopyWithImpl<$Res>
    extends _$MonsterCopyWithImpl<$Res, _$MonsterImpl>
    implements _$$MonsterImplCopyWith<$Res> {
  __$$MonsterImplCopyWithImpl(
      _$MonsterImpl _value, $Res Function(_$MonsterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? configId = null,
    Object? position = null,
    Object? health = null,
    Object? maxHealth = null,
    Object? aiState = null,
    Object? energy = null,
  }) {
    return _then(_$MonsterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      configId: null == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      health: null == health
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as int,
      maxHealth: null == maxHealth
          ? _value.maxHealth
          : maxHealth // ignore: cast_nullable_to_non_nullable
              as int,
      aiState: null == aiState
          ? _value.aiState
          : aiState // ignore: cast_nullable_to_non_nullable
              as AIState,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonsterImpl extends _Monster {
  const _$MonsterImpl(
      {required this.id,
      required this.configId,
      required this.position,
      required this.health,
      required this.maxHealth,
      this.aiState = AIState.idle,
      this.energy = 0})
      : super._();

  factory _$MonsterImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonsterImplFromJson(json);

  /// Unique identifier for this monster instance.
  @override
  final String id;

  /// Reference to the monster type in MonsterRegistry.
  @override
  final String configId;

  /// Current position on the game map.
  @override
  final Position position;

  /// Current health points.
  @override
  final int health;

  /// Maximum health points.
  @override
  final int maxHealth;

  /// Current AI behavior state.
  @override
  @JsonKey()
  final AIState aiState;

  /// Current energy for the energy-based turn system.
  @override
  @JsonKey()
  final int energy;

  @override
  String toString() {
    return 'Monster(id: $id, configId: $configId, position: $position, health: $health, maxHealth: $maxHealth, aiState: $aiState, energy: $energy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonsterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.configId, configId) ||
                other.configId == configId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.maxHealth, maxHealth) ||
                other.maxHealth == maxHealth) &&
            (identical(other.aiState, aiState) || other.aiState == aiState) &&
            (identical(other.energy, energy) || other.energy == energy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, configId, position, health, maxHealth, aiState, energy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonsterImplCopyWith<_$MonsterImpl> get copyWith =>
      __$$MonsterImplCopyWithImpl<_$MonsterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonsterImplToJson(
      this,
    );
  }
}

abstract class _Monster extends Monster {
  const factory _Monster(
      {required final String id,
      required final String configId,
      required final Position position,
      required final int health,
      required final int maxHealth,
      final AIState aiState,
      final int energy}) = _$MonsterImpl;
  const _Monster._() : super._();

  factory _Monster.fromJson(Map<String, dynamic> json) = _$MonsterImpl.fromJson;

  @override

  /// Unique identifier for this monster instance.
  String get id;
  @override

  /// Reference to the monster type in MonsterRegistry.
  String get configId;
  @override

  /// Current position on the game map.
  Position get position;
  @override

  /// Current health points.
  int get health;
  @override

  /// Maximum health points.
  int get maxHealth;
  @override

  /// Current AI behavior state.
  AIState get aiState;
  @override

  /// Current energy for the energy-based turn system.
  int get energy;
  @override
  @JsonKey(ignore: true)
  _$$MonsterImplCopyWith<_$MonsterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
