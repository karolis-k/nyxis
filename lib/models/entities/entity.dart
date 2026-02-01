import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity.freezed.dart';
part 'entity.g.dart';

/// Represents a position on the game grid.
@freezed
class Position with _$Position {
  const factory Position({
    required int x,
    required int y,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  /// Creates a position at the origin (0, 0).
  factory Position.zero() => const Position(x: 0, y: 0);
}

/// Extension methods for Position calculations.
extension PositionExtensions on Position {
  /// Returns the Manhattan distance to another position.
  int manhattanDistanceTo(Position other) {
    return (x - other.x).abs() + (y - other.y).abs();
  }

  /// Returns the Chebyshev distance (max of x/y distance) to another position.
  int chebyshevDistanceTo(Position other) {
    return ((x - other.x).abs()).clamp(0, double.infinity).toInt() >
            ((y - other.y).abs()).clamp(0, double.infinity).toInt()
        ? (x - other.x).abs()
        : (y - other.y).abs();
  }

  /// Returns a new position offset by the given amounts.
  Position offset(int dx, int dy) {
    return Position(x: x + dx, y: y + dy);
  }

  /// Returns adjacent positions (4-directional: up, down, left, right).
  List<Position> get cardinalNeighbors => [
        offset(0, -1), // up
        offset(0, 1), // down
        offset(-1, 0), // left
        offset(1, 0), // right
      ];

  /// Returns all adjacent positions (8-directional).
  List<Position> get allNeighbors => [
        offset(0, -1), // up
        offset(0, 1), // down
        offset(-1, 0), // left
        offset(1, 0), // right
        offset(-1, -1), // up-left
        offset(1, -1), // up-right
        offset(-1, 1), // down-left
        offset(1, 1), // down-right
      ];
}

/// Base mixin for all game entities that have an ID and position.
mixin Entity {
  /// Unique identifier for this entity instance.
  String get id;

  /// Current position on the game map.
  Position get position;
}
