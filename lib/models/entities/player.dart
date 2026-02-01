import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'entity.dart';

part 'player.freezed.dart';
part 'player.g.dart';

/// The player character entity with stats, inventory, and equipment.
@freezed
class Player with _$Player, Entity {
  const Player._();

  const factory Player({
    /// Unique identifier for this player instance.
    required String id,

    /// Current position on the game map.
    required Position position,

    /// Current health points.
    required int health,

    /// Maximum health points.
    required int maxHealth,

    /// Base attack power (before equipment bonuses).
    required int attack,

    /// Base defense value (before equipment bonuses).
    required int defense,

    /// List of item IDs in the player's inventory.
    @Default([]) List<String> inventoryItemIds,

    /// ID of the currently equipped weapon, if any.
    String? equippedWeaponId,

    /// ID of the currently equipped armor, if any.
    String? equippedArmorId,

    /// Speed value for energy-based turn system (100 = normal speed).
    @Default(100) int speed,

    /// Current energy for the energy-based turn system.
    @Default(0) int energy,

    /// Current experience points earned from kills.
    @Default(0) int experience,

    /// Current score (experience + bonus points).
    @Default(0) int score,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  /// Creates a new player with default starting stats.
  factory Player.create({
    required Position position,
    int maxHealth = 100,
    int attack = 10,
    int defense = 5,
  }) {
    return Player(
      id: const Uuid().v4(),
      position: position,
      health: maxHealth,
      maxHealth: maxHealth,
      attack: attack,
      defense: defense,
    );
  }
}

/// Extension methods for Player combat and inventory management.
extension PlayerExtensions on Player {
  /// Returns true if the player is alive.
  bool get isAlive => health > 0;

  /// Returns true if the player is at full health.
  bool get isFullHealth => health >= maxHealth;

  /// Returns the health percentage (0.0 to 1.0).
  double get healthPercent => maxHealth > 0 ? health / maxHealth : 0.0;

  /// Returns true if the player has a weapon equipped.
  bool get hasWeaponEquipped => equippedWeaponId != null;

  /// Returns true if the player has armor equipped.
  bool get hasArmorEquipped => equippedArmorId != null;

  /// Returns true if the specified item is in the inventory.
  bool hasItem(String itemId) => inventoryItemIds.contains(itemId);

  /// Returns the number of items in the inventory.
  int get inventoryCount => inventoryItemIds.length;

  /// Returns a new player with damage applied.
  Player takeDamage(int damage) {
    final actualDamage = (damage - defense).clamp(1, damage);
    return copyWith(health: (health - actualDamage).clamp(0, maxHealth));
  }

  /// Returns a new player with health restored.
  Player heal(int amount) {
    return copyWith(health: (health + amount).clamp(0, maxHealth));
  }

  /// Returns a new player with an item added to inventory.
  Player addItem(String itemId) {
    return copyWith(inventoryItemIds: [...inventoryItemIds, itemId]);
  }

  /// Returns a new player with an item removed from inventory.
  Player removeItem(String itemId) {
    return copyWith(
      inventoryItemIds: inventoryItemIds.where((id) => id != itemId).toList(),
    );
  }

  /// Returns a new player with the weapon equipped.
  /// If there was a previous weapon, it remains in inventory.
  Player equipWeapon(String weaponId) {
    return copyWith(equippedWeaponId: weaponId);
  }

  /// Returns a new player with the armor equipped.
  /// If there was previous armor, it remains in inventory.
  Player equipArmor(String armorId) {
    return copyWith(equippedArmorId: armorId);
  }

  /// Returns a new player with the weapon unequipped.
  Player unequipWeapon() {
    return copyWith(equippedWeaponId: null);
  }

  /// Returns a new player with the armor unequipped.
  Player unequipArmor() {
    return copyWith(equippedArmorId: null);
  }

  /// Returns a new player moved to the specified position.
  Player moveTo(Position newPosition) {
    return copyWith(position: newPosition);
  }

  /// Returns a new player with experience added.
  Player addExperience(int amount) {
    return copyWith(
      experience: experience + amount,
      score: score + amount,
    );
  }

  /// Returns a new player with bonus score added (no XP).
  Player addScore(int amount) {
    return copyWith(score: score + amount);
  }
}
