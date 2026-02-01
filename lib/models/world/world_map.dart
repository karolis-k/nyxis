import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/entity.dart';

part 'world_map.freezed.dart';
part 'world_map.g.dart';

/// Types of terrain on the world map.
@JsonEnum()
enum TerrainType {
  plains, // Open grassland, walkable
  forest, // Dense trees, walkable
  mountain, // Impassable mountain
  water, // Impassable water
  desert, // Sandy area, walkable
  road, // Easy travel path
}

/// Represents a single tile on the world map.
@freezed
class MapTile with _$MapTile {
  const MapTile._();

  const factory MapTile({
    required TerrainType terrain,

    /// Reference to LocationConfig.id
    String? locationId,
    @Default(false) bool discovered,
    @Default(false) bool visited,
  }) = _MapTile;

  factory MapTile.fromJson(Map<String, dynamic> json) =>
      _$MapTileFromJson(json);

  /// Whether this tile has a location the player can enter
  bool get hasLocation => locationId != null;
}

/// Represents the world map as a grid of terrain tiles.
@freezed
class WorldMap with _$WorldMap {
  const WorldMap._();

  const factory WorldMap({
    required int width,
    required int height,
    required List<List<MapTile>> tiles,
    @Default(Position(x: 5, y: 5)) Position playerPosition,
  }) = _WorldMap;

  factory WorldMap.fromJson(Map<String, dynamic> json) =>
      _$WorldMapFromJson(json);

  /// Gets a tile at the given coordinates
  MapTile? getTile(int x, int y) {
    if (!isInBounds(x, y)) return null;
    return tiles[y][x];
  }

  /// Checks if coordinates are in bounds
  bool isInBounds(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height;
  }

  /// Checks if a tile can be walked on
  bool isWalkable(int x, int y) {
    final tile = getTile(x, y);
    if (tile == null) return false;

    switch (tile.terrain) {
      case TerrainType.plains:
      case TerrainType.forest:
      case TerrainType.desert:
      case TerrainType.road:
        return true;
      case TerrainType.mountain:
      case TerrainType.water:
        return false;
    }
  }
}
