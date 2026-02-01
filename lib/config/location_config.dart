import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_config.freezed.dart';
part 'location_config.g.dart';

/// The type of location in the game world.
enum LocationType {
  /// Underground multi-floor dungeon with rooms and corridors.
  dungeon,

  /// Natural cave system with organic layouts.
  cave,

  /// Outdoor surface area (forest, plains, etc.).
  surface,

  /// Town or village with buildings and NPCs.
  town,
}

/// Configuration for a game location.
///
/// Defines the static properties and generation rules for a location type.
/// Used by the dungeon generator to create Location instances.
@freezed
class LocationConfig with _$LocationConfig {
  const LocationConfig._();

  const factory LocationConfig({
    /// Unique identifier for this location config (e.g., 'dark_dungeon', 'goblin_cave').
    required String id,

    /// Display name shown to the player.
    required String name,

    /// The type of location (dungeon, cave, surface, town).
    required LocationType type,

    /// Whether this is an outdoor/surface location.
    /// True for outdoor areas, false for underground.
    required bool isSurface,

    /// Maximum number of floors in this location.
    /// 1 for surface locations, higher for dungeons/caves.
    required int maxDepth,

    /// The generator ID used to create this location's map.
    /// Maps to a specific map generation algorithm (e.g., 'dungeon', 'cave', 'surface').
    required String generatorType,

    /// Optional ambient music track ID for this location.
    String? ambientMusic,

    /// List of monster config IDs that can spawn in this location.
    @Default([]) List<String> monsterPool,

    /// List of item config IDs that can spawn in this location.
    @Default([]) List<String> itemPool,
  }) = _LocationConfig;

  factory LocationConfig.fromJson(Map<String, dynamic> json) =>
      _$LocationConfigFromJson(json);

  /// Returns true if this location has any monsters that can spawn.
  bool get hasMonsters => monsterPool.isNotEmpty;

  /// Returns true if this location has any items that can spawn.
  bool get hasItems => itemPool.isNotEmpty;

  /// Returns true if this is an underground location.
  bool get isUnderground => !isSurface;

  /// Returns true if this location has multiple floors.
  bool get isMultiFloor => maxDepth > 1;
}

/// Registry for all location configurations in the game.
///
/// Provides static access to location configs by ID or type.
/// Must call [registerAll] before accessing any configs.
class LocationRegistry {
  LocationRegistry._();

  static final Map<String, LocationConfig> _configs = {};
  static bool _initialized = false;

  /// Registers a location configuration.
  ///
  /// Throws [StateError] if a config with the same ID already exists.
  static void register(LocationConfig config) {
    if (_configs.containsKey(config.id)) {
      throw StateError(
        'LocationConfig with id "${config.id}" is already registered.',
      );
    }
    _configs[config.id] = config;
  }

  /// Gets a location configuration by ID.
  ///
  /// Throws [ArgumentError] if no config with the given ID exists.
  static LocationConfig get(String id) {
    final config = _configs[id];
    if (config == null) {
      throw ArgumentError('No LocationConfig found with id "$id".');
    }
    return config;
  }

  /// Tries to get a location configuration by ID.
  ///
  /// Returns null if no config with the given ID exists.
  static LocationConfig? tryGet(String id) {
    return _configs[id];
  }

  /// Returns all registered location configurations.
  static List<LocationConfig> all() {
    return _configs.values.toList();
  }

  /// Returns all location configurations of a specific type.
  static List<LocationConfig> byType(LocationType type) {
    return _configs.values.where((config) => config.type == type).toList();
  }

  /// Clears all registered configurations.
  ///
  /// Primarily used for testing purposes.
  static void clear() {
    _configs.clear();
    _initialized = false;
  }

  /// Registers all default location configurations.
  ///
  /// Safe to call multiple times; will only register once.
  static void registerAll() {
    if (_initialized) return;

    for (final config in _defaultLocations) {
      register(config);
    }

    _initialized = true;
  }
}

/// Default location configurations for the game.
const List<LocationConfig> _defaultLocations = [
  // Starting Village - Safe town area
  LocationConfig(
    id: 'starting_village',
    name: 'Elderwood Village',
    type: LocationType.town,
    isSurface: true,
    maxDepth: 1,
    generatorType: 'dungeon', // Use dungeon generator for now
    ambientMusic: 'village_theme',
    monsterPool: [], // Safe area, no monsters
    itemPool: [
      'health_potion',
    ],
  ),

  // Dark Dungeon - Main dungeon area
  LocationConfig(
    id: 'dark_dungeon',
    name: 'The Dark Dungeon',
    type: LocationType.dungeon,
    isSurface: false,
    maxDepth: 5,
    generatorType: 'dungeon',
    ambientMusic: 'dungeon_ambience',
    monsterPool: [
      'goblin',
      'skeleton',
      'orc',
    ],
    itemPool: [
      'health_potion',
      'mana_potion',
      'sword',
      'leather_armor',
      'gold_coin',
    ],
  ),

  // Goblin Cave - Smaller cave area
  LocationConfig(
    id: 'goblin_cave',
    name: 'Goblin Cave',
    type: LocationType.cave,
    isSurface: false,
    maxDepth: 3,
    generatorType: 'dungeon', // Use dungeon generator for caves too
    ambientMusic: 'cave_ambience',
    monsterPool: [
      'goblin',
      'rat',
      'slime',
    ],
    itemPool: [
      'health_potion',
      'dagger',
      'gold_coin',
    ],
  ),

  // Dark Dungeon Surface - Outdoor area above the dungeon
  LocationConfig(
    id: 'dark_dungeon_surface',
    name: 'Dark Forest',
    type: LocationType.surface,
    isSurface: true,
    maxDepth: 1,
    generatorType: 'surface',
    ambientMusic: 'forest_ambience',
    monsterPool: [], // Safe surface area
    itemPool: [],
  ),

  // Goblin Cave Surface - Outdoor area above the cave
  LocationConfig(
    id: 'goblin_cave_surface',
    name: 'Rocky Outcrops',
    type: LocationType.surface,
    isSurface: true,
    maxDepth: 1,
    generatorType: 'surface',
    ambientMusic: 'wilderness_ambience',
    monsterPool: [], // Safe surface area
    itemPool: [],
  ),
];
