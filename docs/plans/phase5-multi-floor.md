# Phase 5: Multi-Floor Dungeon — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Enable stair traversal to explore multiple floors of the dungeon.

---

## Overview

This phase adds vertical depth to the dungeon. Players can descend deeper via stairs, with each floor procedurally generated on first visit and cached for persistence.

**Why this before World Map?**
- Gets to deeper gameplay faster
- Tests floor management and state persistence
- Simpler scope than full world navigation
- Natural progression: master one dungeon, then explore the world

---

## 5.1 Floor Management

### GameState Changes

The current `GameState` stores a single location. We need to support multiple floors:

```dart
@freezed
class GameState with _$GameState {
  const factory GameState({
    required Player player,
    required String currentLocationId,
    required int currentFloor,
    // Change: locations now keyed by "locationId:floor"
    required Map<String, Location> locations,
    required Map<String, Monster> monsters,
    required Map<String, Item> items,
    required int turnNumber,
    required bool isPlayerTurn,
    required GameStatus status,
  }) = _GameState;
}
```

**Tasks:**
- [ ] Update GameState to use composite key `"$locationId:$floor"` for locations map
- [ ] Add helper method `getFloor(String locationId, int floor)` 
- [ ] Add helper method `setFloor(Location location)` to cache a floor
- [ ] Track `Set<String> visitedFloors` for persistence optimization

### Lazy Floor Generation

Generate floors on-demand when the player first visits:

```dart
Location getOrGenerateFloor(String locationId, int floor, Random random) {
  final key = '$locationId:$floor';
  
  // Return cached floor if exists
  if (locations.containsKey(key)) {
    return locations[key]!;
  }
  
  // Generate new floor
  final config = LocationRegistry.get(locationId);
  final location = dungeonGenerator.generate(
    config: config,
    floor: floor,
    random: random,
  );
  
  // Cache it
  locations[key] = location;
  return location;
}
```

**Tasks:**
- [ ] Create `FloorManager` service or add methods to `MyGame`
- [ ] Implement `getOrGenerateFloor()` with lazy generation
- [ ] Use seeded random for consistent regeneration (seed = baseSeed + floor)

---

## 5.2 Stair Traversal

### Detecting Stair Entry

When the player moves onto a stair tile, we need to handle the transition:

```dart
// In TurnSystem or MyGame
void onPlayerEnteredTile(Position position, Tile tile) {
  if (tile.type == TileType.stairsDown) {
    _descendFloor();
  } else if (tile.type == TileType.stairsUp) {
    _ascendFloor();
  }
}
```

**Tasks:**
- [ ] Listen to `PlayerEnteredTileEvent` (already fired by TurnSystem)
- [ ] Check tile type for stairs
- [ ] Trigger floor transition

### Descending (StairsDown)

When stepping on stairs down:

```dart
void descendFloor() {
  final nextFloor = currentFloor + 1;
  
  // Check if dungeon has more floors
  final config = LocationRegistry.get(currentLocationId);
  if (nextFloor > config.maxDepth) {
    // Can't go deeper - maybe show message
    return;
  }
  
  // Save current floor state
  _saveCurrentFloorState();
  
  // Get or generate next floor
  final nextLocation = getOrGenerateFloor(currentLocationId, nextFloor, random);
  
  // Find stairs up on the new floor (spawn point)
  final spawnPos = _findStairsUp(nextLocation);
  
  // Transition
  _transitionToFloor(nextLocation, nextFloor, spawnPos);
}
```

**Tasks:**
- [ ] Implement `descendFloor()` method
- [ ] Validate against `maxDepth` from LocationConfig
- [ ] Find stairsUp tile on destination floor for spawn position

### Ascending (StairsUp)

When stepping on stairs up:

```dart
void ascendFloor() {
  final prevFloor = currentFloor - 1;
  
  if (prevFloor < 1) {
    // Floor 1 stairs up = exit dungeon
    // For now: show "You escaped!" or similar
    // Later: return to world map
    _exitDungeon();
    return;
  }
  
  // Save current floor state
  _saveCurrentFloorState();
  
  // Get previous floor (must exist, we came from there)
  final prevLocation = getOrGenerateFloor(currentLocationId, prevFloor, random);
  
  // Find stairs down on previous floor (where we came from)
  final spawnPos = _findStairsDown(prevLocation);
  
  // Transition
  _transitionToFloor(prevLocation, prevFloor, spawnPos);
}
```

**Tasks:**
- [ ] Implement `ascendFloor()` method
- [ ] Handle floor 1 exit (win condition or surface exit)
- [ ] Find stairsDown tile on destination floor for spawn position

### Floor Transition

The actual transition logic:

```dart
void _transitionToFloor(Location location, int floor, Position spawnPos) {
  // Update game state
  _gameState = _gameState.copyWith(
    currentFloor: floor,
    player: _gameState.player.moveTo(spawnPos),
  );
  
  // Clear and rebuild visual components
  _rebuildFloorComponents(location);
  
  // Spawn monsters for this floor
  _loadFloorMonsters(location);
  
  // Update camera bounds
  _setupCamera();
  
  // Fire event
  eventBus.fire(FloorChangedEvent(floor, location.id));
}
```

**Tasks:**
- [ ] Implement `_transitionToFloor()` with full component rebuild
- [ ] Create `FloorChangedEvent` 
- [ ] Rebuild tile components for new floor
- [ ] Load monsters from cached floor state (or spawn new if first visit)
- [ ] Update camera bounds for new floor dimensions

---

## 5.3 Floor State Persistence

### Per-Floor Monster/Item State

Each floor needs to remember its state (which monsters are dead, which items are picked up):

```dart
// When leaving a floor
void _saveCurrentFloorState() {
  final key = '$currentLocationId:$currentFloor';
  
  // Update location with current monster IDs
  final currentLocation = locations[key]!;
  final updatedLocation = currentLocation.copyWith(
    monsterIds: monsters.keys.where((id) => 
      monsters[id]!.isAlive && 
      _isMonsterOnThisFloor(monsters[id]!)
    ).toList(),
    itemIds: items.keys.where((id) =>
      _isItemOnThisFloor(items[id]!)
    ).toList(),
  );
  
  locations[key] = updatedLocation;
}
```

**Tasks:**
- [ ] Save monster state to floor's Location when leaving
- [ ] Save item state to floor's Location when leaving
- [ ] Restore monster components when returning to a floor
- [ ] Restore item components when returning to a floor

### Visited Floors Tracking

```dart
// In GameState
Set<String> get visitedFloors => locations.keys.toSet();

bool hasVisitedFloor(String locationId, int floor) {
  return locations.containsKey('$locationId:$floor');
}
```

**Tasks:**
- [ ] Add `visitedFloors` getter or field
- [ ] Use for determining if floor needs generation vs loading

---

## LocationConfig Updates

Ensure LocationConfig has `maxDepth`:

```dart
@freezed
class LocationConfig with _$LocationConfig {
  const factory LocationConfig({
    required String id,
    required String name,
    required LocationType type,
    @Default(5) int maxDepth,  // Maximum floors (1-indexed)
    // ... other fields
  }) = _LocationConfig;
}
```

**Tasks:**
- [ ] Verify `maxDepth` exists in LocationConfig
- [ ] Set appropriate depths for each location (dark_dungeon: 5, etc.)

---

## Events

New events for floor transitions:

```dart
class FloorChangedEvent extends GameEvent {
  final int floor;
  final String locationId;
  FloorChangedEvent(this.floor, this.locationId);
}

class DungeonExitedEvent extends GameEvent {
  final String locationId;
  DungeonExitedEvent(this.locationId);
}
```

**Tasks:**
- [ ] Add `FloorChangedEvent` to events.dart
- [ ] Add `DungeonExitedEvent` for stairs up from floor 1
- [ ] Fire events at appropriate times

---

## UI Updates

### Floor Indicator

Show current floor in the UI:

```dart
// In HUD or overlay
Text('Floor $currentFloor')
```

**Tasks:**
- [ ] Add floor indicator to game overlay or HUD
- [ ] Update on floor change

### Transition Feedback

Brief visual feedback during floor transitions:

```dart
// Simple approach: brief fade or message
"Descending to floor 2..."
```

**Tasks:**
- [ ] Add brief transition message or effect
- [ ] Consider brief fade-to-black during floor rebuild

---

## Implementation Order

1. **GameState changes** — Update composite key structure
2. **FloorChangedEvent** — Add the event type
3. **Stair detection** — Listen for stair entry in MyGame
4. **Descend logic** — Implement descendFloor with generation
5. **Ascend logic** — Implement ascendFloor with floor 1 exit
6. **Floor transition** — Component rebuild and camera update
7. **State persistence** — Save/restore floor state
8. **UI updates** — Floor indicator and transition feedback

---

## Done Criteria

Phase 5 is complete when:
- [x] Player can step on stairs down and descend to next floor
- [x] Player can step on stairs up and ascend to previous floor
- [x] Stairs up on floor 1 exits the dungeon (restart or win message)
- [x] New floors are generated on first visit
- [x] Returning to a visited floor restores its state (monsters, items)
- [x] Floor indicator shows current floor
- [x] Dungeon respects maxDepth (can't descend past it)
- [x] No crashes during floor transitions

---

## Test Checklist

Before moving to Phase 6, verify:
- [ ] Descend from floor 1 to floor 2 works
- [ ] Ascend from floor 2 to floor 1 works
- [ ] Kill monster on floor 1, descend, ascend — monster stays dead
- [ ] Floor 5 (maxDepth) has no stairs down, or stairs down are blocked
- [ ] Stairs up on floor 1 produces exit behavior
- [ ] Multiple descend/ascend cycles don't cause memory issues
- [ ] Camera properly bounds to each floor's dimensions
- [ ] Player spawns at correct stair position

---

## Next Phase

After completing Phase 5, proceed to [Phase 6: First Playable](phase6-first-playable.md).
