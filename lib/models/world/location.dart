import 'package:freezed_annotation/freezed_annotation.dart';

import 'map.dart';

part 'location.freezed.dart';
part 'location.g.dart';

/// Represents a location in the game world (e.g., a dungeon floor, town, etc.)
@freezed
class Location with _$Location {
  const Location._();

  const factory Location({
    /// Unique identifier for this location instance
    /// Format: "{configId}_{floor}" e.g., "dungeon_1_2"
    required String id,

    /// Reference to the LocationRegistry config
    /// Defines the type and generation rules for this location
    required String configId,

    /// Current floor number (0-indexed)
    /// 0 is the top/entrance floor, higher numbers are deeper
    required int floor,

    /// The game map for this location
    required GameMap map,

    /// IDs of monsters currently in this location
    @Default([]) List<String> monsterIds,

    /// IDs of items on the ground in this location
    @Default([]) List<String> itemIds,

    /// IDs of world objects in this location (portals, chests, etc.)
    @Default([]) List<String> worldObjectIds,

    /// Whether the player has visited this location before
    @Default(false) bool visited,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Creates a unique location ID from config ID and floor number
  static String generateId(String configId, int floor) => '${configId}_$floor';

  /// Creates a new location with the generated ID
  factory Location.create({
    required String configId,
    required int floor,
    required GameMap map,
    List<String> monsterIds = const [],
    List<String> itemIds = const [],
    bool visited = false,
  }) {
    return Location(
      id: generateId(configId, floor),
      configId: configId,
      floor: floor,
      map: map,
      monsterIds: monsterIds,
      itemIds: itemIds,
      visited: visited,
    );
  }

  /// Returns a new location with a monster added
  Location addMonster(String monsterId) {
    return copyWith(monsterIds: [...monsterIds, monsterId]);
  }

  /// Returns a new location with a monster removed
  Location removeMonster(String monsterId) {
    return copyWith(
      monsterIds: monsterIds.where((id) => id != monsterId).toList(),
    );
  }

  /// Returns a new location with an item added
  Location addItem(String itemId) {
    return copyWith(itemIds: [...itemIds, itemId]);
  }

  /// Returns a new location with an item removed
  Location removeItem(String itemId) {
    return copyWith(
      itemIds: itemIds.where((id) => id != itemId).toList(),
    );
  }

  /// Returns a new location with a world object added
  Location addWorldObject(String worldObjectId) {
    return copyWith(worldObjectIds: [...worldObjectIds, worldObjectId]);
  }

  /// Returns a new location with a world object removed
  Location removeWorldObject(String worldObjectId) {
    return copyWith(
      worldObjectIds: worldObjectIds.where((id) => id != worldObjectId).toList(),
    );
  }

  /// Checks if this location has any world objects
  bool get hasWorldObjects => worldObjectIds.isNotEmpty;

  /// Gets the number of world objects in this location
  int get worldObjectCount => worldObjectIds.length;

  /// Returns a new location marked as visited
  Location markVisited() => copyWith(visited: true);

  /// Checks if this location has any monsters
  bool get hasMonsters => monsterIds.isNotEmpty;

  /// Checks if this location has any items on the ground
  bool get hasItems => itemIds.isNotEmpty;

  /// Gets the number of monsters in this location
  int get monsterCount => monsterIds.length;

  /// Gets the number of items on the ground in this location
  int get itemCount => itemIds.length;

  /// Checks if the tile at the given coordinates is walkable
  bool isTileWalkable(int x, int y) => map.isWalkable(x, y);
}
