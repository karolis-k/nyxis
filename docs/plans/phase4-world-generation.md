# Phase 4: World Generation — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Build the procedural generation architecture.

---

## Overview

This phase creates a flexible, extensible world generation system. The architecture prioritizes:
1. **Composability** — Pipeline steps can be mixed and matched
2. **Testability** — Each step can be tested in isolation
3. **Extensibility** — New location types require minimal new code

---

## 4.1 Generation Architecture

### LocationGenerator Interface
Base interface for all location generators.

```dart
abstract class LocationGenerator {
  /// Generate a complete location for the given config and floor.
  Location generate({
    required LocationConfig config,
    required int floor,
    required Random random,
  });
}
```

- [x] Define LocationGenerator interface
- [x] Create abstract base with common utilities
- [x] Add seeded Random for reproducibility

### Generation Pipeline
A location is generated through a series of composable steps.

```dart
abstract class GenerationStep {
  /// Execute this step on the generation context.
  void execute(GenerationContext context);
}

class GenerationContext {
  final int width;
  final int height;
  final Random random;
  final LocationConfig config;
  final int floor;
  
  // Mutable state built up by steps
  List<List<TileType>> tiles;
  List<Room> rooms = [];
  List<Corridor> corridors = [];
  Position? playerSpawn;
  Position? stairsUp;
  Position? stairsDown;
  List<Position> monsterSpawns = [];
  List<Position> itemSpawns = [];
}
```

- [x] Define GenerationStep interface
- [x] Create GenerationContext data class
- [x] Implement pipeline executor

### LayoutBehavior Interface
Defines how rooms are placed and connected.

```dart
abstract class LayoutBehavior {
  /// Generate room definitions (position, size).
  List<Room> generateRooms(GenerationContext context);
  
  /// Define how rooms should be connected.
  List<Connection> defineConnections(List<Room> rooms, GenerationContext context);
}
```

- [x] Define LayoutBehavior interface
- [x] Create Room and Connection data classes

---

## 4.2 Pipeline Steps

Each step modifies the GenerationContext in a specific way.

### RoomGenerationStep
Uses LayoutBehavior to define room positions and sizes.

- [x] Call layoutBehavior.generateRooms()
- [x] Validate rooms don't overlap
- [x] Store rooms in context

### RoomCreationStep
Paints room tiles onto the map.

- [x] Iterate through rooms
- [x] Set floor tiles for room interiors
- [ ] Set wall tiles for room borders (deferred - using carve approach)
- [ ] Handle room features (pillars, alcoves) (deferred)

### CorridorGenerationStep
Connects rooms with corridors.

- [x] Get connections from LayoutBehavior
- [x] Generate corridor paths (L-shaped or direct)
- [x] Paint corridor floor tiles
- [x] Ensure corridors don't break room walls incorrectly

### ConnectivityValidationStep
Ensures all rooms are reachable.

- [x] Flood fill from player spawn
- [x] Verify all rooms are reached
- [ ] If not, add additional corridors (deferred - logs warning)
- [ ] Fail generation if unreachable (deferred)

### DoorGenerationStep
Places doors at room entrances.

- [ ] Find corridor-room intersections (deferred)
- [ ] Place door tiles at thresholds (deferred)
- [ ] Ensure doors are accessible from both sides (deferred)

### FeatureGenerationStep
Adds environmental features.

- [ ] Water pools in appropriate rooms (deferred)
- [ ] Decorative objects (statues, fountains) (deferred)
- [ ] Traps (future)
- [ ] Based on location config feature definitions (deferred)

### StairsPlacementStep
Places stairs for floor transitions.

- [x] Place stairs up (to previous floor or surface)
- [x] Place stairs down (to next floor, if not max depth)
- [x] Ensure stairs are in accessible locations
- [x] Store positions in context

---

## 4.3 Generators & Layouts

### DungeonGenerator
Standard underground location with rooms and corridors.

```dart
class DungeonGenerator extends LocationGenerator {
  final LayoutBehavior layout;
  final List<GenerationStep> pipeline;
  
  DungeonGenerator({
    this.layout = const DefaultLayoutBehavior(),
  }) : pipeline = [
    RoomGenerationStep(layout),
    RoomCreationStep(),
    CorridorGenerationStep(layout),
    ConnectivityValidationStep(),
    DoorGenerationStep(),
    FeatureGenerationStep(),
    StairsPlacementStep(),
  ];
}
```

- [x] Implement DungeonGenerator
- [x] Configure default pipeline
- [x] Add monster/item spawn point selection

### SurfaceGenerator
Open outdoor areas with map exits on borders.

```dart
class SurfaceGenerator extends LocationGenerator {
  @override
  Location generate(...) {
    // Single large clearing
    // Border tiles are MapExitTile
    // Central area has dungeon entrance
    // Natural features scattered
  }
}
```

- [ ] Implement SurfaceGenerator
- [ ] Single large room (clearing)
- [ ] MapExitTile on all borders
- [ ] Place dungeon entrance (stair down)
- [ ] Scatter natural features (trees, rocks, water)

### DefaultLayoutBehavior
Standard room placement for dungeons.

- [x] Generate 5-10 rooms of varying sizes
- [x] Random placement with overlap checking
- [x] Connect rooms with minimum spanning tree + extras

### WildernessLayoutBehavior
Open layout for outdoor/surface areas.

- [ ] Single large room covering most of map
- [ ] No corridors needed
- [ ] Border handling for map exits

### CaveLayoutBehavior
Organic cave generation using cellular automata.

- [ ] Initial random fill
- [ ] Cellular automata smoothing passes
- [ ] Convert to room-like regions
- [ ] Connect isolated regions

---

## Generation Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    LocationConfig + Floor                        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                   Select LocationGenerator                       │
│            (DungeonGenerator, SurfaceGenerator, etc.)           │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                   Create GenerationContext                       │
│                (width, height, random, config)                   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Execute Pipeline Steps                        │
│                                                                  │
│  1. RoomGenerationStep      → Define room positions             │
│  2. RoomCreationStep        → Paint room tiles                  │
│  3. CorridorGenerationStep  → Connect rooms                     │
│  4. ConnectivityValidation  → Verify reachability               │
│  5. DoorGenerationStep      → Place doors                       │
│  6. FeatureGenerationStep   → Add features                      │
│  7. StairsPlacementStep     → Place stairs                      │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                Build Location from Context                       │
│           (GameMap, monster spawns, item spawns, etc.)          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Done Criteria

Phase 4 is complete when:
- [ ] LocationGenerator interface defined and documented
- [ ] GenerationStep interface with pipeline execution
- [ ] LayoutBehavior interface implemented
- [ ] All 7 pipeline steps implemented
- [ ] DungeonGenerator produces valid dungeons
- [ ] SurfaceGenerator produces valid surface areas
- [ ] DefaultLayoutBehavior creates varied room layouts
- [ ] WildernessLayoutBehavior creates open clearings
- [ ] CaveLayoutBehavior creates organic caves
- [ ] Generated maps pass connectivity validation
- [ ] Stairs placed correctly for floor transitions

---

## Test Checklist

Before moving to Phase 5, verify:
- [ ] Dungeons are fully connected (no unreachable areas)
- [ ] Room sizes and counts are reasonable
- [ ] Corridors connect rooms correctly
- [ ] Doors appear at room entrances
- [ ] Stairs are placed in accessible locations
- [ ] Surface maps have proper border exits
- [ ] Cave layouts are playable (no tiny isolated areas)
- [ ] Generation is reproducible with same seed
- [ ] Performance is acceptable (< 100ms per location)

---

## Next Phase

After completing Phase 4, proceed to [Phase 5: World Map & Navigation](phase5-world-navigation.md).
