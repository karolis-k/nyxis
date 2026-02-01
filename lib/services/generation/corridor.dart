/// Data class representing a corridor connecting two points.
///
/// Corridors are used to connect rooms in the dungeon. They can be
/// rendered as L-shaped paths (horizontal then vertical, or vice versa)
/// or as direct lines between points.
class Corridor {
  /// Starting X coordinate.
  final int startX;

  /// Starting Y coordinate.
  final int startY;

  /// Ending X coordinate.
  final int endX;

  /// Ending Y coordinate.
  final int endY;

  /// Creates a new corridor between two points.
  const Corridor({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
  });

  /// The horizontal distance of this corridor.
  int get deltaX => endX - startX;

  /// The vertical distance of this corridor.
  int get deltaY => endY - startY;

  /// The Manhattan distance (total tiles to traverse).
  int get length => deltaX.abs() + deltaY.abs();

  /// Whether this corridor is purely horizontal.
  bool get isHorizontal => startY == endY;

  /// Whether this corridor is purely vertical.
  bool get isVertical => startX == endX;

  /// Whether this corridor requires an L-shape (not a straight line).
  bool get isLShaped => !isHorizontal && !isVertical;

  /// Returns all points along a horizontal-first L-shaped path.
  ///
  /// Moves horizontally from start to end X, then vertically to end Y.
  Iterable<({int x, int y})> get horizontalFirstPath sync* {
    // Horizontal segment
    final xStep = startX <= endX ? 1 : -1;
    for (int x = startX; x != endX; x += xStep) {
      yield (x: x, y: startY);
    }

    // Vertical segment (including corner and end)
    final yStep = startY <= endY ? 1 : -1;
    for (int y = startY; y != endY + yStep; y += yStep) {
      yield (x: endX, y: y);
    }
  }

  /// Returns all points along a vertical-first L-shaped path.
  ///
  /// Moves vertically from start to end Y, then horizontally to end X.
  Iterable<({int x, int y})> get verticalFirstPath sync* {
    // Vertical segment
    final yStep = startY <= endY ? 1 : -1;
    for (int y = startY; y != endY; y += yStep) {
      yield (x: startX, y: y);
    }

    // Horizontal segment (including corner and end)
    final xStep = startX <= endX ? 1 : -1;
    for (int x = startX; x != endX + xStep; x += xStep) {
      yield (x: x, y: endY);
    }
  }

  @override
  String toString() => 'Corridor(($startX, $startY) -> ($endX, $endY))';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Corridor &&
          startX == other.startX &&
          startY == other.startY &&
          endX == other.endX &&
          endY == other.endY;

  @override
  int get hashCode => Object.hash(startX, startY, endX, endY);
}
