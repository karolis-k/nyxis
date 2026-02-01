# Phase 2: Core Architecture — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Build robust, extensible systems that will scale with content.

---

## Sub-Phase Status

| Sub-Phase | Status | Focus |
|-----------|--------|-------|
| Phase 2a | ✅ Complete | Data Foundation (models, state) |
| Phase 2b | ✅ Complete | Registry + EventBus |
| Phase 2c | ✅ Complete | Systems + Services |

---

## Overview

This phase establishes the foundational architecture. Every system built here will be used throughout the game's lifetime. Quality matters more than speed.

> [!NOTE]
> World Generation architecture (generators, layout behaviors, world map, portals) is covered in **Phase 3** where the implementations are needed.

---

## 2.1 Data Layer (Phase 2a)

### Entity Models

| Model | File | Key Fields |
|-------|------|------------|
| Player | `models/entities/player.dart` | health, position, inventory, stats |
| Monster | `models/entities/monster.dart` | health, position, configId, ai state |
| Item | `models/entities/item.dart` | configId, position, quantity |

### World Models

| Model | File | Key Fields |
|-------|------|------------|
| Tile | `models/world/tile.dart` | type, walkable, feature, effect, contents |
| Map | `models/world/map.dart` | tiles[][], dimensions |
| Location | `models/world/location.dart` | map, entities, state |

### Tile Properties

Tiles have two optional property layers that generators determine:

```dart
/// Environmental features placed on tiles (decorative/functional)
enum TileFeature {
  water,      // Shallow water, slows movement
  deepWater,  // Deep water, blocks non-flying
  moss,       // Decorative, slippery
  grass,      // Decorative vegetation
  rubble,     // Debris, slows movement
  ice,        // Slippery surface
  lava,       // Damages on contact
  mud,        // Slows movement significantly
}

/// Active effects currently on a tile (temporary/persistent)
enum TileEffect {
  burning,    // Fire damage over time
  frozen,     // Movement penalty
  poisoned,   // Poison damage over time
  electrified,// Lightning damage
  blessed,    // Healing effect
  cursed,     // Debuff effect
  darkness,   // Reduced visibility
}

class Tile {
  final TileType type;
  final bool walkable;
  final TileFeature? feature;  // Generator determines this
  final TileEffect? effect;    // Can change at runtime
  final List<Entity> contents;
}
```

Generators (implemented in Phase 3) place features based on location type (e.g., wilderness adds grass/water, caves add moss/rubble).

### Implementation Notes
- Use `freezed` for immutable models where appropriate
- All entities need unique IDs (use `uuid` package)
- Consider using mixins for shared behavior (Positionable, Damageable)

---

## 2.2 Registry/Config System (Phase 2b)

Each entity type has:
1. **Config class** — immutable definition (stats, sprite, behavior)
2. **Registry class** — static lookup by ID

### Monster Registry
```dart
class MonsterConfig {
  final String id;
  final String name;
  final int baseHealth;
  final int baseDamage;
  final String spriteId;
  final AIBehavior behavior;
}

class MonsterRegistry {
  static void register(MonsterConfig config);
  static MonsterConfig get(String id);
  static List<MonsterConfig> all();
}
```

### Item Registry
```dart
class ItemConfig {
  final String id;
  final String name;
  final ItemType type;
  final String spriteId;
  final Map<String, dynamic> properties;
}
```

### Location Registry
```dart
class LocationConfig {
  final String id;
  final String name;
  final LocationType type;
  final bool isSurface;              // Surface vs underground
  final int maxDepth;                // Number of floors
  final String generatorType;        // Generator type ID (used by Phase 3 generators)
}
```

The config defines location metadata. Actual generation logic is implemented in Phase 3.

### Tasks
- [ ] Create base Config classes
- [ ] Create Registry classes with static maps
- [ ] Define initial monster configs (3-5 types)
- [ ] Define initial item configs (5-10 types)
- [ ] Define initial location configs (2-3 types)

---

## 2.3 Event Bus Architecture (Phase 2b)

### Core Implementation
```dart
class EventBus {
  final _controller = StreamController<GameEvent>.broadcast();
  
  Stream<T> on<T extends GameEvent>() =>
      _controller.stream.whereType<T>();
  
  void fire(GameEvent event) => _controller.add(event);
  
  void dispose() => _controller.close();
}
```

### Base Event Types
```dart
// Movement
class EntityMovedEvent extends GameEvent { ... }

// Combat
class DamageDealtEvent extends GameEvent { ... }
class EntityDiedEvent extends GameEvent { ... }

// Items
class ItemPickedUpEvent extends GameEvent { ... }
class ItemUsedEvent extends GameEvent { ... }

// World
class LocationChangedEvent extends GameEvent { ... }
class TurnCompletedEvent extends GameEvent { ... }
```

### Tasks
- [ ] Implement EventBus singleton
- [ ] Create GameEvent base class
- [ ] Define movement events
- [ ] Define combat events
- [ ] Define item events
- [ ] Define world events

---

## 2.4 Core Game Systems (Phase 2c)

### TurnSystem
Orchestrates the turn-based game loop.

```dart
class TurnSystem {
  void processPlayerAction(Action action);
  void processAITurns();
  bool isPlayerTurn();
}
```

### CombatSystem
Handles all damage calculations and effects.

```dart
class CombatSystem {
  DamageResult calculateDamage(Entity attacker, Entity target);
  void applyDamage(Entity target, int amount);
  void processHit(Entity attacker, Entity target);
}
```

### AISystem
Manages monster behavior and decision-making.

```dart
class AISystem {
  Action decideAction(Monster monster, GameState state);
  Path findPathToTarget(Monster monster, Point target);
}
```

### Tasks
- [ ] Implement TurnSystem with player/AI phases
- [ ] Implement CombatSystem with damage formulas
- [ ] Implement AISystem with basic chase behavior

---

## 2.5 Services Layer (Phase 2c)

### PathfindingService
```dart
class PathfindingService {
  List<Point>? findPath(Point start, Point end, Map map);
  bool isReachable(Point start, Point end, Map map);
}
```

### SaveService
```dart
class SaveService {
  Future<void> saveGame(GameState state);
  Future<GameState?> loadGame(String slotId);
  Future<void> saveLocation(Location location);
  Future<Location?> loadLocation(String locationId);
}
```

### AudioService
```dart
class AudioService {
  void playSound(String soundId);
  void playMusic(String musicId);
  void stopMusic();
  void setVolume(double volume);
}
```

### Tasks
- [ ] Implement PathfindingService with A*
- [ ] Implement SaveService with Hive (per-location)
- [ ] Implement AudioService with flame_audio

---

## Done Criteria

### Phase 2a: Data Foundation ✅
- [x] Player model implemented with health, position, inventory, stats
- [x] Monster model implemented with health, position, configId, AI state
- [x] Item model implemented with configId, position, quantity
- [x] Tile model implemented with type, walkable, feature, effect, contents
- [x] GameMap model implemented with tiles grid and dimensions
- [x] Location model implemented with map, entities, state
- [x] GameState container implemented
- [x] All models have freezed/Hive integration for serialization

### Phase 2b: Registry + EventBus ✅
- [x] MonsterRegistry populated with 5 monster configs (rat, goblin, skeleton, slime, orc)
- [x] ItemRegistry populated with 10 item configs (weapons, armor, consumables, keys, treasure)
- [x] LocationRegistry populated with 3 location configs (village, dungeon, cave)
- [x] EventBus singleton implemented
- [x] Movement events defined (EntityMovedEvent, PlayerEnteredTileEvent)
- [x] Combat events defined (DamageDealtEvent, EntityDiedEvent, AttackMissedEvent)
- [x] Item events defined (ItemPickedUpEvent, ItemDroppedEvent, ItemUsedEvent, ItemEquippedEvent)
- [x] World events defined (LocationChangedEvent, FloorChangedEvent, TurnCompletedEvent)
- [x] Game state events defined (GameStartedEvent, GamePausedEvent, GameResumedEvent, GameOverEvent)

### Phase 2c: Systems + Services ✅
- [x] TurnSystem processes player and AI actions (energy-ready architecture)
- [x] CombatSystem calculates and applies damage
- [x] MonsterBehaviorSystem moves monsters toward player (renamed from AISystem)
- [x] PathfindingService returns valid paths using A* (with caching)
- [x] SaveService can save/load game state with Hive
- [x] AudioService can play sound effects

---

## Next Phase

After completing Phase 2, proceed to [Phase 3: First Playable](phase3-first-playable.md).
