# Phase 7: World Map & Travel — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Expand beyond a single dungeon with world exploration.

---

## Overview

This phase adds horizontal breadth to the game. Players can explore a world map with multiple locations, each containing their own multi-floor dungeons.

**Prerequisites**: Phase 5 (multi-floor) and Phase 6 (first playable) should be complete.

---

## 7.1 World Map Model

### WorldMap Data Structure

```dart
@freezed
class WorldMap with _$WorldMap {
  const factory WorldMap({
    required int width,
    required int height,
    required List<List<MapTile>> tiles,
    required Position playerPosition,
  }) = _WorldMap;
}

@freezed
class MapTile with _$MapTile {
  const factory MapTile({
    required TerrainType terrain,
    String? locationId,  // Reference to LocationConfig
    @Default(false) bool discovered,
    @Default(false) bool visited,
  }) = _MapTile;
}

enum TerrainType {
  plains,
  forest,
  mountain,
  water,
  desert,
}
```

### Tasks
- [x] Create WorldMap model with freezed
- [x] Create MapTile model
- [x] Define TerrainType enum
- [x] Add Hive serialization
- [x] Create static world definition

---

## 7.2 Navigation

### World Map Screen

- [x] Create WorldMapScreen (FlameGame or Flutter widget)
- [x] Render terrain tiles with sprites
- [x] Show location icons on tiles with locations
- [x] Display player position marker
- [x] Arrow key movement on map

### Transitions

- [x] Enter location: step on location tile + confirm
- [x] Exit location: stairs up from floor 1 → return to world map
- [x] Save/restore world map position

---

## 7.3 Location Variety

> **Moved to Phase 7b**: Location-specific generators (CaveGenerator, TownGenerator, SurfaceGenerator) are now tracked in [Phase 7b: World Map Flow Fix](phase7b-world-map-flow.md) along with the game initialization fix.

---

## Simplified Scope

**Included:**
- Basic world map (10x10)
- Multiple location types defined in config
- Enter/exit transitions via GameWrapper

**Deferred to Phase 7b:**
- Location-specific generators
- Surface location system
- Game flow fix (start in dungeon)

---

## Done Criteria

Phase 7 is complete when:
- [x] World map renders with terrain
- [x] Player can move on world map
- [x] Player can enter a dungeon from map
- [x] Exiting dungeon returns to world map
- [x] Multiple location types defined in registry
- [x] World map state persists

---

## Next Phase

After completing Phase 7, proceed to [Phase 7b: World Map Flow Fix](phase7b-world-map-flow.md).
