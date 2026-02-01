/// Game-wide constants and configuration values.
library;

/// Tile and rendering constants.
abstract class TileConstants {
  /// Size of a tile in pixels.
  static const double tileSize = 32.0;

  /// Default map width in tiles.
  static const int defaultMapWidth = 50;

  /// Default map height in tiles.
  static const int defaultMapHeight = 50;
}

/// Player balance constants.
abstract class PlayerConstants {
  /// Starting health for a new player.
  static const int startingHealth = 100;

  /// Starting attack power.
  static const int startingAttack = 10;

  /// Starting defense value.
  static const int startingDefense = 5;

  /// Maximum inventory slots.
  static const int maxInventorySize = 20;
}

/// Combat balance constants.
abstract class CombatConstants {
  /// Minimum damage dealt (even with high defense).
  static const int minimumDamage = 1;

  /// Critical hit damage multiplier.
  static const double criticalMultiplier = 2.0;

  /// Base critical hit chance (0.0 - 1.0).
  static const double baseCritChance = 0.05;
}

/// AI behavior constants.
abstract class AIConstants {
  /// Default aggro range for monsters.
  static const int defaultAggroRange = 6;

  /// Health percentage below which monsters may flee.
  static const double fleeHealthThreshold = 0.2;

  /// Maximum pathfinding distance.
  static const int maxPathfindingDistance = 20;
}

/// Game timing constants.
abstract class GameConstants {
  /// Target frames per second.
  static const int targetFps = 60;

  /// Animation speed multiplier.
  static const double animationSpeed = 1.0;
}
