import '../../config/item_config.dart';
import '../../core/event_bus.dart';
import '../../core/events.dart';
import '../../models/entities/entity.dart';
import '../../models/entities/item.dart';
import '../../models/entities/monster.dart';
import '../../models/entities/player.dart';
import '../../models/game_state.dart';
import 'combat_system.dart';
import 'monster_behavior_system.dart';

// =============================================================================
// Player Actions
// =============================================================================

/// Actions the player can take during their turn.
sealed class PlayerAction {}

/// Player moves to an adjacent tile.
class PlayerMoveAction extends PlayerAction {
  final Position target;
  PlayerMoveAction(this.target);

  @override
  String toString() => 'PlayerMoveAction(target: $target)';
}

/// Player attacks an adjacent monster.
class PlayerAttackAction extends PlayerAction {
  final String targetMonsterId;
  PlayerAttackAction(this.targetMonsterId);

  @override
  String toString() => 'PlayerAttackAction(targetMonsterId: $targetMonsterId)';
}

/// Player waits and skips their turn.
class PlayerWaitAction extends PlayerAction {
  @override
  String toString() => 'PlayerWaitAction()';
}

/// Player picks up an item at their current position.
class PlayerPickupAction extends PlayerAction {
  final String itemId;
  PlayerPickupAction(this.itemId);

  @override
  String toString() => 'PlayerPickupAction(itemId: $itemId)';
}

/// Player drops an item from inventory to the ground.
class PlayerDropAction extends PlayerAction {
  final String itemId;
  PlayerDropAction(this.itemId);

  @override
  String toString() => 'PlayerDropAction(itemId: $itemId)';
}

/// Player uses a consumable item from inventory.
class PlayerUseItemAction extends PlayerAction {
  final String itemId;
  PlayerUseItemAction(this.itemId);

  @override
  String toString() => 'PlayerUseItemAction(itemId: $itemId)';
}

/// Equipment slot types.
enum EquipmentSlot { weapon, armor }

/// Player equips a weapon or armor from inventory.
class PlayerEquipAction extends PlayerAction {
  final String itemId;
  PlayerEquipAction(this.itemId);

  @override
  String toString() => 'PlayerEquipAction(itemId: $itemId)';
}

/// Player unequips a weapon or armor.
class PlayerUnequipAction extends PlayerAction {
  final EquipmentSlot slot;
  PlayerUnequipAction(this.slot);

  @override
  String toString() => 'PlayerUnequipAction(slot: $slot)';
}

// =============================================================================
// Turn System
// =============================================================================

/// Manages turn-based gameplay, coordinating player and monster actions.
///
/// The TurnSystem orchestrates the flow of combat:
/// 1. Player takes an action (move, attack, wait, pickup)
/// 2. All monsters take their turns
/// 3. TurnCompletedEvent is fired
/// 4. Turn counter increments
///
/// This system is designed to be energy-ready for future implementations:
/// - Each entity has a `speed` stat and `energy` accumulator
/// - Future: entities act when energy >= 100, energy += speed each tick
/// - This allows for variable action speeds (fast enemies, slow attacks, etc.)
class TurnSystem {
  final CombatSystem _combat;
  final MonsterBehaviorSystem _behavior;
  final EventBus _eventBus;

  int _turnCount = 0;
  bool _isPlayerTurn = true;

  /// Creates a new TurnSystem.
  ///
  /// [combat] handles damage calculations and combat resolution.
  /// [behavior] decides monster AI actions each turn.
  /// [eventBus] is optional and used for testing (defaults to EventBus.instance).
  TurnSystem(
    this._combat,
    this._behavior, {
    EventBus? eventBus,
  }) : _eventBus = eventBus ?? EventBus.instance;

  /// Whether it's currently the player's turn to act.
  bool get isPlayerTurn => _isPlayerTurn;

  /// The current turn number (increments after each full turn cycle).
  int get turnCount => _turnCount;

  /// Process a player action and then all monster turns.
  ///
  /// This is the main entry point for turn processing:
  /// 1. Validates and executes the player's action
  /// 2. Processes all monster turns
  /// 3. Fires TurnCompletedEvent
  /// 4. Increments the turn counter
  ///
  /// Returns the updated GameState after all actions are resolved.
  GameState processPlayerAction(PlayerAction action, GameState state) {
    // Don't process if game is not playing
    if (!state.isPlaying) {
      return state;
    }

    _isPlayerTurn = true;

    // Execute the player's action
    GameState newState = switch (action) {
      PlayerMoveAction(:final target) => _processPlayerMove(target, state),
      PlayerAttackAction(:final targetMonsterId) =>
        _processPlayerAttack(targetMonsterId, state),
      PlayerWaitAction() => state,
      PlayerPickupAction(:final itemId) => _processPlayerPickup(itemId, state),
      PlayerDropAction(:final itemId) => _processPlayerDrop(itemId, state),
      PlayerUseItemAction(:final itemId) => _processPlayerUseItem(itemId, state),
      PlayerEquipAction(:final itemId) => _processPlayerEquip(itemId, state),
      PlayerUnequipAction(:final slot) => _processPlayerUnequip(slot, state),
    };

    // Check if player died (shouldn't happen during player action, but check anyway)
    if (!newState.player.isAlive) {
      return newState.copyWith(status: GameStatus.gameOver);
    }

    // Process all monster turns
    _isPlayerTurn = false;
    newState = processMonsterTurns(newState);

    // Check if player died during monster turns
    if (!newState.player.isAlive) {
      return newState.copyWith(status: GameStatus.gameOver);
    }

    // Increment turn counter and fire event
    _turnCount++;
    _eventBus.fire(TurnCompletedEvent(_turnCount));

    // Update game state with new turn number
    return newState.copyWith(
      turnNumber: _turnCount,
      isPlayerTurn: true,
    );
  }

  /// Process a player move action.
  ///
  /// Validates that the target position is walkable, then updates
  /// the player's position and fires an EntityMovedEvent.
  GameState _processPlayerMove(Position target, GameState state) {
    final player = state.player;
    final oldPosition = player.position;

    // Validate: target must be adjacent (within 1 tile)
    if (oldPosition.manhattanDistanceTo(target) != 1) {
      // Invalid move - not adjacent
      return state;
    }

    // Validate: target must be walkable
    if (!state.isTileWalkable(target.x, target.y)) {
      // Can't move to this tile
      return state;
    }

    // Execute the move
    final newPlayer = player.moveTo(target);

    // Fire movement event
    _eventBus.fire(EntityMovedEvent(player.id, oldPosition, target));

    // Check if player stepped on a tile with special effects
    final location = state.currentLocation;
    if (location != null) {
      final tile = location.map.getTile(target.x, target.y);
      if (tile != null) {
        _eventBus.fire(PlayerEnteredTileEvent(target, tile));
      }
    }

    return state.copyWith(player: newPlayer);
  }

  /// Process a player attack action.
  ///
  /// Uses the CombatSystem to resolve the attack, updates or removes
  /// the target monster based on the result.
  GameState _processPlayerAttack(String targetMonsterId, GameState state) {
    final player = state.player;
    final monster = state.monsters[targetMonsterId];

    // Validate: monster exists and is alive
    if (monster == null || !monster.isAlive) {
      return state;
    }

    // Validate: monster is adjacent
    if (!_combat.isAdjacent(player.position, monster.position)) {
      return state;
    }

    // Process the attack (with equipment bonuses)
    final updatedMonster = _combat.processPlayerAttack(player, monster, state);

    // Update state based on result
    if (updatedMonster == null) {
      // Monster died - remove from state
      final newMonsters = Map<String, Monster>.from(state.monsters)
        ..remove(targetMonsterId);
      return state.copyWith(monsters: newMonsters);
    } else {
      // Monster survived - update in state
      final newMonsters = Map<String, Monster>.from(state.monsters)
        ..[targetMonsterId] = updatedMonster;
      return state.copyWith(monsters: newMonsters);
    }
  }

  /// Process a player pickup action.
  ///
  /// Adds the item to the player's inventory and removes it from the world.
  GameState _processPlayerPickup(String itemId, GameState state) {
    final item = state.items[itemId];

    // Validate: item exists
    if (item == null) {
      return state;
    }

    // Validate: item is at player's position
    if (item.position != state.player.position) {
      return state;
    }

    // Add to inventory and remove from world
    final newPlayer = state.player.addItem(itemId);

    // Update item to have no world position (it's now in inventory)
    final pickedUpItem = item.pickup();
    final newItems = Map<String, Item>.from(state.items)..[itemId] = pickedUpItem;

    // Fire pickup event
    _eventBus.fire(ItemPickedUpEvent(itemId, state.player.id));

    return state.copyWith(
      player: newPlayer,
      items: newItems,
    );
  }

  /// Process a player drop action.
  ///
  /// Removes the item from inventory and places it in the world at player's position.
  GameState _processPlayerDrop(String itemId, GameState state) {
    final player = state.player;
    
    // Validate: item is in player's inventory
    if (!player.hasItem(itemId)) {
      return state;
    }
    
    final item = state.items[itemId];
    if (item == null) {
      return state;
    }
    
    // Remove from inventory
    final newPlayer = player.removeItem(itemId);
    
    // Place item in world at player's position
    final droppedItem = item.dropAt(player.position);
    final newItems = Map<String, Item>.from(state.items)..[itemId] = droppedItem;
    
    // Fire drop event
    _eventBus.fire(ItemDroppedEvent(itemId, player.position));
    
    return state.copyWith(
      player: newPlayer,
      items: newItems,
    );
  }

  /// Process a player use item action.
  ///
  /// Uses a consumable item for its effect and removes it from inventory.
  GameState _processPlayerUseItem(String itemId, GameState state) {
    final player = state.player;
    
    // Validate: item is in player's inventory
    if (!player.hasItem(itemId)) {
      return state;
    }
    
    final item = state.items[itemId];
    if (item == null) {
      return state;
    }
    
    // Get item config
    final config = ItemRegistry.tryGet(item.configId);
    if (config == null) {
      return state;
    }
    
    // Only consumables can be "used"
    if (config.type != ItemType.consumable) {
      return state;
    }
    
    // Apply effect based on item properties
    var newPlayer = player;
    
    // Healing effect
    if (config.healing > 0) {
      newPlayer = newPlayer.heal(config.healing);
    }
    
    // Remove item from inventory (consumed)
    newPlayer = newPlayer.removeItem(itemId);
    
    // Remove item from items map
    final newItems = Map<String, Item>.from(state.items)..remove(itemId);
    
    // Fire use event
    _eventBus.fire(ItemUsedEvent(itemId, player.id));
    
    return state.copyWith(
      player: newPlayer,
      items: newItems,
    );
  }

  /// Process a player equip action.
  ///
  /// Equips a weapon or armor from inventory.
  GameState _processPlayerEquip(String itemId, GameState state) {
    final player = state.player;
    
    // Validate: item is in player's inventory
    if (!player.hasItem(itemId)) {
      return state;
    }
    
    final item = state.items[itemId];
    if (item == null) {
      return state;
    }
    
    // Get item config
    final config = ItemRegistry.tryGet(item.configId);
    if (config == null) {
      return state;
    }
    
    // Equip based on item type
    var newPlayer = player;
    
    switch (config.type) {
      case ItemType.weapon:
        // Unequip current weapon if any (it stays in inventory)
        newPlayer = newPlayer.equipWeapon(itemId);
      case ItemType.armor:
        // Unequip current armor if any (it stays in inventory)
        newPlayer = newPlayer.equipArmor(itemId);
      default:
        // Can't equip this item type
        return state;
    }
    
    // Fire equip event
    _eventBus.fire(ItemEquippedEvent(itemId, player.id));
    
    return state.copyWith(player: newPlayer);
  }

  /// Process a player unequip action.
  ///
  /// Unequips a weapon or armor (item remains in inventory).
  GameState _processPlayerUnequip(EquipmentSlot slot, GameState state) {
    final player = state.player;
    
    var newPlayer = player;
    
    switch (slot) {
      case EquipmentSlot.weapon:
        if (player.equippedWeaponId == null) {
          return state; // Nothing to unequip
        }
        newPlayer = newPlayer.unequipWeapon();
      case EquipmentSlot.armor:
        if (player.equippedArmorId == null) {
          return state; // Nothing to unequip
        }
        newPlayer = newPlayer.unequipArmor();
    }
    
    return state.copyWith(player: newPlayer);
  }

  /// Process all monster turns.
  ///
  /// Iterates through all alive monsters and processes their individual turns.
  /// Returns the updated GameState after all monsters have acted.
  GameState processMonsterTurns(GameState state) {
    GameState currentState = state;

    // Get all alive monsters (create a copy of the keys to avoid modification during iteration)
    final monsterIds = currentState.aliveMonsters.keys.toList();

    for (final monsterId in monsterIds) {
      // Get the current monster state (may have changed during other monster's turns)
      final monster = currentState.monsters[monsterId];
      if (monster == null || !monster.isAlive) {
        continue;
      }

      currentState = processMonsterTurn(monster, currentState);

      // Stop processing if player died
      if (!currentState.player.isAlive) {
        break;
      }
    }

    return currentState;
  }

  /// Process a single monster's turn.
  ///
  /// 1. Updates the monster's AI state based on current conditions
  /// 2. Decides what action the monster should take
  /// 3. Executes the action (move, attack, flee, or idle)
  /// 4. Fires appropriate events
  ///
  /// Returns the updated GameState.
  GameState processMonsterTurn(Monster monster, GameState state) {
    // Decide what action the monster should take
    // (updateAIState is called internally by decideAction)
    final action = _behavior.decideAction(monster, state);

    // Execute the action
    return switch (action) {
      MoveAction(:final target) => _processMonsterMove(monster, target, state),
      AttackAction(:final targetId) =>
        _processMonsterAttack(monster, targetId, state),
      FleeAction(:final target) => _processMonsterMove(monster, target, state),
      IdleAction() => state, // Monster does nothing
    };
  }

  /// Process a monster move action.
  ///
  /// Updates the monster's position and fires an EntityMovedEvent.
  GameState _processMonsterMove(
    Monster monster,
    Position target,
    GameState state,
  ) {
    final oldPosition = monster.position;

    // Validate move is valid (should be validated by behavior system, but double-check)
    final location = state.currentLocation;
    if (location == null) {
      return state;
    }

    if (!location.map.isWalkable(target.x, target.y)) {
      return state;
    }

    // Check position isn't occupied by player or another monster
    if (state.player.position == target) {
      return state;
    }

    for (final other in state.monsters.values) {
      if (other.id != monster.id && other.isAlive && other.position == target) {
        return state;
      }
    }

    // Execute the move
    final newMonster = monster.moveTo(target);

    // Fire movement event
    _eventBus.fire(EntityMovedEvent(monster.id, oldPosition, target));

    // Update state
    final newMonsters = Map<String, Monster>.from(state.monsters)
      ..[monster.id] = newMonster;

    return state.copyWith(monsters: newMonsters);
  }

  /// Process a monster attack action.
  ///
  /// Uses the CombatSystem to resolve the attack on the player.
  GameState _processMonsterAttack(
    Monster monster,
    String targetId,
    GameState state,
  ) {
    // Currently, monsters can only attack the player
    if (targetId != state.player.id) {
      return state;
    }

    // Validate: player is adjacent
    if (!_combat.isAdjacent(monster.position, state.player.position)) {
      return state;
    }

    // Process the attack
    final updatedPlayer = _combat.processMonsterAttack(monster, state.player, state);

    return state.copyWith(player: updatedPlayer);
  }
}
