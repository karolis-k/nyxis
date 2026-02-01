import 'dart:math';

import '../../config/location_config.dart';
import '../../models/world/location.dart';

/// Abstract interface for location generators.
///
/// Location generators are responsible for creating complete, playable
/// dungeon floors. They orchestrate the entire generation process,
/// combining layout behaviors, generation steps, and other components
/// to produce a fully populated [Location].
///
/// Different implementations can create various location types:
/// - Standard dungeon floors with rooms and corridors
/// - Cave systems with organic layouts
/// - Maze-like structures
/// - Boss arenas with special layouts
abstract class LocationGenerator {
  /// Generate a complete location for the given config and floor.
  ///
  /// Creates a fully populated [Location] based on the provided parameters:
  /// - [config]: The configuration defining the location's properties,
  ///   including size constraints, monster types, and difficulty scaling.
  /// - [floor]: The floor number within the dungeon, which may affect
  ///   difficulty, layout complexity, and content distribution.
  /// - [random]: A random number generator for reproducible generation.
  ///   Using a seeded random allows for deterministic dungeon creation.
  ///
  /// Returns a complete [Location] ready for gameplay.
  Location generate({
    required LocationConfig config,
    required int floor,
    required Random random,
  });
}
