import '../../../models/entities/entity.dart';
import '../../../models/world/tile.dart';
import '../generation_context.dart';
import '../generation_step.dart';

/// Pipeline step that places stairs up and down in the dungeon.
///
/// This step places:
/// - Stairs up in the first room (player spawn area / entrance)
/// - Stairs down in the last room (furthest from start / exit to next level)
/// - Sets the player spawn position near the stairs up
///
/// **Prerequisites:**
/// - Rooms must be placed in [GenerationContext.rooms]
/// - Rooms should already be carved into floor tiles
///
/// **Output:**
/// - [GenerationContext.stairsUp] is set and tile changed to [TileType.stairsUp]
/// - [GenerationContext.stairsDown] is set and tile changed to [TileType.stairsDown]
/// - [GenerationContext.playerSpawn] is set near the stairs up
///
/// **Edge Cases:**
/// - If floor == 0, stairs up still serves as the exit to surface
/// - For the deepest floor, stairs down should be skipped (handled at higher level)
class StairsStep implements GenerationStep {
  /// Creates a new stairs step.
  const StairsStep();

  @override
  void execute(GenerationContext context) {
    // Early return if there are no rooms
    if (context.rooms.isEmpty) {
      return;
    }

    // Place stairs up in the first room (entrance/spawn area)
    final firstRoom = context.rooms.first;
    final stairsUpX = firstRoom.centerX;
    final stairsUpY = firstRoom.centerY;

    context.stairsUp = Position(x: stairsUpX, y: stairsUpY);
    context.setTile(stairsUpX, stairsUpY, TileType.stairsUp);

    // Set player spawn near the stairs up
    // Try to find an adjacent floor tile, or use the same position
    context.playerSpawn = _findSpawnNearStairs(context, stairsUpX, stairsUpY);

    // Place stairs down in the last room (exit to next level)
    // Only place if not on the deepest floor
    if (!context.isDeepestFloor) {
      if (context.rooms.length > 1) {
        final lastRoom = context.rooms.last;
        final stairsDownX = lastRoom.centerX;
        final stairsDownY = lastRoom.centerY;

        context.stairsDown = Position(x: stairsDownX, y: stairsDownY);
        context.setTile(stairsDownX, stairsDownY, TileType.stairsDown);
      } else {
        // Single room: place stairs down offset from stairs up
        final offset = _findOffsetPosition(context, firstRoom, stairsUpX, stairsUpY);
        if (offset != null) {
          context.stairsDown = offset;
          context.setTile(offset.x, offset.y, TileType.stairsDown);
        }
      }
    }
  }

  /// Finds a spawn position near the stairs.
  ///
  /// Attempts to find an adjacent floor tile. If none available,
  /// returns the stairs position itself.
  Position _findSpawnNearStairs(GenerationContext context, int stairsX, int stairsY) {
    // Cardinal directions to check for spawn point
    const offsets = [
      (1, 0), // right
      (-1, 0), // left
      (0, 1), // down
      (0, -1), // up
    ];

    for (final (dx, dy) in offsets) {
      final x = stairsX + dx;
      final y = stairsY + dy;

      if (context.isInBounds(x, y) && context.getTile(x, y) == TileType.floor) {
        return Position(x: x, y: y);
      }
    }

    // Fallback to stairs position if no adjacent floor found
    return Position(x: stairsX, y: stairsY);
  }

  /// Finds an offset position for stairs down when there's only one room.
  ///
  /// Returns a floor tile position that's not on the stairs up, or null if none found.
  Position? _findOffsetPosition(
    GenerationContext context,
    room,
    int stairsUpX,
    int stairsUpY,
  ) {
    // Search within the room for a floor tile that's not the stairs up position
    for (int y = room.y; y < room.bottom; y++) {
      for (int x = room.x; x < room.right; x++) {
        if (x == stairsUpX && y == stairsUpY) continue;
        if (context.getTile(x, y) == TileType.floor) {
          return Position(x: x, y: y);
        }
      }
    }
    return null;
  }
}
