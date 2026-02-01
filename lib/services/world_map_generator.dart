import '../models/world/world_map.dart';
import '../models/entities/entity.dart'; // for Position

/// Generates the game's world map.
class WorldMapGenerator {
  WorldMapGenerator._();

  /// Generates the static world map.
  /// This is a hand-crafted map for the MVP.
  static WorldMap generate() {
    const width = 10;
    const height = 10;

    // Create a 2D grid of tiles
    final tiles = List.generate(height, (y) {
      return List.generate(width, (x) {
        return _getTileAt(x, y);
      });
    });

    return WorldMap(
      width: width,
      height: height,
      tiles: tiles,
      playerPosition: const Position(x: 5, y: 4), // Start near village
    );
  }

  static MapTile _getTileAt(int x, int y) {
    // Water on west edge
    if (x == 0) {
      return const MapTile(terrain: TerrainType.water);
    }

    // Water on south edge
    if (y == 10 - 1) {
      return const MapTile(terrain: TerrainType.water);
    }

    // Mountains on north edge
    if (y == 0 && x > 1) {
      return const MapTile(terrain: TerrainType.mountain);
    }

    // Village at center (5, 4)
    if (x == 5 && y == 4) {
      return const MapTile(
        terrain: TerrainType.road,
        locationId: 'starting_village',
        discovered: true,
      );
    }

    // Dark Dungeon south of village (5, 7)
    if (x == 5 && y == 7) {
      return const MapTile(
        terrain: TerrainType.plains,
        locationId: 'dark_dungeon',
        discovered: true,
      );
    }

    // Goblin Cave to the east (8, 5)
    if (x == 8 && y == 5) {
      return const MapTile(
        terrain: TerrainType.forest,
        locationId: 'goblin_cave',
        discovered: true,
      );
    }

    // Forests scattered around
    if ((x == 3 && y == 3) || (x == 7 && y == 3) || (x == 2 && y == 6) || (x == 7 && y == 6)) {
      return const MapTile(terrain: TerrainType.forest);
    }

    // Desert in southeast
    if (x >= 7 && y >= 7 && y < 9) {
      return const MapTile(terrain: TerrainType.desert);
    }

    // Road from village to dungeon
    if (x == 5 && y >= 4 && y <= 7) {
      return const MapTile(terrain: TerrainType.road);
    }

    // Default to plains
    return const MapTile(terrain: TerrainType.plains);
  }
}
