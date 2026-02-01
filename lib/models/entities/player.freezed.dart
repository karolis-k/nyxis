// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  /// Unique identifier for this player instance.
  String get id => throw _privateConstructorUsedError;

  /// Current position on the game map.
  Position get position => throw _privateConstructorUsedError;

  /// Current health points.
  int get health => throw _privateConstructorUsedError;

  /// Maximum health points.
  int get maxHealth => throw _privateConstructorUsedError;

  /// Base attack power (before equipment bonuses).
  int get attack => throw _privateConstructorUsedError;

  /// Base defense value (before equipment bonuses).
  int get defense => throw _privateConstructorUsedError;

  /// List of item IDs in the player's inventory.
  List<String> get inventoryItemIds => throw _privateConstructorUsedError;

  /// ID of the currently equipped weapon, if any.
  String? get equippedWeaponId => throw _privateConstructorUsedError;

  /// ID of the currently equipped armor, if any.
  String? get equippedArmorId => throw _privateConstructorUsedError;

  /// Speed value for energy-based turn system (100 = normal speed).
  int get speed => throw _privateConstructorUsedError;

  /// Current energy for the energy-based turn system.
  int get energy => throw _privateConstructorUsedError;

  /// Current experience points earned from kills.
  int get experience => throw _privateConstructorUsedError;

  /// Current score (experience + bonus points).
  int get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {String id,
      Position position,
      int health,
      int maxHealth,
      int attack,
      int defense,
      List<String> inventoryItemIds,
      String? equippedWeaponId,
      String? equippedArmorId,
      int speed,
      int energy,
      int experience,
      int score});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? health = null,
    Object? maxHealth = null,
    Object? attack = null,
    Object? defense = null,
    Object? inventoryItemIds = null,
    Object? equippedWeaponId = freezed,
    Object? equippedArmorId = freezed,
    Object? speed = null,
    Object? energy = null,
    Object? experience = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      attack: null == attack
          ? _value.attack
          : attack // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      inventoryItemIds: null == inventoryItemIds
          ? _value.inventoryItemIds
          : inventoryItemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      equippedWeaponId: freezed == equippedWeaponId
          ? _value.equippedWeaponId
          : equippedWeaponId // ignore: cast_nullable_to_non_nullable
              as String?,
      equippedArmorId: freezed == equippedArmorId
          ? _value.equippedArmorId
          : equippedArmorId // ignore: cast_nullable_to_non_nullable
              as String?,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Position position,
      int health,
      int maxHealth,
      int attack,
      int defense,
      List<String> inventoryItemIds,
      String? equippedWeaponId,
      String? equippedArmorId,
      int speed,
      int energy,
      int experience,
      int score});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? health = null,
    Object? maxHealth = null,
    Object? attack = null,
    Object? defense = null,
    Object? inventoryItemIds = null,
    Object? equippedWeaponId = freezed,
    Object? equippedArmorId = freezed,
    Object? speed = null,
    Object? energy = null,
    Object? experience = null,
    Object? score = null,
  }) {
    return _then(_$PlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      attack: null == attack
          ? _value.attack
          : attack // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      inventoryItemIds: null == inventoryItemIds
          ? _value._inventoryItemIds
          : inventoryItemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      equippedWeaponId: freezed == equippedWeaponId
          ? _value.equippedWeaponId
          : equippedWeaponId // ignore: cast_nullable_to_non_nullable
              as String?,
      equippedArmorId: freezed == equippedArmorId
          ? _value.equippedArmorId
          : equippedArmorId // ignore: cast_nullable_to_non_nullable
              as String?,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerImpl extends _Player {
  const _$PlayerImpl(
      {required this.id,
      required this.position,
      required this.health,
      required this.maxHealth,
      required this.attack,
      required this.defense,
      final List<String> inventoryItemIds = const [],
      this.equippedWeaponId,
      this.equippedArmorId,
      this.speed = 100,
      this.energy = 0,
      this.experience = 0,
      this.score = 0})
      : _inventoryItemIds = inventoryItemIds,
        super._();

  factory _$PlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerImplFromJson(json);

  /// Unique identifier for this player instance.
  @override
  final String id;

  /// Current position on the game map.
  @override
  final Position position;

  /// Current health points.
  @override
  final int health;

  /// Maximum health points.
  @override
  final int maxHealth;

  /// Base attack power (before equipment bonuses).
  @override
  final int attack;

  /// Base defense value (before equipment bonuses).
  @override
  final int defense;

  /// List of item IDs in the player's inventory.
  final List<String> _inventoryItemIds;

  /// List of item IDs in the player's inventory.
  @override
  @JsonKey()
  List<String> get inventoryItemIds {
    if (_inventoryItemIds is EqualUnmodifiableListView)
      return _inventoryItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inventoryItemIds);
  }

  /// ID of the currently equipped weapon, if any.
  @override
  final String? equippedWeaponId;

  /// ID of the currently equipped armor, if any.
  @override
  final String? equippedArmorId;

  /// Speed value for energy-based turn system (100 = normal speed).
  @override
  @JsonKey()
  final int speed;

  /// Current energy for the energy-based turn system.
  @override
  @JsonKey()
  final int energy;

  /// Current experience points earned from kills.
  @override
  @JsonKey()
  final int experience;

  /// Current score (experience + bonus points).
  @override
  @JsonKey()
  final int score;

  @override
  String toString() {
    return 'Player(id: $id, position: $position, health: $health, maxHealth: $maxHealth, attack: $attack, defense: $defense, inventoryItemIds: $inventoryItemIds, equippedWeaponId: $equippedWeaponId, equippedArmorId: $equippedArmorId, speed: $speed, energy: $energy, experience: $experience, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.maxHealth, maxHealth) ||
                other.maxHealth == maxHealth) &&
            (identical(other.attack, attack) || other.attack == attack) &&
            (identical(other.defense, defense) || other.defense == defense) &&
            const DeepCollectionEquality()
                .equals(other._inventoryItemIds, _inventoryItemIds) &&
            (identical(other.equippedWeaponId, equippedWeaponId) ||
                other.equippedWeaponId == equippedWeaponId) &&
            (identical(other.equippedArmorId, equippedArmorId) ||
                other.equippedArmorId == equippedArmorId) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.energy, energy) || other.energy == energy) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      position,
      health,
      maxHealth,
      attack,
      defense,
      const DeepCollectionEquality().hash(_inventoryItemIds),
      equippedWeaponId,
      equippedArmorId,
      speed,
      energy,
      experience,
      score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerImplToJson(
      this,
    );
  }
}

abstract class _Player extends Player {
  const factory _Player(
      {required final String id,
      required final Position position,
      required final int health,
      required final int maxHealth,
      required final int attack,
      required final int defense,
      final List<String> inventoryItemIds,
      final String? equippedWeaponId,
      final String? equippedArmorId,
      final int speed,
      final int energy,
      final int experience,
      final int score}) = _$PlayerImpl;
  const _Player._() : super._();

  factory _Player.fromJson(Map<String, dynamic> json) = _$PlayerImpl.fromJson;

  @override

  /// Unique identifier for this player instance.
  String get id;
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

  /// Base attack power (before equipment bonuses).
  int get attack;
  @override

  /// Base defense value (before equipment bonuses).
  int get defense;
  @override

  /// List of item IDs in the player's inventory.
  List<String> get inventoryItemIds;
  @override

  /// ID of the currently equipped weapon, if any.
  String? get equippedWeaponId;
  @override

  /// ID of the currently equipped armor, if any.
  String? get equippedArmorId;
  @override

  /// Speed value for energy-based turn system (100 = normal speed).
  int get speed;
  @override

  /// Current energy for the energy-based turn system.
  int get energy;
  @override

  /// Current experience points earned from kills.
  int get experience;
  @override

  /// Current score (experience + bonus points).
  int get score;
  @override
  @JsonKey(ignore: true)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
