import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'entity.dart';

part 'monster.freezed.dart';
part 'monster.g.dart';

/// AI behavior states for monsters.
enum AIState {
  /// Monster is stationary or wandering randomly.
  idle,

  /// Monster is actively pursuing the player.
  chasing,

  /// Monster is in combat range and attacking.
  attacking,

  /// Monster is retreating due to low health.
  fleeing,
}

/// A monster entity with stats and AI behavior.
@freezed
class Monster with _$Monster, Entity {
  const Monster._();

  const factory Monster({
    /// Unique identifier for this monster instance.
    required String id,

    /// Reference to the monster type in MonsterRegistry.
    required String configId,

    /// Current position on the game map.
    required Position position,

    /// Current health points.
    required int health,

    /// Maximum health points.
    required int maxHealth,

    /// Current AI behavior state.
    @Default(AIState.idle) AIState aiState,

    /// Current energy for the energy-based turn system.
    @Default(0) int energy,
  }) = _Monster;

  factory Monster.fromJson(Map<String, dynamic> json) =>
      _$MonsterFromJson(json);

  /// Creates a new monster instance from a config.
  factory Monster.create({
    required String configId,
    required Position position,
    required int maxHealth,
  }) {
    return Monster(
      id: const Uuid().v4(),
      configId: configId,
      position: position,
      health: maxHealth,
      maxHealth: maxHealth,
      aiState: AIState.idle,
    );
  }
}

/// Extension methods for Monster combat and AI behavior.
extension MonsterExtensions on Monster {
  /// X coordinate shorthand.
  int get x => position.x;

  /// Y coordinate shorthand.
  int get y => position.y;

  /// Returns true if the monster is alive.
  bool get isAlive => health > 0;

  /// Returns true if the monster blocks movement (alive monsters block).
  bool get blocksMovement => isAlive;

  /// Returns the health percentage (0.0 to 1.0).
  double get healthPercent => maxHealth > 0 ? health / maxHealth : 0.0;

  /// Returns true if the monster is in a hostile state (chasing or attacking).
  bool get isHostile => aiState == AIState.chasing || aiState == AIState.attacking;

  /// Returns true if the monster is fleeing.
  bool get isFleeing => aiState == AIState.fleeing;

  /// Returns true if the monster health is low (below 25%).
  bool get isLowHealth => healthPercent < 0.25;

  /// Returns a new monster with damage applied.
  Monster takeDamage(int damage) {
    final newHealth = (health - damage).clamp(0, maxHealth);
    return copyWith(health: newHealth);
  }

  /// Returns a new monster with health restored.
  Monster heal(int amount) {
    return copyWith(health: (health + amount).clamp(0, maxHealth));
  }

  /// Returns a new monster with updated AI state.
  Monster withAIState(AIState newState) {
    return copyWith(aiState: newState);
  }

  /// Returns a new monster moved to the specified position.
  Monster moveTo(Position newPosition) {
    return copyWith(position: newPosition);
  }

  /// Returns the appropriate AI state based on distance to player and health.
  AIState calculateAIState({
    required Position playerPosition,
    int aggroRange = 8,
    int attackRange = 1,
    double fleeHealthThreshold = 0.2,
  }) {
    final distance = position.manhattanDistanceTo(playerPosition);

    // Flee if health is very low
    if (healthPercent <= fleeHealthThreshold) {
      return AIState.fleeing;
    }

    // Attack if in range
    if (distance <= attackRange) {
      return AIState.attacking;
    }

    // Chase if within aggro range
    if (distance <= aggroRange) {
      return AIState.chasing;
    }

    // Otherwise idle
    return AIState.idle;
  }
}
