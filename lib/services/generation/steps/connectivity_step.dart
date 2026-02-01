import 'dart:developer' as developer;

import '../../../models/world/tile.dart';
import '../generation_context.dart';
import '../generation_step.dart';

/// Pipeline step that validates all rooms are reachable using flood fill.
///
/// This step performs a flood fill from the first room's center to find
/// all reachable floor tiles, then verifies that every room's center
/// is reachable. This ensures the dungeon is fully connected.
///
/// **Prerequisites:**
/// - Rooms must be placed in [GenerationContext.rooms]
/// - Rooms and corridors should already be carved into floor tiles
///
/// **Output:**
/// - Logs a warning if any rooms are unreachable
/// - Future implementations may trigger regeneration at a higher level
class ConnectivityStep implements GenerationStep {
  /// Creates a new connectivity step.
  const ConnectivityStep();

  @override
  void execute(GenerationContext context) {
    // Early return if there are no rooms
    if (context.rooms.isEmpty) {
      return;
    }

    // Get the starting point from the first room's center
    final startRoom = context.rooms.first;
    final startX = startRoom.centerX;
    final startY = startRoom.centerY;

    // Perform flood fill to find all reachable floor tiles
    final reachable = _floodFill(context, startX, startY);

    // Check if each room's center is reachable
    final unreachableRooms = <int>[];
    for (int i = 0; i < context.rooms.length; i++) {
      final room = context.rooms[i];
      final centerX = room.centerX;
      final centerY = room.centerY;

      if (!reachable.contains((centerX, centerY))) {
        unreachableRooms.add(i);
      }
    }

    // Log warning if any rooms are unreachable
    if (unreachableRooms.isNotEmpty) {
      developer.log(
        'ConnectivityStep: ${unreachableRooms.length} room(s) are unreachable: $unreachableRooms',
        name: 'DungeonGeneration',
        level: 900, // Warning level
      );
      // TODO: Handle regeneration at higher level
      // For now, we just log the warning and continue
    }
  }

  /// Performs flood fill from the starting position.
  ///
  /// Returns a set of all reachable floor tile positions as (x, y) tuples.
  Set<(int, int)> _floodFill(GenerationContext context, int startX, int startY) {
    final reachable = <(int, int)>{};
    final queue = <(int, int)>[(startX, startY)];

    // Check if starting position is valid
    if (!context.isInBounds(startX, startY) ||
        !_isWalkable(context.getTile(startX, startY))) {
      return reachable;
    }

    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      final (x, y) = current;

      // Skip if already visited
      if (reachable.contains(current)) {
        continue;
      }

      // Skip if out of bounds or not walkable
      if (!context.isInBounds(x, y) || !_isWalkable(context.getTile(x, y))) {
        continue;
      }

      // Mark as reachable
      reachable.add(current);

      // Add cardinal neighbors to the queue
      queue.add((x - 1, y)); // left
      queue.add((x + 1, y)); // right
      queue.add((x, y - 1)); // up
      queue.add((x, y + 1)); // down
    }

    return reachable;
  }

  /// Checks if a tile type is walkable for connectivity purposes.
  bool _isWalkable(TileType type) {
    return type == TileType.floor ||
        type == TileType.door ||
        type == TileType.stairsUp ||
        type == TileType.stairsDown;
  }
}
