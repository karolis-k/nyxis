import 'dart:math';

import '../../config/portal_registry.dart';
import '../../models/entities/entity.dart';
import '../../models/entities/portal.dart';
import '../../models/entities/world_object.dart';
import '../../models/world/location.dart';
import '../../models/world/tile.dart';

/// Utility for placing portals in generated locations.
class PortalPlacement {
  PortalPlacement._();

  /// Find valid walkable positions for portal placement.
  ///
  /// Avoids stairs and already-used positions.
  static List<Position> findPositions(
    Location location,
    int count,
    Random rng,
  ) {
    final positions = <Position>[];
    final map = location.map;

    int attempts = 0;
    const maxAttempts = 200;

    while (positions.length < count && attempts < maxAttempts) {
      final x = rng.nextInt(map.width);
      final y = rng.nextInt(map.height);
      final tile = map.getTile(x, y);

      if (tile != null &&
          tile.isWalkable &&
          !_isTransitionTile(tile) &&
          !positions.any((p) => p.x == x && p.y == y)) {
        positions.add(Position(x: x, y: y));
      }
      attempts++;
    }

    return positions;
  }

  /// Checks if a tile is a transition tile (stairs).
  static bool _isTransitionTile(Tile tile) {
    return tile.type == TileType.stairsUp || tile.type == TileType.stairsDown;
  }

  /// Create portal WorldObjects for a location/floor.
  ///
  /// Returns list of portals that should be placed, along with their positions.
  static List<WorldObject> createPortals(
    Location location,
    String locationConfigId,
    int floor,
    Random rng,
  ) {
    final portalIds = PortalRegistry.getPortalIdsForLocation(locationConfigId, floor);
    if (portalIds.isEmpty) return [];

    final positions = findPositions(location, portalIds.length, rng);
    final portals = <WorldObject>[];

    for (int i = 0; i < positions.length && i < portalIds.length; i++) {
      portals.add(Portal.create(
        portalId: portalIds[i],
        position: positions[i],
      ));
    }

    return portals;
  }
}
