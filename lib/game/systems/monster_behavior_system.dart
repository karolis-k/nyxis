import 'dart:math';

import '../../config/monster_config.dart';
import '../../models/entities/entity.dart';
import '../../models/entities/monster.dart';
import '../../models/game_state.dart';
import '../../services/pathfinding_service.dart';

/// Actions a monster can take
sealed class MonsterAction {}

/// Monster moves to a target position.
class MoveAction extends MonsterAction {
  final Position target;
  MoveAction(this.target);

  @override
  String toString() => 'MoveAction(target: $target)';
}

/// Monster attacks a target entity.
class AttackAction extends MonsterAction {
  final String targetId; // Usually the player
  AttackAction(this.targetId);

  @override
  String toString() => 'AttackAction(targetId: $targetId)';
}

/// Monster does nothing this turn.
class IdleAction extends MonsterAction {
  @override
  String toString() => 'IdleAction()';
}

/// Monster flees toward a position (away from threat).
class FleeAction extends MonsterAction {
  final Position target; // Position to flee toward
  FleeAction(this.target);

  @override
  String toString() => 'FleeAction(target: $target)';
}

/// System responsible for deciding monster actions based on AI behavior.
///
/// Uses the monster's configured behavior pattern and current state to
/// determine what action the monster should take each turn.
class MonsterBehaviorSystem {
  final PathfindingService _pathfinding;
  final Random _random;

  /// Creates a new MonsterBehaviorSystem.
  ///
  /// [pathfinding] is used for movement calculations.
  /// [random] is optional and used for random movement (defaults to Random()).
  MonsterBehaviorSystem(this._pathfinding, [Random? random])
      : _random = random ?? Random();

  /// Decide what action a monster should take based on its behavior and state.
  ///
  /// Examines the monster's AI behavior type (passive, aggressive, territorial,
  /// cowardly) and current conditions to determine the appropriate action.
  MonsterAction decideAction(Monster monster, GameState state) {
    // Get monster configuration
    final config = MonsterRegistry.tryGet(monster.configId);
    if (config == null) {
      // No config found, default to idle
      return IdleAction();
    }

    final playerPosition = state.player.position;
    final distanceToPlayer = monster.position.manhattanDistanceTo(playerPosition);
    final isPlayerAdjacent = distanceToPlayer == 1;

    // Update AI state based on current conditions
    final updatedAIState = updateAIState(monster, playerPosition, config);

    // Handle actions based on AI state
    switch (updatedAIState) {
      case AIState.fleeing:
        return _handleFleeing(monster, playerPosition, state);

      case AIState.attacking:
        // Player is adjacent, attack them
        if (isPlayerAdjacent) {
          return AttackAction(state.player.id);
        }
        // Shouldn't happen, but fall through to chasing
        return _handleChasing(monster, playerPosition, state, config);

      case AIState.chasing:
        return _handleChasing(monster, playerPosition, state, config);

      case AIState.idle:
        return _handleIdle(monster, playerPosition, state, config);
    }
  }

  /// Update the monster's AI state based on current conditions.
  ///
  /// Considers the monster's behavior type, health, distance to player,
  /// and aggro range to determine the appropriate AI state.
  AIState updateAIState(
    Monster monster,
    Position playerPosition,
    MonsterConfig config,
  ) {
    final distanceToPlayer = monster.position.manhattanDistanceTo(playerPosition);
    final isPlayerAdjacent = distanceToPlayer == 1;

    // Cowardly monsters flee when health is low (< 25%)
    if (config.behavior == MonsterBehaviour.cowardly && monster.isLowHealth) {
      return AIState.fleeing;
    }

    // Check behavior-specific state transitions
    switch (config.behavior) {
      case MonsterBehaviour.passive:
        // Passive monsters only attack if player is adjacent
        if (isPlayerAdjacent) {
          return AIState.attacking;
        }
        return AIState.idle;

      case MonsterBehaviour.aggressive:
        // Aggressive monsters chase within aggro range, attack when adjacent
        if (isPlayerAdjacent) {
          return AIState.attacking;
        }
        if (distanceToPlayer <= config.aggroRange) {
          return AIState.chasing;
        }
        return AIState.idle;

      case MonsterBehaviour.territorial:
        // Territorial monsters attack intruders within aggro range
        if (isPlayerAdjacent) {
          return AIState.attacking;
        }
        if (distanceToPlayer <= config.aggroRange) {
          // Stay and defend territory - chase within range
          return AIState.chasing;
        }
        return AIState.idle;

      case MonsterBehaviour.cowardly:
        // Cowardly monsters act aggressive until health is low
        // (fleeing case handled above)
        if (isPlayerAdjacent) {
          return AIState.attacking;
        }
        if (distanceToPlayer <= config.aggroRange) {
          return AIState.chasing;
        }
        return AIState.idle;
    }
  }

  /// Handle fleeing behavior - find a position away from the player.
  MonsterAction _handleFleeing(
    Monster monster,
    Position playerPosition,
    GameState state,
  ) {
    final fleePosition = _findFleePosition(monster, playerPosition, state);
    if (fleePosition != null) {
      return FleeAction(fleePosition);
    }
    // Can't flee, stay in place
    return IdleAction();
  }

  /// Handle chasing behavior - move toward the player.
  MonsterAction _handleChasing(
    Monster monster,
    Position playerPosition,
    GameState state,
    MonsterConfig config,
  ) {
    final currentLocation = state.currentLocation;
    if (currentLocation == null) {
      return IdleAction();
    }

    // For territorial monsters, check if moving would take us too far from spawn
    // Note: We don't have spawn position stored, so territorial monsters
    // just act like aggressive ones for now

    // Use pathfinding to get next step toward player
    final nextStep = _pathfinding.getNextStep(
      monster.position,
      playerPosition,
      currentLocation.map,
    );

    if (nextStep != null) {
      // Check if the position is walkable and not blocked by another monster
      if (_isPositionAvailable(nextStep, monster.id, state)) {
        return MoveAction(nextStep);
      }
    }

    // Can't reach player, try to get closer via adjacent tiles
    final alternativeMove = _findAlternativeMove(
      monster,
      playerPosition,
      state,
    );
    if (alternativeMove != null) {
      return MoveAction(alternativeMove);
    }

    // Can't move toward player at all, idle
    return IdleAction();
  }

  /// Handle idle behavior - stay still or wander randomly.
  MonsterAction _handleIdle(
    Monster monster,
    Position playerPosition,
    GameState state,
    MonsterConfig config,
  ) {
    // For passive monsters, occasionally wander
    if (config.behavior == MonsterBehaviour.passive) {
      // 30% chance to wander
      if (_random.nextDouble() < 0.3) {
        final wanderPosition = _findWanderPosition(monster, state);
        if (wanderPosition != null) {
          return MoveAction(wanderPosition);
        }
      }
    }

    // Default: do nothing
    return IdleAction();
  }

  /// Find a position to flee toward (away from the player).
  Position? _findFleePosition(
    Monster monster,
    Position playerPosition,
    GameState state,
  ) {
    final currentLocation = state.currentLocation;
    if (currentLocation == null) {
      return null;
    }

    // Get all adjacent walkable positions
    final neighbors = monster.position.cardinalNeighbors;
    Position? bestFleePosition;
    int maxDistance = monster.position.manhattanDistanceTo(playerPosition);

    for (final neighbor in neighbors) {
      // Check if position is available
      if (!_isPositionAvailable(neighbor, monster.id, state)) {
        continue;
      }

      // Check if it's walkable on the map
      if (!currentLocation.map.isWalkable(neighbor.x, neighbor.y)) {
        continue;
      }

      final distanceFromPlayer = neighbor.manhattanDistanceTo(playerPosition);
      if (distanceFromPlayer > maxDistance) {
        maxDistance = distanceFromPlayer;
        bestFleePosition = neighbor;
      }
    }

    return bestFleePosition;
  }

  /// Find an alternative move when pathfinding fails.
  Position? _findAlternativeMove(
    Monster monster,
    Position targetPosition,
    GameState state,
  ) {
    final currentLocation = state.currentLocation;
    if (currentLocation == null) {
      return null;
    }

    final neighbors = monster.position.cardinalNeighbors;
    Position? bestMove;
    int minDistance = monster.position.manhattanDistanceTo(targetPosition);

    for (final neighbor in neighbors) {
      // Check if position is available
      if (!_isPositionAvailable(neighbor, monster.id, state)) {
        continue;
      }

      // Check if it's walkable on the map
      if (!currentLocation.map.isWalkable(neighbor.x, neighbor.y)) {
        continue;
      }

      final distanceToTarget = neighbor.manhattanDistanceTo(targetPosition);
      if (distanceToTarget < minDistance) {
        minDistance = distanceToTarget;
        bestMove = neighbor;
      }
    }

    return bestMove;
  }

  /// Find a random walkable adjacent position for wandering.
  Position? _findWanderPosition(Monster monster, GameState state) {
    final currentLocation = state.currentLocation;
    if (currentLocation == null) {
      return null;
    }

    final neighbors = monster.position.cardinalNeighbors;
    final walkableNeighbors = <Position>[];

    for (final neighbor in neighbors) {
      if (_isPositionAvailable(neighbor, monster.id, state) &&
          currentLocation.map.isWalkable(neighbor.x, neighbor.y)) {
        walkableNeighbors.add(neighbor);
      }
    }

    if (walkableNeighbors.isEmpty) {
      return null;
    }

    // Pick a random walkable neighbor
    return walkableNeighbors[_random.nextInt(walkableNeighbors.length)];
  }

  /// Check if a position is available (walkable and not occupied by another monster).
  bool _isPositionAvailable(Position position, String monsterId, GameState state) {
    final currentLocation = state.currentLocation;
    if (currentLocation == null) {
      return false;
    }

    // Check map bounds
    if (!currentLocation.map.isInBounds(position.x, position.y)) {
      return false;
    }

    // Check if tile is walkable
    if (!currentLocation.map.isWalkable(position.x, position.y)) {
      return false;
    }

    // Check if player is at this position
    if (state.player.position.x == position.x &&
        state.player.position.y == position.y) {
      return false;
    }

    // Check if another monster is at this position
    for (final otherMonster in state.monsters.values) {
      if (otherMonster.id != monsterId &&
          otherMonster.isAlive &&
          otherMonster.position.x == position.x &&
          otherMonster.position.y == position.y) {
        return false;
      }
    }

    return true;
  }
}
