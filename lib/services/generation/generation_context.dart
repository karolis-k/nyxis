import 'dart:math';

import '../../models/entities/entity.dart';
import '../../models/world/tile.dart';
import 'corridor.dart';
import 'room.dart';

/// Mutable context that dungeon generation pipeline steps modify.
///
/// This class holds all the state needed during dungeon generation,
/// including the tile grid, rooms, corridors, and spawn points.
/// Pipeline steps receive this context and modify it in sequence.
class GenerationContext {
  /// Width of the dungeon in tiles.
  final int width;

  /// Height of the dungeon in tiles.
  final int height;

  /// Random number generator for this generation.
  final Random random;

  /// Configuration ID used for this generation (e.g., 'standard', 'cave').
  final String configId;

  /// Current floor number being generated.
  final int floor;

  /// Maximum depth of the dungeon (from LocationConfig).
  final int maxDepth;

  /// 2D grid of tile types. Initialized with walls.
  late List<List<TileType>> tiles;

  /// List of rooms placed in the dungeon.
  List<Room> rooms = [];

  /// List of corridors connecting rooms.
  List<Corridor> corridors = [];

  /// Player spawn position (typically in the first room or at stairs up).
  Position? playerSpawn;

  /// Position of stairs leading up (to previous floor).
  Position? stairsUp;

  /// Position of stairs leading down (to next floor).
  Position? stairsDown;

  /// Positions where monsters should spawn.
  List<Position> monsterSpawns = [];

  /// Positions where items should spawn.
  List<Position> itemSpawns = [];

  /// Creates a new generation context with the given parameters.
  ///
  /// The tile grid is automatically initialized with walls.
  GenerationContext({
    required this.width,
    required this.height,
    required this.random,
    required this.configId,
    required this.floor,
    required this.maxDepth,
  }) {
    // Initialize tile grid with walls
    tiles = List.generate(
      height,
      (_) => List.filled(width, TileType.wall),
    );
  }

  /// Returns true if this is the deepest floor of the dungeon.
  bool get isDeepestFloor => floor >= maxDepth;

  /// Sets a tile at the given coordinates.
  ///
  /// Does nothing if coordinates are out of bounds.
  void setTile(int x, int y, TileType type) {
    if (isInBounds(x, y)) {
      tiles[y][x] = type;
    }
  }

  /// Gets the tile type at the given coordinates.
  ///
  /// Returns [TileType.wall] if coordinates are out of bounds.
  TileType getTile(int x, int y) {
    if (isInBounds(x, y)) {
      return tiles[y][x];
    }
    return TileType.wall;
  }

  /// Checks if the given coordinates are within the dungeon bounds.
  bool isInBounds(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height;
  }

  /// Checks if the given coordinates are within the dungeon bounds
  /// with an optional margin from the edges.
  bool isInBoundsWithMargin(int x, int y, {int margin = 1}) {
    return x >= margin &&
        x < width - margin &&
        y >= margin &&
        y < height - margin;
  }

  /// Returns all floor tiles as positions.
  Iterable<Position> get floorPositions sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (tiles[y][x] == TileType.floor) {
          yield Position(x: x, y: y);
        }
      }
    }
  }

  /// Counts the total number of floor tiles.
  int get floorTileCount {
    int count = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (tiles[y][x] == TileType.floor) {
          count++;
        }
      }
    }
    return count;
  }

  /// Fills a rectangular area with the given tile type.
  void fillRect(int x, int y, int rectWidth, int rectHeight, TileType type) {
    for (int dy = 0; dy < rectHeight; dy++) {
      for (int dx = 0; dx < rectWidth; dx++) {
        setTile(x + dx, y + dy, type);
      }
    }
  }

  /// Carves out a room by setting its interior to floor tiles.
  void carveRoom(Room room) {
    fillRect(room.x, room.y, room.width, room.height, TileType.floor);
  }
}
