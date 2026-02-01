import '../models/entities/entity.dart';
import '../models/world/tile.dart';

/// Base class for all game events.
///
/// All events include a timestamp for debugging and replay functionality.
abstract class GameEvent {
  final DateTime timestamp;
  GameEvent() : timestamp = DateTime.now();
}

// =============================================================================
// Movement Events
// =============================================================================

/// Fired when any entity moves from one position to another.
class EntityMovedEvent extends GameEvent {
  final String entityId;
  final Position from;
  final Position to;

  EntityMovedEvent(this.entityId, this.from, this.to);
}

/// Fired when the player enters a new tile.
class PlayerEnteredTileEvent extends GameEvent {
  final Position position;
  final Tile tile;

  PlayerEnteredTileEvent(this.position, this.tile);
}

// =============================================================================
// Combat Events
// =============================================================================

/// Fired when an entity deals damage to another entity.
class DamageDealtEvent extends GameEvent {
  final String attackerId;
  final String targetId;
  final int damage;
  final bool isCritical;

  DamageDealtEvent(this.attackerId, this.targetId, this.damage, this.isCritical);
}

/// Fired when an entity dies.
class EntityDiedEvent extends GameEvent {
  final String entityId;
  final String? killerId;

  EntityDiedEvent(this.entityId, this.killerId);
}

/// Fired when an attack misses its target.
class AttackMissedEvent extends GameEvent {
  final String attackerId;
  final String targetId;

  AttackMissedEvent(this.attackerId, this.targetId);
}

// =============================================================================
// Item Events
// =============================================================================

/// Fired when the player picks up an item.
class ItemPickedUpEvent extends GameEvent {
  final String itemId;
  final String playerId;

  ItemPickedUpEvent(this.itemId, this.playerId);
}

/// Fired when an item is dropped at a position.
class ItemDroppedEvent extends GameEvent {
  final String itemId;
  final Position position;

  ItemDroppedEvent(this.itemId, this.position);
}

/// Fired when an item is used (e.g., potion consumed).
class ItemUsedEvent extends GameEvent {
  final String itemId;
  final String userId;

  ItemUsedEvent(this.itemId, this.userId);
}

/// Fired when an item is equipped.
class ItemEquippedEvent extends GameEvent {
  final String itemId;
  final String playerId;

  ItemEquippedEvent(this.itemId, this.playerId);
}

// =============================================================================
// World Events
// =============================================================================

/// Fired when the player moves to a different location (e.g., dungeon to town).
class LocationChangedEvent extends GameEvent {
  final String fromLocationId;
  final String toLocationId;

  LocationChangedEvent(this.fromLocationId, this.toLocationId);
}

/// Fired when the player changes floors within a location.
class FloorChangedEvent extends GameEvent {
  final String locationId;
  final int fromFloor;
  final int toFloor;

  FloorChangedEvent(this.locationId, this.fromFloor, this.toFloor);
}

/// Fired when a game turn is completed.
class TurnCompletedEvent extends GameEvent {
  final int turnNumber;

  TurnCompletedEvent(this.turnNumber);
}

// =============================================================================
// Game State Events
// =============================================================================

/// Fired when a new game starts.
class GameStartedEvent extends GameEvent {
  GameStartedEvent();
}

/// Fired when the game is paused.
class GamePausedEvent extends GameEvent {
  GamePausedEvent();
}

/// Fired when the game is resumed from pause.
class GameResumedEvent extends GameEvent {
  GameResumedEvent();
}

/// Fired when the game ends.
class GameOverEvent extends GameEvent {
  final bool isVictory;

  GameOverEvent(this.isVictory);
}
