import 'package:freezed_annotation/freezed_annotation.dart';

import 'tile.dart';

part 'map.freezed.dart';
part 'map.g.dart';

/// Represents a 2D game map containing tiles
@freezed
class GameMap with _$GameMap {
  const GameMap._();

  const factory GameMap({
    /// Width of the map in tiles
    required int width,

    /// Height of the map in tiles
    required int height,

    /// 2D grid of tiles [y][x] - row-major order
    required List<List<Tile>> tiles,
  }) = _GameMap;

  factory GameMap.fromJson(Map<String, dynamic> json) =>
      _$GameMapFromJson(json);

  /// Creates an empty map filled with floor tiles
  factory GameMap.empty(int width, int height) {
    final tiles = List.generate(
      height,
      (_) => List.generate(width, (_) => Tile.floor()),
    );
    return GameMap(width: width, height: height, tiles: tiles);
  }

  /// Creates a map filled with wall tiles (for dungeon generation)
  factory GameMap.filled(int width, int height) {
    final tiles = List.generate(
      height,
      (_) => List.generate(width, (_) => Tile.wall()),
    );
    return GameMap(width: width, height: height, tiles: tiles);
  }

  /// Checks if the given coordinates are within map bounds
  bool isInBounds(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height;
  }

  /// Gets the tile at the given coordinates
  /// Returns null if out of bounds
  Tile? getTile(int x, int y) {
    if (!isInBounds(x, y)) return null;
    return tiles[y][x];
  }

  /// Checks if the tile at the given coordinates can be walked on
  /// Returns false if out of bounds
  bool isWalkable(int x, int y) {
    final tile = getTile(x, y);
    return tile?.isWalkable ?? false;
  }

  /// Checks if the tile at the given coordinates blocks vision
  /// Returns true if out of bounds (can't see outside the map)
  bool blocksVision(int x, int y) {
    final tile = getTile(x, y);
    return tile?.isBlockingVision ?? true;
  }

  /// Returns a new map with a tile replaced at the given position
  GameMap setTile(int x, int y, Tile tile) {
    if (!isInBounds(x, y)) return this;

    final newTiles = tiles.map((row) => List<Tile>.from(row)).toList();
    newTiles[y][x] = tile;

    return copyWith(tiles: newTiles);
  }

  /// Returns a new map with the tile at the given position marked as explored
  GameMap markExplored(int x, int y) {
    final tile = getTile(x, y);
    if (tile == null || tile.explored) return this;

    return setTile(x, y, tile.copyWith(explored: true));
  }

  /// Returns a new map with the tile at the given position's visibility set
  GameMap setVisible(int x, int y, bool visible) {
    final tile = getTile(x, y);
    if (tile == null) return this;

    return setTile(x, y, tile.copyWith(visible: visible));
  }

  /// Returns a new map with all tiles set to not visible
  GameMap clearVisibility() {
    final newTiles = tiles.map((row) {
      return row.map((tile) => tile.copyWith(visible: false)).toList();
    }).toList();

    return copyWith(tiles: newTiles);
  }

  /// Gets all coordinates of tiles matching the given type
  List<({int x, int y})> findTilesByType(TileType type) {
    final result = <({int x, int y})>[];
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (tiles[y][x].type == type) {
          result.add((x: x, y: y));
        }
      }
    }
    return result;
  }

  /// Gets all walkable tile coordinates
  List<({int x, int y})> get walkableTiles {
    final result = <({int x, int y})>[];
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (tiles[y][x].isWalkable) {
          result.add((x: x, y: y));
        }
      }
    }
    return result;
  }
}
