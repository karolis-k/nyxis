// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monster_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LootEntry _$LootEntryFromJson(Map<String, dynamic> json) {
  return _LootEntry.fromJson(json);
}

/// @nodoc
mixin _$LootEntry {
  /// Item config ID that can drop
  String get itemConfigId => throw _privateConstructorUsedError;

  /// Drop chance (0.0 to 1.0)
  double get chance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LootEntryCopyWith<LootEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LootEntryCopyWith<$Res> {
  factory $LootEntryCopyWith(LootEntry value, $Res Function(LootEntry) then) =
      _$LootEntryCopyWithImpl<$Res, LootEntry>;
  @useResult
  $Res call({String itemConfigId, double chance});
}

/// @nodoc
class _$LootEntryCopyWithImpl<$Res, $Val extends LootEntry>
    implements $LootEntryCopyWith<$Res> {
  _$LootEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemConfigId = null,
    Object? chance = null,
  }) {
    return _then(_value.copyWith(
      itemConfigId: null == itemConfigId
          ? _value.itemConfigId
          : itemConfigId // ignore: cast_nullable_to_non_nullable
              as String,
      chance: null == chance
          ? _value.chance
          : chance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LootEntryImplCopyWith<$Res>
    implements $LootEntryCopyWith<$Res> {
  factory _$$LootEntryImplCopyWith(
          _$LootEntryImpl value, $Res Function(_$LootEntryImpl) then) =
      __$$LootEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String itemConfigId, double chance});
}

/// @nodoc
class __$$LootEntryImplCopyWithImpl<$Res>
    extends _$LootEntryCopyWithImpl<$Res, _$LootEntryImpl>
    implements _$$LootEntryImplCopyWith<$Res> {
  __$$LootEntryImplCopyWithImpl(
      _$LootEntryImpl _value, $Res Function(_$LootEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemConfigId = null,
    Object? chance = null,
  }) {
    return _then(_$LootEntryImpl(
      itemConfigId: null == itemConfigId
          ? _value.itemConfigId
          : itemConfigId // ignore: cast_nullable_to_non_nullable
              as String,
      chance: null == chance
          ? _value.chance
          : chance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LootEntryImpl implements _LootEntry {
  const _$LootEntryImpl({required this.itemConfigId, required this.chance});

  factory _$LootEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LootEntryImplFromJson(json);

  /// Item config ID that can drop
  @override
  final String itemConfigId;

  /// Drop chance (0.0 to 1.0)
  @override
  final double chance;

  @override
  String toString() {
    return 'LootEntry(itemConfigId: $itemConfigId, chance: $chance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LootEntryImpl &&
            (identical(other.itemConfigId, itemConfigId) ||
                other.itemConfigId == itemConfigId) &&
            (identical(other.chance, chance) || other.chance == chance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, itemConfigId, chance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LootEntryImplCopyWith<_$LootEntryImpl> get copyWith =>
      __$$LootEntryImplCopyWithImpl<_$LootEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LootEntryImplToJson(
      this,
    );
  }
}

abstract class _LootEntry implements LootEntry {
  const factory _LootEntry(
      {required final String itemConfigId,
      required final double chance}) = _$LootEntryImpl;

  factory _LootEntry.fromJson(Map<String, dynamic> json) =
      _$LootEntryImpl.fromJson;

  @override

  /// Item config ID that can drop
  String get itemConfigId;
  @override

  /// Drop chance (0.0 to 1.0)
  double get chance;
  @override
  @JsonKey(ignore: true)
  _$$LootEntryImplCopyWith<_$LootEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonsterConfig _$MonsterConfigFromJson(Map<String, dynamic> json) {
  return _MonsterConfig.fromJson(json);
}

/// @nodoc
mixin _$MonsterConfig {
  /// Unique identifier for this monster type (e.g., 'goblin', 'skeleton').
  String get id => throw _privateConstructorUsedError;

  /// Display name shown to the player.
  String get name => throw _privateConstructorUsedError;

  /// Base health points for this monster type.
  int get baseHealth => throw _privateConstructorUsedError;

  /// Base damage dealt per attack.
  int get baseDamage => throw _privateConstructorUsedError;

  /// Base defense value (damage reduction).
  int get baseDefense => throw _privateConstructorUsedError;

  /// Reference to the sprite asset for rendering.
  String get spriteId => throw _privateConstructorUsedError;

  /// AI behavior pattern for this monster type.
  MonsterBehaviour get behavior => throw _privateConstructorUsedError;

  /// Distance at which the monster detects and reacts to the player.
  int get aggroRange => throw _privateConstructorUsedError;

  /// Experience points awarded to the player on kill.
  int get xpValue => throw _privateConstructorUsedError;

  /// Speed value for energy-based turn system (100 = normal speed).
  int get speed => throw _privateConstructorUsedError;

  /// Color value for rendering this monster type (stored as int for JSON serialization).
  int get colorValue => throw _privateConstructorUsedError;

  /// Loot table for items that can drop on death.
  List<LootEntry> get lootTable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonsterConfigCopyWith<MonsterConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonsterConfigCopyWith<$Res> {
  factory $MonsterConfigCopyWith(
          MonsterConfig value, $Res Function(MonsterConfig) then) =
      _$MonsterConfigCopyWithImpl<$Res, MonsterConfig>;
  @useResult
  $Res call(
      {String id,
      String name,
      int baseHealth,
      int baseDamage,
      int baseDefense,
      String spriteId,
      MonsterBehaviour behavior,
      int aggroRange,
      int xpValue,
      int speed,
      int colorValue,
      List<LootEntry> lootTable});
}

/// @nodoc
class _$MonsterConfigCopyWithImpl<$Res, $Val extends MonsterConfig>
    implements $MonsterConfigCopyWith<$Res> {
  _$MonsterConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? baseHealth = null,
    Object? baseDamage = null,
    Object? baseDefense = null,
    Object? spriteId = null,
    Object? behavior = null,
    Object? aggroRange = null,
    Object? xpValue = null,
    Object? speed = null,
    Object? colorValue = null,
    Object? lootTable = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      baseHealth: null == baseHealth
          ? _value.baseHealth
          : baseHealth // ignore: cast_nullable_to_non_nullable
              as int,
      baseDamage: null == baseDamage
          ? _value.baseDamage
          : baseDamage // ignore: cast_nullable_to_non_nullable
              as int,
      baseDefense: null == baseDefense
          ? _value.baseDefense
          : baseDefense // ignore: cast_nullable_to_non_nullable
              as int,
      spriteId: null == spriteId
          ? _value.spriteId
          : spriteId // ignore: cast_nullable_to_non_nullable
              as String,
      behavior: null == behavior
          ? _value.behavior
          : behavior // ignore: cast_nullable_to_non_nullable
              as MonsterBehaviour,
      aggroRange: null == aggroRange
          ? _value.aggroRange
          : aggroRange // ignore: cast_nullable_to_non_nullable
              as int,
      xpValue: null == xpValue
          ? _value.xpValue
          : xpValue // ignore: cast_nullable_to_non_nullable
              as int,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      lootTable: null == lootTable
          ? _value.lootTable
          : lootTable // ignore: cast_nullable_to_non_nullable
              as List<LootEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonsterConfigImplCopyWith<$Res>
    implements $MonsterConfigCopyWith<$Res> {
  factory _$$MonsterConfigImplCopyWith(
          _$MonsterConfigImpl value, $Res Function(_$MonsterConfigImpl) then) =
      __$$MonsterConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int baseHealth,
      int baseDamage,
      int baseDefense,
      String spriteId,
      MonsterBehaviour behavior,
      int aggroRange,
      int xpValue,
      int speed,
      int colorValue,
      List<LootEntry> lootTable});
}

/// @nodoc
class __$$MonsterConfigImplCopyWithImpl<$Res>
    extends _$MonsterConfigCopyWithImpl<$Res, _$MonsterConfigImpl>
    implements _$$MonsterConfigImplCopyWith<$Res> {
  __$$MonsterConfigImplCopyWithImpl(
      _$MonsterConfigImpl _value, $Res Function(_$MonsterConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? baseHealth = null,
    Object? baseDamage = null,
    Object? baseDefense = null,
    Object? spriteId = null,
    Object? behavior = null,
    Object? aggroRange = null,
    Object? xpValue = null,
    Object? speed = null,
    Object? colorValue = null,
    Object? lootTable = null,
  }) {
    return _then(_$MonsterConfigImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      baseHealth: null == baseHealth
          ? _value.baseHealth
          : baseHealth // ignore: cast_nullable_to_non_nullable
              as int,
      baseDamage: null == baseDamage
          ? _value.baseDamage
          : baseDamage // ignore: cast_nullable_to_non_nullable
              as int,
      baseDefense: null == baseDefense
          ? _value.baseDefense
          : baseDefense // ignore: cast_nullable_to_non_nullable
              as int,
      spriteId: null == spriteId
          ? _value.spriteId
          : spriteId // ignore: cast_nullable_to_non_nullable
              as String,
      behavior: null == behavior
          ? _value.behavior
          : behavior // ignore: cast_nullable_to_non_nullable
              as MonsterBehaviour,
      aggroRange: null == aggroRange
          ? _value.aggroRange
          : aggroRange // ignore: cast_nullable_to_non_nullable
              as int,
      xpValue: null == xpValue
          ? _value.xpValue
          : xpValue // ignore: cast_nullable_to_non_nullable
              as int,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int,
      colorValue: null == colorValue
          ? _value.colorValue
          : colorValue // ignore: cast_nullable_to_non_nullable
              as int,
      lootTable: null == lootTable
          ? _value._lootTable
          : lootTable // ignore: cast_nullable_to_non_nullable
              as List<LootEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonsterConfigImpl extends _MonsterConfig {
  const _$MonsterConfigImpl(
      {required this.id,
      required this.name,
      required this.baseHealth,
      required this.baseDamage,
      required this.baseDefense,
      required this.spriteId,
      required this.behavior,
      required this.aggroRange,
      required this.xpValue,
      required this.speed,
      required this.colorValue,
      final List<LootEntry> lootTable = const []})
      : _lootTable = lootTable,
        super._();

  factory _$MonsterConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonsterConfigImplFromJson(json);

  /// Unique identifier for this monster type (e.g., 'goblin', 'skeleton').
  @override
  final String id;

  /// Display name shown to the player.
  @override
  final String name;

  /// Base health points for this monster type.
  @override
  final int baseHealth;

  /// Base damage dealt per attack.
  @override
  final int baseDamage;

  /// Base defense value (damage reduction).
  @override
  final int baseDefense;

  /// Reference to the sprite asset for rendering.
  @override
  final String spriteId;

  /// AI behavior pattern for this monster type.
  @override
  final MonsterBehaviour behavior;

  /// Distance at which the monster detects and reacts to the player.
  @override
  final int aggroRange;

  /// Experience points awarded to the player on kill.
  @override
  final int xpValue;

  /// Speed value for energy-based turn system (100 = normal speed).
  @override
  final int speed;

  /// Color value for rendering this monster type (stored as int for JSON serialization).
  @override
  final int colorValue;

  /// Loot table for items that can drop on death.
  final List<LootEntry> _lootTable;

  /// Loot table for items that can drop on death.
  @override
  @JsonKey()
  List<LootEntry> get lootTable {
    if (_lootTable is EqualUnmodifiableListView) return _lootTable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lootTable);
  }

  @override
  String toString() {
    return 'MonsterConfig(id: $id, name: $name, baseHealth: $baseHealth, baseDamage: $baseDamage, baseDefense: $baseDefense, spriteId: $spriteId, behavior: $behavior, aggroRange: $aggroRange, xpValue: $xpValue, speed: $speed, colorValue: $colorValue, lootTable: $lootTable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonsterConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.baseHealth, baseHealth) ||
                other.baseHealth == baseHealth) &&
            (identical(other.baseDamage, baseDamage) ||
                other.baseDamage == baseDamage) &&
            (identical(other.baseDefense, baseDefense) ||
                other.baseDefense == baseDefense) &&
            (identical(other.spriteId, spriteId) ||
                other.spriteId == spriteId) &&
            (identical(other.behavior, behavior) ||
                other.behavior == behavior) &&
            (identical(other.aggroRange, aggroRange) ||
                other.aggroRange == aggroRange) &&
            (identical(other.xpValue, xpValue) || other.xpValue == xpValue) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.colorValue, colorValue) ||
                other.colorValue == colorValue) &&
            const DeepCollectionEquality()
                .equals(other._lootTable, _lootTable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      baseHealth,
      baseDamage,
      baseDefense,
      spriteId,
      behavior,
      aggroRange,
      xpValue,
      speed,
      colorValue,
      const DeepCollectionEquality().hash(_lootTable));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonsterConfigImplCopyWith<_$MonsterConfigImpl> get copyWith =>
      __$$MonsterConfigImplCopyWithImpl<_$MonsterConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonsterConfigImplToJson(
      this,
    );
  }
}

abstract class _MonsterConfig extends MonsterConfig {
  const factory _MonsterConfig(
      {required final String id,
      required final String name,
      required final int baseHealth,
      required final int baseDamage,
      required final int baseDefense,
      required final String spriteId,
      required final MonsterBehaviour behavior,
      required final int aggroRange,
      required final int xpValue,
      required final int speed,
      required final int colorValue,
      final List<LootEntry> lootTable}) = _$MonsterConfigImpl;
  const _MonsterConfig._() : super._();

  factory _MonsterConfig.fromJson(Map<String, dynamic> json) =
      _$MonsterConfigImpl.fromJson;

  @override

  /// Unique identifier for this monster type (e.g., 'goblin', 'skeleton').
  String get id;
  @override

  /// Display name shown to the player.
  String get name;
  @override

  /// Base health points for this monster type.
  int get baseHealth;
  @override

  /// Base damage dealt per attack.
  int get baseDamage;
  @override

  /// Base defense value (damage reduction).
  int get baseDefense;
  @override

  /// Reference to the sprite asset for rendering.
  String get spriteId;
  @override

  /// AI behavior pattern for this monster type.
  MonsterBehaviour get behavior;
  @override

  /// Distance at which the monster detects and reacts to the player.
  int get aggroRange;
  @override

  /// Experience points awarded to the player on kill.
  int get xpValue;
  @override

  /// Speed value for energy-based turn system (100 = normal speed).
  int get speed;
  @override

  /// Color value for rendering this monster type (stored as int for JSON serialization).
  int get colorValue;
  @override

  /// Loot table for items that can drop on death.
  List<LootEntry> get lootTable;
  @override
  @JsonKey(ignore: true)
  _$$MonsterConfigImplCopyWith<_$MonsterConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
