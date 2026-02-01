import 'generation_context.dart';
import 'layout_behavior.dart';
import 'room.dart';

/// Standard room placement strategy for dungeon generation.
///
/// This layout behavior uses a random placement algorithm that attempts
/// to place rooms without overlap, then connects them using a minimum
/// spanning tree approach with optional extra connections for loops.
///
/// The algorithm:
/// 1. Randomly places rooms of varying sizes within the map bounds
/// 2. Ensures rooms don't overlap (with configurable padding)
/// 3. Connects all rooms using a greedy MST approach
/// 4. Optionally adds extra connections to create loops
///
/// Example usage:
/// ```dart
/// final layout = DefaultLayoutBehavior(
///   minRoomSize: 5,
///   maxRoomSize: 12,
///   minRooms: 6,
///   maxRooms: 12,
/// );
/// final rooms = layout.generateRooms(context);
/// final connections = layout.defineConnections(rooms, context);
/// ```
class DefaultLayoutBehavior implements LayoutBehavior {
  /// Minimum room width/height in tiles.
  final int minRoomSize;

  /// Maximum room width/height in tiles.
  final int maxRoomSize;

  /// Minimum number of rooms to generate.
  final int minRooms;

  /// Maximum number of rooms to generate.
  final int maxRooms;

  /// Padding between rooms in tiles.
  ///
  /// This ensures rooms have at least this many tiles of wall between them,
  /// which helps with corridor placement and visual separation.
  final int roomPadding;

  /// Maximum attempts per room before giving up.
  ///
  /// Higher values increase the chance of placing all desired rooms
  /// but may slow down generation for crowded maps.
  final int maxAttemptsPerRoom;

  /// Number of extra connections to add beyond the MST.
  ///
  /// Extra connections create loops in the dungeon, giving players
  /// multiple paths and more interesting exploration.
  final int extraConnections;

  /// Creates a default layout behavior with configurable room parameters.
  ///
  /// All parameters have sensible defaults for typical dungeon generation:
  /// - [minRoomSize]: Minimum room dimension (default: 4)
  /// - [maxRoomSize]: Maximum room dimension (default: 10)
  /// - [minRooms]: Minimum rooms to place (default: 5)
  /// - [maxRooms]: Maximum rooms to place (default: 10)
  /// - [roomPadding]: Gap between rooms (default: 1)
  /// - [maxAttemptsPerRoom]: Placement attempts (default: 100)
  /// - [extraConnections]: Additional connections for loops (default: 2)
  const DefaultLayoutBehavior({
    this.minRoomSize = 4,
    this.maxRoomSize = 10,
    this.minRooms = 5,
    this.maxRooms = 10,
    this.roomPadding = 1,
    this.maxAttemptsPerRoom = 100,
    this.extraConnections = 2,
  });

  @override
  List<Room> generateRooms(GenerationContext context) {
    final rooms = <Room>[];
    final random = context.random;

    // Determine target room count
    final targetRoomCount = minRooms + random.nextInt(maxRooms - minRooms + 1);

    // Margin from map edges (at least 1 tile)
    const edgeMargin = 1;

    for (int roomIndex = 0; roomIndex < targetRoomCount; roomIndex++) {
      Room? placedRoom;

      // Try multiple times to place each room
      for (int attempt = 0; attempt < maxAttemptsPerRoom; attempt++) {
        // Generate random room dimensions
        final width = minRoomSize + random.nextInt(maxRoomSize - minRoomSize + 1);
        final height = minRoomSize + random.nextInt(maxRoomSize - minRoomSize + 1);

        // Calculate valid position range (accounting for edge margin)
        final maxX = context.width - width - edgeMargin;
        final maxY = context.height - height - edgeMargin;

        // Skip if room can't fit in the map
        if (maxX < edgeMargin || maxY < edgeMargin) {
          continue;
        }

        // Generate random position
        final x = edgeMargin + random.nextInt(maxX - edgeMargin + 1);
        final y = edgeMargin + random.nextInt(maxY - edgeMargin + 1);

        final candidateRoom = Room(x: x, y: y, width: width, height: height);

        // Check if room overlaps with any existing room (including padding)
        bool hasOverlap = false;
        for (final existingRoom in rooms) {
          if (candidateRoom.overlaps(existingRoom, padding: roomPadding)) {
            hasOverlap = true;
            break;
          }
        }

        // If no overlap, place the room
        if (!hasOverlap) {
          placedRoom = candidateRoom;
          break;
        }
      }

      // Add successfully placed room
      if (placedRoom != null) {
        rooms.add(placedRoom);
      }
    }

    return rooms;
  }

  @override
  List<(int, int)> defineConnections(List<Room> rooms, GenerationContext context) {
    if (rooms.length < 2) {
      return [];
    }

    final connections = <(int, int)>[];
    final random = context.random;

    // Track which rooms are connected using indices
    final connected = <int>{0}; // Start with first room
    final unconnected = <int>{for (int i = 1; i < rooms.length; i++) i};

    // Build minimum spanning tree using greedy approach
    while (unconnected.isNotEmpty) {
      int? bestConnectedRoom;
      int? bestUnconnectedRoom;
      int bestDistance = double.maxFinite.toInt();

      // Find closest unconnected room to any connected room
      for (final connectedIndex in connected) {
        for (final unconnectedIndex in unconnected) {
          final distance = _manhattanDistance(
            rooms[connectedIndex],
            rooms[unconnectedIndex],
          );

          if (distance < bestDistance) {
            bestDistance = distance;
            bestConnectedRoom = connectedIndex;
            bestUnconnectedRoom = unconnectedIndex;
          }
        }
      }

      // Add the connection
      if (bestConnectedRoom != null && bestUnconnectedRoom != null) {
        // Always store with smaller index first for consistency
        final connection = bestConnectedRoom < bestUnconnectedRoom
            ? (bestConnectedRoom, bestUnconnectedRoom)
            : (bestUnconnectedRoom, bestConnectedRoom);
        connections.add(connection);

        // Mark room as connected
        connected.add(bestUnconnectedRoom);
        unconnected.remove(bestUnconnectedRoom);
      }
    }

    // Add extra random connections to create loops
    if (rooms.length > 2 && extraConnections > 0) {
      final existingConnections = connections.toSet();
      int addedExtras = 0;
      int attempts = 0;
      final maxExtraAttempts = extraConnections * 10;

      while (addedExtras < extraConnections && attempts < maxExtraAttempts) {
        attempts++;

        // Pick two random different rooms
        final roomA = random.nextInt(rooms.length);
        final roomB = random.nextInt(rooms.length);

        if (roomA == roomB) {
          continue;
        }

        // Normalize the connection (smaller index first)
        final connection = roomA < roomB ? (roomA, roomB) : (roomB, roomA);

        // Add if not already connected
        if (!existingConnections.contains(connection)) {
          connections.add(connection);
          existingConnections.add(connection);
          addedExtras++;
        }
      }
    }

    return connections;
  }

  /// Calculates Manhattan distance between room centers.
  ///
  /// Manhattan distance is used because corridors typically follow
  /// an L-shaped path rather than a diagonal line.
  int _manhattanDistance(Room a, Room b) {
    return (a.centerX - b.centerX).abs() + (a.centerY - b.centerY).abs();
  }
}
