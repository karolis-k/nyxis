# Nyxis Roguelike — Development Roadmap

> **Philosophy**: Architecture first, speed second. Each phase builds a solid foundation for the next.

---

## Project Status

| Phase | Status | Description |
|-------|--------|-------------|
| Phase 1 | ✅ Complete | Project Setup & Foundation |
| Phase 2 | ✅ Complete | Core Architecture |
| Phase 3 | ✅ Complete | Rendering & Core Loop |
| Phase 4 | ✅ Complete | World Generation |
| Phase 5 | ✅ Complete | Multi-Floor Dungeon |
| Phase 6 | ✅ Complete | First Playable |
| Phase 6b | ✅ Complete | Asset Integration |
| Phase 7 | ✅ Complete | World Map & Travel |
| Phase 7b | ✅ Complete | World Map Flow Fix |
| Phase 8 | 🚧 In Progress | Release Pipeline |
| Phase 9 | ⏳ Pending | Content & Polish |
| Phase 10 | ⏳ Post-Release | Advanced Polish |

---

## Phase 1: Project Setup & Foundation ✅

**Goal**: Establish project structure and migrate reusable assets.

- [x] Initialize Flutter project with Flame
- [x] Set up folder structure per TECH_STACK.md
- [x] Migrate sprites, audio, and other assets from previous game
- [x] Configure pubspec.yaml with core dependencies

---

## Phase 2: Core Architecture ✅

**Goal**: Build robust, extensible systems that will scale with content.

> [!IMPORTANT]
> This is the most critical phase. Rushing here creates technical debt that compounds with every feature added.

### Phase 2a: Data Foundation ✅
- [x] Implement entity models (Player, Monster, Item)
- [x] Design tile and map data structures (Tile, GameMap, Location)
- [x] Create GameState management
- [x] Add freezed/Hive integration for serialization

### Phase 2b: Registry + EventBus ✅
- [x] Finalize MonsterRegistry + MonsterConfig
- [x] Finalize ItemRegistry + ItemConfig
- [x] Finalize LocationRegistry + LocationConfig
- [x] Implement core EventBus singleton
- [x] Define base GameEvent types (movement, combat, items, world)

### Phase 2c: Systems + Services ✅
- [x] TurnSystem — turn-based game loop (energy-ready)
- [x] CombatSystem — damage, death, effects
- [x] MonsterBehaviorSystem — monster behavior framework
- [x] PathfindingService (A* integration with caching)
- [x] SaveService (per-location Hive persistence)
- [x] AudioService (sound effects framework)

📄 **Detailed Plan**: [plans/phase2-core-architecture.md](plans/phase2-core-architecture.md)

---

## Phase 3: Rendering & Core Loop ✅

**Goal**: Get something on screen — a playable test game with hardcoded map.

> [!TIP]
> This phase validates all Phase 2 systems by wiring them to Flame and player input.

### 3.1 Flame Game Setup
- [x] FlameGame subclass with game loop
- [x] Camera system with player follow
- [x] Input handling (keyboard)

### 3.2 Rendering
- [x] TileComponent and TileMapComponent
- [x] PlayerComponent with sprite
- [x] MonsterComponent with sprite and health bar
- [x] Basic animations (smooth lerp movement)

### 3.3 Gameplay Wiring
- [x] Wire player input → TurnSystem
- [x] Wire TurnSystem → visual updates
- [x] Melee combat (bump attack)
- [x] Monster AI integration
- [x] Hardcoded test dungeon (defer procedural generation)
- [x] Game over screen with restart

> **Deferred to Phase 7**: Touch input, attack animations, ItemComponent wiring

📄 **Detailed Plan**: [plans/phase3-rendering-core-loop.md](plans/phase3-rendering-core-loop.md)

---

## Phase 4: World Generation 🗺️ ✅

**Goal**: Build the procedural generation architecture.

### 4.1 Generation Architecture
- [x] LocationGenerator interface
- [x] Generation pipeline with composable steps
- [x] LayoutBehavior interface

### 4.2 Pipeline Steps (Core)
- [x] RoomGenerationStep
- [x] RoomCreationStep
- [x] CorridorGenerationStep
- [x] ConnectivityValidationStep
- [x] StairsPlacementStep

### 4.3 Generators & Layouts (MVP)
- [x] DungeonGenerator (rooms, corridors, stairs)
- [x] DefaultLayoutBehavior
- [x] Integration with MyGame

> **Deferred**: DoorGenerationStep, FeatureGenerationStep, SurfaceGenerator, WildernessLayoutBehavior, CaveLayoutBehavior

📄 **Detailed Plan**: [plans/phase4-world-generation.md](plans/phase4-world-generation.md)

---

## Phase 5: Multi-Floor Dungeon 🏰 ✅

**Goal**: Enable stair traversal to explore multiple floors of the dungeon.

> [!TIP]
> This phase adds vertical depth before horizontal breadth. Players can go deeper into a single dungeon before we add world travel.

### 5.1 Floor Management
- [x] Store multiple floors in GameState
- [x] Lazy generation (generate floor on first visit)
- [x] Cache visited floors with their state

### 5.2 Stair Traversal
- [x] Detect player stepping on stair tiles
- [x] StairsDown → descend to floor+1 (generate if new)
- [x] StairsUp → ascend to floor-1 (or surface exit if floor 1)
- [x] Position player at matching stair on destination floor

### 5.3 Floor State Persistence
- [x] Save monster/item state per floor
- [x] Restore state when returning to a floor
- [x] Track visited floors

📄 **Detailed Plan**: [plans/phase5-multi-floor.md](plans/phase5-multi-floor.md)

---

## Phase 6: First Playable 🏁 ✅

**Goal**: Integrate all systems into a complete gameplay experience.

> [!TIP]
> 🏁 **MILESTONE: RUNNING GAME**  
> At the end of Phase 6, you will have a fully playable dungeon crawler with movement, combat, items, and persistence.

### 6.1 Player Mechanics
- [x] Inventory pickup/drop
- [x] Use consumable items
- [x] Equip/unequip gear

### 6.2 Monster Polish
- [x] Loot drops on death
- [x] XP/score on kill

### 6.3 Basic UI
- [x] HUD (health, floor indicator)
- [x] HUD equipped items display
- [x] Inventory screen with item actions
- [x] Polish game over screen

### 6.4 Persistence
- [x] Save on floor change
- [x] Save on game exit
- [x] Load game from slot

📄 **Detailed Plan**: [plans/phase6-first-playable.md](plans/phase6-first-playable.md)

---

## Phase 6b: Asset Integration 🎨 ✅

**Goal**: Replace placeholder shapes with actual sprites from the migrated asset library.

> [!NOTE]
> Assets were copied in Phase 1 but not wired to Flame components. This phase connects the visual assets to the game engine.

### 6b.1 Entity Sprites
- [x] PlayerComponent: Load sprite from `assets/icons/entities/`
- [x] MonsterComponent: Load sprite based on `MonsterConfig.spriteId`
- [x] ItemComponent: Load sprite based on `ItemConfig.spriteId`

### 6b.2 Tile Sprites
- [x] TileComponent: Load tile sprites from `assets/icons/tiles/`
- [x] Stair overlays (up/down) with transparency
- [x] Wall vs floor differentiation

### 6b.3 Sprite Caching
- [x] Preload sprites in MyGame.onLoad() for performance
- [x] Use Flame's image cache
- [x] Handle missing sprites gracefully (fallback to colored shape)

### 6b.4 Visual Polish
- [x] Entity death/damage visual feedback
- [x] Item rarity visual indicators (border colors, glow)
- [x] Monster elite/boss indicators

📄 **Detailed Plan**: [plans/phase6b-asset-integration.md](plans/phase6b-asset-integration.md)

---

## Phase 7: World Map & Travel 🧭 ✅

**Goal**: Expand beyond a single dungeon with world exploration.

> [!NOTE]
> This phase adds horizontal breadth. Multiple locations on a world map, each with their own multi-floor dungeons.

### 7.1 World Map Model
- [x] WorldMap with grid-based structure
- [x] MapTile with terrain and location references
- [x] Fog of war for undiscovered areas

### 7.2 Navigation
- [x] World map screen with movement
- [x] Enter location from world map
- [x] Exit location back to world map
- [x] Multiple location types (dungeon, cave, town)

### 7.3 Location Variety

> **Moved to Phase 7b**: Location-specific generators (CaveGenerator, TownGenerator, SurfaceGenerator) are now tracked in Phase 7b along with the world map flow fix.

📄 **Detailed Plan**: [plans/phase7-world-travel.md](plans/phase7-world-travel.md)

---

## Phase 7b: World Map Flow with Portals 🗺️ ✅

**Goal**: Fix game flow to start in dungeon, use portal system for location connections, with surface locations as intermediate step to world map.

### 7b.1 Game Initialization
- [x] Start game in dungeon (not world map)
- [x] Change floor indexing from 1-based to 0-based
- [x] Update GameState default `isOnWorldMap: false`
- [x] Lazy world map generation (on first exit)

### 7b.2 Portal System
- [x] Create `PortalDefinition` class for portal configuration
- [x] Create `PortalRegistry` with static portal definitions
- [x] Create `WorldObject` base class for interactive objects
- [x] Create `Portal` entity extending WorldObject
- [x] Add portal placement during floor generation
- [x] Add portal interaction and traversal logic

### 7b.3 Generator System
- [x] GeneratorRegistry to map `generatorType` → `LocationGenerator`
- [x] SurfaceGenerator for outdoor/surface areas (no walls)
- [x] Wire MyGame to use registry instead of hardcoded DungeonGenerator

### 7b.4 Flow Integration
- [x] Dungeon floor 0 has portal to surface location
- [x] Surface location has portal back to dungeon
- [x] Surface location → walk to edge → World map
- [x] World map → enter tile → Surface location of that tile

> **Deferred**: CaveGenerator, TownGenerator (caves/towns use dungeon layout for now)

📄 **Detailed Plan**: [plans/phase7b-world-map-flow.md](plans/phase7b-world-map-flow.md)

---

## Phase 8: Release Pipeline 🚀

**Goal**: Production-ready deployment.

- [x] GitHub Actions CI/CD pipeline
- [x] Web build and deployment (GitHub Pages)
- [ ] Android build configuration (requires secrets setup)
- [ ] iOS build configuration
- [ ] Performance profiling and optimization
- [ ] Final QA pass

📄 **Detailed Plan**: [plans/phase8-release.md](plans/phase8-release.md)

---

## Phase 9: Content & Polish

**Goal**: Expand the game with varied content and polished UX.

### 9.1 Content Expansion (using existing assets)
- [ ] Configure 4 monster types (Goblin, Orc, Dragon, Fairy)
- [ ] Configure 7 item types (Sword, Stone, Armor, Helmet, Boots, Pants, Potion)

### 9.2 UI/UX Polish
- [ ] Main menu screen
- [ ] Settings/options

> **Deferred to Phase 10 (Post-Release)**: Minimap, damage numbers, smooth animations, smart wall rendering, quest system

### 9.3 Audio
- [ ] Ambient music per location
- [ ] Combat sound effects
- [ ] UI feedback sounds

### 9.4 Balance & Tuning
- [ ] Difficulty curves
- [ ] Item rarity distribution
- [ ] Monster stat balancing

📄 **Detailed Plan**: [plans/phase9-content-polish.md](plans/phase9-content-polish.md)

---

## Phase 10: Post-Release Polish 🎨

**Goal**: Advanced features and polish after initial release.

> [!NOTE]
> These items are nice-to-have enhancements that don't block a playable release. Tackle them based on player feedback and priorities.

### 10.1 Advanced Rendering
- [ ] Smart wall rendering (neighbor-aware thin walls with corner detection)
- [ ] Damage numbers and combat feedback
- [ ] Smooth animations and transitions
- [ ] Attack/spell visual effects

### 10.2 UI Enhancements
- [ ] Minimap
- [ ] Character stats screen
- [ ] Bestiary/monster compendium
- [ ] Item tooltips with detailed stats

### 10.3 Gameplay Expansion
- [ ] Quest/objective system
- [ ] NPC dialogue system
- [ ] Achievements
- [ ] Leaderboards

---

## How to Use This Roadmap

1. **Check current phase** at the top of this document
2. **Review the detailed plan** for that phase in `docs/plans/`
3. **Mark tasks complete** as you finish them
4. **Update phase status** when moving to the next phase

---

## Links

- [TECH_STACK.md](TECH_STACK.md) — Technology choices and patterns
- [ARCHITECTURE.md](ARCHITECTURE.md) — High-level system architecture
- [plans/](plans/) — Detailed phase implementation plans
