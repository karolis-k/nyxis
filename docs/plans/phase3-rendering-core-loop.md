# Phase 3: Rendering & Core Loop — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Get something on screen — a playable test game with hardcoded map.

---

> [!TIP]
> This phase validates all Phase 2 systems by wiring them to Flame and player input.
> Use a hardcoded test dungeon to defer procedural generation complexity.

---

## Overview

This phase connects the Phase 2 architecture to a visual, interactive game. The focus is on:
1. Setting up the Flame rendering pipeline
2. Wiring player input to the TurnSystem
3. Displaying entities and responding to game events
4. Using a **hardcoded test map** to avoid generation complexity

---

## 3.1 Flame Game Setup

### MyGame Class
- [ ] Extend FlameGame with HasKeyboardHandlerComponents
- [ ] Initialize game state with test data
- [ ] Set up component hierarchy (world, camera, HUD)
- [ ] Implement onLoad() for asset loading

### Camera System
- [ ] Create CameraComponent following player
- [ ] Implement smooth camera movement
- [ ] Handle camera bounds (don't show outside map)
- [ ] Configure viewport for different screen sizes

### Input Handling
- [ ] Keyboard input (arrow keys, WASD)
- [ ] Touch input (tap to move)
- [ ] Map screen coordinates to grid coordinates
- [ ] Queue input during animations (optional)

### Implementation Notes
```dart
class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  late GameState gameState;
  late TurnSystem turnSystem;
  late TileMapComponent tileMap;
  late PlayerComponent playerComponent;
  
  @override
  Future<void> onLoad() async {
    // Load test game state
    gameState = _createTestGameState();
    
    // Initialize systems
    turnSystem = TurnSystem(CombatSystem(), MonsterBehaviorSystem());
    
    // Add world components
    await add(tileMap = TileMapComponent(gameState.currentLocation!.map));
    await add(playerComponent = PlayerComponent(gameState.player));
    
    // Set up camera
    camera.follow(playerComponent);
  }
}
```

---

## 3.2 Rendering

### TileComponent
- [ ] Render individual tile sprite based on TileType
- [ ] Handle tile variants (e.g., different floor textures)
- [ ] Support fog of war overlay (optional for this phase)

### TileMapComponent
- [ ] Container for all TileComponents
- [ ] Efficient rendering (only visible tiles)
- [ ] Update when location changes

### PlayerComponent
- [ ] Render player sprite at grid position
- [ ] Smooth movement animation between tiles
- [ ] Attack animation (swing/thrust)
- [ ] Idle animation

### MonsterComponent
- [ ] Render monster sprite based on configId
- [ ] Smooth movement animation
- [ ] Attack animation
- [ ] Death animation and removal
- [ ] Health bar above monster (optional)

### ItemComponent
- [ ] Render item sprite on ground
- [ ] Pickup animation (fade out)
- [ ] Drop animation (fade in)

### Coordinate System
```dart
// Grid to screen conversion
Vector2 gridToScreen(Position gridPos) {
  return Vector2(
    gridPos.x * tileSize,
    gridPos.y * tileSize,
  );
}

// Screen to grid conversion
Position screenToGrid(Vector2 screenPos) {
  return Position(
    (screenPos.x / tileSize).floor(),
    (screenPos.y / tileSize).floor(),
  );
}
```

---

## 3.3 Gameplay Wiring

### Input → TurnSystem
- [ ] Convert keyboard/touch input to PlayerAction
- [ ] Call turnSystem.processPlayerAction()
- [ ] Update gameState with result
- [ ] Block input during animations

### TurnSystem → Visual Updates
- [ ] Listen to EventBus for EntityMovedEvent
- [ ] Listen to EventBus for EntityDamagedEvent
- [ ] Listen to EventBus for EntityDiedEvent
- [ ] Animate components in response to events

### Melee Combat
- [ ] Detect attack intent (move into occupied tile)
- [ ] Create PlayerAttackAction instead of PlayerMoveAction
- [ ] Play attack animation
- [ ] Show damage feedback (flash, number)

### Monster AI Integration
- [ ] Monsters act after player via TurnSystem
- [ ] Animate monster movement
- [ ] Animate monster attacks
- [ ] Handle monster death (remove component)

### Test Dungeon
Create a simple hardcoded dungeon for testing:

```dart
GameMap _createTestMap() {
  const width = 20;
  const height = 15;
  
  final tiles = <List<Tile>>[];
  for (var y = 0; y < height; y++) {
    final row = <Tile>[];
    for (var x = 0; x < width; x++) {
      // Walls on edges
      if (x == 0 || x == width - 1 || y == 0 || y == height - 1) {
        row.add(Tile(type: TileType.wall, x: x, y: y));
      } else {
        row.add(Tile(type: TileType.floor, x: x, y: y));
      }
    }
    tiles.add(row);
  }
  
  // Add some internal walls for interest
  tiles[5][5] = Tile(type: TileType.wall, x: 5, y: 5);
  tiles[5][6] = Tile(type: TileType.wall, x: 6, y: 5);
  // ... more walls
  
  return GameMap(width: width, height: height, tiles: tiles);
}
```

---

## Event Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                        Player Input                              │
│                    (keyboard/touch)                              │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Convert to PlayerAction                       │
│              (Move, Attack, Wait, Pickup)                        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│              TurnSystem.processPlayerAction()                    │
│                                                                  │
│  1. Execute player action                                        │
│  2. Fire events (EntityMoved, EntityDamaged, etc.)              │
│  3. Process all monster turns                                    │
│  4. Fire TurnCompletedEvent                                      │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      EventBus Listeners                          │
│                                                                  │
│  - PlayerComponent listens for player events                    │
│  - MonsterComponents listen for monster events                  │
│  - AudioService plays sounds                                    │
│  - (Future) UI updates health bars                              │
└─────────────────────────────────────────────────────────────────┘
```

---

## Done Criteria

Phase 3 is complete when:
- [ ] Game renders a tile map with walls and floors
- [ ] Player sprite is visible and follows camera
- [ ] Player can move with keyboard (arrow keys, WASD)
- [ ] Player can move with touch (tap adjacent tile)
- [ ] Monsters render and are visible
- [ ] Player can attack monsters by bumping into them
- [ ] Monsters chase and attack the player
- [ ] Combat resolves correctly (damage, death)
- [ ] Dead monsters are removed from the game
- [ ] Game over triggers when player dies

---

## Test Checklist

Before moving to Phase 4, verify:
- [ ] Player movement feels responsive
- [ ] Collision with walls works
- [ ] Combat damage matches CombatSystem calculations
- [ ] Monster AI behaves as expected
- [ ] No visual glitches or flickering
- [ ] Performance is acceptable (60 FPS)
- [ ] Events fire correctly (check logs)

---

## Next Phase

After completing Phase 3, proceed to [Phase 4: World Generation](phase4-world-generation.md).
