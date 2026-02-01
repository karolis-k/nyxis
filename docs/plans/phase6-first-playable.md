# Phase 6: First Playable — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Integrate all systems into a complete gameplay experience.

---

> [!TIP]
> 🏁 **MILESTONE: RUNNING GAME**  
> At the end of Phase 6, you will have a fully playable dungeon crawler with movement, combat, items, multi-floor exploration, and persistence.

---

## Overview

This phase ties together all previous phases into a cohesive game:
- Complete player mechanics (inventory, equipment)
- Polish monster interactions (death, loot)
- Basic but functional UI
- Working persistence

> **Deferred to Phase 8**: Ranged combat (adds complexity, not essential for first playable)

---

## 6.1 Player Mechanics ✅

### Inventory Pickup/Drop

- [x] Pickup: `PlayerPickupAction` in TurnSystem
- [x] Drop item from inventory to ground: `PlayerDropAction`
- [ ] Handle full inventory (reject pickup or swap)
- [x] Visual feedback via InventoryScreen updates

### Use Consumable Items

- [x] `PlayerUseItemAction` implemented in TurnSystem
- [x] Health potion → restore HP (healing effect)
- [ ] Scroll → cast spell effect (future)
- [ ] Key → unlock door (future)
- [x] Remove item after use (consumables consumed)
- [x] Fire `ItemUsedEvent`

### Equip/Unequip Gear

- [x] Equipment slots in Player model (`equippedWeaponId`, `equippedArmorId`)
- [x] `PlayerEquipAction` (equip from inventory)
- [x] `PlayerUnequipAction` (unequip to inventory)
- [ ] Equipment modifies combat stats (verify wiring)
- [x] Visual indicator in InventoryScreen

---

## 6.2 Monster Polish

### Loot Drops

```dart
void onMonsterDied(MonsterDiedEvent event) {
  final monster = event.monster;
  final config = MonsterRegistry.get(monster.configId);
  
  // Roll for drops based on loot table
  for (final drop in config.lootTable) {
    if (random.nextDouble() < drop.chance) {
      final item = Item.fromConfig(drop.itemConfigId, monster.position);
      gameState = gameState.addItem(item);
    }
  }
}
```

- [x] Define loot tables in MonsterConfig
- [x] Roll drops on monster death
- [x] Create item entities at death position
- [x] Visual feedback (items appearing)

### XP/Score on Kill

- [x] Add XP value to MonsterConfig
- [x] Award XP to player on kill
- [x] Track total score/XP
- [ ] Fire XpGainedEvent (deferred)
- [ ] (Future) Level up system

---

## 6.3 Basic UI

### HUD Widget

- [x] Health bar with current/max HP (color-coded)
- [x] Equipped weapon icon
- [x] Equipped armor icon
- [ ] Turn indicator (deferred)
- [x] Floor/location indicator

### Inventory Screen ✅

- [x] List of inventory items with icons
- [x] Item icons colored by type and rarity
- [x] Tap for action menu (Use, Equip, Drop, Cancel)
- [x] Equipment slots display (Weapon/Armor)
- [x] Close button to return to game
- [x] Unequip by tapping equipment slot

### Game Over Screen

- [x] Display "Game Over" message (basic overlay)
- [x] Show final score/stats
- [x] "New Game" button (restart)
- [ ] "Return to Menu" button (deferred - no main menu yet)

### Screen Navigation

- [x] Inventory button opens InventoryScreen
- [x] Game over triggers overlay
- [x] Screens overlay game view

---

## 6.4 Persistence

### Save Triggers

```dart
// Auto-save on location change
eventBus.on<LocationChangedEvent>().listen((e) {
  saveService.saveGame(gameState);
});

// Auto-save on game exit
@override
void onRemove() {
  saveService.saveGame(gameState);
  super.onRemove();
}

// Manual save from menu
void onSavePressed() {
  saveService.saveGame(gameState);
  showMessage("Game saved!");
}
```

- [x] Save on location change (stairs, portals, map exit)
- [x] Save on game exit / app background
- [ ] Manual save option in menu (deferred)
- [ ] Save indicator/feedback (deferred)

### What to Save

```dart
class SaveData {
  final Player player;
  final String currentLocationId;
  final int currentFloor;
  final Position worldMapPosition;
  final Map<String, LocationSaveData> locations;
  final int turnNumber;
  final int seed;  // For regenerating if needed
}

class LocationSaveData {
  final Map<String, Monster> monsters;
  final Map<String, Item> items;
  final Set<Position> exploredTiles;
}
```

- [x] Player state (HP, inventory, equipment, position)
- [x] Current location and floor
- [ ] World map position (deferred - Phase 7)
- [x] Per-location state (monsters, items, explored tiles)
- [x] Turn number
- [ ] World seed for consistency (deferred)

### Load Game

```dart
Future<GameState?> loadGame(String slotId) async {
  final saveData = await hiveBox.get(slotId);
  if (saveData == null) return null;
  
  // Reconstruct game state
  return GameState(
    player: saveData.player,
    currentLocationId: saveData.currentLocationId,
    // ... etc
  );
}
```

- [x] Load from save slot
- [x] Reconstruct GameState
- [x] Restore player position
- [x] Load current location data
- [x] Resume gameplay seamlessly

### Save Slot Management (basic)

- [x] Single save slot for now
- [x] Check if save exists (for Continue button)
- [x] Delete save on new game (or confirm overwrite)

---

## Integration Testing

### Full Gameplay Session Test

1. Start new game
2. Explore surface area
3. Enter dungeon
4. Fight monsters
5. Pick up items
6. Use consumables
7. Equip gear
8. Go deeper (stairs down)
9. Die or exit
10. Load game
11. Verify state restored

### Edge Cases

- [ ] Save/load with empty inventory
- [ ] Save/load with dead monsters
- [ ] Save/load on different floors
- [ ] Save/load with active portals
- [ ] Interrupt during save (crash recovery)

---

## Done Criteria

Phase 6 is complete when:
- [x] Player can pick up and drop items
- [x] Player can use consumable items
- [x] Player can equip and unequip gear
- [x] Monsters drop loot on death
- [x] XP/score is tracked
- [x] HUD displays health and equipment
- [x] Inventory screen allows item management
- [x] Game over screen appears on death
- [x] Game saves automatically on transitions
- [x] Game can be loaded from save
- [x] Full gameplay loop is completable

---

## Test Checklist

Before moving to Phase 7, verify:
- [x] Complete playthrough without crashes
- [x] All player actions work correctly (move, attack, pickup, drop, use, equip)
- [x] Combat feels responsive
- [x] Items work as expected
- [x] Equipment modifies stats correctly
- [x] UI is readable and usable
- [x] Save/load preserves all state
- [x] Performance remains at 60 FPS
- [x] No softlocks or unwinnable states

---

## Next Phase

After completing Phase 6, proceed to [Phase 7: Content & Polish](phase7-content-polish.md).
