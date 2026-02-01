import '../generation_context.dart';
import '../generation_step.dart';

/// Pipeline step that carves out room floors from the wall-filled grid.
///
/// This step iterates through all rooms in the context and converts
/// their interior tiles from walls to floors using [GenerationContext.carveRoom].
///
/// **Prerequisites:**
/// - Rooms must already be placed in [GenerationContext.rooms]
/// - The tile grid should be initialized with walls
///
/// **Output:**
/// - All room interiors are set to [TileType.floor]
class RoomCreationStep implements GenerationStep {
  /// Creates a new room creation step.
  const RoomCreationStep();

  @override
  void execute(GenerationContext context) {
    // Carve out each room by setting its interior tiles to floor
    for (final room in context.rooms) {
      context.carveRoom(room);
    }
  }
}
