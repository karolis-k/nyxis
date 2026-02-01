import 'dart:math';

import '../../config/item_config.dart';
import '../../config/monster_config.dart';
import '../../core/event_bus.dart';
import '../../core/events.dart';
import '../../models/entities/entity.dart';
import '../../models/entities/monster.dart';
import '../../models/entities/player.dart';
import '../../models/game_state.dart';

/// Result of a damage calculation.
class DamageResult {
  /// The amount of damage dealt.
  final int damage;

  /// Whether this was a critical hit (2x damage).
  final bool isCritical;

  /// Whether the attack hit (false = miss).
  final bool isHit;

  const DamageResult({
    required this.damage,
    this.isCritical = false,
    this.isHit = true,
  });

  /// A missed attack result.
  static const DamageResult miss = DamageResult(damage: 0, isHit: false);
}

/// Handles all combat-related calculations and state changes.
///
/// The CombatSystem is responsible for:
/// - Calculating damage based on attacker and defender stats
/// - Processing attacks between player and monsters
/// - Firing combat-related events (damage, misses, deaths)
class CombatSystem {
  final Random _random;
  final EventBus _eventBus;

  /// Creates a new CombatSystem.
  ///
  /// [random] - Optional Random instance for testing determinism.
  /// [eventBus] - Optional EventBus instance for testing.
  CombatSystem({
    Random? random,
    EventBus? eventBus,
  })  : _random = random ?? Random(),
        _eventBus = eventBus ?? EventBus.instance;

  /// Chance for an attack to miss (10%).
  static const double missChance = 0.10;

  /// Chance for an attack to be a critical hit (10%).
  static const double criticalChance = 0.10;

  /// Critical hit damage multiplier.
  static const int criticalMultiplier = 2;

  /// Calculate damage from attacker to target.
  ///
  /// Formula: damage = attackPower - defense (minimum 1 damage).
  /// - 10% chance to miss (returns 0 damage, isHit = false).
  /// - 10% chance for critical hit (2x damage).
  DamageResult calculateDamage({
    required int attackPower,
    required int defense,
  }) {
    // Check for miss (10% chance)
    if (_random.nextDouble() < missChance) {
      return DamageResult.miss;
    }

    // Check for critical hit (10% chance)
    final isCritical = _random.nextDouble() < criticalChance;

    // Calculate base damage: attackPower - defense, minimum 1
    int damage = (attackPower - defense).clamp(1, attackPower);

    // Apply critical multiplier if critical hit
    if (isCritical) {
      damage *= criticalMultiplier;
    }

    return DamageResult(
      damage: damage,
      isCritical: isCritical,
      isHit: true,
    );
  }

  /// Gets the player's effective attack power including equipment bonuses.
  int getPlayerAttack(Player player, GameState state) {
    int attack = player.attack;

    // Add weapon bonus
    if (player.equippedWeaponId != null) {
      final weapon = state.items[player.equippedWeaponId];
      if (weapon != null) {
        final config = ItemRegistry.tryGet(weapon.configId);
        if (config != null) {
          attack += config.damage;
        }
      }
    }

    return attack;
  }

  /// Gets the player's effective defense including equipment bonuses.
  int getPlayerDefense(Player player, GameState state) {
    int defense = player.defense;

    // Add armor bonus
    if (player.equippedArmorId != null) {
      final armor = state.items[player.equippedArmorId];
      if (armor != null) {
        final config = ItemRegistry.tryGet(armor.configId);
        if (config != null) {
          defense += config.defense;
        }
      }
    }

    return defense;
  }

  /// Process a player attack on a monster.
  ///
  /// Calculates damage based on player's attack (including equipment) and monster's defense,
  /// applies the damage, and fires appropriate events.
  ///
  /// Returns the updated Monster, or null if the monster died.
  Monster? processPlayerAttack(Player player, Monster monster, GameState state) {
    // Get monster config for defense value
    final monsterConfig = MonsterRegistry.get(monster.configId);

    // Calculate damage with equipment bonus
    final result = calculateDamage(
      attackPower: getPlayerAttack(player, state),
      defense: monsterConfig.baseDefense,
    );

    // Handle miss
    if (!result.isHit) {
      _eventBus.fire(AttackMissedEvent(player.id, monster.id));
      return monster;
    }

    // Apply damage to monster
    final updatedMonster = monster.takeDamage(result.damage);

    // Fire damage event
    _eventBus.fire(DamageDealtEvent(
      player.id,
      monster.id,
      result.damage,
      result.isCritical,
    ));

    // Check if monster died
    if (!updatedMonster.isAlive) {
      _eventBus.fire(EntityDiedEvent(monster.id, player.id));
      return null;
    }

    return updatedMonster;
  }

  /// Process a monster attack on the player.
  ///
  /// Calculates damage based on monster's base damage and player's defense (including equipment),
  /// applies the damage, and fires appropriate events.
  ///
  /// Returns the updated Player.
  Player processMonsterAttack(Monster monster, Player player, GameState state) {
    // Get monster config for attack value
    final monsterConfig = MonsterRegistry.get(monster.configId);

    // Calculate damage with equipment defense
    final result = calculateDamage(
      attackPower: monsterConfig.baseDamage,
      defense: getPlayerDefense(player, state),
    );

    // Handle miss
    if (!result.isHit) {
      _eventBus.fire(AttackMissedEvent(monster.id, player.id));
      return player;
    }

    // Apply damage to player (using raw damage, defense already factored in)
    final updatedPlayer = player.copyWith(
      health: (player.health - result.damage).clamp(0, player.maxHealth),
    );

    // Fire damage event
    _eventBus.fire(DamageDealtEvent(
      monster.id,
      player.id,
      result.damage,
      result.isCritical,
    ));

    // Check if player died
    if (!updatedPlayer.isAlive) {
      _eventBus.fire(EntityDiedEvent(player.id, monster.id));
    }

    return updatedPlayer;
  }

  /// Check if attacker is adjacent to target (can melee attack).
  ///
  /// Uses Chebyshev distance (8-directional adjacency including diagonals).
  /// Two positions are adjacent if their Chebyshev distance is exactly 1.
  bool isAdjacent(Position a, Position b) {
    final dx = (a.x - b.x).abs();
    final dy = (a.y - b.y).abs();

    // Adjacent means within 1 tile in any direction (including diagonal)
    // Both dx and dy must be <= 1, and at least one must be >= 1
    return dx <= 1 && dy <= 1 && (dx > 0 || dy > 0);
  }
}
