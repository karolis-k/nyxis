import '../../../models/world/tile.dart';
import '../generation_context.dart';
import '../generation_step.dart';

/// Pipeline step that connects rooms with L-shaped corridors.
///
/// This step iterates through all corridors in the context and carves
/// paths between the connected rooms. For variety, it randomly alternates
/// between horizontal-first and vertical-first L-shaped paths.
///
/// **Prerequisites:**
/// - Corridors must already be defined in [GenerationContext.corridors]
/// - Rooms should already be carved (though corridors can be carved first)
///
/// **Output:**
/// - Corridor paths are set to [TileType.floor]
class CorridorStep implements GenerationStep {
  /// Creates a new corridor step.
  const CorridorStep();

  @override
  void execute(GenerationContext context) {
    for (final corridor in context.corridors) {
      // Randomly choose between horizontal-first or vertical-first path
      // for visual variety in the dungeon layout
      final useHorizontalFirst = context.random.nextBool();

      final path = useHorizontalFirst
          ? corridor.horizontalFirstPath
          : corridor.verticalFirstPath;

      // Carve the corridor by setting each tile in the path to floor
      for (final point in path) {
        context.setTile(point.x, point.y, TileType.floor);
      }
    }
  }
}
