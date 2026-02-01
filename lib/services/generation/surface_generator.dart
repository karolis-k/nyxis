import 'dart:math';

import '../../config/location_config.dart';
import '../../models/world/location.dart';
import '../../models/world/map.dart';
import '../../models/world/tile.dart';
import 'location_generator.dart';

/// Generator for outdoor/surface locations.
///
/// Creates open areas with no internal walls - just floor tiles.
/// Used for surface locations that connect to dungeons/caves via portals.
/// Walking to the edge of a surface location exits to the world map.
class SurfaceGenerator implements LocationGenerator {
  /// Width of the generated surface area.
  final int width;

  /// Height of the generated surface area.
  final int height;

  /// Creates a surface generator with the specified dimensions.
  SurfaceGenerator({
    this.width = 30,
    this.height = 25,
  });

  @override
  Location generate({
    required LocationConfig config,
    required int floor,
    required Random random,
  }) {
    // Create all floor tiles (no walls - surface is open)
    final tiles = List.generate(
      height,
      (y) => List.generate(
        width,
        (x) => const Tile(type: TileType.floor, explored: true),
      ),
    );

    final gameMap = GameMap(
      width: width,
      height: height,
      tiles: tiles,
    );

    return Location.create(
      configId: config.id,
      floor: floor,
      map: gameMap,
    );
  }
}
