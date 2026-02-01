import 'generation_context.dart';
import 'room.dart';

/// Abstract interface for room layout strategies.
///
/// Layout behaviors define how rooms are placed and connected within a dungeon.
/// Different implementations can provide various dungeon styles:
/// - Grid-based layouts with regular room spacing
/// - Organic layouts with irregular room placement
/// - Linear layouts for corridor-style dungeons
/// - Hub layouts with central rooms and radiating passages
abstract class LayoutBehavior {
  /// Generate room definitions (position, size).
  ///
  /// Creates a list of [Room] objects defining where rooms should be placed
  /// in the dungeon. The rooms should fit within the bounds defined in the
  /// [context] and follow any constraints specified by the layout strategy.
  ///
  /// Returns a list of rooms with their positions and dimensions set.
  List<Room> generateRooms(GenerationContext context);

  /// Define how rooms should be connected.
  ///
  /// Takes the list of generated [rooms] and determines which pairs should
  /// be connected by corridors. The returned pairs are indices into the
  /// rooms list.
  ///
  /// The connection strategy can vary by implementation:
  /// - Minimum spanning tree for efficient connectivity
  /// - Delaunay triangulation for more organic connections
  /// - Sequential connections for linear dungeons
  ///
  /// Returns pairs of room indices that should be connected.
  List<(int, int)> defineConnections(List<Room> rooms, GenerationContext context);
}
