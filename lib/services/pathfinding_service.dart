import 'dart:math';

import 'package:a_star_algorithm/a_star_algorithm.dart';

import '../models/entities/entity.dart';
import '../models/world/map.dart';

/// Service for pathfinding operations using the A* algorithm.
///
/// Provides methods to find paths between positions, check reachability,
/// and calculate distances on a game map.
class PathfindingService {
  /// Cache of barriers for the last processed map to avoid recalculation.
  /// Key is the map's hashCode, value is the list of barrier positions.
  final Map<int, List<Point<int>>> _barrierCache = {};

  /// Finds a path from [start] to [end] on the given [map], avoiding non-walkable tiles.
  ///
  /// Returns a list of [Position]s representing the path from start to end (inclusive),
  /// or `null` if no path exists.
  ///
  /// Edge cases handled:
  /// - Returns `null` if start or end is out of bounds
  /// - Returns `[start]` if start equals end
  /// - Returns `null` if start or end is not walkable
  List<Position>? findPath(Position start, Position end, GameMap map) {
    // Handle edge case: start equals end
    if (start.x == end.x && start.y == end.y) {
      return [start];
    }

    // Validate bounds
    if (!map.isInBounds(start.x, start.y) || !map.isInBounds(end.x, end.y)) {
      return null;
    }

    // Validate start and end are walkable
    if (!map.isWalkable(start.x, start.y) || !map.isWalkable(end.x, end.y)) {
      return null;
    }

    // Get barriers from cache or compute them
    final barriers = _getBarriers(map);

    // Convert Position (x, y) to A* format Point(x: col, y: row) = Point(x, y)
    // Note: A* Point uses x for column, y for row
    final startPoint = Point<int>(start.x, start.y);
    final endPoint = Point<int>(end.x, end.y);

    try {
      final aStar = AStar(
        rows: map.height,
        columns: map.width,
        start: startPoint,
        end: endPoint,
        barriers: barriers,
      );

      final result = aStar.findThePath();

      if (result.isEmpty) {
        return null;
      }

      // Convert A* result Point back to Position
      // Point.x is column, Point.y is row
      final path = result.map((point) {
        return Position(x: point.x, y: point.y);
      }).toList();

      return path;
    } catch (e) {
      // If pathfinding fails for any reason, return null
      return null;
    }
  }

  /// Returns `true` if [end] is reachable from [start] on the given [map].
  ///
  /// This is a convenience method that checks if a path exists without
  /// returning the full path.
  bool isReachable(Position start, Position end, GameMap map) {
    final path = findPath(start, end, map);
    return path != null;
  }

  /// Returns the Manhattan distance between two positions.
  ///
  /// The Manhattan distance is the sum of the absolute differences
  /// of their x and y coordinates: |a.x - b.x| + |a.y - b.y|
  int distance(Position a, Position b) {
    return (a.x - b.x).abs() + (a.y - b.y).abs();
  }

  /// Computes and returns the list of barrier positions for the given map.
  ///
  /// Uses caching to avoid recomputing barriers for the same map.
  List<Point<int>> _getBarriers(GameMap map) {
    final cacheKey = map.hashCode;

    // Return cached barriers if available
    if (_barrierCache.containsKey(cacheKey)) {
      return _barrierCache[cacheKey]!;
    }

    // Compute barriers: all tiles where walkable is false
    final barriers = <Point<int>>[];

    for (var y = 0; y < map.height; y++) {
      for (var x = 0; x < map.width; x++) {
        final tile = map.tiles[y][x];
        if (!tile.isWalkable) {
          // A* Point uses x for column, y for row
          barriers.add(Point<int>(x, y));
        }
      }
    }

    // Cache the barriers (limit cache size to prevent memory issues)
    if (_barrierCache.length >= 10) {
      _barrierCache.remove(_barrierCache.keys.first);
    }
    _barrierCache[cacheKey] = barriers;

    return barriers;
  }

  /// Clears the barrier cache.
  ///
  /// Call this when the map changes significantly to ensure fresh barrier data.
  void clearCache() {
    _barrierCache.clear();
  }

  /// Finds all positions reachable from [start] within [maxDistance] steps.
  ///
  /// Returns a map of positions to their distance from the start.
  /// Useful for movement range visualization or area-of-effect calculations.
  Map<Position, int> findReachablePositions(
    Position start,
    GameMap map, {
    int maxDistance = 10,
  }) {
    final reachable = <Position, int>{};
    final visited = <String>{};
    final queue = <_QueueEntry>[_QueueEntry(start, 0)];

    while (queue.isNotEmpty) {
      final entry = queue.removeAt(0);
      final current = entry.position;
      final dist = entry.distance;
      final key = '${current.x},${current.y}';

      if (visited.contains(key)) continue;
      if (dist > maxDistance) continue;
      if (!map.isInBounds(current.x, current.y)) continue;
      if (!map.isWalkable(current.x, current.y) && current != start) continue;

      visited.add(key);
      reachable[current] = dist;

      // Add cardinal neighbors (4-directional movement)
      for (final neighbor in current.cardinalNeighbors) {
        final neighborKey = '${neighbor.x},${neighbor.y}';
        if (!visited.contains(neighborKey)) {
          queue.add(_QueueEntry(neighbor, dist + 1));
        }
      }
    }

    return reachable;
  }

  /// Finds the next step position to move from [current] towards [target].
  ///
  /// Returns the next position to move to, or `null` if no path exists.
  /// Useful for AI movement where you only need the next step.
  Position? getNextStep(Position current, Position target, GameMap map) {
    final path = findPath(current, target, map);

    if (path == null || path.length < 2) {
      return null;
    }

    // Return the second position in the path (first is the current position)
    return path[1];
  }
}

/// Helper class for BFS queue entries.
class _QueueEntry {
  final Position position;
  final int distance;

  _QueueEntry(this.position, this.distance);
}
