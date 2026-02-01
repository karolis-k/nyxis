/// Data class representing a room in the dungeon.
///
/// Rooms are rectangular areas defined by their top-left corner position
/// and dimensions. They provide computed properties for calculating
/// center points, bounds checking, and overlap detection.
class Room {
  /// X coordinate of the top-left corner.
  final int x;

  /// Y coordinate of the top-left corner.
  final int y;

  /// Width of the room in tiles.
  final int width;

  /// Height of the room in tiles.
  final int height;

  /// Creates a new room with the given position and dimensions.
  const Room({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  /// The X coordinate of the room's center point.
  int get centerX => x + width ~/ 2;

  /// The Y coordinate of the room's center point.
  int get centerY => y + height ~/ 2;

  /// The right edge X coordinate (exclusive).
  int get right => x + width;

  /// The bottom edge Y coordinate (exclusive).
  int get bottom => y + height;

  /// The area of the room in tiles.
  int get area => width * height;

  /// Checks if a point is within this room's bounds.
  bool contains(int px, int py) {
    return px >= x && px < right && py >= y && py < bottom;
  }

  /// Checks if this room overlaps with another room.
  ///
  /// Optionally specify [padding] to require a minimum gap between rooms.
  bool overlaps(Room other, {int padding = 0}) {
    return x - padding < other.right + padding &&
        right + padding > other.x - padding &&
        y - padding < other.bottom + padding &&
        bottom + padding > other.y - padding;
  }

  /// Checks if this room is completely within the given bounds.
  bool isWithinBounds(int mapWidth, int mapHeight, {int margin = 0}) {
    return x >= margin &&
        y >= margin &&
        right <= mapWidth - margin &&
        bottom <= mapHeight - margin;
  }

  @override
  String toString() => 'Room($x, $y, ${width}x$height)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Room &&
          x == other.x &&
          y == other.y &&
          width == other.width &&
          height == other.height;

  @override
  int get hashCode => Object.hash(x, y, width, height);
}
