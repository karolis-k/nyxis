# Roguelike Game - Recommended Tech Stack

A comprehensive guide for building a cross-platform (mobile + web) roguelike dungeon crawler with Flutter and Flame.

---

## Core Technology

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform UI framework |
| **Flame Engine** | 2D game engine built on Flutter |
| **Dart** | Programming language |

---

## 🔥 Flame Ecosystem Packages

| Package | Purpose | Use Case |
|---------|---------|----------|
| `flame` | Core game engine | Everything |
| `flame_audio` | Sound effects & music | Combat sounds, ambient music |
| `flame_tiled` | Tiled map support | Level design with Tiled editor |
| `flame_bloc` | State management | Complex game states |
| `flame_rive` | Rive animations | Smooth character animations |
| `flame_svg` | SVG rendering | Scalable vector graphics |

---

## 💾 Data & Persistence

| Package | Purpose | Recommendation |
|---------|---------|----------------|
| `hive` + `hive_flutter` | Fast NoSQL database | ⭐ Save/load game state (works on web!) |
| `shared_preferences` | Simple key-value | Settings, high scores |
| `json_serializable` | JSON code generation | Serialize game entities |
| `freezed` | Immutable data classes | Clean game state models |

---

## 🧭 Pathfinding & AI

| Package | Purpose | Use Case |
|---------|---------|----------|
| `a_star_algorithm` | A* pathfinding | Monster/player navigation |
| `directed_graph` | Graph structures | Quest dependencies, skill trees |

---

## 🎲 Procedural Generation

**Custom Location Generators** (no external packages needed):

Each location type has its own generator function:

```dart
abstract class LocationGenerator {
  Location generate(int seed);
}

class DungeonGenerator extends LocationGenerator { ... }
class CaveGenerator extends LocationGenerator { ... }
class TownGenerator extends LocationGenerator { ... }
```

| Package | Purpose | Use Case |
|---------|---------|----------|
| `dart_random` | Seeded random | Reproducible world gen (optional) |

---

## 🎨 UI & Widgets

| Package | Purpose | Use Case |
|---------|---------|----------|
| `google_fonts` | Custom fonts | Fantasy/pixel fonts |
| `flutter_animate` | Widget animations | Menu transitions, damage numbers |
| `responsive_builder` | Responsive layouts | Mobile + web support |

---

## 📊 State Management

| Package | Purpose | When to Use |
|---------|---------|-------------|
| `riverpod` | Modern state management | ⭐ Recommended |
| `flutter_bloc` | Bloc pattern | Alternative if preferred |
| `get_it` | Service locator | Dependency injection |

---

## Recommended pubspec.yaml

```yaml
name: roguelike_game
description: A roguelike dungeon crawler game
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
    
  # Core Game
  flame: ^1.18.0
  flame_audio: ^2.10.0
  flame_tiled: ^1.20.0
  
  # Data & State
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  riverpod: ^2.5.0
  flutter_riverpod: ^2.5.0
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0
  
  # Pathfinding
  a_star_algorithm: ^0.3.0
  
  # UI
  google_fonts: ^6.0.0
  flutter_animate: ^4.5.0
  
  # Utilities
  collection: ^1.18.0
  equatable: ^2.0.5
  uuid: ^4.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.0
  freezed: ^2.5.0
  json_serializable: ^6.8.0
  hive_generator: ^2.0.1
```

---

## Project Architecture

```
lib/
├── main.dart
├── game/
│   ├── my_game.dart              # FlameGame class
│   ├── components/               # Flame components
│   │   ├── player_component.dart
│   │   ├── monster_component.dart
│   │   ├── item_component.dart
│   │   └── tile_component.dart
│   └── systems/                  # Game systems
│       ├── combat_system.dart
│       ├── ai_system.dart
│       └── turn_system.dart
├── models/
│   ├── entities/                 # Game entities
│   │   ├── player.dart
│   │   ├── monster.dart
│   │   └── item.dart
│   ├── world/                    # World data
│   │   ├── map.dart
│   │   ├── tile.dart
│   │   └── location.dart
│   └── game_state.dart
├── services/
│   ├── save_service.dart         # Hive persistence
│   ├── pathfinding_service.dart  # A* pathfinding
│   ├── audio_service.dart        # Sound management
│   └── dungeon_generator.dart    # Procedural generation
├── ui/
│   ├── screens/                  # Flutter screens
│   │   ├── main_menu_screen.dart
│   │   ├── game_screen.dart
│   │   └── inventory_screen.dart
│   └── widgets/                  # UI widgets
│       ├── hud_widget.dart
│       ├── health_bar.dart
│       └── minimap_widget.dart
└── config/
    ├── monster_config.dart       # Monster definitions
    ├── item_config.dart          # Item definitions
    ├── location_config.dart      # Location definitions
    └── constants.dart            # Game constants
```

---

## Key Patterns from Previous Project

### 1. Registry/Config Pattern
Centralized configuration for game entities:
```dart
class MonsterConfig {
  final String id;
  final String name;
  final int health;
  final int damage;
  final String spriteId;
}

class MonsterRegistry {
  static final Map<String, MonsterConfig> _monsters = {};
  static MonsterConfig get(String id) => _monsters[id]!;
}
```

### 2. Event-Driven Architecture
Loose coupling between systems:
```dart
class EventBus {
  final _controller = StreamController<GameEvent>.broadcast();
  Stream<T> on<T extends GameEvent>() => _controller.stream.whereType<T>();
  void fire(GameEvent event) => _controller.add(event);
}

// Usage
eventBus.fire(ItemUsedEvent(item: potion));
eventBus.on<ItemUsedEvent>().listen((e) => playSound('potion.wav'));
```

### 4. Per-Location Save System
Efficient save/load for large worlds:
```
saves/
├── meta.json           # Save metadata
├── player.json         # Player state
├── world_state.json    # Global flags
└── locations/
    ├── dungeon_1.json
    ├── dungeon_2.json
    └── town.json
```

## Assets

Reusing assets from the previous game:
- Sprites (player, monsters, items, tiles)
- Audio files (sound effects, music)

---

## Deployment

Reusing deployment strategies from the previous game:
- GitHub Actions CI/CD pipeline
- Web deployment configuration
- Mobile build settings

---

## Next Steps

1. ~~**Set up the project** with Flutter and the recommended dependencies~~ ✅
4. **Create the folder structure** as outlined above
2. **Migrate assets** from previous game to new project
5. **Implement core systems**: game loop, tile rendering, player movement
6. **Add pathfinding** for monsters
7. **Implement save/load** with Hive
8. **Build the UI**: HUD, inventory, menus
9. **Add content**: monsters, items, dungeons
3. **Set up deployment** pipelines (reuse from previous game)
