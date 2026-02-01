import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'monster_config.freezed.dart';
part 'monster_config.g.dart';

/// A single entry in a monster's loot table.
@freezed
class LootEntry with _$LootEntry {
  const factory LootEntry({
    /// Item config ID that can drop
    required String itemConfigId,

    /// Drop chance (0.0 to 1.0)
    required double chance,
  }) = _LootEntry;

  factory LootEntry.fromJson(Map<String, dynamic> json) =>
      _$LootEntryFromJson(json);
}

/// AI behavior types that define how monsters act.
enum MonsterBehaviour {
  /// Monster ignores the player unless attacked.
  passive,

  /// Monster actively seeks out and attacks the player.
  aggressive,

  /// Monster defends a specific area and attacks intruders.
  territorial,

  /// Monster flees from combat when threatened.
  cowardly,
}

/// Configuration data for a monster type.
///
/// This defines the base stats and behavior for a category of monsters.
/// Individual monster instances reference this via [Monster.configId].
@freezed
class MonsterConfig with _$MonsterConfig {
  const MonsterConfig._();

  const factory MonsterConfig({
    /// Unique identifier for this monster type (e.g., 'goblin', 'skeleton').
    required String id,

    /// Display name shown to the player.
    required String name,

    /// Base health points for this monster type.
    required int baseHealth,

    /// Base damage dealt per attack.
    required int baseDamage,

    /// Base defense value (damage reduction).
    required int baseDefense,

    /// Reference to the sprite asset for rendering.
    required String spriteId,

    /// AI behavior pattern for this monster type.
    required MonsterBehaviour behavior,

    /// Distance at which the monster detects and reacts to the player.
    required int aggroRange,

    /// Experience points awarded to the player on kill.
    required int xpValue,

    /// Speed value for energy-based turn system (100 = normal speed).
    required int speed,

    /// Color value for rendering this monster type (stored as int for JSON serialization).
    required int colorValue,

    /// Loot table for items that can drop on death.
    @Default([]) List<LootEntry> lootTable,
  }) = _MonsterConfig;

  /// Gets the color for rendering this monster.
  Color get color => Color(colorValue);

  factory MonsterConfig.fromJson(Map<String, dynamic> json) =>
      _$MonsterConfigFromJson(json);
}

/// Registry for monster configurations.
///
/// Provides access to all defined monster types and their stats.
/// Call [registerAll] during game initialization to populate the registry.
class MonsterRegistry {
  MonsterRegistry._();

  static final Map<String, MonsterConfig> _configs = {};

  /// Registers a monster configuration.
  ///
  /// Throws [ArgumentError] if a config with the same ID already exists.
  static void register(MonsterConfig config) {
    if (_configs.containsKey(config.id)) {
      throw ArgumentError('Monster config with id "${config.id}" already exists');
    }
    _configs[config.id] = config;
  }

  /// Gets a monster configuration by ID.
  ///
  /// Throws [StateError] if no config with the given ID exists.
  static MonsterConfig get(String id) {
    final config = _configs[id];
    if (config == null) {
      throw StateError('Monster config with id "$id" not found. '
          'Make sure to call MonsterRegistry.registerAll() during initialization.');
    }
    return config;
  }

  /// Tries to get a monster configuration by ID.
  ///
  /// Returns null if no config with the given ID exists.
  static MonsterConfig? tryGet(String id) {
    return _configs[id];
  }

  /// Returns all registered monster configurations.
  static List<MonsterConfig> all() {
    return _configs.values.toList();
  }

  /// Clears all registered configurations.
  ///
  /// Primarily used for testing.
  static void clear() {
    _configs.clear();
  }

  /// Registers all default monster configurations.
  ///
  /// Call this during game initialization.
  static void registerAll() {
    for (final config in _defaultMonsters) {
      if (!_configs.containsKey(config.id)) {
        _configs[config.id] = config;
      }
    }
  }
}

/// Default monster configurations for the game.
const List<MonsterConfig> _defaultMonsters = [
  // Rat: Weak, passive creature. Easy early-game encounter.
  MonsterConfig(
    id: 'rat',
    name: 'Rat',
    baseHealth: 8,
    baseDamage: 2,
    baseDefense: 0,
    spriteId: 'monsters/rat',
    behavior: MonsterBehaviour.passive,
    aggroRange: 3,
    xpValue: 5,
    speed: 120, // Fast
    colorValue: 0xFF808080, // Gray
    lootTable: [
      LootEntry(itemConfigId: 'health_potion', chance: 0.2),
    ],
  ),

  // Goblin: Basic aggressive enemy. Common threat.
  MonsterConfig(
    id: 'goblin',
    name: 'Goblin',
    baseHealth: 20,
    baseDamage: 5,
    baseDefense: 1,
    spriteId: 'monsters/goblin',
    behavior: MonsterBehaviour.aggressive,
    aggroRange: 6,
    xpValue: 15,
    speed: 100, // Normal
    colorValue: 0xFF00AA00, // Green
    lootTable: [
      LootEntry(itemConfigId: 'health_potion', chance: 0.3),
      LootEntry(itemConfigId: 'gold_coin', chance: 0.15),
    ],
  ),

  // Skeleton: Medium-strength undead. Aggressive fighter.
  MonsterConfig(
    id: 'skeleton',
    name: 'Skeleton',
    baseHealth: 25,
    baseDamage: 7,
    baseDefense: 2,
    spriteId: 'monsters/skeleton',
    behavior: MonsterBehaviour.aggressive,
    aggroRange: 7,
    xpValue: 25,
    speed: 90, // Slightly slow
    colorValue: 0xFFEEEEEE, // White
    lootTable: [
      LootEntry(itemConfigId: 'health_potion', chance: 0.3),
      LootEntry(itemConfigId: 'dagger', chance: 0.2),
      LootEntry(itemConfigId: 'rusty_key', chance: 0.1),
    ],
  ),

  // Slime: Slow-moving, defends its territory.
  MonsterConfig(
    id: 'slime',
    name: 'Slime',
    baseHealth: 30,
    baseDamage: 4,
    baseDefense: 3,
    spriteId: 'monsters/slime',
    behavior: MonsterBehaviour.territorial,
    aggroRange: 4,
    xpValue: 20,
    speed: 60, // Slow
    colorValue: 0xFF00AAAA, // Cyan
    lootTable: [
      LootEntry(itemConfigId: 'health_potion', chance: 0.4),
      LootEntry(itemConfigId: 'gem', chance: 0.1),
    ],
  ),

  // Orc: Strong warrior. High threat, high reward.
  MonsterConfig(
    id: 'orc',
    name: 'Orc',
    baseHealth: 50,
    baseDamage: 12,
    baseDefense: 4,
    spriteId: 'monsters/orc',
    behavior: MonsterBehaviour.aggressive,
    aggroRange: 8,
    xpValue: 50,
    speed: 80, // Somewhat slow
    colorValue: 0xFFAA5500, // Orange-brown
    lootTable: [
      LootEntry(itemConfigId: 'health_potion', chance: 0.5),
      LootEntry(itemConfigId: 'sword', chance: 0.25),
      LootEntry(itemConfigId: 'leather_armor', chance: 0.2),
      LootEntry(itemConfigId: 'chainmail', chance: 0.1),
    ],
  ),
];
